Return-Path: <netdev+bounces-237067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D988FC444AF
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 18:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BEFF4E200F
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 17:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43783002CA;
	Sun,  9 Nov 2025 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1O2fIM5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809DB1E0083
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762710132; cv=none; b=tPa8fR2u1HQBPDNA07ThjFBsRcxsyFHbVmdYgVNcOJU9fgpK71Ysg9HOo2U3UY6rTWkPlNjrfMv2IxI8rBxKruBv7wSZfFhMPu+bH3ohzmZ/udRUbiIqjRWA7M6FZI7WT7jH8DDMcpns1pgJeJS0E9xgvCV9zZhBIpxzWaZZztc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762710132; c=relaxed/simple;
	bh=zc9hK0jHrMMiD+V7uBIpSu5vlq30um47umH/ZCf0DNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GWffCbUUbDxjeD/SSQk/c6qM81LB1C88kCbo04PjLaHqL+DG1+VvcWB2o4lEv2oGtCex+vB1YIhWnZeLLRT/eW0V1ISdNble5lqBmVyl6HkLuUVPVDaE6CXcwVpbTIRy7t3KuvF+8quGqaYH+lEC/ME0IbcoEovHVrp/P3/AczY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1O2fIM5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED96C4CEFB;
	Sun,  9 Nov 2025 17:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762710129;
	bh=zc9hK0jHrMMiD+V7uBIpSu5vlq30um47umH/ZCf0DNE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W1O2fIM5M65CVlxw4zJgVvoDcltTeirpqDwkjtF4GJnFyO/5rb83Dfc89C71GLj76
	 ySdyNlSD5Hv/5q2A+SHc2x5E+H5HbzmyvDbMo2mYQ/kxhdhv3XY59511Yh4ZY56EUA
	 q0INMbt4TtNUDS+320pnmSD9Utx/5wAlqAXf1+PCJ7GFrVZihiCsRg5dz9eq8baAxq
	 fiTOgXLu0QTMuRVOOBHUP+sA0IiOjYPY2vEjcXg5xNhHwxxnilP6nDRBG1M7pFn5h3
	 Ben/eUkpFFF5kcvQ03unfJnhGAHkLafJK0Hhzt9VzPv7tnhKAj65UM5qNj1KyYdMSO
	 2n811bSBFN2nw==
Message-ID: <737664cf-bd1b-4ea7-9203-1a8e6a3473b7@kernel.org>
Date: Sun, 9 Nov 2025 10:42:07 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2] dpll: Add dpll command
Content-Language: en-US
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: stephen@networkplumber.org, jiri@resnulli.us,
 Ivan Vecera <ivecera@redhat.com>
References: <20251107173116.96622-1-poros@redhat.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20251107173116.96622-1-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/25 10:31 AM, Petr Oros wrote:
> diff --git a/dpll/dpll.c b/dpll/dpll.c
> new file mode 100644
> index 00000000000000..995f90b66759fa
> --- /dev/null
> +++ b/dpll/dpll.c
> @@ -0,0 +1,2022 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * dpll.c	DPLL tool
> + *
> + * Authors:	Petr Oros <poros@redhat.com>
> + */
> +
> +#include <errno.h>
> +#include <getopt.h>
> +#include <inttypes.h>
> +#include <poll.h>
> +#include <signal.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <linux/dpll.h>
> +#include <linux/genetlink.h>
> +#include <libmnl/libmnl.h>
> +
> +#include "../devlink/mnlg.h"

Add a separate patch that moves mnlg.c to lib, and mnlg.h to include.

> +#include "mnl_utils.h"
> +#include "version.h"
> +#include "utils.h"
> +#include "json_print.h"
> +
> +#define pr_err(args...) fprintf(stderr, ##args)
> +#define pr_out(args...) fprintf(stdout, ##args)
> +
> +struct dpll {
> +	struct mnlu_gen_socket nlg;
> +	int argc;
> +	char **argv;
> +	bool json_output;
> +};
> +
> +static volatile sig_atomic_t monitor_running = 1;
> +
> +static void monitor_sig_handler(int signo __attribute__((unused)))
> +{
> +	monitor_running = 0;
> +}
> +
> +static int str_to_bool(const char *s, bool *val)
> +{
> +	if (!strcmp(s, "true") || !strcmp(s, "1") || !strcmp(s, "enable"))
> +		*val = true;
> +	else if (!strcmp(s, "false") || !strcmp(s, "0") ||
> +		 !strcmp(s, "disable"))
> +		*val = false;
> +	else
> +		return -EINVAL;
> +	return 0;
> +}

This essentially replicates parse_one_of(). Make it a function in
lib/utils.c and update it to use parse_one_of.

...

> +
> +static int str_to_dpll_pin_state(const char *s, __u32 *v)
> +{
> +	if (!strcmp(s, "connected"))
> +		*v = DPLL_PIN_STATE_CONNECTED;
> +	else if (!strcmp(s, "disconnected"))
> +		*v = DPLL_PIN_STATE_DISCONNECTED;
> +	else if (!strcmp(s, "selectable"))
> +		*v = DPLL_PIN_STATE_SELECTABLE;
> +	else
> +		return -EINVAL;
> +	return 0;
> +}

dpll_pin_state_name is the inverse of this; create a table that is used
for both directions.

> +
> +static int str_to_dpll_pin_type(const char *s, __u32 *type)
> +{
> +	if (!strcmp(s, "mux"))
> +		*type = DPLL_PIN_TYPE_MUX;
> +	else if (!strcmp(s, "ext"))
> +		*type = DPLL_PIN_TYPE_EXT;
> +	else if (!strcmp(s, "synce-eth-port"))
> +		*type = DPLL_PIN_TYPE_SYNCE_ETH_PORT;
> +	else if (!strcmp(s, "int-oscillator"))
> +		*type = DPLL_PIN_TYPE_INT_OSCILLATOR;
> +	else if (!strcmp(s, "gnss"))
> +		*type = DPLL_PIN_TYPE_GNSS;
> +	else
> +		return -EINVAL;
> +	return 0;
> +}

dpll_pin_type_name below is the inverse of this. Do the same here - 1
table used by both directions.

> +
> +static int dpll_parse_state(struct dpll *dpll, __u32 *state)
> +{
> +	const char *str = dpll_argv(dpll);
> +
> +	if (str_to_dpll_pin_state(str, state)) {
> +		pr_err("invalid state: %s (use connected/disconnected/selectable)\n",
> +		       str);
> +		return -EINVAL;
> +	}
> +	dpll_arg_inc(dpll);
> +	return 0;
> +}
> +
> +static int dpll_parse_direction(struct dpll *dpll, __u32 *direction)
> +{
> +	if (dpll_argv_match_inc(dpll, "input")) {
> +		*direction = DPLL_PIN_DIRECTION_INPUT;
> +	} else if (dpll_argv_match_inc(dpll, "output")) {
> +		*direction = DPLL_PIN_DIRECTION_OUTPUT;
> +	} else {
> +		pr_err("invalid direction: %s (use input/output)\n",
> +		       dpll_argv(dpll));
> +		return -EINVAL;
> +	}
> +	return 0;
> +}

again here.

> +
> +static int dpll_parse_pin_type(struct dpll *dpll, __u32 *type)
> +{
> +	const char *str = dpll_argv(dpll);
> +
> +	if (str_to_dpll_pin_type(str, type)) {
> +		pr_err("invalid type: %s (use mux/ext/synce-eth-port/int-oscillator/gnss)\n",> +		       str);
> +		return -EINVAL;
> +	}
> +	dpll_arg_inc(dpll);
> +	return 0;
> +}
> +
> +static int dpll_parse_u32(struct dpll *dpll, const char *arg_name,
> +			  __u32 *val_ptr)
> +{
> +	const char *__str = dpll_argv_next(dpll);
> +
> +	if (!__str) {
> +		pr_err("%s requires an argument\n", arg_name);
> +		return -EINVAL;
> +	}
> +	if (get_u32(val_ptr, __str, 0)) {
> +		pr_err("invalid %s: %s\n", arg_name, __str);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static int dpll_parse_attr_u32(struct dpll *dpll, struct nlmsghdr *nlh,
> +			       const char *arg_name, int attr_id)
> +{
> +	__u32 val;
> +
> +	if (dpll_parse_u32(dpll, arg_name, &val))
> +		return -EINVAL;
> +	mnl_attr_put_u32(nlh, attr_id, val);
> +	return 0;
> +}
> +
> +static int dpll_parse_attr_s32(struct dpll *dpll, struct nlmsghdr *nlh,
> +			       const char *arg_name, int attr_id)
> +{
> +	const char *str = dpll_argv_next(dpll);
> +	__s32 val;
> +
> +	if (!str) {
> +		pr_err("%s requires an argument\n", arg_name);
> +		return -EINVAL;
> +	}
> +	if (get_s32(&val, str, 0)) {
> +		pr_err("invalid %s: %s\n", arg_name, str);
> +		return -EINVAL;
> +	}
> +	mnl_attr_put_u32(nlh, attr_id, val);

function is `_s32` but the put here is `_u32`.


> +	return 0;
> +}
> +

...

> +/* Macros for printing netlink attributes
> + * These macros combine the common pattern of:
> + *
> + * if (tb[ATTR])
> + *	print_xxx(PRINT_ANY, "name", "format", mnl_attr_get_xxx(tb[ATTR]));
> + *
> + * Generic versions with custom format string (_FMT suffix)
> + * Simple versions auto-generate format string: "  name: %d\n"
> + */
> +
> +#define DPLL_PR_INT_FMT(tb, attr_id, name, format_str)                         \

INT

> +	do {                                                                   \
> +		if (tb[attr_id])                                               \
> +			print_int(PRINT_ANY, name, format_str,                 \
> +				  mnl_attr_get_u32(tb[attr_id]));              \

u32?


> +	} while (0)
> +
> +#define DPLL_PR_UINT_FMT(tb, attr_id, name, format_str)                        \
> +	do {                                                                   \
> +		if (tb[attr_id])                                               \
> +			print_uint(PRINT_ANY, name, format_str,                \
> +				   mnl_attr_get_u32(tb[attr_id]));             \
> +	} while (0)
> +
> +#define DPLL_PR_U64_FMT(tb, attr_id, name, format_str)                         \
> +	do {                                                                   \
> +		if (tb[attr_id])                                               \
> +			print_lluint(PRINT_ANY, name, format_str,              \
> +				     mnl_attr_get_u64(tb[attr_id]));           \
> +	} while (0)
> +
> +#define DPLL_PR_STR_FMT(tb, attr_id, name, format_str)                         \
> +	do {                                                                   \
> +		if (tb[attr_id])                                               \
> +			print_string(PRINT_ANY, name, format_str,              \
> +				     mnl_attr_get_str(tb[attr_id]));           \
> +	} while (0)
> +
> +/* Simple versions with auto-generated format */
> +#define DPLL_PR_INT(tb, attr_id, name)                                         \
> +	DPLL_PR_INT_FMT(tb, attr_id, name, "  " name ": %d\n")
> +
> +#define DPLL_PR_UINT(tb, attr_id, name)                                        \
> +	DPLL_PR_UINT_FMT(tb, attr_id, name, "  " name ": %u\n")
> +
> +#define DPLL_PR_U64(tb, attr_id, name)                                         \
> +	DPLL_PR_U64_FMT(tb, attr_id, name, "  " name ": %" PRIu64 "\n")
> +
> +/* Helper to read signed int (can be s32 or s64 depending on value) */
> +static __s64 mnl_attr_get_sint(const struct nlattr *attr)

one user of mnl_attr_get_sint and it expects s64

> +{
> +	if (mnl_attr_get_payload_len(attr) == sizeof(__s32))
> +		return *(__s32 *)mnl_attr_get_payload(attr);
> +	else
> +		return *(__s64 *)mnl_attr_get_payload(attr);
> +}
> +
> +#define DPLL_PR_SINT_FMT(tb, attr_id, name, format_str)                        \
> +	do {                                                                   \
> +		if (tb[attr_id])                                               \
> +			print_s64(PRINT_ANY, name, format_str,                 \
> +				  mnl_attr_get_sint(tb[attr_id]));             \
> +	} while (0)
> +

...

> +static int cmd_device_show(struct dpll *dpll)
> +{
> +	bool has_id = false;
> +	__u32 id = 0;
> +
> +	while (dpll_argc(dpll) > 0) {
> +		if (dpll_argv_match(dpll, "id")) {
> +			if (dpll_parse_u32(dpll, "id", &id))
> +				return -EINVAL;
> +			has_id = true;
> +		} else {
> +			pr_err("unknown option: %s\n", dpll_argv(dpll));
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (has_id)
> +		return cmd_device_show_id(dpll, id);
> +	else

else is not needed, just
	if ()
		return...

	return ...

> +		return cmd_device_show_dump(dpll);
> +}
> +

A few "legacy" comments? this is the first submissions for this command
to iproute2, so how is there a legacy expectation?

> +			pr_out("    ");
> +			if (freq_min == freq_max) {
> +				print_lluint(PRINT_FP, NULL, "%" PRIu64 " Hz\n",
> +					     freq_min);
> +			} else {
> +				print_lluint(PRINT_FP, NULL, "%" PRIu64,
> +					     freq_min);
> +				pr_out("-");
> +				print_lluint(PRINT_FP, NULL, "%" PRIu64 " Hz\n",
> +					     freq_max);
> +			}
> +		}
> +


