Return-Path: <netdev+bounces-32364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2099B796FC0
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 07:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B738B1C20AC9
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 05:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C13EA6;
	Thu,  7 Sep 2023 05:02:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E1BA47
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 05:02:44 +0000 (UTC)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E7719BC
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 22:02:42 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-44e8ddf1f1aso1005585137.1
        for <netdev@vger.kernel.org>; Wed, 06 Sep 2023 22:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci-edu.20230601.gappssmtp.com; s=20230601; t=1694062962; x=1694667762; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XCb56VrKp80bSU0vswLbV8TbBj5p+0nir/bVi0IqztE=;
        b=ULjjI98nG59P1BzjsiqE5gK7bRtg1ZXC2hAtLOBLAtdDDAoUtDgPrVj+DxoA+cto3j
         RDiDPEuDMLcQXdiIL2Zwx9YlRMCezSoC2iv/AoyK65+z3CxF36P5yT+v0981lqcq0t7i
         wM9ZXHY2WOcPbioyVEOv5XywXMyB3RwFZuUmZuyqn7jCfCpJkXerEWFTyGzLEpWeardi
         SvieaT64l0V02OntiSHfUZ/DWhKXuzOSzWZ0K0FTzWMa1iUeUS/wHwDXQUYuWIw/GYzs
         wkjlz//1lJph/ofP9NiExDID9Ib2Zp5p60T3Ajq4fCuK1Ya6NnRQsz08bUIQAa/ZzZDy
         VfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694062962; x=1694667762;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XCb56VrKp80bSU0vswLbV8TbBj5p+0nir/bVi0IqztE=;
        b=VD8WUA40NDtHwlxUCUnw/h6KHbO4jy65U52EBvpcD2DL/iymPM2gCtosLcTrX9Agof
         bFGpT3+4xlwQElcObsBnZqsCvXIOU7BuDjp78kR81Ok0t1IWrwYaQuWYfjYCgSvARVPr
         1TZZ2q6fv4Y32Pocp1EnTHuK8vnQK9PjutTJIviVEm1fJgIDz+z1xzvTxCFUD3388BYM
         LU021oAhqVyLEaecxiAy701g9gCe8llGaFMjvelUkJIxkR9kidllizDnT4PViGr366xK
         YUXyvazbqtI/3bOXeDl5kbYt8896uHzz/97m1GBZL3wRnv/kqbGRJLI9Hk+L1CVv956l
         ICaA==
X-Gm-Message-State: AOJu0Yyc7IaFkN9eCGleBdLhFjLWJvizjyurNBY0MXvNc9XzsBP5xD1X
	N3vdu+x4M8sMdr3M1ZK2TueQaQfbaa7++6ECOUEXmA==
X-Google-Smtp-Source: AGHT+IHQ6M61oX2JV8bZOgegxuC65EUC7MYQZ4+v3ZPX0rxwbO/jxIARfQy8UQns4AVF8iKFeoN2oGrliH8qWb/QfmQ=
X-Received: by 2002:a67:eecb:0:b0:44d:42c4:f4bf with SMTP id
 o11-20020a67eecb000000b0044d42c4f4bfmr1255110vsp.10.1694062961712; Wed, 06
 Sep 2023 22:02:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hsin-Wei Hung <hsinweih@uci.edu>
Date: Wed, 6 Sep 2023 22:02:05 -0700
Message-ID: <CABcoxUbYwuZUL-xm1+5juO42nJMgpQX7cNyQELYz+g2XkZi9TQ@mail.gmail.com>
Subject: Possible deadlock in bpf queue map
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

Our bpf fuzzer, a customized Syzkaller, triggered a lockdep warning in
the bpf queue map in v5.15. Since queue_stack_maps.c has no major changes
since v5.15, we think this should still exist in the latest kernel.
The bug can be occasionally triggered, and we suspect one of the
eBPF programs involved to be the following one. We also attached the lockdep
warning at the end.

#define DEFINE_BPF_MAP_NO_KEY(the_map, TypeOfMap, MapFlags,
TypeOfValue, MaxEntries) \
        struct {                                                        \
            __uint(type, TypeOfMap);                                    \
            __uint(map_flags, (MapFlags));                              \
            __uint(max_entries, (MaxEntries));                          \
            __type(value, TypeOfValue);                                 \
        } the_map SEC(".maps");

DEFINE_BPF_MAP_NO_KEY(map_0, BPF_MAP_TYPE_QUEUE, 0 | BPF_F_WRONLY,
struct_0, 162);
SEC("perf_event")
int func(struct bpf_perf_event_data *ctx) {
        char v0[96] = {};
        uint64_t v1 = 0;
        v1 = bpf_map_pop_elem(&map_0, v0);
        return 163819661;
}


The program is attached to the following perf event.

struct perf_event_attr attr_type_hw = {
        .type = PERF_TYPE_HARDWARE,
        .config = PERF_COUNT_HW_CPU_CYCLES,
        .sample_freq = 50,
        .inherit = 1,
        .freq = 1,
};

================================WARNING: inconsistent lock state
5.15.26+ #2 Not tainted
--------------------------------
inconsistent {INITIAL USE} -> {IN-NMI} usage.
syz-executor.5/19749 [HC1[1]:SC0[0]:HE0:SE1] takes:
ffff88804c9fc198 (&qs->lock){..-.}-{2:2}, at: __queue_map_get+0x31/0x250
{INITIAL USE} state was registered at:
  lock_acquire+0x1a3/0x4b0
  _raw_spin_lock_irqsave+0x48/0x60
  __queue_map_get+0x31/0x250
  bpf_prog_577904e86c81dead_func+0x12/0x4b4
  trace_call_bpf+0x262/0x5d0
  perf_trace_run_bpf_submit+0x91/0x1c0
  perf_trace_sched_switch+0x46c/0x700
  __schedule+0x11b5/0x24a0
  schedule+0xd4/0x270
  futex_wait_queue_me+0x25f/0x520
  futex_wait+0x1e0/0x5f0
  do_futex+0x395/0x1890
  __x64_sys_futex+0x1cb/0x480
  do_syscall_64+0x3b/0xc0
  entry_SYSCALL_64_after_hwframe+0x44/0xae
irq event stamp: 13640
hardirqs last  enabled at (13639): [<ffffffff95eb2bf4>]
_raw_spin_unlock_irq+0x24/0x40
hardirqs last disabled at (13640): [<ffffffff95eb2d4d>]
_raw_spin_lock_irqsave+0x5d/0x60
softirqs last  enabled at (13464): [<ffffffff93e26de5>] __sys_bpf+0x3e15/0x4e80
softirqs last disabled at (13462): [<ffffffff93e26da3>] __sys_bpf+0x3dd3/0x4e80

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&qs->lock);
  <Interrupt>
    lock(&qs->lock);

 *** DEADLOCK ***

3 locks held by syz-executor.5/19749:
 #0: ffff88801904dd80 (&sb->s_type->i_mutex_key#17){++++}-{3:3}, at:
path_openat+0x1585/0x2760
 #1: ffff88800924c020 (&chan->lock){-.-.}-{2:2}, at:
p9_virtio_request+0x18c/0x640
 #2: ffffffff977d32e0 (rcu_read_lock){....}-{1:2}, at:
is_bpf_text_address+0x5/0x180

stack backtrace:
CPU: 0 PID: 19749 Comm: syz-executor.5 Not tainted 5.15.26+ #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <NMI>
 dump_stack_lvl+0x9d/0xc9
 lock_acquire.cold+0x3b/0x40
 ? lock_release+0x6c0/0x6c0
 ? __queue_map_get+0x31/0x250
 ? __perf_event_header__init_id+0x2bd/0x610
 ? look_up_lock_class+0x76/0xd0
 ? lock_acquire+0x282/0x4b0
 _raw_spin_lock_irqsave+0x48/0x60
 ? __queue_map_get+0x31/0x250
 __queue_map_get+0x31/0x250
 bpf_prog_9e60c62721f22dfa_func+0x5a/0xc18
 bpf_overflow_handler+0x17b/0x460
 ? perf_output_read+0x12b0/0x12b0
 ? __perf_event_account_interrupt+0xe9/0x3a0
 __perf_event_overflow+0x13f/0x3c0
 handle_pmi_common+0x59b/0x980
 ? intel_pmu_save_and_restart+0x100/0x100
 ? intel_bts_interrupt+0x10d/0x3d0
 intel_pmu_handle_irq+0x28a/0x8b0
 perf_event_nmi_handler+0x4d/0x70
 nmi_handle+0x147/0x390
 default_do_nmi+0x40/0x100
 exc_nmi+0x152/0x170
 end_repeat_nmi+0x16/0x55
RIP: 0010:lock_acquire+0x1b4/0x4b0
Code: f7 6a 00 45 0f b6 c9 6a 00 ff b4 24 f8 00 00 00 ff 74 24 18 e8
cd 98 ff ff b8 ff ff ff ff 48 83 c4 20 65 0f c1 05 fc 19 50 6c <83> f8
01 0f 85 7f 02 00 00 48 83 7c 24 08 00 0f 85 50 02 00 00 48
RSP: 0018:ffff88802825ec30 EFLAGS: 00000057
RAX: 0000000000000001 RBX: 1ffff1100504bd88 RCX: 00000000dea5863f
RDX: 1ffff110053cd1b6 RSI: 1ffff1100504bd6f RDI: 00000000fe94d1a3
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff99172ba7
R10: fffffbfff322e574 R11: 0000000000000001 R12: 0000000000000002
R13: 0000000000000000 R14: ffffffff977d32e0 R15: 0000000000000000
 ? lock_acquire+0x1b4/0x4b0
 ? lock_acquire+0x1b4/0x4b0
 </NMI>

