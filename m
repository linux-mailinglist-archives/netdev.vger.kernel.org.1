Return-Path: <netdev+bounces-276233-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGA9A3Cy1WlF8wcAu9opvQ
	(envelope-from <netdev+bounces-276233-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 03:42:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D8D3B6021
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 03:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33237301BED1
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 01:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E7A34403D;
	Wed,  8 Apr 2026 01:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqJYZ67D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43111448E0
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 01:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775612524; cv=none; b=hEXfq690spaBe5Ry7j1fcf2JHeUdMzrEemiShiZ20T63CAqqYE2byP/gWrE2sINjxj1CzG/8PfB02Rmq08/h/qOuUJ2cAXP0RgRUn5UYrCcoQ/jXEEZcKk28/pwDzudAf7hquszF9EMSGQSRvPP7zq5MwaOS1XsXAHHSoFyzOdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775612524; c=relaxed/simple;
	bh=zYhaCYwc8i8xPwfbp6YhRW2YziF87VVMNZsRp6y9iWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fGYiDzGbOUVM+MbDJi2K54DLB9B3aa47+LXu66HBDdxQsKzkACAMuYjVyKj2meso5QELBtiLkZP/rcXTz6zuWsrITuA6KN97JWi2Jy4vYlWrchIF6Ae3SYjPmd5K4klhagpk+9HGVYb58zm8mYo1nEiiVh8xhQ9jPCBZbFA0re4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqJYZ67D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E65C19421;
	Wed,  8 Apr 2026 01:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775612523;
	bh=zYhaCYwc8i8xPwfbp6YhRW2YziF87VVMNZsRp6y9iWU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LqJYZ67D+JM/WlxnQq96JX9OQ7dYMr/ucp1tWGBDm4DEVi3BpdZ5aIK0QkjB8yCbX
	 pNxQByq7kGoM16Azuu1x1fMv+Xam0EMiuxysuebSsfS0rmifG8a+raPLj7FJ7vb5yk
	 w/E8iNjeKFhiOKa4Y7n9MwwQXEO3eEjeE5FryRYuT42VImdis69u7/DgYUAwYS/n96
	 kmAngIWAzh6xm6SSaRlkxsD5Vo7VhLt2N9QIjbH/cSfMbO6FaTnaBD7DGNwEVxv2Sb
	 0F45q9EbaN3X1l1SQfKJ2apkFxTTVLNuRKtotmSQtgS6MTeLPLrftKwNEVvq85p4K+
	 RofqqntJ/9zMQ==
Date: Tue, 7 Apr 2026 18:42:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v3 net-next 00/15] ip6mr: No RTNL for RTNL_FAMILY_IP6MR
 rtnetlink.
Message-ID: <20260407184202.34cfe2d6@kernel.org>
In-Reply-To: <20260407212001.2368593-1-kuniyu@google.com>
References: <20260407212001.2368593-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-276233-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 76D8D3B6021
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue,  7 Apr 2026 21:19:33 +0000 Kuniyuki Iwashima wrote:
> This series is the IPv6 version of
> 
>   https://lore.kernel.org/netdev/20260228221800.1082070-1-kuniyu@google.com/
> 
> and removes RTNL from ip6mr rtnetlink handlers.

CI says:

[  857.648411][   T63] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] SMP KASAN
[  857.648639][   T63] KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
[  857.648765][   T63] CPU: 2 UID: 0 PID: 63 Comm: kworker/2:2 Not tainted 7.0.0-rc6-virtme #1 PREEMPT(full) 
[  857.648903][   T63] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[  857.649006][   T63] Workqueue: mld mld_ifc_work
[  857.649090][   T63] RIP: 0010:mroute6_is_socket+0x4a/0x80
[  857.649172][   T63] Code: df 48 89 f9 48 c1 e9 03 80 3c 11 00 75 2f 48 8b 80 e8 10 00 00 48 ba 00 00 00 00 00 fc ff df 48 8d 78 30 48 89 f9 48 c1 e9 03 <80> 3c 11 00 75 1c 48 83 78 30 00 0f 95 c0 48 83 c4 08 c3 48 89 04
[  857.649439][   T63] RSP: 0018:ffa00000004478b0 EFLAGS: 00010216
[  857.649533][   T63] RAX: 0000000000000000 RBX: ff1100000e2ae200 RCX: 0000000000000006
[  857.649645][   T63] RDX: dffffc0000000000 RSI: ff1100000e2ae200 RDI: 0000000000000030
[  857.649755][   T63] RBP: ff110000077d0900 R08: ffffffffa63b8550 R09: 1fe2200002937e85
[  857.649863][   T63] R10: ff11000010736898 R11: ff11000008ab40b0 R12: 1ff4000000088f20
[  857.649974][   T63] R13: ff11000008ab4000 R14: ff11000008c78800 R15: ff11000010736880
[  857.650083][   T63] FS:  0000000000000000(0000) GS:ff110000c2de4000(0000) knlGS:0000000000000000
[  857.650213][   T63] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  857.650307][   T63] CR2: 00007f1dc25d2574 CR3: 000000001c74f002 CR4: 0000000000771ef0
[  857.650421][   T63] PKRU: 55555554
[  857.650480][   T63] Call Trace:
[  857.650536][   T63]  <TASK>
[  857.650575][   T63]  ip6_finish_output2+0xa7f/0x1310
[  857.650653][   T63]  ? ip6_xmit+0x2000/0x2000
[  857.650724][   T63]  ? find_held_lock+0x2b/0x80
[  857.650800][   T63]  ? __lock_release.isra.0+0x6b/0x1a0
[  857.650873][   T63]  ? ip6_mtu+0x174/0x410
[  857.650929][   T63]  ip6_finish_output+0x701/0xe80
[  857.651002][   T63]  ip6_output+0x23f/0x7f0
[  857.651056][   T63]  ? ip6_finish_output+0xe80/0xe80
[  857.651128][   T63]  ? __lock_release.isra.0+0x6b/0x1a0
[  857.651201][   T63]  ? xfrm_bundle_lookup.constprop.0+0xba0/0xba0
[  857.651296][   T63]  ? mark_held_locks+0x40/0x70
[  857.651369][   T63]  ? __local_bh_enable_ip+0xa5/0x140
[  857.651443][   T63]  ? __local_bh_enable_ip+0xa5/0x140
[  857.651516][   T63]  ? icmp6_dst_alloc+0x317/0x4d0
[  857.651589][   T63]  mld_sendpack+0x9d6/0xec0
[  857.651661][   T63]  ? nf_hook.constprop.0+0x340/0x340
[  857.651734][   T63]  ? mld_send_cr+0x50f/0x820
[  857.651808][   T63]  mld_ifc_work+0x36/0x190
[  857.651880][   T63]  ? process_one_work+0xdb4/0x1410
[  857.651954][   T63]  process_one_work+0xdf5/0x1410
[  857.652028][   T63]  ? pwq_dec_nr_in_flight+0x710/0x710
[  857.652100][   T63]  ? lock_acquire.part.0+0xbc/0x260
[  857.652172][   T63]  worker_thread+0x4f1/0xd60
[  857.652244][   T63]  ? rescuer_thread+0x1320/0x1320
[  857.652318][   T63]  ? __kthread_parkme+0xbd/0x210
[  857.652391][   T63]  ? rescuer_thread+0x1320/0x1320
[  857.652495][   T63]  kthread+0x364/0x460
[  857.652550][   T63]  ? trace_irq_enable.constprop.0+0x9b/0x180
[  857.652641][   T63]  ? kthread_affine_node+0x330/0x330
[  857.652714][   T63]  ret_from_fork+0x474/0x6b0
[  857.652787][   T63]  ? arch_exit_to_user_mode_prepare.isra.0+0x140/0x140
[  857.652877][   T63]  ? __switch_to+0x540/0xd10
[  857.652952][   T63]  ? kthread_affine_node+0x330/0x330
[  857.653025][   T63]  ret_from_fork_asm+0x11/0x20
[  857.653102][   T63]  </TASK>
[  857.653157][   T63] Modules linked in: ip6_gre ip_gre gre act_gact cls_matchall sch_ingress ipt_REJECT nf_reject_ipv4 nft_compat nf_tables
[  857.653387][   T63] ---[ end trace 0000000000000000 ]---
[  857.653511][   T63] RIP: 0010:mroute6_is_socket+0x4a/0x80
[  857.653630][   T63] Code: df 48 89 f9 48 c1 e9 03 80 3c 11 00 75 2f 48 8b 80 e8 10 00 00 48 ba 00 00 00 00 00 fc ff df 48 8d 78 30 48 89 f9 48 c1 e9 03 <80> 3c 11 00 75 1c 48 83 78 30 00 0f 95 c0 48 83 c4 08 c3 48 89 04
[  857.653928][   T63] RSP: 0018:ffa00000004478b0 EFLAGS: 00010216
[  857.654063][   T63] RAX: 0000000000000000 RBX: ff1100000e2ae200 RCX: 0000000000000006
[  857.654267][   T63] RDX: dffffc0000000000 RSI: ff1100000e2ae200 RDI: 0000000000000030
[  857.654422][   T63] RBP: ff110000077d0900 R08: ffffffffa63b8550 R09: 1fe2200002937e85
[  857.654579][   T63] R10: ff11000010736898 R11: ff11000008ab40b0 R12: 1ff4000000088f20
[  857.654728][   T63] R13: ff11000008ab4000 R14: ff11000008c78800 R15: ff11000010736880
[  857.654876][   T63] FS:  0000000000000000(0000) GS:ff110000c2de4000(0000) knlGS:0000000000000000
[  857.655046][   T63] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  857.655189][   T63] CR2: 00007f1dc25d2574 CR3: 000000001c74f002 CR4: 0000000000771ef0
[  857.655340][   T63] PKRU: 55555554
[  857.655470][   T63] Kernel panic - not syncing: Fatal exception
[  857.655657][   T63] Kernel Offset: 0x23000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  857.655864][   T63] ---[ end Kernel panic - not syncing: Fatal exception ]---

