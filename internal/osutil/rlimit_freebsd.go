//go:build freebsd
// +build freebsd

package osutil

import (
	"fmt"
	"syscall"
)

// RaiseOpenFileLimit tries to maximize the limit of open file descriptors, limited by max or the OS's hard limit
func RaiseOpenFileLimit(max uint64) error {
	var limit syscall.Rlimit
	if err := syscall.Getrlimit(syscall.RLIMIT_NOFILE, &limit); err != nil {
		return fmt.Errorf("Could not get current limit: %v", err)
	}
	if limit.Cur >= limit.Max || limit.Cur >= int64(max) {
		return nil
	}
	limit.Cur = limit.Max
	if limit.Cur > int64(max) {
		limit.Cur = int64(max)
	}
	return syscall.Setrlimit(syscall.RLIMIT_NOFILE, &limit)
}
