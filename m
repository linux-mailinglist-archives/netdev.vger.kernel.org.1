Return-Path: <netdev+bounces-268837-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wO7dJzj3uWkMQAIAu9opvQ
	(envelope-from <netdev+bounces-268837-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 01:52:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C307E2B4B6C
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 01:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8A9630579F1
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 00:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBB6175A91;
	Wed, 18 Mar 2026 00:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="d1X5SKse";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="Rwj2tfRN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C882A15E8B;
	Wed, 18 Mar 2026 00:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773795124; cv=none; b=rvcPCQKt6a73Qg3efqZl/1/FsDJk32IErmqc5OgqGpwA1NXfinEj7PVuftOXWES4ymmvBalR/DGbZX00UxXwi1pCP2+E5n0VqRtDFBSArrlrKMBPspb+zjvx5Ju1YN5cnSGeMv6QDIQQ5vYGwEaNc6QjnIy0bKmAnpWH1igsB4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773795124; c=relaxed/simple;
	bh=h8sf+bsOqQLKxkAFb6wfbQnnj4gyhsI3x72Ya2ekeig=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KhYUHTQJ/A6mqbaEXYzlsIN/e+eg9ItpdQF974FDsEVWGYoSujFPbmjRkQ/U+ZNxrS7KEY/PPnXDuLBHG4W4ZCOuBXFJg8wW7XG0xqL66qIy6973b5kQ8bBOwDZP5T9QucD4CzFnbV//PEK/WkKaGgBlncD5tN9tPOsqNhZGE7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=d1X5SKse; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=Rwj2tfRN; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 62I0pPM2017722;
	Wed, 18 Mar 2026 01:51:31 +0100
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id E91AC1205C5;
	Wed, 18 Mar 2026 01:51:20 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1773795081; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TGI60m1VO5PlpLph395BckUvAm4N1bKlvISAY04YGcY=;
	b=d1X5SKsethoGCHAdu95xQqQLpgmCV07LLkCSt/qpao6i9AaWfc4Cd+5H9nn7vw/TyuHazW
	JcNz8GOOm2YJAqBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1773795081; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TGI60m1VO5PlpLph395BckUvAm4N1bKlvISAY04YGcY=;
	b=Rwj2tfRNQiQTrXR7Fuxt/EzExCdEh4p7Q5udD4deyOL5PPNUxmqn9G1rZLqwYneQA4r/Gr
	aaPATGvNSaTNaHJ0qNnECWmgMW0wYFioMYq4F55Y7XyaH8WG7GFSdvJdTHG5sYJJRpUTqJ
	cnkqK2CIeqms25TJU5TBWszB1asJuTdEGLFw7T58lrlapUvZmX71XKsrFfXGc1k8esIN5j
	6/V6cnWoVqK5Et6C+85Syt63t4BjcWgw3K29VBmOgFm76kuRP/963unxZ3ES2u0s7UWBYA
	yEf6jf9HD3x1A8YAhyBDEaPG9Nr5anDdnnGYMMMf86orLLw2vceeAEX+lemPPg==
Date: Wed, 18 Mar 2026 01:51:20 +0100
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Minhong He <heminhong@kylinos.cn>
Cc: horms@kernel.org, davem@davemloft.net, david.lebrun@uclouvain.be,
        dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, stefano.salsano@uniroma2.it,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net v3] ipv6: add NULL checks for idev in SRv6 paths
Message-Id: <20260318015120.92575a78f2e39f9e4ccf76a2@uniroma2.it>
In-Reply-To: <20260316073301.106643-1-heminhong@kylinos.cn>
References: <20260315160159.1394504-1-horms@kernel.org>
	<20260316073301.106643-1-heminhong@kylinos.cn>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniroma2.it,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[uniroma2.it:s=ed201904,uniroma2.it:s=rsa201904];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268837-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[uniroma2.it:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.mayer@uniroma2.it,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uniroma2.it:dkim,uniroma2.it:email,uniroma2.it:mid,kylinos.cn:email]
X-Rspamd-Queue-Id: C307E2B4B6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 16 Mar 2026 15:33:01 +0800
Minhong He <heminhong@kylinos.cn> wrote:

> __in6_dev_get() can return NULL when the device has no IPv6 configuration
> (e.g. MTU < IPV6_MIN_MTU or after NETDEV_UNREGISTER).
> 
> Add NULL checks for idev returned by __in6_dev_get() in both
> seg6_hmac_validate_skb() and ipv6_srh_rcv() to prevent potential NULL
> pointer dereferences.
> 
> Fixes: 1ababeba4a21 ("ipv6: implement dataplane support for rthdr type 4 (Segment Routing Header)")
> Fixes: bf355b8d2c30 ("ipv6: sr: add core files for SR HMAC support")
> Signed-off-by: Minhong He <heminhong@kylinos.cn>
> ---

Hi Minhong,
 
I was able to trigger this with the MTU < IPV6_MIN_MTU scenario
while SRv6 traffic is in flight:

[ 2506.476833] ==================================================================
[ 2506.478368] BUG: KASAN: null-ptr-deref in ipv6_rthdr_rcv+0x7c7/0x1cc0
[ 2506.478368] Read of size 4 at addr 00000000000006a8 by task ping6/22207
[ 2506.478368]
[ 2506.478368] CPU: 0 UID: 0 PID: 22207 Comm: ping6 Not tainted 7.0.0-rc3-micro-vm-dev-00185-g43d222fbcdff #2176 PREEMPT(full)
[ 2506.478368] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
[ 2506.478368] Call Trace:
[ 2506.478368]  <IRQ>
[ 2506.478368]  dump_stack_lvl+0x7c/0xc0
[ 2506.478368]  print_report+0x3f1/0x5d0
[ 2506.478368]  ? __virt_addr_valid+0x24/0x340
[ 2506.478368]  ? ipv6_rthdr_rcv+0x7c7/0x1cc0
[ 2506.478368]  kasan_report+0x92/0xc0
[ 2506.478368]  ? ipv6_rthdr_rcv+0x7c7/0x1cc0
[ 2506.478368]  ipv6_rthdr_rcv+0x7c7/0x1cc0
[ 2506.478368]  ? __pfx_ipv6_rthdr_rcv+0x10/0x10
[ 2506.478368]  ? rcu_read_lock_held+0xac/0xc0
[ 2506.478368]  ? __pfx_rcu_read_lock_held+0x10/0x10
[ 2506.478368]  ? rcu_read_lock_held+0xac/0xc0
[ 2506.478368]  ? __pfx_rcu_read_lock_held+0x10/0x10
[ 2506.478368]  ? __rt6_find_exception_rcu+0x2c/0x200
[ 2506.478368]  ? kmem_cache_free+0xd0/0x530
[ 2506.478368]  ? icmpv6_rcv+0x4ec/0x10c0
[ 2506.478368]  ? ip6_protocol_deliver_rcu+0x93a/0xe20
[ 2506.478368]  ? find_held_lock+0x2d/0xa0
[ 2506.478368]  ? ip6_pol_route+0x1e3/0x7a0
[ 2506.478368]  ? __rcu_read_unlock+0x64/0x2f0
[ 2506.478368]  ? ip6_pol_route+0x1ed/0x7a0
[ 2506.478368]  ? __pfx_ip6_pol_route+0x10/0x10
[ 2506.478368]  ? __lock_acquire+0xb7f/0x1d30
[ 2506.478368]  ? kasan_quarantine_put+0x120/0x1c0
[ 2506.478368]  ? find_held_lock+0x2d/0xa0
[ 2506.478368]  ? rcu_read_lock_held+0xac/0xc0
[ 2506.478368]  ? __pfx_rcu_read_lock_held+0x10/0x10
[ 2506.478368]  ip6_protocol_deliver_rcu+0x93a/0xe20
[ 2506.478368]  ? rcu_read_lock_held+0xac/0xc0
[ 2506.478368]  ip6_input_finish+0x93/0x1a0
[ 2506.478368]  ip6_input+0xcd/0x480
[ 2506.478368]  ? __pfx_ip6_input+0x10/0x10
[ 2506.478368]  ? rcu_read_lock_held+0xac/0xc0
[ 2506.478368]  ? __pfx_rcu_read_lock_held+0x10/0x10
[ 2506.478368]  ? find_held_lock+0x2d/0xa0
[ 2506.478368]  ip6_rcv_finish+0x127/0x1d0
[ 2506.478368]  ? __pfx_ip6_rcv_finish+0x10/0x10
[ 2506.478368]  ? __pfx_ip6_input+0x10/0x10
[ 2506.478368]  ? sock_wfree+0x229/0x460
[ 2506.478368]  ? ip6_rcv_core.isra.19+0x5ea/0xcc0
[ 2506.478368]  ipv6_rcv+0xb4/0x330
[ 2506.478368]  ? __pfx_ipv6_rcv+0x10/0x10
[ 2506.478368]  ? __lock_acquire+0xb7f/0x1d30
[ 2506.478368]  ? __pfx_ipv6_rcv+0x10/0x10
[ 2506.478368]  __netif_receive_skb_one_core+0xe0/0x140
[ 2506.478368]  ? __pfx___netif_receive_skb_one_core+0x10/0x10
[ 2506.478368]  ? process_backlog+0x281/0x940
[ 2506.478368]  ? process_backlog+0x281/0x940
[ 2506.478368]  process_backlog+0x2c1/0x940
[ 2506.478368]  __napi_poll+0x57/0x3b0
[ 2506.478368]  net_rx_action+0x33f/0x710
[ 2506.478368]  ? __pfx_net_rx_action+0x10/0x10
[ 2506.478368]  ? rcu_nocb_unlock_irqrestore.isra.58+0x24/0x30
[ 2506.478368]  ? rcu_nocb_unlock_irqrestore.isra.58+0x24/0x30
[ 2506.478368]  ? lockdep_hardirqs_on+0xcc/0x150
[ 2506.478368]  ? rcu_do_batch+0x9e8/0xfa0
[ 2506.478368]  ? mark_held_locks+0x48/0x80
[ 2506.478368]  ? __pfx_rcu_do_batch+0x10/0x10
[ 2506.478368]  ? mark_held_locks+0x48/0x80
[ 2506.478368]  ? handle_softirqs+0xd8/0x680
[ 2506.478368]  handle_softirqs+0xf7/0x680
[ 2506.478368]  ? lwtunnel_output+0x9b/0x410
[ 2506.478368]  do_softirq.part.23+0x8f/0xd0
[ 2506.478368]  </IRQ>
[ 2506.478368]  <TASK>
[ 2506.478368]  __local_bh_enable_ip+0xe9/0xf0
[ 2506.478368]  lwtunnel_output+0xa0/0x410
[ 2506.478368]  ip6_local_out+0x15b/0x160
[ 2506.478368]  ? __pfx_ip6_local_out+0x10/0x10
[ 2506.478368]  ? __pfx_lwtunnel_output+0x10/0x10
[ 2506.478368]  ? __pfx_lwtunnel_output+0x10/0x10
[ 2506.478368]  ip6_send_skb+0x94/0x210
[ 2506.478368]  rawv6_sendmsg+0x10de/0x1340
[ 2506.478368]  ? down_read_non_owner+0xca/0x2f0
[ 2506.478368]  ? __pfx_rawv6_sendmsg+0x10/0x10
[ 2506.478368]  ? __mutex_unlock_slowpath+0x125/0x4f0
[ 2506.478368]  ? find_held_lock+0x2d/0xa0
[ 2506.478368]  ? __pfx_rcu_read_lock_any_held+0x10/0x10
[ 2506.478368]  ? __lock_acquire+0xb7f/0x1d30
[ 2506.478368]  ? n_tty_write+0x463/0x7d0
[ 2506.478368]  ? sock_has_perm+0x96/0x190
[ 2506.478368]  ? inet_send_prepare+0x16/0x290
[ 2506.478368]  ? __pfx_inet_sendmsg+0x10/0x10
[ 2506.478368]  ? __sock_sendmsg+0xd4/0xe0
[ 2506.478368]  __sock_sendmsg+0xd4/0xe0
[ 2506.478368]  __sys_sendto+0x18f/0x210
[ 2506.478368]  ? __pfx___sys_sendto+0x10/0x10
[ 2506.478368]  ? find_held_lock+0x2d/0xa0
[ 2506.478368]  ? __might_fault+0x6f/0xb0
[ 2506.478368]  ? __x64_sys_gettimeofday+0xe3/0x150
[ 2506.478368]  __x64_sys_sendto+0x6f/0x80
[ 2506.478368]  do_syscall_64+0xb3/0x5e0
[ 2506.478368]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 2506.478368] RIP: 0033:0x7f23442319b7
[ 2506.478368] Code: 64 89 02 48 c7 c0 ff ff ff ff eb b6 0f 1f 80 00 00 00 00 48 8d 05 49 5d 0c 00 41 89 ca 8b 00 85 c0 75 10 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 71 c3 41 57 4d 89 c7 41 56 41 89 ce 41 55 49
[ 2506.478368] RSP: 002b:00007ffcde563fb8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
[ 2506.478368] RAX: ffffffffffffffda RBX: 000055bf4d595a20 RCX: 00007f23442319b7
[ 2506.478368] RDX: 0000000000000040 RSI: 000055bf4d595a20 RDI: 0000000000000003
[ 2506.478368] RBP: 0000000000000040 R08: 000055bf4d593940 R09: 000000000000001c
[ 2506.478368] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffcde5652b8
[ 2506.478368] R13: 000055bf4d595a20 R14: 00007ffcde5640d0 R15: 000055bf4d5916a0
[ 2506.478368]  </TASK>
[ 2506.478368] ==================================================================


>  net/ipv6/exthdrs.c   | 4 ++++
>  net/ipv6/seg6_hmac.c | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index 5e3610a926cf..95558fd6f447 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -379,6 +379,10 @@ static int ipv6_srh_rcv(struct sk_buff *skb)
>  	hdr = (struct ipv6_sr_hdr *)skb_transport_header(skb);
>  
>  	idev = __in6_dev_get(skb->dev);
> +	if (!idev) {
> +		kfree_skb(skb);
> +		return -1;
> +	}
>  
>  	accept_seg6 = min(READ_ONCE(net->ipv6.devconf_all->seg6_enabled),
>  			  READ_ONCE(idev->cnf.seg6_enabled));
> diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
> index ee6bac0160ac..e6964c6b0d38 100644
> --- a/net/ipv6/seg6_hmac.c
> +++ b/net/ipv6/seg6_hmac.c
> @@ -184,6 +184,8 @@ bool seg6_hmac_validate_skb(struct sk_buff *skb)
>  	int require_hmac;
>  
>  	idev = __in6_dev_get(skb->dev);
> +	if (!idev)
> +		return false;
>  
>  	srh = (struct ipv6_sr_hdr *)skb_transport_header(skb);
>  
> -- 
> 2.25.1
> 

The fixes look correct to me.

Nit: as shown by the trace above, the issue is not just potential
but actually reproducible.

Reviewed-by: Andrea Mayer <andrea.mayer@uniroma2.it>

Thanks,
Andrea

