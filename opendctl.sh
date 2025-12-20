#!/bin/sh
{ sleep 1; echo "input_phone_verify_code -code=$1"; sleep 1; } | telnet 127.0.0.1 22222