Return-Path: <netdev+bounces-284503-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wI28CS8Y+mlrJQMAu9opvQ
	(envelope-from <netdev+bounces-284503-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:17:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F75D4D11AB
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 874D431246DE
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 16:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D60648B39A;
	Tue,  5 May 2026 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHpMbhqd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jPQHiS0t"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D117148B37E
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997484; cv=none; b=mXbtajO7oMkuAluKv4v8wre46Pp6Ajp0Oem2uuMHyIcLPErwqu8KJgJMvOZmAbqZXcxytihqztq8qdVwXOW68Esb33ooP5ypRzZknq/99wKZLjFj5uvzHOxe2Ci8JhlPikYLFhijx5em8x1u8PYrBTACcjsubRBOK9rda3aVkCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997484; c=relaxed/simple;
	bh=NZswvJER178yJggzp3PBiIDtYWsGq7nDkywdtiyUvBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gghN0dMomONE/nKw5AfBqnwJRc7KqrIC9wuSl04uK0+LuUmhhWJqsTq8jJgJok/s2avADNyKTsadNtBwM0+vwIwWkr62lt/lS8adwykYX1xH/V9S5FVpxCeJgDrcYGqVbGPTDklr5ShzdRubrENTmkch5PFgLyA8XqGFZQjYsWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UHpMbhqd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jPQHiS0t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777997481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cDx07l4ozVnxxK7UujBIhmzxsF1zsTEyokH05DVKlSg=;
	b=UHpMbhqdGzqgn1xAJfVlk0ChNqq4P36Su5ZAw39HGR+Wj96sRErc/wmiSiUW30yBwUDE37
	HBjkYU2UaA1mkwjRJ2PJqJhVk88aHKz2QEsD3StfCCyxlmKP9IbL3mzybJgKBcP+Jdp49o
	ypZIsvV/e28VU0xQGiSAYmbJxpb6Apk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-F9Tct85DMwif6JGerZFdEA-1; Tue, 05 May 2026 12:11:19 -0400
X-MC-Unique: F9Tct85DMwif6JGerZFdEA-1
X-Mimecast-MFC-AGG-ID: F9Tct85DMwif6JGerZFdEA_1777997478
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488f973ddfeso40019695e9.3
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 09:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777997478; x=1778602278; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cDx07l4ozVnxxK7UujBIhmzxsF1zsTEyokH05DVKlSg=;
        b=jPQHiS0tjibLAhDCU6AAtsPYhuwHzyTPfWQ4l/Z8rBkOTMEZTJ0yuUFp00U/mjfmUK
         RQN9MQLCtOcEPiaPZC4OFOsnxcHG/KLrhJw9/G/s9ckv+EefHUYmyPADaN93SpVUfScA
         +j2S3Asipgu8f0h7V4kUn1KxgduO/mcG6KbB0OoWa6irXCBKXqA6F94CLtZ1ffoHM1++
         BlO36tl4Ni0RWf0twBi+e0zXtT9F0l/PSL92AnSHejzNe/x+rdOELiLZZANyd7pwagiD
         WHC0uCvs7KkmIXFevErB8v4MIXNKAWyJXhug0/CpJfiVvwwUJ9AX35I1uKDZdRYxzscs
         oCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777997478; x=1778602278;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cDx07l4ozVnxxK7UujBIhmzxsF1zsTEyokH05DVKlSg=;
        b=etnw9tt32M4e9gCibNzUYgEkj6MDB16PM8TY0++ammS8+csiohF+6ZDh7nx/asJTk0
         lhy+0QkklqzHeNH8CroWZUY+NjHJ+ug4ral/V7yZzw1/RxaMC1nVPfesmla2AwQaDCQX
         xBXKMzcX3ejsERIXS445zQ7thpd6iwHkqAyJ24Ccj959ddcQ7qzD5Hj5GblyJfGHLltI
         VHCdQbSOc3oKyznR+Inst5Svelj3UJYD2WSy2NcK390wpXsPHGZyfmZzYYtn1+Zn17nN
         uZcv2f+AXB2TqWRK6WHtsxpaiHNTP9NoJWiKGYw/ajNqQsp9HokfmOvDxwnK3+0suza3
         Z3ig==
X-Forwarded-Encrypted: i=1; AFNElJ+L9BIOdt/U+bskbifxX9Uval4S0lpiU/EQiTBCNhklGWpCzAe01BYW2GlUxvo/xRyGWCqjXuA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlej4V+5FZeeCUHoI86bGWQftaihsPBJldwkgiziWnzgUcqOGr
	lRipok2F+MxjQCOYlWmmTXYg4liDq0IelAg49EFO6TTDAT0QiE68URGutw1qlvJwfwo7solvE/p
	6xpAPaG9gykm7ct2LtnlfUkZR7kS6wreQTkMu2KTFSsRXHhP8WJsEUlnC7w==
X-Gm-Gg: AeBDies7Eb/vj6jyWSw6w4OLl6sCsrkLBtsWA8kxobiTuC9gFle1fvzjopswn9w2xeF
	Qj9EmIYSPK0FNsK2ehWOaCBdLKk5H7ESBKDQp/zedv4zAq+knDVjwI+kuXbQKlBpJmQYyh1JvUZ
	qNolyfNB4B1BX4ocMkv6uSa+OR1DJNdDrEVJ0bqUbBzXnPOfYuV474fvlk6ubYCGg8pVHCOVX2j
	so8M3ex7qLR15ywKjdxO/pNkJ0qkqJ7iE10lkZwnH3H5Mt+8b6yMI1c5i5t3oLmUdX2A6BkovEW
	IE5uZWaQFxB/6lTnFNq/0VZTXGjGjCzN2tRVb9k96b6gJYwO2D+b4jwbkEosX9gK4wlT/8DNBon
	tUIPGFL9xm2vrkKg7NMnb3mQL5MUgPd0KeaZ6i/gMLwqIE+fRaOAJrnlNek/z3+h6pyRo7ouDcg
	==
X-Received: by 2002:a05:600c:1d0d:b0:488:8840:e5ae with SMTP id 5b1f17b1804b1-48e51c723bfmr551535e9.24.1777997478338;
        Tue, 05 May 2026 09:11:18 -0700 (PDT)
X-Received: by 2002:a05:600c:1d0d:b0:488:8840:e5ae with SMTP id 5b1f17b1804b1-48e51c723bfmr550795e9.24.1777997477746;
        Tue, 05 May 2026 09:11:17 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8ebb3dc1sm380443525e9.14.2026.05.05.09.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 09:11:16 -0700 (PDT)
Date: Tue, 5 May 2026 18:11:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eric Dumazet <edumazet@google.com>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
Message-ID: <afoF_cHfl6ygcupM@sgarzare-redhat>
References: <20260430122653.554058-1-edumazet@google.com>
 <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
X-Rspamd-Queue-Id: 6F75D4D11AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284503-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,sberdevices.ru,linux.alibaba.com,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alibaba.com:email,oasis-open.org:url,sberdevices.ru:email]

On Tue, May 05, 2026 at 07:14:36AM -0700, Eric Dumazet wrote:
>On Tue, May 5, 2026 at 6:52 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Thu, Apr 30, 2026 at 12:26:52PM +0000, Eric Dumazet wrote:
>> >virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.
>> >
>> >virtio_transport_recv_enqueue() skips coalescing for packets
>> >with VIRTIO_VSOCK_SEQ_EOM.
>> >
>> >If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
>> >a very large number of packets can be queued
>> >because vvs->rx_bytes stays at 0.
>> >
>> >Fix this by estimating the skb metadata size:
>> >
>> >       (Number of skbs in the queue) * SKB_TRUESIZE(0)
>> >
>> >Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
>> >Signed-off-by: Eric Dumazet <edumazet@google.com>
>> >Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>> >Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> >Cc: Stefano Garzarella <sgarzare@redhat.com>
>> >Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> >Cc: Jason Wang <jasowang@redhat.com>
>> >Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> >Cc: "Eugenio Pérez" <eperezma@redhat.com>
>> >Cc: kvm@vger.kernel.org
>> >Cc: virtualization@lists.linux.dev
>> >---
>> > net/vmw_vsock/virtio_transport_common.c | 4 +++-
>> > 1 file changed, 3 insertions(+), 1 deletion(-)
>> >
>> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> >index 416d533f493d7b07e9c77c43f741d28cfcd0953e..9b8014516f4fb1130ae184635fbba4dfee58bd64 100644
>> >--- a/net/vmw_vsock/virtio_transport_common.c
>> >+++ b/net/vmw_vsock/virtio_transport_common.c
>> >@@ -447,7 +447,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>> > static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>> >                                       u32 len)
>> > {
>> >-      if (vvs->buf_used + len > vvs->buf_alloc)
>> >+      u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>> >+
>> >+      if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
>> >               return false;
>>
>> I'm not sure about this fix, I mean that maybe this is incomplete.
>> In virtio-vsock, there is a credit mechanism between the two peers:
>> https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html#x1-4850003
>>
>> This takes only the payload into account, so it’s true that this problem
>> exists; however, perhaps we should also inform the other peer of a lower
>> credit balance, otherwise the other peer will believe it has much more
>> credit than it actually does, send a large payload, and then the packet
>> will be discarded and the data lost (there are no retransmissions,
>> etc.).
>
>I dunno, perhaps revert 077706165717 ("virtio/vsock: don't use skbuff
>state to account credit")
>and find a better fix then?

IIRC the same issue was there before the commit fixed by that one 
(commit 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with 
sk_buff")), so not sure about reverting it TBH.

CCing Arseniy and Bobby.

>
>There is always a discrepancy between skb->len and skb->truesize.
>You will not be able to announce a 1MB window, and accept one milliion
>skb of 1-byte each.
>
>This kind of contract is broken.
>

Yep, I agree, but before we start discarding data (and losing it), IMHO 
we should at least inform the other peer that we're out of space.

@Stefan, @Michael, do you think we can do something in the spec to avoid 
this issue and in some way take into account also the metadata in the 
credit. I mean to avoid the 1-byte packets flooding.

Thanks,
Stefano


