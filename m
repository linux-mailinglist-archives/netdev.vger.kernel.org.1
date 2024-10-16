Return-Path: <netdev+bounces-136189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8F59A0E31
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 17:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EC251C20C9D
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 15:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92B420E029;
	Wed, 16 Oct 2024 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OySxTNcb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB03126F1E;
	Wed, 16 Oct 2024 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729092571; cv=none; b=DrbvQs9bB9k/03cZuTgvDxgnnxMHfaXgxdeu2/ynpJjDsT/qxO+6aUwU4bmjxtE9vQDjn7VW/3gz4V/i59OPlyB44ZALUH/Gnmmzy6qE8YFHl5X6SDn1Majfc0Nv4bpztdW36b6FsriflxwQGEfi0CLeA/qtTiCRVb8d3DdZOFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729092571; c=relaxed/simple;
	bh=MvDwE3/z4JPUki6lMeQKyNnUOD9grJy6ttxMPbfIZAE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SJn22bEW281HMKWVoyud8K8f/8V6/EBG71Zlpph8vP685cGqHQTl+shXAGiU4W0jrpp/k+4cRHj2rk9LWQeSJxBDXPqlOfMArK1gP2DMI98/+h4luVgHxBW8+WXxwUXeAuL1RaNIuTOjnUshaA/nKPLCIMwUaCu+qB2oDvl7pzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OySxTNcb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A85EC4CEC5;
	Wed, 16 Oct 2024 15:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729092571;
	bh=MvDwE3/z4JPUki6lMeQKyNnUOD9grJy6ttxMPbfIZAE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=OySxTNcbli1ikrG2JpEacw6LK/2yRtBSiX/5D4oMRcZTvZYlLQ1NdUTUPYhzdu8rj
	 3XoNPg6AgJoUoFgclPuSIMHMXIebFw4xKSJ5fIcCUpYjSUITJMEf7tHBgDAI8vzbju
	 j+TgDZtU89cfg3GY5pqkcE8EFR3IUtWn/Ff86ZU6xL4wL93NKLESDDcy0o6Ws2ObJ6
	 EDofQj9auvwYEGZAaL8Jkn9oFhX99KpwB9gXWD+L76c7D7axD/mACEKEKuGKH4GJSZ
	 Ynf1jbJl3VlBOZYHusfckYlVpEklFgygvVS+b4bCjkC8IbJIoaTbncMZwTYPxdi92F
	 bJB1MvGMuB5DA==
Message-ID: <e9739fe9-d395-43d9-9cd9-547107cf781f@kernel.org>
Date: Wed, 16 Oct 2024 17:29:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH rcu] configs/debug: make sure PROVE_RCU_LIST=y takes
 effect
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
 joel@joelfernandes.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 kees@kernel.org, paulmck@kernel.org
References: <20241016011144.3058445-1-kuba@kernel.org>
 <22df18fd-4db4-4bf6-94e2-5a45aad91680@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <22df18fd-4db4-4bf6-94e2-5a45aad91680@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/10/2024 17:18, Matthieu Baerts wrote:
> Hi Jakub,
> 
> On 16/10/2024 03:11, Jakub Kicinski wrote:
>> Commit 0aaa8977acbf ("configs: introduce debug.config for CI-like setup")
>> added CONFIG_PROVE_RCU_LIST=y to the common CI config,
>> but RCU_EXPERT is not set, and it's a dependency for
>> CONFIG_PROVE_RCU_LIST=y. Make sure CIs take advantage
>> of CONFIG_PROVE_RCU_LIST=y, recent fixes in networking
>> indicate that it does catch bugs.
> 
> Good catch! I confirm it fixes the issue:
> 
> Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> ---
>> I'd be slightly tempted to still send it to Linux for v6.12.
> 
> Good idea, it sounds like a fix because I guess if it was on the list,
> it was supposed to be used. But be careful it might detect quite a few
> issues: I just enabled it on MPTCP tree, and it found issues.
Sorry, I forgot to mention that it found 3 issues: one specific to
MPTCP, one in Netfilter, but also one when shutting down the VM:


> # /usr/lib/klibc/bin/poweroff
> [ 2360.588763][T11825] 
> [ 2360.589006][T11825] =============================
> [ 2360.589424][T11825] WARNING: suspicious RCU usage
> [ 2360.589952][T11825] 6.12.0-rc2+ #1 Tainted: G                 N
> [ 2360.590522][T11825] -----------------------------
> [ 2360.590896][T11825] kernel/events/core.c:13962 RCU-list traversed in non-reader section!!
> [ 2360.592341][T11825] 
> [ 2360.592341][T11825] other info that might help us debug this:
> [ 2360.592341][T11825] 
> [ 2360.593343][T11825] 
> [ 2360.593343][T11825] rcu_scheduler_active = 2, debug_locks = 1
> [ 2360.593951][T11825] 3 locks held by poweroff/11825:
> [2360.594481][T11825] #0: ffffffff89641e28 (system_transition_mutex){+.+.}-{3:3}, at: __do_sys_reboot (kernel/reboot.c:770) 
> [2360.594997][T11825] #1: ffffffff8963eab0 ((reboot_notifier_list).rwsem){++++}-{3:3}, at: blocking_notifier_call_chain (kernel/notifier.c:388) 
> [2360.595859][T11825] #2: ffffffff898d1a68 (pmus_lock){+.+.}-{3:3}, at: perf_event_exit_cpu_context (kernel/events/core.c:13983) 
> [ 2360.596645][T11825] 
> [ 2360.596645][T11825] stack backtrace:
> [ 2360.597476][T11825] CPU: 3 UID: 0 PID: 11825 Comm: poweroff Tainted: G                 N 6.12.0-rc2+ #1
> [ 2360.597987][T11825] Tainted: [N]=TEST
> [ 2360.598291][T11825] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> [ 2360.598890][T11825] Call Trace:
> [ 2360.599295][T11825]  <TASK>
> [2360.599568][T11825] dump_stack_lvl (lib/dump_stack.c:123) 
> [2360.600032][T11825] lockdep_rcu_suspicious (kernel/locking/lockdep.c:6822) 
> [2360.600518][T11825] perf_event_clear_cpumask (kernel/events/core.c:13962 (discriminator 9)) 
> [2360.600972][T11825] ? __pfx_perf_event_clear_cpumask (kernel/events/core.c:13939) 
> [2360.601607][T11825] ? acpi_execute_simple_method (drivers/acpi/utils.c:679) 
> [2360.601988][T11825] ? __pfx_acpi_execute_simple_method (drivers/acpi/utils.c:679) 
> [2360.602577][T11825] ? md_notify_reboot (drivers/md/md.c:9860) 
> [2360.603043][T11825] perf_event_exit_cpu_context (kernel/events/core.c:13984 (discriminator 1)) 
> [2360.603543][T11825] perf_reboot (kernel/events/core.c:14066 (discriminator 3)) 
> [2360.603979][T11825] ? trace_notifier_run (include/trace/events/notifier.h:59 (discriminator 2)) 
> [2360.604454][T11825] notifier_call_chain (kernel/notifier.c:93) 
> [2360.604833][T11825] blocking_notifier_call_chain (kernel/notifier.c:389) 
> [2360.605522][T11825] kernel_power_off (kernel/reboot.c:294) 
> [2360.605908][T11825] __do_sys_reboot (kernel/reboot.c:771) 
> [2360.606320][T11825] ? __pfx___do_sys_reboot (kernel/reboot.c:717) 
> [2360.606739][T11825] ? __pfx_ksys_sync (fs/sync.c:98) 
> [2360.607113][T11825] do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1)) 
> [2360.607551][T11825] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
> [ 2360.607911][T11825] RIP: 0033:0x20e505
> [ 2360.608320][T11825] Code: 48 89 77 38 c3 89 f0 48 8b 1f 48 8b 67 08 48 8b 6f 10 4c 8b 67 18 4c 8b 6f 20 4c 8b 77 28 4c 8b 7f 30 ff 67 38 49 89 ca 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 f7 d8 89 05 d6 8e 00 00 48 83 c8 ff c3
> All code
> ========
>    0:	48 89 77 38          	mov    %rsi,0x38(%rdi)
>    4:	c3                   	ret
>    5:	89 f0                	mov    %esi,%eax
>    7:	48 8b 1f             	mov    (%rdi),%rbx
>    a:	48 8b 67 08          	mov    0x8(%rdi),%rsp
>    e:	48 8b 6f 10          	mov    0x10(%rdi),%rbp
>   12:	4c 8b 67 18          	mov    0x18(%rdi),%r12
>   16:	4c 8b 6f 20          	mov    0x20(%rdi),%r13
>   1a:	4c 8b 77 28          	mov    0x28(%rdi),%r14
>   1e:	4c 8b 7f 30          	mov    0x30(%rdi),%r15
>   22:	ff 67 38             	jmp    *0x38(%rdi)
>   25:	49 89 ca             	mov    %rcx,%r10
>   28:	0f 05                	syscall
>   2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
>   30:	73 01                	jae    0x33
>   32:	c3                   	ret
>   33:	f7 d8                	neg    %eax
>   35:	89 05 d6 8e 00 00    	mov    %eax,0x8ed6(%rip)        # 0x8f11
>   3b:	48 83 c8 ff          	or     $0xffffffffffffffff,%rax
>   3f:	c3                   	ret
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
>    6:	73 01                	jae    0x9
>    8:	c3                   	ret
>    9:	f7 d8                	neg    %eax
>    b:	89 05 d6 8e 00 00    	mov    %eax,0x8ed6(%rip)        # 0x8ee7
>   11:	48 83 c8 ff          	or     $0xffffffffffffffff,%rax
>   15:	c3                   	ret
> [ 2360.609571][T11825] RSP: 002b:00007ffd898b0d58 EFLAGS: 00000217 ORIG_RAX: 00000000000000a9
> [ 2360.610171][T11825] RAX: ffffffffffffffda RBX: 000000004321fedc RCX: 000000000020e505
> [ 2360.610763][T11825] RDX: 000000004321fedc RSI: 0000000028121969 RDI: 00000000fee1dead
> [ 2360.611461][T11825] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000213020
> [ 2360.611987][T11825] R10: 0000000000000000 R11: 0000000000000217 R12: 00007ffd898b0db8
> [ 2360.612583][T11825] R13: 0000000000401000 R14: 0000000000000000 R15: 0000000000000000
> [ 2360.613142][T11825]  </TASK>
> [ 2360.615641][T11825] ACPI: PM: Preparing to enter system sleep state S5
> [ 2360.617134][T11825] kvm: exiting hardware virtualization
> [ 2360.617715][T11825] reboot: Power down


I can easily reproduce this one: this means that all "debug" VMs will
report issues!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


