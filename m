Return-Path: <netdev+bounces-289927-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gK0sAHOlDWrp0wUAu9opvQ
	(envelope-from <netdev+bounces-289927-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:13:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D0B58D6BC
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A0411306A489
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA223DBD44;
	Wed, 20 May 2026 12:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNY+b4wf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F41F2DCF46;
	Wed, 20 May 2026 12:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779278754; cv=none; b=DqYjfeAakBKih9O4sTdCY2MAqQAudRp07MZg2AU7Rnr0L4zALmCF6CIdPUzWmPsv45gLH1oEFdkHPgqvKln2zNjZD3RXcxkO3omZxRtM0lNfmuYiolC1CvZdsNspgf1+JM/P68sDNfgY7NnuAN9lbNRXfblMYpC6daKt9EdpMR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779278754; c=relaxed/simple;
	bh=UYUOuk1VwSci2peHvj/JRnwtTW28xTWkrFGCFYL0ms0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=NBaQ3PNy+irsL5uCU00bxG4Eux5rQiu0o+ygqKoCHXqfL8iGnqYpMX02siyujsYb8AUwS27qJzxl3MDHcSTM7ZpEQsz+rZkIWdB3qOvAbPgl5ItN8XcnBDgqKK+bo1W5B8FukfBin5JprmLYtG1oaGAj/Yw28gKBYTsPJ0LmzUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNY+b4wf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371B81F000E9;
	Wed, 20 May 2026 12:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779278752;
	bh=+zLIaM5TyiQu+/+rrgc9oimvpZ04kcixkpZqRos2n48=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To;
	b=oNY+b4wfJ5QzUCJYtoiTXs0pKZHkqxUp9rmeM6I6QH05DF369WqJOsb1s2ZmKBXag
	 IeNdQksgEpTAHGMSssOzO/qfpVJfHGX3JgeMZhhq7yJALCBV6r6pvFSUz0GaBYeiX/
	 YcH83qVmwijn7c8YJ7uVilake1bg3r7ai0JKwpRn1h5GdtfBCXZx22BBL3YKFqBCiq
	 UsVj8pA3Mrg6jK5mticpJvC3fJR9zDthRBsCGBVxyKg9+SpVoKKNvgoOR7AVGZIaVT
	 h9iJs50jcFgDpDq6RuWf4fb+3z0a7C7kNY9oxqRFnT66Ax950na57xmNLcsP9piLtY
	 3GG34xWS4vkog==
Message-ID: <91a3a37b-7c4e-409b-b85c-36b530a738fe@kernel.org>
Date: Wed, 20 May 2026 22:05:45 +1000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [syzbot] [mptcp?] WARNING in mptcp_pm_alloc_anno_list (2)
Content-Language: fr
To: syzbot <syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com>
References: <6a0da138.170a0220.3cbd30.0141.GAE@google.com>
From: Matthieu Baerts <matttbe@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, geliang@kernel.org,
 horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 martineau@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org,
 pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <6a0da138.170a0220.3cbd30.0141.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=cb5b551cf65fa040];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289927-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,syzkaller.appspot.com:url,storage.googleapis.com:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,55c2a5c871441261ed14];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 98D0B58D6BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

On 20/05/2026 21:55, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ab5fce87a778 Merge tag 'perf-tools-fixes-for-v7.1-2026-05-..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=175fcca6580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cb5b551cf65fa040
> dashboard link: https://syzkaller.appspot.com/bug?extid=55c2a5c871441261ed14
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/e36518c61bd7/disk-ab5fce87.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/cd934c0c8950/vmlinux-ab5fce87.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/88cf18661142/bzImage-ab5fce87.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> mptcp_pm_is_kernel(msk)
> WARNING: net/mptcp/pm.c:436 at mptcp_pm_alloc_anno_list+0x408/0x4d0 net/mptcp/pm.c:436, CPU#1: kworker/1:6/5792
> Modules linked in:
> CPU: 1 UID: 0 PID: 5792 Comm: kworker/1:6 Tainted: G             L      syzkaller #0 PREEMPT(full) 
> Tainted: [L]=SOFTLOCKUP
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
> Workqueue: events mptcp_worker
> RIP: 0010:mptcp_pm_alloc_anno_list+0x408/0x4d0 net/mptcp/pm.c:436
> Code: 8d 7b 30 49 c7 c0 00 6f 64 9b 48 c7 c1 40 f5 28 8d 31 d2 48 c7 c6 b0 43 77 8b e8 c3 b3 7c f6 e9 c6 fc ff ff e8 c9 5b 91 f6 90 <0f> 0b 90 31 db e9 09 fd ff ff 48 c7 c7 c4 39 d8 90 e8 22 27 fe f6
> RSP: 0018:ffffc90004187818 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff888079295f00 RCX: ffffffff8b772ecf
> RDX: ffff888029de1ec0 RSI: ffffffff8b773217 RDI: ffff888029de1ec0
> RBP: ffff88807e593100 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: dffffc0000000000 R14: ffff88807e593100 R15: ffff88806a3a5e80
> FS:  0000000000000000(0000) GS:ffff88812446d000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000020000035e030 CR3: 0000000068e39000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>  mptcp_pm_create_subflow_or_signal_addr+0xa7a/0x18a0 net/mptcp/pm_kernel.c:373
>  mptcp_pm_nl_subflow_established net/mptcp/pm_kernel.c:443 [inline]
>  __mptcp_pm_kernel_worker+0xe5/0x1f0 net/mptcp/pm_kernel.c:1573
>  mptcp_pm_worker+0x12b/0x320 net/mptcp/pm.c:1069
>  mptcp_worker+0x15d/0x1420 net/mptcp/protocol.c:2976
>  process_one_work+0xa0e/0x1980 kernel/workqueue.c:3314
>  process_scheduled_works kernel/workqueue.c:3397 [inline]
>  worker_thread+0x5ef/0xe50 kernel/workqueue.c:3478
>  kthread+0x370/0x450 kernel/kthread.c:436
>  ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
This one looks similar to

  https://github.com/multipath-tcp/mptcp_net-next/issues/620

Not sure how it happened, but it doesn't look serious. Probably an odd
path switching between path-managers during the establishment of a
connection, or a reconnect.

To be investigated, but a reproducer would help here.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


