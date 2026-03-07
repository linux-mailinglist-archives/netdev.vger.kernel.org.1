Return-Path: <netdev+bounces-265064-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MRrNBmWmq2nKfAEAu9opvQ
	(envelope-from <netdev+bounces-265064-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 05:15:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E7A22A08E
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 05:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09C6A302E796
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 04:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0E917BED0;
	Sat,  7 Mar 2026 04:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nk22UzM6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDB92745E
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 04:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772856928; cv=pass; b=AzDRcNcQZletH3mkVG9OVMvG3R3iitDZQJhzrshRYlOOOP9crJBygI9uiT8tx1Faf4Bho0XF47IcVfgejc+srMQY9mHvcvnscZqr/PzAbVbgG8GFg+k8ylG3CeGQSsQk3iSwF/DFn3os9bLPIlVaK+cUTQpHWEOlZdk4kG9BKig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772856928; c=relaxed/simple;
	bh=inCuuwoAcPbcYrioLOpQppPGQPvIuxp5NYrPNRRm17M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2tLx0Kcau9wu3gOF9sbTAcTrujc+Y4wQH52n6jcYNm7k8OjcEWMZ+OBsIwvEJEhPExKkNK+Dlfv6TXOWGc7b+TpE337bUTAJhEAPpHE6y59uw4cvtFNNSk9HX2SD4UpfvPqGfLwdP1kYvu71NWxNdz0lCZQmRoSWSLn0Kg2ZXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nk22UzM6; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-899ed41208fso123930936d6.1
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 20:15:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772856925; cv=none;
        d=google.com; s=arc-20240605;
        b=GgCJUqN1X4nlB8Rmam/Gq6s/ZJsuvM+x6q7E0HlELzJ6ubr+c9cEkqEu3kI2cuFHXG
         Ei25LCQ+9D/hfKG7rdqD+aiEGctCiuyxlXxbizOp+AVmeNKH2OIhln1rz38n4dO6B048
         taIp/kSIi71txFPSookh3ahHQVNUZZ6h1muU+0YUEPDhmAWAuXT48DWxI16J454ryLAw
         ri9HMnAssL4VaoHXxhvK2eTgVcFoIyXq90AMkbIKHso+VrKxdzqZY+IV3CJP9v0crJUP
         SD5MUlMyXaiyRDuMtWgv9P7i9oTy4cOjHyMDAzw76voD5WZz0pmaOsMsy+ryN1mWuxwO
         NFKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2j9Bldh73I1ZTU/gwH+Va1opxn4z5tE0/MvG0JXLOnM=;
        fh=DFDpzk0Vbp/f5Csq6BK61vt+Vblc/VL15HbaiyxK6F8=;
        b=WxrnHRSo4gojGX8ZKIkEFDRThTC2vTJK7P5CkG1rwgorVQ4uZRy7PW1swb1mlG2quU
         wgOgVx/9GWcKwb5bc7U89G4LTxoImwVWtz0KbgzCowRUv6r2CuxTPiU9gWxIEk00Lz0/
         E8IS/xHt+DRsE8f9PagvuAvSWozPhH0DUAPUlioL7YV1zTpbHwW6obNXOPPrVkWxgcSp
         t1gyqfA0H1lBBzD7wJHQGz/PusucFBnVM9zbseYr3d3hHA4CUNf+oefS6ZQcX9BxQLl9
         8YgLPfkD6IU9wwE6pHQ7ciEI+QAXEfPRRY9pn8669Dqvr4CJWr6pY7fEIrVu8/O69ZZe
         yCYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772856925; x=1773461725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2j9Bldh73I1ZTU/gwH+Va1opxn4z5tE0/MvG0JXLOnM=;
        b=nk22UzM6Oa1kuaPyllOz3A7ZMb/2lVVhkc1O31pB8cw6FF3tGtdHDHaYIdhx4nI2Z1
         +ljDcMjQiRGpL2x2AlGIdFiypv16p3cFvkVBvFP6lWJW/Yc/MnXanwJ1jOMlCovptepI
         1A2B0yxo/kjNbFdfA/ReKRYsIFHCbD7tJqjVSVjaX1jAVYgSQBXcUWNXUf6dwCJ6LMEJ
         aJXKy7jTEDx7RTLNRoZqv8NTglAKdKfY5mGTq6DZ3jKbFsYc0614Mt2yVxaQ6exoZ7Xy
         CRWKV4Wy67Karwb4eUQ50PAigN5dprG21v3VYAm/zPUZqItCL9D6HUbxif2s9ZlqUk7S
         yNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772856925; x=1773461725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2j9Bldh73I1ZTU/gwH+Va1opxn4z5tE0/MvG0JXLOnM=;
        b=B96hyWBmob0vZas8YhCJJaWdNjsUyBrn6segv8tL7ghGsxeQAHOt2TgPwpsT75JbNi
         sETOifTbrY482ztE+C/RIaBdt1QU4HCe1rlenSyjHPcch90VXT6GeFav8+EPZ+WoSOP7
         O1fPrTOHRXGJHbHbTXK+vmeMSS680CeLTLAvwvKwHy+bQXHKf//4Y1zT7z2mVUv/Cmw3
         hPvOAa3EJeaVMCVfsIBH3x3WG8ZEFqCk98OoqUl7I+RfXkKqEjHDRE4M2ogprR7DedRR
         2fz04DZPWvbwsYkAi4Fy/rgC6mwSQhEi+MXVzkX4/Etjj/SZ6dwvoq3fgSukvk409081
         8UOw==
X-Forwarded-Encrypted: i=1; AJvYcCVfl1NNEzf2sLFBqLOwnT9DClpav87YpwUwTFiD4SD3i8fWD+vHxqdhgohZ4MSR13aJJB1Laa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTvXtz/zh+rjY0t255Z+MHgsGBpv4URHvqiYEFCgagfjjSiIAw
	gFgCynD3mdwT/zVM2jOWveaU86qoTZdYqoKRfpaFAf3mYLNtWPlBzaYIhZhkHcqE3tDD7HMTcRB
	9hjyDEp8qPnd0FlcG57/5YeDiLIVhOq0aC32h4Gfi
X-Gm-Gg: ATEYQzwAm1wEvpOQ7VOE2Jthhm+lR8HcgwCKXyLQc6mEPamrsCgSkZQfKbJtWyg7ja5
	+Rl85StCqfZk5TlsdmgFVuUwmXQGSgys3f8kdRAJSpJLWA7c5rQtq87h1KFpWF+fb/Szja3gFdj
	2fg6N8UsMaW+Ywj4/yOYAohFniDfU/m3ZENgjmWo4om5rz5k6c/FvxZaGC2prq7LCT4iHMZJVG+
	tTyhY0fmDNAG06BzHJQGXItQ1e75uOBYjQKowXdLCr4pl2Qsw7TlnkzAUpgQ/RILOjjbEgga1mW
	gmwiVvdF
X-Received: by 2002:a05:6214:2604:b0:894:6112:457c with SMTP id
 6a1803df08f44-89a30b1fef8mr66196616d6.56.1772856924630; Fri, 06 Mar 2026
 20:15:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307035110.7121-1-xietangxin@yeah.net>
In-Reply-To: <20260307035110.7121-1-xietangxin@yeah.net>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 7 Mar 2026 05:15:13 +0100
X-Gm-Features: AaiRm52Y7DK7119F2b2_eY2drAyaACtUvQzw-3G9kiGO-BiPanreNTAMyjIr48o
Message-ID: <CANn89i+Km-6ixX=mQEZSf_vAbYo4ECge8-jY8s3vLXJ87D63sA@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: Fix UAF on dst_ops when IFF_XMIT_DST_RELEASE
 is cleared and napi_tx is false
To: xietangxin <xietangxin@yeah.net>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 56E7A22A08E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265064-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[yeah.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.975];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[yeah.net:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Sat, Mar 7, 2026 at 4:52=E2=80=AFAM xietangxin <xietangxin@yeah.net> wro=
te:
>
> A UAF issue occurs when the virtio_net driver is configured with napi_tx=
=3DN
> and the device's IFF_XMIT_DST_RELEASE flag is cleared
> (e.g., during the configuration of tc route filter rules).
>
> When IFF_XMIT_DST_RELEASE is removed from the net_device, the network sta=
ck
> expects the driver to hold the reference to skb->dst until the packet
> is fully transmitted and freed. In virtio_net with napi_tx=3DN,
> skbs may remain in the virtio transmit ring for an extended period.
>
> If the network namespace is destroyed while these skbs are still pending,
> the corresponding dst_ops structure has freed. When a subsequent packet
> is transmitted, free_old_xmit() is triggered to clean up old skbs.
> It then calls dst_release() on the skb associated with the stale dst_entr=
y.
> Since the dst_ops (referenced by the dst_entry) has already been freed,
> a UAF kernel paging request occurs.
>
> fix it by adds skb_dst_drop(skb) in start_xmit to explicitly release
> the dst reference before the skb is queued in virtio_net.
>
> Call Trace:
>  Unable to handle kernel paging request at virtual address ffff80007e1500=
00
>  CPU: 2 UID: 0 PID: 6236 Comm: ping Kdump: loaded Not tainted 7.0.0-rc1+ =
#6 PREEMPT
>   ...
>   percpu_counter_add_batch+0x3c/0x158 lib/percpu_counter.c:98 (P)
>   dst_release+0xe0/0x110  net/core/dst.c:177
>   skb_release_head_state+0xe8/0x108 net/core/skbuff.c:1177
>   sk_skb_reason_drop+0x54/0x2d8 net/core/skbuff.c:1255
>   dev_kfree_skb_any_reason+0x64/0x78 net/core/dev.c:3469
>   napi_consume_skb+0x1c4/0x3a0 net/core/skbuff.c:1527
>   __free_old_xmit+0x164/0x230  drivers/net/virtio_net.c:611 [virtio_net]
>   free_old_xmit drivers/net/virtio_net.c:1081 [virtio_net]
>   start_xmit+0x7c/0x530 drivers/net/virtio_net.c:3329 [virtio_net]
>   ...
>
> Reproduction Steps:
> NETDEV=3D"enp3s0"
>
> config_qdisc_route_filter() {
>     tc qdisc del dev $NETDEV root
>     tc qdisc add dev $NETDEV root handle 1: prio
>     tc filter add dev $NETDEV parent 1:0 protocol ip prio 100 route to 10=
0 flowid 1:1
>     ip route add 192.168.1.100/32 dev $NETDEV realm 100
> }
>
> test_ns() {
>     ip netns add testns
>     ip link set $NETDEV netns testns
>     ip netns exec testns ifconfig $NETDEV  10.0.32.46/24
>     ip netns exec testns ping -c 1 10.0.32.1
>     ip netns del testns
> }
>
> config_qdisc_route_filter
>
> test_ns
> sleep 2
> test_ns
>
> Signed-off-by: xietangxin <xietangxin@yeah.net>
> ---
>  drivers/net/virtio_net.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 72d6a9c6a..5b13a61b3 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3351,6 +3351,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, =
struct net_device *dev)
>         /* Don't wait up for transmitted skbs to be freed. */
>         if (!use_napi) {
>                 skb_orphan(skb);
> +               skb_dst_drop(skb);
>                 nf_reset_ct(skb);
>         }

This probably could skb_release_head_state() at this point.

Thanks.

