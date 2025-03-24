Return-Path: <netdev+bounces-177253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE7DA6E6A0
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 23:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54AAE188D800
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 22:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2D91DE4D3;
	Mon, 24 Mar 2025 22:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sA3MJPAX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01C919049B;
	Mon, 24 Mar 2025 22:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742855688; cv=none; b=KMDBGwREoiiOf6t2zyL6tMBKhYDZZfIhDzqQ87vqZwZPdlrwFFodB7kF0uTOrg+naxfJzM/fGuM4ID/RE/+XXHTXeg9roQhX7FsQpkxi5PeeCv3HhfIjt5u5lNKGvqJE3DR2tJtJUV3ErOhcmEonELY2GPAtnV7jzP70IXnJ7iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742855688; c=relaxed/simple;
	bh=Vi1NzMDRhqogQCW68vwegbAdQ8YER+p1F3Pyameq8ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e3RZHeCG7QBZmE+jwcBCGHz1Hw6HCGYGG/FU5/eIHa2hdkz88PM7pJHEs4qOWUcUrlfr11CcyXsv4Zby/LukO35thoj/u20JRVRs6vcoIDd/3nWfqJKhbMBIHaUeDC2kSWE7lq/QHa5+GfVbaS9B17S90p2aAaL3dhJIpFOGLJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sA3MJPAX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07807C4CEDD;
	Mon, 24 Mar 2025 22:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742855688;
	bh=Vi1NzMDRhqogQCW68vwegbAdQ8YER+p1F3Pyameq8ps=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sA3MJPAXo8PHThugpPhAUQ/aoelMEhTy0UtW3P+EKpCt96WJSyW32SPp0TRq8Icuk
	 UeVh5ejO6yxoO2CTLPSF9493z8Bwtz13vyKrMTW7uNr8zLwRW/a07qOUv6+pZUNDJA
	 k8i7hxaUDjqAKmRnRfrw8jR8dJGIKFoLyHtLvvVFqg3Wj9h2H6rj1T3loAvVObIFLv
	 O702AmHcWO8yCcI707/6GRSr9nTaDlr4eqIxUGUBK1sbRFoheKSPMOHKsFo9JnrGKN
	 yg39GG80odtia61Qyk31GQ38OA2KL2f7lQhZOX6JFwHOe/EQB1MLntwo0xaYxtxq7R
	 AUoQ3IaJx7ZQw==
Message-ID: <3a086834-9237-42df-a048-e30444c30cf9@kernel.org>
Date: Mon, 24 Mar 2025 23:34:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v1] page_pool: import Jesper's page_pool
 benchmark
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jakub Kicinski <kuba@kernel.org>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgense?=
 =?UTF-8?Q?n?= <toke@toke.dk>
References: <20250309084118.3080950-1-almasrymina@google.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250309084118.3080950-1-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 09/03/2025 09.41, Mina Almasry wrote:
> diff --git a/lib/bench/time_bench.c b/lib/bench/time_bench.c
> new file mode 100644
> index 000000000000..4f5314419644
> --- /dev/null
> +++ b/lib/bench/time_bench.c
> @@ -0,0 +1,426 @@
> +/*
> + * Benchmarking code execution time inside the kernel
> + *
> + * Copyright (C) 2014, Red Hat, Inc., Jesper Dangaard Brouer
> + *  for licensing details see kernel-base/COPYING
> + */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/module.h>
> +#include <linux/time.h>
> +#include <linux/time_bench.h>
> +
> +#include <linux/perf_event.h> /* perf_event_create_kernel_counter() */
> +
> +/* For concurrency testing */
> +#include <linux/completion.h>
> +#include <linux/sched.h>
> +#include <linux/workqueue.h>
> +#include <linux/kthread.h>
> +
> +static int verbose = 1;
> +
> +/** TSC (Time-Stamp Counter) based **
> + * See: linux/time_bench.h
> + *  tsc_start_clock() and tsc_stop_clock()
> + */
> +
> +/** Wall-clock based **
> + */
> +
> +/** PMU (Performance Monitor Unit) based **
> + */
> +#define PERF_FORMAT					    \
> +	(PERF_FORMAT_GROUP | PERF_FORMAT_ID |		    \
> +	PERF_FORMAT_TOTAL_TIME_ENABLED |		    \
> +	PERF_FORMAT_TOTAL_TIME_RUNNING)
> +
> +struct raw_perf_event {
> +	uint64_t  config;  /* event */
> +	uint64_t  config1; /* umask */
> +	struct perf_event *save;
> +	char *desc;
> +};
> +
> +/* if HT is enable a maximum of 4 events (5 if one is instructions
> + * retired can be specified, if HT is disabled a maximum of 8 (9 if
> + * one is instructions retired) can be specified.
> + *
> + * From Table 19-1. Architectural Performance Events
> + * Architectures Software Developer’s Manual Volume 3: System Programming Guide
> + */
> +struct raw_perf_event perf_events[] = {
> +	{ 0x3c, 0x00, NULL, "Unhalted CPU Cycles" },
> +	{ 0xc0, 0x00, NULL, "Instruction Retired" }
> +};
> +
> +#define NUM_EVTS (sizeof(perf_events) / sizeof(struct raw_perf_event))
> +
> +/* WARNING: PMU config is currently broken!
> + */

As the comment says PMU usage is in a broken state...

I've not used it for years... below config setup code doesn't enable PMU 
correctly.
The way I've activated it (in the past) is by loading (modprobe) the
module under the `perf stat` commands, which does the correct setup, and
then benchmark code can read the PMU counters.

IMHO we should just remove all the PMU code (i.e. not upstream it).
Unless, ACME can fix below setup code in seconds... else let's not bother.

> +bool time_bench_PMU_config(bool enable)
> +{
> +	int i;
> +	struct perf_event_attr perf_conf;
> +	struct perf_event *perf_event;
> +	int cpu;
> +
> +	preempt_disable();
> +	cpu = smp_processor_id();
> +	pr_info("DEBUG: cpu:%d\n", cpu);
> +	preempt_enable();
> +
> +	memset(&perf_conf, 0, sizeof(struct perf_event_attr));
> +	perf_conf.type           = PERF_TYPE_RAW;
> +	perf_conf.size           = sizeof(struct perf_event_attr);
> +	perf_conf.read_format    = PERF_FORMAT;
> +	perf_conf.pinned         = 1;
> +	perf_conf.exclude_user   = 1; /* No userspace events */
> +	perf_conf.exclude_kernel = 0; /* Only kernel events */
> +
> +	for (i = 0; i < NUM_EVTS; i++) {
> +		perf_conf.disabled = enable;
> +		perf_conf.config = perf_events[i].config;
> +		perf_conf.config1 = perf_events[i].config1;
> +		if (verbose)
> +			pr_info("%s() enable PMU counter: %s\n",
> +				__func__, perf_events[i].desc);
> +		perf_event = perf_event_create_kernel_counter(&perf_conf, cpu,
> +						 NULL /* task */,
> +						 NULL /* overflow_handler*/,
> +						 NULL /* context */);
> +		if (perf_event) {
> +			perf_events[i].save = perf_event;
> +			pr_info("%s():DEBUG perf_event success\n", __func__);
> +
> +			perf_event_enable(perf_event);
> +		} else {
> +			pr_info("%s():DEBUG perf_event is NULL\n", __func__);
> +		}
> +	}
> +
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(time_bench_PMU_config);

Below code that reads the PMU registers are likely also flawed.
ACME feel free to yell a me ;-)

[...]
 > +/** PMU (Performance Monitor Unit) based **
 > + *
 > + * Needed for calculating: Instructions Per Cycle (IPC)
 > + * - The IPC number tell how efficient the CPU pipelining were
 > + */
 > +//lookup: perf_event_create_kernel_counter()
 > +
 > +bool time_bench_PMU_config(bool enable);
 > +
 > +/* Raw reading via rdpmc() using fixed counters
 > + *
 > + * From:https://github.com/andikleen/simple-pmu
 > + */
 > +enum {
 > +	FIXED_SELECT = (1U << 30), /* == 0x40000000 */
 > +	FIXED_INST_RETIRED_ANY      = 0,
 > +	FIXED_CPU_CLK_UNHALTED_CORE = 1,
 > +	FIXED_CPU_CLK_UNHALTED_REF  = 2,
 > +};
 > +
 > +static __always_inline unsigned long long p_rdpmc(unsigned in)
 > +{
 > +	unsigned d, a;
 > +
 > +	asm volatile("rdpmc" : "=d" (d), "=a" (a) : "c" (in) : "memory");
 > +	return ((unsigned long long)d << 32) | a;
 > +}
 > +
 > +/* These PMU counter needs to be enabled, but I don't have the
 > + * configure code implemented.  My current hack is running:
 > + *  sudo perf stat -e cycles:k -e instructions:k insmod 
lib/ring_queue_test.ko
 > + */

Here I spell out how I run the `insmod` under `perf stat`.


 > +/* Reading all pipelined instruction */
 > +static __always_inline unsigned long long pmc_inst(void)
 > +{
 > +	return p_rdpmc(FIXED_SELECT | FIXED_INST_RETIRED_ANY);
 > +}
 > +
 > +/* Reading CPU clock cycles */
 > +static __always_inline unsigned long long pmc_clk(void)
 > +{
 > +	return p_rdpmc(FIXED_SELECT | FIXED_CPU_CLK_UNHALTED_CORE);
 > +}
 > +
 > +/* Raw reading via MSR rdmsr() is likely wrong
 > + * FIXME: How can I know which raw MSR registers are conf for what?
 > + */
 > +#define MSR_IA32_PCM0 0x400000C1 /* PERFCTR0 */
 > +#define MSR_IA32_PCM1 0x400000C2 /* PERFCTR1 */
 > +#define MSR_IA32_PCM2 0x400000C3
 > +static inline uint64_t msr_inst(unsigned long long *msr_result)
 > +{
 > +	return rdmsrl_safe(MSR_IA32_PCM0, msr_result);
 > +}


--Jesper

