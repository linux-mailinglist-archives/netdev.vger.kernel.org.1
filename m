Return-Path: <netdev+bounces-272713-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OiWAFZLx2nbVAUAu9opvQ
	(envelope-from <netdev+bounces-272713-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 04:30:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B03634D2B3
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 04:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E4D80302A9D8
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 03:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E7A34D4CB;
	Sat, 28 Mar 2026 03:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRSDToqU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2BF1DDC3F;
	Sat, 28 Mar 2026 03:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774668626; cv=none; b=oLkcUgXFHlbCJ5uEuist3CSebJKzC6AQ376eDtMcfv8apdUL4Oa4Hs/KXDZ1ljpsXvOik2NfdwQErngWfvl8sguNRLfPmcmY9kTml3EGBfJ233nIpBHNYQjVvI85beqOZCeR+72fVR7fiRjdJWWJeuO3XWMLdRVaCs5ovo20TV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774668626; c=relaxed/simple;
	bh=j0dH5kvTMqHLiJML1JmVpOXxmBCLlUMBSucA7QjeNlA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RL8kBB++RA3loQV1P2DzbHYhIw9Q5EHNnciPLB9E4Rj/2xeLOkzHemt1tvpAiHT2nWAK2MvdP2nQvFYsg4GK1sPTlnRW/WgL0JnAEiUPOw9yhLeiBYnvUXopTLqZXZTT1d/ErvDFvPV+GVfdvMNABaNimYsNiy3VVaPwoJp/Y1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRSDToqU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A6CC19424;
	Sat, 28 Mar 2026 03:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774668626;
	bh=j0dH5kvTMqHLiJML1JmVpOXxmBCLlUMBSucA7QjeNlA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sRSDToqUtgUGZDh+5qnZAYPT3xCTpLrrjLzoZrzyFuSCOnBpxDMeA9rfKNcVrKH/T
	 pwq4NbG4CledVelDW4C1K870u2iPacWe+HG7cUpp9cAJKbVGqXCAQW2l5tr2VlVErv
	 PpJMWuxHpgdaM13etbe/8T7eX07sXvsDTQUkFXXVmddUjO6/QwOsFV8ZJnJDeIu1fi
	 oTeeNYO3BbnAR2xBnIJbZym/qeAwgpHjo25xBoO2NyQC8J1+HV9VsF1npyAGzFzZHp
	 /J5CNGjcMeTUgVk0NisrsSoCNSrb1Ho91aS7M21wD99sWyOZkzyB9dBpiBGrgbcKh4
	 oxPlZTAiVqjlg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDD73930181;
	Sat, 28 Mar 2026 03:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] ptr_ring: disable KCSAN warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177466861178.4167434.16609769903000560037.git-patchwork-notify@kernel.org>
Date: Sat, 28 Mar 2026 03:30:11 +0000
References: 
 <dd3984b3bce9df3591927f927668cb31cc7ecf34.1774460059.git.mst@redhat.com>
In-Reply-To: 
 <dd3984b3bce9df3591927f927668cb31cc7ecf34.1774460059.git.mst@redhat.com>
To: Michael S. Tsirkin <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 simon.schippers@tu-dortmund.de, willemdebruijn.kernel@gmail.com,
 jasowang@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com, leiyang@redhat.com,
 stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de,
 netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux.dev,
 edumazet@google.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,tu-dortmund.de,gmail.com,redhat.com,lunn.ch,davemloft.net,kernel.org,networkplumber.org,nutanix.com,lists.linux.dev,google.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-272713-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8B03634D2B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Mar 2026 13:36:00 -0400 you wrote:
> Eric Dumazet reported KCSAN warnings:
> 
> BUG: KCSAN: data-race in pfifo_fast_dequeue / pfifo_fast_enqueue
> 
> write to 0xffff88811d5ccc00 of 8 bytes by interrupt on cpu 0:
> __ptr_ring_zero_tail include/linux/ptr_ring.h:259 [inline]
> __ptr_ring_discard_one include/linux/ptr_ring.h:291 [inline]
> __ptr_ring_consume include/linux/ptr_ring.h:311 [inline]
> __skb_array_consume include/linux/skb_array.h:98 [inline]
> pfifo_fast_dequeue+0x770/0x8f0 net/sched/sch_generic.c:770
> dequeue_skb net/sched/sch_generic.c:297 [inline]
> qdisc_restart net/sched/sch_generic.c:402 [inline]
> __qdisc_run+0x189/0xc80 net/sched/sch_generic.c:420
> qdisc_run include/net/pkt_sched.h:120 [inline]
> net_tx_action+0x379/0x590 net/core/dev.c:5793
> handle_softirqs+0xb9/0x280 kernel/softirq.c:622
> do_softirq+0x45/0x60 kernel/softirq.c:523
> __local_bh_enable_ip+0x70/0x80 kernel/softirq.c:450
> local_bh_enable include/linux/bottom_half.h:33 [inline]
> bpf_test_run+0x2db/0x620 net/bpf/test_run.c:426
> bpf_prog_test_run_skb+0x9a4/0xef0 net/bpf/test_run.c:1159
> bpf_prog_test_run+0x204/0x340 kernel/bpf/syscall.c:4721
> __sys_bpf+0x52e/0x7e0 kernel/bpf/syscall.c:6246
> __do_sys_bpf kernel/bpf/syscall.c:6341 [inline]
> __se_sys_bpf kernel/bpf/syscall.c:6339 [inline]
> __x64_sys_bpf+0x41/0x50 kernel/bpf/syscall.c:6339
> x64_sys_call+0x10cb/0x3020 arch/x86/include/generated/asm/syscalls_64.h:322
> do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - [v2,net] ptr_ring: disable KCSAN warnings
    https://git.kernel.org/netdev/net-next/c/d748047af135

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



