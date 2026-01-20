Return-Path: <netdev+bounces-251510-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WL/2Cuijb2kNDwAAu9opvQ
	(envelope-from <netdev+bounces-251510-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:48:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C35A346B22
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CFAF850B7AD
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 14:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C264418F7;
	Tue, 20 Jan 2026 14:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F6nRyobx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QiAfRtf9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F43D4418EE
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768918415; cv=none; b=Sr7NfYOjCV4QIOrc/FWUTLEYi79gvUo1Vlgf+AA45No2YdnHEBULuMOXbK3vvUT4b35cwlxxkZjCbVzxmqf8842Pjx75VRzMPZbQ8L8bZGbE2HavbUvJ1tPPu8+5WKUQh5SG2DqGtHMf4hHnT1kXAgf2aO+Lij0lEEnnufl2C2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768918415; c=relaxed/simple;
	bh=MTXAttGcmQV+gKT1VuxP3RbxteQV73dhqFSiu5vTsKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GeYxAqC+rTTDLCGVj+gq9ECtFoqP5lCxnzaetYxYjB86jM+hVNna145SV+Le5ezB/Q8eP0TXGr+RC/SJpiXH6YNizEuTPHbv5EiIUIb4URtYVfV+tGhppXbuY//YdRClrsZptJ56ejMI8soV5qFarGJpXuEnPoySk85lR7xnKnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F6nRyobx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QiAfRtf9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768918412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o4YIZav5bzJmQLAgwNywWVFJIuBH5AeoqXsTBWn1nZk=;
	b=F6nRyobxxQ8YvcWxJKiDL0VR0iacWnJWXTrVL2kQW40sMKnf58/ifcxNcRLqEPi453oYOI
	JQ35hNkdm3pXOysiNhIejzA1m2sbSH943hhLJWymVT4Bc8fY7/BUCPNEAAX30VnCJT6nyb
	eEBsIRUWbpf/a+rFqafbcVOqHHCHOFg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-JOp4XxwxNo6TOgdfw-Y08w-1; Tue, 20 Jan 2026 09:13:31 -0500
X-MC-Unique: JOp4XxwxNo6TOgdfw-Y08w-1
X-Mimecast-MFC-AGG-ID: JOp4XxwxNo6TOgdfw-Y08w_1768918410
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-430fc83f58dso3691294f8f.2
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 06:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768918410; x=1769523210; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o4YIZav5bzJmQLAgwNywWVFJIuBH5AeoqXsTBWn1nZk=;
        b=QiAfRtf9cyycvkVyc0yBvW6VQG51+xrGU/cDcp2l5jHvShuJ2wEnJwTkyoAM7F6ezS
         lawZ01R1YFkGLb4eYz3sxhbRXZSQtetWGBBtAWgh4jLxLSvsU6ixE1eNIiYyYP52vFj3
         SunwV6p/dKBtZkav1sIi0/QMBW+RInhLSFNQeT9H6un+0j9BKLx7SopZQqv/5rNLeLjG
         4aXNHB1a29nsZIlh7WAV6s3NjqmsV5Mp9gVxmWB9g4T5JjBsew3YKwTFnfTZZUXFg74B
         qNunI4qEASWmzr6Vc+6iAnV37p4qYQa/T5Pud0IVf7dFXqMVbMs164MGefDnWTmnWeTU
         QRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768918410; x=1769523210;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4YIZav5bzJmQLAgwNywWVFJIuBH5AeoqXsTBWn1nZk=;
        b=CKmuI81KOJ1otOzMFSGY/ES1i0aR9gdO3hObTRxnfXZ0XphwnAhZRdVp9dHP3JWVSr
         E3Oc0amIPqhvQHXBYuuvEG/02vhjzV/C0AasxEKaaHvM+S0yVl1w8wrC5RYuOV5eUsov
         3Kkq9s2AsplBKzY+pXx8TOlXPaBi4un8J/re9swDsYSAcy9mRe8kEONPQbi4HDmHNhkz
         vfRvqfJk9sTVfwGdJoSxp7oOe66+UqFG6vnFq88DPXstnw5yMufykEGfrDHee6STOk6W
         Hd0VJ5BobIz0Wgeqx3mVN4zbPtnBNSCia1eJou9vWpY8EGJCj8t0JmajpcAa0QuF0Yf6
         BDrA==
X-Forwarded-Encrypted: i=1; AJvYcCU8zt/B9eYVEwAt9UKniZsjL0CVpt2W5LisdmAXKFLYSezkr31ncF7SaXPkHeosR3EEH0r4WnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM1OUbHsJAQxIHEUzf0fU5s3utMpDsqJrEPxuputlherRHlZEm
	PnlO3uNULk4s6DdTvl+V91jQrNE6/MZnDkoP+fAYkTERZbrfY0OP2Z2tWKk3dDKwiE33hl4S7of
	sagIg1FYroiBbg7uu2kfwX28FIcELNUReZE2D2RpJMw6OO5ToA/k0/4V+Pg==
X-Gm-Gg: AZuq6aJX3sD/0yhuEheLA935imcQkaE4VVQgk4ji0EsHxBjyshX6rxc52vSURkN2qIz
	dZp/PtJjgY74UJp8+Sy76IEHDxgncpDu+SCAdgSBj2UUCgPTCvXR0dyc1Zu4XUT/Qf06lgO/e9o
	Ac5XUbEpmelQ/O7hroCG0JEAIOo8NicBjLJd8MBoXKzAGcIbcwSqzcl5QFBDivMxoV4bq6r8sWd
	+xHM0wMasEyK3GrpZ1rx1DTGEah/JLltPTLtOH5Cg+hCyrP8nU56nwilXawmorcRJqo/OyOzOjx
	dd4wQwtpCmnlcgGEKXecMq2jTr2DvC46nivqcU8z6JLVK7q+ExwhpdPDw9748lVQkaiVr1vb9gn
	RJUXqwtx5E3kH
X-Received: by 2002:a5d:5887:0:b0:432:8504:8d5b with SMTP id ffacd0b85a97d-43569bcb816mr18237025f8f.50.1768918409933;
        Tue, 20 Jan 2026 06:13:29 -0800 (PST)
X-Received: by 2002:a5d:5887:0:b0:432:8504:8d5b with SMTP id ffacd0b85a97d-43569bcb816mr18236980f8f.50.1768918409485;
        Tue, 20 Jan 2026 06:13:29 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.113])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43596b62700sm581337f8f.42.2026.01.20.06.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 06:13:28 -0800 (PST)
Message-ID: <71705484-46fc-469f-9357-07a076ee0e73@redhat.com>
Date: Tue, 20 Jan 2026 15:13:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 08/16] quic: add path management
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>,
 quic@lists.linux.dev
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Stefan Metzmacher <metze@samba.org>,
 Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>,
 Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>,
 linux-cifs@vger.kernel.org, Steve French <smfrench@gmail.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Paulo Alcantara <pc@manguebit.com>,
 Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Alexander Aring <aahringo@redhat.com>, David Howells <dhowells@redhat.com>,
 Matthieu Baerts <matttbe@kernel.org>, John Ericson <mail@johnericson.me>,
 Cong Wang <xiyou.wangcong@gmail.com>, "D . Wythe"
 <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>,
 illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Daniel Stenberg <daniel@haxx.se>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <cover.1768489876.git.lucien.xin@gmail.com>
 <3771dfc211626a9f0c603c90113e38f325ceb456.1768489876.git.lucien.xin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <3771dfc211626a9f0c603c90113e38f325ceb456.1768489876.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,samba.org,openbsd.org,redhat.com,xiaomi.com,simula.no,vger.kernel.org,gmail.com,manguebit.com,talpey.com,lists.linux.dev,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-251510-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: C35A346B22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/15/26 4:11 PM, Xin Long wrote:
> @@ -0,0 +1,524 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* QUIC kernel implementation
> + * (C) Copyright Red Hat Corp. 2023
> + *
> + * This file is part of the QUIC kernel implementation
> + *
> + * Initialization/cleanup for QUIC protocol support.
> + *
> + * Written or modified by:
> + *    Xin Long <lucien.xin@gmail.com>
> + */
> +
> +#include <net/udp_tunnel.h>
> +#include <linux/quic.h>
> +
> +#include "common.h"
> +#include "family.h"
> +#include "path.h"
> +
> +static int (*quic_path_rcv)(struct sock *sk, struct sk_buff *skb, u8 err);

It's unclear why an indirect call is needed here. At least some
explanation is needed in the commit message, possibly you could call
directly a static function.

> +
> +static int quic_udp_rcv(struct sock *sk, struct sk_buff *skb)
> +{
> +	memset(skb->cb, 0, sizeof(skb->cb));
> +	QUIC_SKB_CB(skb)->seqno = -1;
> +	QUIC_SKB_CB(skb)->time = quic_ktime_get_us();
> +
> +	skb_pull(skb, sizeof(struct udphdr));
> +	skb_dst_force(skb);
> +	quic_path_rcv(sk, skb, 0);
> +	return 0;

Why not:
	return quic_path_rcv(sk, skb, 0);
?

> +static struct quic_udp_sock *quic_udp_sock_create(struct sock *sk, union quic_addr *a)
> +{
> +	struct udp_tunnel_sock_cfg tuncfg = {};
> +	struct udp_port_cfg udp_conf = {};
> +	struct net *net = sock_net(sk);
> +	struct quic_uhash_head *head;
> +	struct quic_udp_sock *us;
> +	struct socket *sock;
> +
> +	us = kzalloc(sizeof(*us), GFP_KERNEL);
> +	if (!us)
> +		return NULL;
> +
> +	quic_udp_conf_init(sk, &udp_conf, a);
> +	if (udp_sock_create(net, &udp_conf, &sock)) {
> +		pr_debug("%s: failed to create udp sock\n", __func__);
> +		kfree(us);
> +		return NULL;
> +	}
> +
> +	tuncfg.encap_type = 1;
> +	tuncfg.encap_rcv = quic_udp_rcv;
> +	tuncfg.encap_err_lookup = quic_udp_err;
> +	setup_udp_tunnel_sock(net, sock, &tuncfg);
> +
> +	refcount_set(&us->refcnt, 1);
> +	us->sk = sock->sk;
> +	memcpy(&us->addr, a, sizeof(*a));
> +	us->bind_ifindex = sk->sk_bound_dev_if;
> +
> +	head = quic_udp_sock_head(net, ntohs(a->v4.sin_port));
> +	hlist_add_head(&us->node, &head->head);
> +	INIT_WORK(&us->work, quic_udp_sock_put_work);
> +
> +	return us;
> +}
> +
> +static bool quic_udp_sock_get(struct quic_udp_sock *us)
> +{
> +	return refcount_inc_not_zero(&us->refcnt);
> +}
> +
> +static void quic_udp_sock_put(struct quic_udp_sock *us)
> +{
> +	if (refcount_dec_and_test(&us->refcnt))
> +		queue_work(quic_wq, &us->work);

Why using a workqueue here? AFAICS all the caller are in process
context. Is that to break a possible deadlock due to nested mutex?
Likely a comment on the refcount/locking scheme would help.

/P


