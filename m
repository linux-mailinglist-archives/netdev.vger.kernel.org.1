Return-Path: <netdev+bounces-260113-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Hf/A8mDnGlwIwQAu9opvQ
	(envelope-from <netdev+bounces-260113-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:43:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE1617A0AE
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDB5F30C2EAF
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379DE318BAE;
	Mon, 23 Feb 2026 16:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHDp7POD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D4E315D35
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 16:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864605; cv=none; b=p4jgDPbZ3wjh6QDstAvI/7vtp3TkgxB6MOdt2zIs8mBJnVnFuQq0xBQwrvSWZGZo5HB7CJr7H2jRHAOrlOX6ghxgTeE7g92Hm53RZy/k3NPPen5coEOxCCQW89h0wT/dtorKY+m2BCi4aL9KkgPG43lpXPCYd4yPDtv7BFTWCpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864605; c=relaxed/simple;
	bh=xtfa/vxoFSsQrTYe1rrYVP9JJnv3xS0XC17doAWzp4w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d26WfRlQC2iFMGrgiM080kHdcc+h+yQXNpPZPCGKSZhhqtBMQhtqELUqKj35XoJHYsRzVeN7v8veepMg25JfcXJBX3SfUu0vFpvfzDG48ojwq50Fiht865AVhNFMdxef8WCVxqQJOnFAS5KHpg3HRm38oAOERjCJ+eDphxD3Pq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHDp7POD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62549C116C6;
	Mon, 23 Feb 2026 16:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771864604;
	bh=xtfa/vxoFSsQrTYe1rrYVP9JJnv3xS0XC17doAWzp4w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tHDp7PODtiq1Bv7EpK8btxq+j41yLYaBSI1P7AoNqGIgdKkfG+pDd6yannwGUuoNr
	 jyipY7XdR2uV7ekMsfwYaSTmSerBblsfs6V/iItaSMb14NaVv+28dxQRIEHeNvN+yV
	 uagACK85ade8ab5LtgZ+pWwYJdIwoLhleTT4ZMQB1xQDC9AOaV18SfxM2bwjy++dxN
	 j6Wp4NF43oQBrH9bR1avkUmw9E11lo6M455BDWYsTHp4i2VWHqh17dJaJuNJDRusmV
	 0QJ8jGzgJQSPCNoNF9bh4NOsgG3hFk9vd7h038preKDrsGdpCAcpQqAWvl1VtB+XS7
	 qk2U3ZwOyXVzQ==
Date: Mon, 23 Feb 2026 08:36:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com,
 milena.olech@intel.com, willemdebruijn.kernel@gmail.com, andrew@lunn.ch,
 vadim.fedorenko@linux.dev
Subject: Re: [PATCH v2 net-next 1/3] ptp_mock: Expose ptp_clock_info to
 external drivers
Message-ID: <20260223083643.0b322f7e@kernel.org>
In-Reply-To: <20260222094110.127927-2-maciek@machnikowski.net>
References: <20260222094110.127927-1-maciek@machnikowski.net>
	<20260222094110.127927-2-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,intel.com,lunn.ch,linux.dev];
	TAGGED_FROM(0.00)[bounces-260113-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5BE1617A0AE
X-Rspamd-Action: no action

On Sun, 22 Feb 2026 10:41:08 +0100 Maciek Machnikowski wrote:
> -	spin_lock(&phc->lock);
> +	spin_lock_bh(&phc->lock);
>  	timecounter_read(&phc->tc);
>  	phc->cc.mult = MOCK_PHC_CC_MULT + adj;
> -	spin_unlock(&phc->lock);
> +	spin_unlock_bh(&phc->lock);

Sorry if I told you _bh, the locks need the be taken _irqsave()
because of netpoll/netconsole. Running netconsole tests
(netcons_basic.sh):


[  698.451639][T12749] WARNING: kernel/softirq.c:430 at __local_bh_enable_ip+0xc0/0x140, CPU#3: pr/netcon0/12749
[  698.451959][T12749] Modules linked in: netconsole netdevsim geneve vxlan ip6_udp_tunnel udp_tunnel [last unloaded: netdevsim]
[  698.452408][T12749] CPU: 3 UID: 0 PID: 12749 Comm: pr/netcon0 Not tainted 6.19.0-virtme #1 PREEMPT(full) 
[  698.452683][T12749] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[  698.452872][T12749] RIP: 0010:__local_bh_enable_ip+0xc0/0x140
[  698.453071][T12749] Code: 00 00 00 e8 12 15 0a 00 e8 3d 7c 3c 00 fb 65 8b 05 05 72 40 04 85 c0 74 64 48 83 c4 10 c3 65 8b 05 11 b6 40 04 85 c0 75 a2 90 <0f> 0b 90 eb 9c 89 74 24 0c 4c 89 04 24 e8 ce 7f 3c 00 8b 74 24 0c
[  698.453612][T12749] RSP: 0018:ffa0000000657900 EFLAGS: 00010046
[  698.453825][T12749] RAX: 0000000000000000 RBX: 00000000b30e1132 RCX: 1ffffffff7c4ca80
[  698.454046][T12749] RDX: 0000000000000001 RSI: 0000000000000201 RDI: ffffffffbc0657ff
[  698.454262][T12749] RBP: ffa0000000657930 R08: ffffffffbc0657ff R09: ffe21c0000480d23
[  698.454486][T12749] R10: ffe21c0000480d24 R11: ff11000002406914 R12: ffa00000006579d8
[  698.454720][T12749] R13: ff1100000ea7f000 R14: ff1100000c54a000 R15: ff11000013e5ad00
[  698.454953][T12749] FS:  0000000000000000(0000) GS:ff11000070c0b000(0000) knlGS:0000000000000000
[  698.455229][T12749] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  698.455412][T12749] CR2: 00007fe32fcac000 CR3: 000000003753b004 CR4: 0000000000771ef0
[  698.455636][T12749] PKRU: 55555554
[  698.455748][T12749] Call Trace:
[  698.455862][T12749]  <TASK>
[  698.455940][T12749]  ? _raw_spin_unlock_bh+0x23/0x40
[  698.456097][T12749]  mock_phc_gettime64+0x3f/0x80
[  698.456245][T12749]  nsim_start_xmit+0x3be/0x10d0 [netdevsim]
[  698.456437][T12749]  ? __lock_acquire+0x577/0xc10
[  698.456601][T12749]  ? nsim_poll+0x500/0x500 [netdevsim]
[  698.456758][T12749]  ? lock_acquire.part.0+0xbc/0x260
[  698.456912][T12749]  ? rcu_is_watching+0x15/0xd0
[  698.457065][T12749]  ? netif_skb_features+0x27c/0xce0
[  698.457219][T12749]  netpoll_start_xmit+0x18e/0x2e0
[  698.457369][T12749]  __netpoll_send_skb+0x66b/0x800
[  698.457519][T12749]  netpoll_send_skb+0x22/0x90
[  698.457667][T12749]  netconsole_write+0x249/0x2c0 [netconsole]
[  698.457859][T12749]  nbcon_emit_next_record+0x79b/0x930
[  698.458013][T12749]  ? nbcon_can_proceed+0x120/0x120
[  698.458162][T12749]  ? nbcon_context_try_acquire+0x26a/0x5b0
[  698.458346][T12749]  nbcon_emit_one+0x158/0x220
[  698.458490][T12749]  ? nbcon_emit_next_record+0x930/0x930
[  698.458636][T12749]  nbcon_kthread_func+0x3d9/0x570
[  698.458800][T12749]  ? __nbcon_atomic_flush_pending+0x3d0/0x3d0
[  698.458989][T12749]  ? __lock_release.isra.0+0x59/0x170
[  698.459140][T12749]  ? __nbcon_atomic_flush_pending+0x3d0/0x3d0
[  698.459320][T12749]  ? __kthread_parkme+0xb3/0x200
[  698.459476][T12749]  ? __nbcon_atomic_flush_pending+0x3d0/0x3d0
[  698.459664][T12749]  kthread+0x30f/0x3f0
[  698.459777][T12749]  ? trace_irq_enable.constprop.0+0x13c/0x190
[  698.459964][T12749]  ? kthread_affine_node+0x150/0x150
[  698.460118][T12749]  ret_from_fork+0x472/0x6b0
[  698.460266][T12749]  ? arch_exit_to_user_mode_prepare.isra.0+0x140/0x140
[  698.460452][T12749]  ? __switch_to+0x538/0xcf0
[  698.460603][T12749]  ? kthread_affine_node+0x150/0x150
[  698.460748][T12749]  ret_from_fork_asm+0x11/0x20
[  698.460902][T12749]  </TASK>
[  698.461017][T12749] irq event stamp: 73
[  698.461129][T12749] hardirqs last  enabled at (71): [<ffffffffba847c2f>] finish_task_switch.isra.0+0x15f/0x6a0
[  698.461424][T12749] hardirqs last disabled at (72): [<ffffffffbcb45260>] _raw_spin_lock_irqsave+0x50/0x60
[  698.461685][T12749] softirqs last  enabled at (0): [<ffffffffba76c723>] copy_process+0x1673/0x5700
[  698.461947][T12749] softirqs last disabled at (73): [<ffffffffbc0657e4>] mock_phc_gettime64+0x24/0x80
[  698.462214][T12749] ---[ end trace 0000000000000000 ]---
-- 
pw-bot: cr

