#!/bin/bash

set -ex
# turn off ftrace
echo 0 > /sys/kernel/debug/tracing/tracing_on
sleep 1

echo 0 > /sys/kernel/debug/tracing/events/enable
sleep 1

echo secondary_start_kernel > /sys/kernel/debug/tracing/set_ftrace_filter
sleep 1

# function tracer 
echo function > /sys/kernel/debug/tracing/current_tracer
sleep 1

echo 1 > /sys/kernel/debug/tracing/events/sched/sched_wakeup/enable
echo 1 > /sys/kernel/debug/tracing/events/sched/sched_switch/enable

echo 1 > /sys/kernel/debug/tracing/events/irq/irq_handler_entry/enable
echo 1 > /sys/kernel/debug/tracing/events/irq/irq_handler_exit/enable

echo 1 > /sys/kernel/debug/tracing/events/raw_syscalls/enable
sleep 1

# check /sys/kernel/debug/tracing/available_filter_functions
echo schedule ttwu_do_wakeup > /sys/kernel/debug/tracing/set_ftrace_filter

sleep 1

echo 1 > /sys/kernel/debug/tracing/options/func_stack_trace
echo 1 > /sys/kernel/debug/tracing/options/sym-offset

echo 1 > /sys/kernel/debug/tracing/tracing_on

