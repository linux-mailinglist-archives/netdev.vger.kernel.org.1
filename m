Return-Path: <netdev+bounces-281910-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENWhCjnU8GkSZQEAu9opvQ
	(envelope-from <netdev+bounces-281910-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:37:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B81F488016
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8D7AE30520F0
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF1743E9D5;
	Tue, 28 Apr 2026 14:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eKfQgIIR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nd/4OGs+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AE0436352
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777385454; cv=none; b=amWxAtQtbkKaC9UH/R12wk1yFtAdu6g3/Y67rPFIgJDi5P794yLCa6ESD8RLikiI1xTHYFxy3BJ9PVEkciHSWPghT5PDFZmsowKTXFnxSUThxlj25Il+WJ6/qc+wMiS87DnD1E3xiTzWugNmK2kJBAwSzIsSeP7YMtmztZQ8hMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777385454; c=relaxed/simple;
	bh=s3do0e5rCtxlTF9/cwVfZsB+RqqAZt5EnzhjSA6Ajvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G7rqYbOx15WwctggjeegYk3zD2LOKZnZLXZDGAjrTM19l61c5BT80vUNmqJmfM4aMMKXpgwROOkFpKLFnjnzvpCMJ7EMPOnYGyocthc8Ebuz2H2FZ+HhfFok6mqFSYdbwR1AfaQeuEIy9zGfCh1BUUbh5PK4zaw9V3WqJW/UPS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eKfQgIIR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nd/4OGs+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777385451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tP7oo7RDQoK7h0JXxV4QJ2IDSooBXQffesJO77KHtBA=;
	b=eKfQgIIR9N/hBtbrYkIqD+TT0HKGjh20sqiOahFZXeWecNBwe/Y05/dxF4hLRRetaE+DJz
	PAY8SBx1ovqTYuVbnkJTuAKonG4EgkhNgxh7NxvTH/lOe1ZI1Bx6wliuPicXcdlm5ZPa4g
	A5krZs7ryrtBLzeP+9ikOTG9G5musHM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-rrNDYu0EOBiEpkdPyxJ3gg-1; Tue, 28 Apr 2026 10:10:48 -0400
X-MC-Unique: rrNDYu0EOBiEpkdPyxJ3gg-1
X-Mimecast-MFC-AGG-ID: rrNDYu0EOBiEpkdPyxJ3gg_1777385448
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8f87d6ce659so71056885a.3
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 07:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777385448; x=1777990248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tP7oo7RDQoK7h0JXxV4QJ2IDSooBXQffesJO77KHtBA=;
        b=Nd/4OGs+yTLvUdwRmwFO4cLafYNmktecTJ6fZTHIJXn9zyPTySJWiXB6dTOes6/cXp
         IS/sftUyTvGXLp3H1/Maqc8qUIA98OPCLNhzJqU1a2x3Ba1c8IufNqZIdx+C1Q3uQVrE
         Pyr4XxDZsJhXXOvD1Accl8ddoIVA08upS2njj8NVL36bdyOn3m90915Ah3N0LqPdN/t/
         638PtFcYDuktbU6jmH7eATcd8/BLKg8aGRwA+JOOHbuXQrc4DB82JsrJefeqTsMnCe4d
         TKj/OEoUdVTL8Q9itQRO7X2oYIVgJyDxr2MmpzspBeP8svWGyMkxZa2ddAwvWXzv+jXs
         RAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777385448; x=1777990248;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tP7oo7RDQoK7h0JXxV4QJ2IDSooBXQffesJO77KHtBA=;
        b=ppKZqi0S2X79oydUTCXj7NBmG94axCJuvOY2qs3a/pU5RBg81JzaevIV1D00DiIett
         aH3MnngKjs5EA4EF9lnEUyJm8lMrnxw2T2u8Qrt+6kSqjsA1MU9Lz58XD3i7WxVahxHV
         FyOM3IatSH74qoisJBqZdkTim1axzUR3cMu4wcC3RvcO886V+xUNlEuahtT/Rf51PSAO
         bcO0HcskBOjsgHsqj/yPMWaY+QDvPrd6SH24lsyFy4n29TE6c523IAJ0d7FWfBZnPhjd
         sUKNbrP2I5wAeJKHTqpXlDR72RTzrE1lfaA87v67VW/MM5r/Aqb6k1xQujtWoKa7iQLF
         rjNw==
X-Forwarded-Encrypted: i=1; AFNElJ/SNkEcjxScE+acm7HdGWZ3u1Sd0Hjpl0r2xFR5UHWhvhtEnNiWqlChBwG7aTrnHTskLBclN5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgqH/buKdsTHxHwNp022xdPijFWVvSpz43gjHaCcDjJONrMv4h
	vZfyy3I5OENZgHzUlJ62b6QdxYnnQOJBloMa5qaua9C2HaCQk7FPOMWsbDzHAgGC9O2xJprlW1I
	cvU0MVnmcz9OcQqUpbisIQUEfayswED+HRcvLEMd2JKN1H+ylc2gtKVMILA==
X-Gm-Gg: AeBDievzC4/UGwZW/ylUXgvXnDpA/JhbfVvgXgm3zFooG1sEANPlcyf3cK5SaUlNINb
	5WeDEV/H3NzK8kvbhHkQ8hAMVVmsPIsstmBv1//ueuY8Qp1kEvNjtYJ0wEPWl1W/fXjQlCONd5M
	pD46WhDyCk7IS8q1nDhktXm89ZYpoVSYf3fifo7RfmxDnxmQ1oFKviGgm8XzqCv20rw2LkVo+VD
	2LgsY3rpNptBIMpjknK4mMQBdD9IhJsNgSI6l48IWlAbX0EQ4ssZabDfYXO9x8+S67IO98NT4Iv
	5ewvbzYSC0XjBO27Sz8qHO/LzsD9++1dLzcVds31qWygoWUggxuoehDlW4nTd1XAJcSMtAPQ96B
	EPyIZQpEi7kNfeIiHixBLtiANXaOo4kUFT5f1mXthuM7s5wpzEQOSfJY00ur6bDCmPQ==
X-Received: by 2002:a05:620a:4493:b0:8ea:addd:892e with SMTP id af79cd13be357-8f7d9a0f618mr406785785a.49.1777385447465;
        Tue, 28 Apr 2026 07:10:47 -0700 (PDT)
X-Received: by 2002:a05:620a:4493:b0:8ea:addd:892e with SMTP id af79cd13be357-8f7d9a0f618mr406778585a.49.1777385446785;
        Tue, 28 Apr 2026 07:10:46 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.114])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f7c19ae61bsm204783085a.0.2026.04.28.07.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 07:10:46 -0700 (PDT)
Message-ID: <ba420053-c201-47a1-83af-6b092e46d6fb@redhat.com>
Date: Tue, 28 Apr 2026 16:10:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bridge: mcast: Fix a false positive lockdep splat
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux.dev
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 razor@blackwall.org, horms@kernel.org, herbert@gondor.apana.org.au,
 linus.luessing@c0d3.blue
References: <20260426133435.207006-1-idosch@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260426133435.207006-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2B81F488016
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281910-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,appspotmail.com:email]

On 4/26/26 3:34 PM, Ido Schimmel wrote:
> Connecting two bridges on the same system [1] can result in a lockdep
> splat [2].
> 
> The report is a false positive. Multicast queries are built and
> transmitted under the bridge multicast lock. When the outgoing port of
> one bridge is configured on top of another bridge, the transmit path
> re-enters bridge code and acquires the other bridge's multicast lock in
> order to snoop the query. Both lock instances share a single lockdep
> class, so lockdep flags the nested acquisition as an AA deadlock.
> 
> Giving each bridge its own lock class will not solve the problem: the
> reverse topology would produce an ABBA splat with the same pair of
> classes. It also consumes a lockdep key per bridge.
> 
> Instead, fix the problem by deferring the transmission of the queries to
> a workqueue. Build the skb and update querier state under the lock as
> before, then enqueue the skb on a per multicast context queue and
> schedule the work.

I must admit that introducing an additional WQ to fix a false positive
feels a bit overkill to me - even if I can't think of a better solution
on top of my head.

> Flush the work when the multicast context is de-initialized. At this
> stage the work cannot be requeued. There is no need to take a reference
> on skb->dev since the work cannot outlive the bridge or the bridge port.
> 
> Use the high priority workqueue to reduce the delay between the enqueue
> time and the transmission time. With default settings (i.e., querier
> interval - 255 seconds, query interval - 125 seconds) the extra delay
> should not be a problem.
> 
> [1]
> ip link add name br1 up type bridge mcast_snooping 1 mcast_querier 1
> ip link add name br0 up type bridge mcast_snooping 1 mcast_querier 1
> ip link add link br0 name br0.10 up master br1 type vlan id 10
> 
> [2]
> ============================================
> WARNING: possible recursive locking detected
> 7.0.0-virtme-gb50c64a58a90 #1 Not tainted
> --------------------------------------------

checkpatch reports that the above separator may break tool. Possibly
just remove it from the commit message.

> ip/339 is trying to acquire lock:
> ffff888104f0b480 (&br->multicast_lock){+.-.}-{3:3}, at: br_ip6_multicast_query (net/bridge/br_multicast.c:3584)
> 
> but task is already holding lock:
> ffff888104f03480 (&br->multicast_lock){+.-.}-{3:3}, at: br_multicast_port_query_expired (net/bridge/br_multicast.c:1904)
> 
> [...]
> 
> Call Trace:
> [...]
> br_ip6_multicast_query (net/bridge/br_multicast.c:3584)
> br_multicast_ipv6_rcv (net/bridge/br_multicast.c:3988)
> br_dev_xmit (net/bridge/br_device.c:98 (discriminator 1))
> dev_hard_start_xmit (./include/linux/netdevice.h:5343 ./include/linux/netdevice.h:5352 net/core/dev.c:3888 net/core/dev.c:3904)
> __dev_queue_xmit (./include/linux/netdevice.h:3619 net/core/dev.c:4871)
> vlan_dev_hard_start_xmit (net/8021q/vlan_dev.c:131 (discriminator 1))
> dev_hard_start_xmit (./include/linux/netdevice.h:5343 ./include/linux/netdevice.h:5352 net/core/dev.c:3888 net/core/dev.c:3904)
> __dev_queue_xmit (./include/linux/netdevice.h:3619 net/core/dev.c:4871)
> br_dev_queue_push_xmit (net/bridge/br_forward.c:60)
> __br_multicast_send_query (net/bridge/br_multicast.c:1811 (discriminator 1))
> br_multicast_send_query (net/bridge/br_multicast.c:1889)
> br_multicast_port_query_expired (./include/linux/spinlock.h:390 net/bridge/br_multicast.c:1914)
> call_timer_fn (./arch/x86/include/asm/jump_label.h:37 ./include/trace/events/timer.h:127 kernel/time/timer.c:1749)
> [...]
> 
> Fixes: eb1d16414339 ("bridge: Add core IGMP snooping support")
> Reported-by: syzbot+d7b7f1412c02134efa6d@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/000000000000c4c9d405f2643e01@google.com/
> Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_multicast.c | 39 +++++++++++++++++++++++++++++++++++----
>  net/bridge/br_private.h   |  4 ++++
>  2 files changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 881d866d687a..252c46977ed5 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1776,6 +1776,28 @@ static void br_multicast_select_own_querier(struct net_bridge_mcast *brmctx,
>  #endif
>  }
>  
> +static void br_multicast_port_query_queue_work(struct work_struct *work)
> +{
> +	struct net_bridge_mcast_port *pmctx;
> +	struct sk_buff *skb;
> +
> +	pmctx = container_of(work, struct net_bridge_mcast_port,
> +			     query_queue_work);
> +	while ((skb = skb_dequeue(&pmctx->query_queue)))
> +		NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_OUT, dev_net(skb->dev),
> +			NULL, skb, NULL, skb->dev, br_dev_queue_push_xmit);
> +}
> +
> +static void br_multicast_query_queue_work(struct work_struct *work)
> +{
> +	struct net_bridge_mcast *brmctx;
> +	struct sk_buff *skb;
> +
> +	brmctx = container_of(work, struct net_bridge_mcast, query_queue_work);
> +	while ((skb = skb_dequeue(&brmctx->query_queue)))
> +		netif_rx(skb);
> +}
> +
>  static void __br_multicast_send_query(struct net_bridge_mcast *brmctx,
>  				      struct net_bridge_mcast_port *pmctx,
>  				      struct net_bridge_port_group *pg,
> @@ -1804,9 +1826,8 @@ static void __br_multicast_send_query(struct net_bridge_mcast *brmctx,
>  		skb->dev = pmctx->port->dev;
>  		br_multicast_count(brmctx->br, pmctx->port, skb, igmp_type,
>  				   BR_MCAST_DIR_TX);
> -		NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_OUT,
> -			dev_net(pmctx->port->dev), NULL, skb, NULL, skb->dev,
> -			br_dev_queue_push_xmit);
> +		skb_queue_tail(&pmctx->query_queue, skb);
> +		queue_work(system_highpri_wq, &pmctx->query_queue_work);

Also the AI reported concerns vs unbounded queue len looks relevant.
Usually the RX path is slower than TX, but i.e. asymmetric filtering
rules could reverse the scenario.

/P


