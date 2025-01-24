Return-Path: <netdev+bounces-160833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35584A1BB87
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 18:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDCD1188C94E
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 17:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CA41CEEA4;
	Fri, 24 Jan 2025 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="unFS/zxg"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B576B1C5F2B;
	Fri, 24 Jan 2025 17:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737740130; cv=none; b=poro/f4sdnZHaAvw1YQp/M7Yr+/yPC8bEO487Ls0P28DhbR0zHcx2KPbwqVwRPTUVbrAH5Wvxe65GkXtyxPG5zlBujxfXW3NHwWT2n+Rct9JuUHeP9fw2LPvaJ4TUI+FnhSf7/RrHUr6zhztdjiaV44GAT5oAFjJE+CW1YSpqbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737740130; c=relaxed/simple;
	bh=YxHdzO8LMBxvXBXKz38pAaN1kH89l4af8hdoM58dBus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hTSYB8GBpuE8PbIi4TiqfYh0i7Kdte8iij3LJlNc95O200lc6hM2TTzeE5HH2fW5A9QhEUpr61TxkdyholGgA4u/QR1j1tQ+MF9vFl6S5lYMp9DfLE9HI3v8Y5yn4SvgdfpyvuR6da987wUnPf74KjgzXPvlbLLFy5nVS4Gh3NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=unFS/zxg; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8186a9c5-8a78-4c0b-a0a3-256231ef8f86@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737740115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AVDk4Qmge+d9+zv9jHy0P0dAeBXk61CtVVJCRllCkIA=;
	b=unFS/zxgDEPSFMvJFEcSqIJbrtib+C0YIjREj056krR2nwJI4BQEcOXismH2v/LWd7ItoQ
	d0FDUDw6vK+Ki/UEaGM9oUEP3ZxfTrsJAYZHIe1pG9MEOW8BG4OjSLYNxQNpL1kRqbaKoQ
	4cl1fqgxOzUQ+DTLS0YaU71fsHlON7M=
Date: Fri, 24 Jan 2025 09:35:08 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC net-next] trace: tcp: Add tracepoint for
 tcp_cwnd_reduction()
Content-Language: en-GB
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Breno Leitao <leitao@debian.org>, Jason Xing <kerneljasonxing@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernel-team@meta.com, Song Liu <song@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20250120-cwnd_tracepoint-v1-1-36b0e0d643fa@debian.org>
 <CAL+tcoC+A94uzaSZ+SKhV04=iDWrvUGEfxYJKYCF0ovqvyhfOg@mail.gmail.com>
 <20250120-panda-of-impressive-aptitude-2b714e@leitao>
 <CAL+tcoCzStjkEMdNw5ORYbQy3VnVE9A6aj6HcmQvGj3VG1VypA@mail.gmail.com>
 <20250120-daring-outstanding-jaguarundi-c8aaed@leitao>
 <20250120100340.4129eff7@batman.local.home>
 <20250122-vengeful-myna-of-tranquility-f0f8cf@leitao>
 <20250122095604.3c93bc93@gandalf.local.home>
 <4f3dfc10-7959-4ec7-9ce7-7a555f4865c2@linux.dev>
 <20250124105022.7baeeb33@gandalf.local.home>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250124105022.7baeeb33@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT




On 1/24/25 7:50 AM, Steven Rostedt wrote:
> On Thu, 23 Jan 2025 20:40:20 -0800
> Yonghong Song <yonghong.song@linux.dev> wrote:
>
>> Hi, Steve,
>>
>> I did some prototype to support bpf dynamic_events tracepoint. I fixed a couple of issues
> Before I go further, I want to make sure that we have our terminology's
> inline. A dynamic event is one that is created at run time. For example, a
> kprobe event is a dynamic event. Other dynamic events are synthetic events,
> event probes, and uprobes.
>
>> but still not working. See the hacked patch:
>>
>> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
>> index 9ea4c404bd4e..729ea1c21c94 100644
>> --- a/include/trace/events/sched.h
>> +++ b/include/trace/events/sched.h
>> @@ -824,6 +824,15 @@ DECLARE_TRACE(sched_compute_energy_tp,
>>                    unsigned long max_util, unsigned long busy_time),
>>           TP_ARGS(p, dst_cpu, energy, max_util, busy_time));
>>                                                                                                                                             
>> +/* At /sys/kernel/debug/tracing directory, do
>> + *   echo 't sched_switch_dynamic' >> dynamic_events
>> + * before actually use this tracepoint. The tracepoint will be at
>> + *   /sys/kernel/debug/tracing/events/tracepoints/sched_switch_dynamic/
>> + */
>> +DECLARE_TRACE(sched_switch_dynamic,
>> +       TP_PROTO(bool preempt),
>> +       TP_ARGS(preempt));
> The above is just creating a tracepoint and no "event" is attached to it.
>
> tracepoints (defined in include/linux/tracepoints.h) are what creates the
> hooks within the kernel. The trace_##call() functions, like trace_sched_switch().
> A trace event is something that can be attached to tracepoints, and show up
> in the tracefs file system. The TRACE_EVENT() macro will create both a
> tracepoint and a trace event that attaches to the tracepoint it created.
>
>> +
>>    #endif /* _TRACE_SCHED_H */
>>                                                                                                                                             
>>    /* This part must be outside protection */
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 065f9188b44a..37391eb5089f 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -10749,6 +10749,7 @@ static inline bool perf_event_is_tracing(struct perf_event *event)
>>    int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog,
>>                               u64 bpf_cookie)
>>    {
>> +       u32 dyn_tp_flags = TRACE_EVENT_FL_DYNAMIC | TRACE_EVENT_FL_FPROBE;
>>           bool is_kprobe, is_uprobe, is_tracepoint, is_syscall_tp;
>>     
>>           if (!perf_event_is_tracing(event))
>> @@ -10756,7 +10757,9 @@ int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog,
>>     
>>           is_kprobe = event->tp_event->flags & TRACE_EVENT_FL_KPROBE;
>>           is_uprobe = event->tp_event->flags & TRACE_EVENT_FL_UPROBE;
>> -       is_tracepoint = event->tp_event->flags & TRACE_EVENT_FL_TRACEPOINT;
>> +       is_tracepoint = (event->tp_event->flags & TRACE_EVENT_FL_TRACEPOINT) ||
>> +                       ((event->tp_event->flags & dyn_tp_flags) == dyn_tp_flags);
>> +
>>           is_syscall_tp = is_syscall_trace_event(event->tp_event);
>>           if (!is_kprobe && !is_uprobe && !is_tracepoint && !is_syscall_tp)
>>                   /* bpf programs can only be attached to u/kprobe or tracepoint */
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 3e5a6bf587f9..53b3d9e20d00 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -6750,6 +6750,7 @@ static void __sched notrace __schedule(int sched_mode)
>>                   psi_account_irqtime(rq, prev, next);
>>                   psi_sched_switch(prev, next, block);
>>     
>> +               trace_sched_switch_dynamic(preempt);
>>                   trace_sched_switch(preempt, prev, next, prev_state);
>>     
>>                   /* Also unlocks the rq: */
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index 71c1c02ca7a3..8f9fd2f347ef 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -2448,7 +2448,8 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
>>                               u64 *probe_offset, u64 *probe_addr,
>>                               unsigned long *missed)
>>    {
>> -       bool is_tracepoint, is_syscall_tp;
>> +       u32 dyn_tp_flags = TRACE_EVENT_FL_DYNAMIC | TRACE_EVENT_FL_FPROBE;
>> +       bool is_tracepoint, is_dyn_tracepoint, is_syscall_tp;
>>           struct bpf_prog *prog;
>>           int flags, err = 0;
>>     
>> @@ -2463,9 +2464,10 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
>>           *prog_id = prog->aux->id;
>>           flags = event->tp_event->flags;
>>           is_tracepoint = flags & TRACE_EVENT_FL_TRACEPOINT;
>> +       is_dyn_tracepoint = (event->tp_event->flags & dyn_tp_flags) == dyn_tp_flags;
>>           is_syscall_tp = is_syscall_trace_event(event->tp_event);
>>     
>> -       if (is_tracepoint || is_syscall_tp) {
>> +       if (is_tracepoint || is_dyn_tracepoint || is_syscall_tp) {
>>                   *buf = is_tracepoint ? event->tp_event->tp->name
>>                                        : event->tp_event->name;
>>                   /* We allow NULL pointer for tracepoint */
>> diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
>> index c62d1629cffe..bacc4a1f5f20 100644
>> --- a/kernel/trace/trace_fprobe.c
>> +++ b/kernel/trace/trace_fprobe.c
>> @@ -436,8 +436,10 @@ static struct trace_fprobe *find_trace_fprobe(const char *event,
>>     
>>    static inline int __enable_trace_fprobe(struct trace_fprobe *tf)
>>    {
>> -       if (trace_fprobe_is_registered(tf))
>> +       if (trace_fprobe_is_registered(tf)) {
>> +               pr_warn("fprobe is enabled\n");
>>                   enable_fprobe(&tf->fp);
>> +       }
>>     
>>           return 0;
>>    }
>> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
>> index 1702aa592c2c..423770aa581e 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
>> @@ -196,6 +196,8 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>>           /* notify child safe to exit */
>>           ASSERT_EQ(write(pipe_p2c[1], buf, 1), 1, "pipe_write");
>>     
>> +       ASSERT_EQ(skel->bss->dyn_tp_visited, 1, "dyn_tp_visited");
>> +
>>    disable_pmu:
>>           close(pmu_fd);
>>    destroy_skel:
>> @@ -260,6 +262,8 @@ void test_send_signal(void)
>>    {
>>           if (test__start_subtest("send_signal_tracepoint"))
>>                   test_send_signal_tracepoint(false, false);
>> +/* Disable all other subtests except above send_signal_tracepoint. */
>> +if (0) {
>>           if (test__start_subtest("send_signal_perf"))
>>                   test_send_signal_perf(false, false);
>>           if (test__start_subtest("send_signal_nmi"))
>> @@ -285,3 +289,4 @@ void test_send_signal(void)
>>           if (test__start_subtest("send_signal_nmi_thread_remote"))
>>                   test_send_signal_nmi(true, true);
>>    }
> The above looks like you are trying to create your own dynamic event on top
> of the tracepoint you made.
>
>> +}
>> diff --git a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
>> index 176a355e3062..9b580d437046 100644
>> --- a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
>> +++ b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
>> @@ -60,6 +60,20 @@ int send_signal_tp_sched(void *ctx)
>>           return bpf_send_signal_test(ctx);
>>    }
>>     
>> +int dyn_tp_visited = 0;
>> +#if 1
>> +/* This will fail */
>> +SEC("tracepoint/tracepoints/sched_switch_dynamic")
>> +#else
>> +/* This will succeed */
>> +SEC("tracepoint/sched/sched_switch")
>> +#endif
> I don't know bpf code at all, so I don't know what this is trying to do. Is
> it looking at the tracefs file system?

Thanks for the above clarification for terminologies.
For the above code, yet, I try to look at tracefs file system since
at runtime once we add 'sched_switch_dynamic' to dynamic_events,
the above tracepoint tracepoints/sched_switch_dynamic will show up
in /sys/kernel/debug/tracing/events/ directory.

>
> What I was suggesting, was not to use trace events at all (nothing should
> be added to the tracefs files system). You would need some code inside the
> kernel to search for tracepoints that are not exported to tracefs and then
> BPF could provide its own hooks to them. Isn't this what BPF raw tracepoints do?

Thanks for suggestion! I tried and raw tracepoint indeed work. The following
is a hack:

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 9ea4c404bd4e..db28c5c37a10 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -824,6 +824,10 @@ DECLARE_TRACE(sched_compute_energy_tp,
                  unsigned long max_util, unsigned long busy_time),
         TP_ARGS(p, dst_cpu, energy, max_util, busy_time));
                                                                                                                                           
+DECLARE_TRACE(sched_switch_hack,
+       TP_PROTO(bool preempt),
+       TP_ARGS(preempt));
+
  #endif /* _TRACE_SCHED_H */
                                                                                                                                           
  /* This part must be outside protection */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 88a9a515b2ba..df3e52d89c94 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6754,6 +6754,7 @@ static void __sched notrace __schedule(int sched_mode)
                 psi_sched_switch(prev, next, !task_on_rq_queued(prev) ||
                                              prev->se.sched_delayed);
                                                                                                                                           
+               trace_sched_switch_hack(preempt);
                 trace_sched_switch(preempt, prev, next, prev_state);
   
                 /* Also unlocks the rq: */
diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
index 1702aa592c2c..937d5e05fe08 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -195,6 +195,8 @@ static void test_send_signal_common(struct perf_event_attr *attr,
   
         /* notify child safe to exit */
         ASSERT_EQ(write(pipe_p2c[1], buf, 1), 1, "pipe_write");
+       if (!attr)
+               ASSERT_EQ(skel->bss->dyn_tp_visited, 1, "dyn_tp_visited");
   
  disable_pmu:
         close(pmu_fd);
diff --git a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
index 176a355e3062..abed1a55ae3b 100644
--- a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
@@ -60,6 +60,15 @@ int send_signal_tp_sched(void *ctx)
         return bpf_send_signal_test(ctx);
  }
   
+int dyn_tp_visited = 0;
+
+SEC("raw_tp/sched_switch_hack")
+int send_signal_dyn_tp_sched(void *ctx)
+{
+       dyn_tp_visited = 1;
+       return 0;
+}
+
  SEC("perf_event")
  int send_signal_perf(void *ctx)
  {

The raw_tp/sched_switch_hack works great!

>
>> +int send_signal_dyn_tp_sched(void *ctx)
>> +{
>> +       dyn_tp_visited = 1;
>> +       return 0;
>> +}
>> +
>>    SEC("perf_event")
>>    int send_signal_perf(void *ctx)
>>    {
>>
>> To test the above, build the latest bpf-next and then apply the above change.
>> Boot the updated kernel and boot into a qemu VM and run bpf selftest
>>     ./test_progs -t send_signal
>>
>> With tracepoint tracepoint/sched/sched_switch, the test result is correct.
>> With tracepoint tracepoint/tracepoints/sched_switch_dynamic, the test failed.
>> The test failure means the sched_switch_dynamic tracepoint is not
>> triggered with the bpf program.
>>
>> As expected, do
>>     echo 1 > /sys/kernel/debug/tracing/events/tracepoints/sched_switch_dynamic/enable
>> and the sched_switch_dynamic tracepoint works as expected (trace_pipe can dump
>> the expected result).
>>
>> For both 'echo 1 > .../sched_switch_dynamic/enable' approach and
>> bpf tracepoint tracepoint/tracepoints/sched_switch_dynamic, the message
>>     fprobe is enabled
>> is printed out in dmesg. The following is enable_fprobe() code.
>>
>> /**
>>    * enable_fprobe() - Enable fprobe
>>    * @fp: The fprobe to be enabled.
>>    *
>>    * This will soft-enable @fp.
>>    */
>> static inline void enable_fprobe(struct fprobe *fp)
>> {
>>           if (fp)
>>                   fp->flags &= ~FPROBE_FL_DISABLED;
>> }
>>
>> Note that in the above the fprobe/dynamic_events is soft-enable.
>> Maybe the bpf tracepoint/tracepoints/sched_switch_dynamic only has
>> soft-enable and 'echo 1 > ...' approach has both soft-enable and
>> actual hard-enable (at pmu level)? If this is the case, what is
>> missing for hard-enable for bpf dynamic_events case? Do you have
>> any suggestions?
>>
>>
>> The above prototype tries to reuse the existing infra/API.
>> If you have better way to support dynamic_events, please let me know.
> Either create a full trace event (one that is exposed in tracefs), or add a
> direct hook to the tracepoint you want. What the above looks like is some
> kind of mixture of the two. No "dynamic events" should be involed.

Indeed, as you suggested in the above, raw_tracepoint works fine for bpf
for those DECLARE_TRACE tracepoints. We can just use it.

>
> -- Steve
>


