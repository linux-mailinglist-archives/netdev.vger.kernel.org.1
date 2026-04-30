Return-Path: <netdev+bounces-282851-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CG+AF6FU82mLzgEAu9opvQ
	(envelope-from <netdev+bounces-282851-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:09:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C6B4A32F3
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 887743062441
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 13:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98E7410D1F;
	Thu, 30 Apr 2026 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGlUyu4r";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="POTcm97i"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F9940F8D3
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777554287; cv=none; b=NTgzfbJ707HeCxwtB3diEHESqIfb5Q46o8b1lqN8npT2Mjlb5EkkwXOjOeGoD16U+KulEu7p0wJvM4FBJCSm+B29VRGHROfGF3yCL0hS59CsqzHwPpXIFtuDM48yYP6gyJMZfSEEnIqo6dXtxpIWml2nU6G9l4karqAwz7xxpvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777554287; c=relaxed/simple;
	bh=Dk9brHbKfFNbGJGzioI4SNCia5lWoLEHi0LrGbaPeqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmXfiGMFdqxLuAm6yBtGrdPihzJ5xBBAOv0e9CammeZpswn1Ok/5F5M1mumGddNvcN6D/g0uXIgOUpGmWqIPfRKZ2U9jbDceZrz0SyamQeIicKaZtpHI5Yh+5UhIaD1ZnHLS3mP+nFgjbFJ+v0pTY907+mf0ap5RSmSOfHEF+A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZGlUyu4r; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=POTcm97i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777554284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4iM1C5bPOK6CsY7bMqOIntIdxAE/svN63ooTIzddU6M=;
	b=ZGlUyu4rbOPVnW4Sr1iIvILnB3w43V+YJDxJ1yHvjiV/UlSXj1cD0OAZo3lmAdYseokGMb
	rlgba/lLn2FVt5AmAN24j/uL6hIIk59CO6XG6vRpTIfmaI5REgQK9ORhIsMbv2k7hhCf80
	qkshYq4W3135MLlOzZbdyc+5349FFSg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-BWK6ppvwMq-O3qKbFUKcqg-1; Thu, 30 Apr 2026 09:04:43 -0400
X-MC-Unique: BWK6ppvwMq-O3qKbFUKcqg-1
X-Mimecast-MFC-AGG-ID: BWK6ppvwMq-O3qKbFUKcqg_1777554282
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488d9e1e61aso9721805e9.0
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 06:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777554282; x=1778159082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4iM1C5bPOK6CsY7bMqOIntIdxAE/svN63ooTIzddU6M=;
        b=POTcm97iezuPZHqF0RvZ1r7OFeiV8TDsuFww9kPOTy5qXjT6k+smCN2BzrSSRP2zRX
         YMYHmpLE4gqRM4OrBSpe2pGideFti0061hbCb5Sw/T9AJ5cW49YqtaprYa5fBbnNrDPD
         ayjK//nCMh6OjbCNexe1Hllnk7K7DQ3XdXAkSU8+HKvyrJ2SQ/Tox1ZQvb8iLnDsJDNY
         V5Taor7rsLr1ehAiKoKRP/7bRt4zN3TTzTHDQmnHsqT+ffKvdx5vpcika7oxNs7SLbpS
         Ku6+BUag+ciarVWBDfaCPCe1N9Q1AEpV4fCfhCDbR2cJWyM9ftP6xY+j0bkdSatTVUQD
         SGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777554282; x=1778159082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iM1C5bPOK6CsY7bMqOIntIdxAE/svN63ooTIzddU6M=;
        b=jXjg75Gks8VDJZRtufDTZzzMM76qppsCCvtLz23cZhNGshu/O44/gk6C774rKv+z5M
         XMkjsgBuMfD3OFNxeXtaYd4FVELd0zscdLmrnFNBcC/OoHL371BYf0V0Ye9MQdSnlNnZ
         hwNzhQtgQ8z73wZJou/JzYbVNSKkUenKjHAR2jd3BRIOuw2DGjaDyO2VfdJFiXvMzJIT
         CYzikwbSZCxSMs1tPDkLJ8YiDjOG6jfDNPN5lMZV4ZqwjGILHlF+4XlKOa/weVyAOMBc
         j1PXIbx0ghNoQM0PJIynxSlCysNYgnBg+Q0T5U1cItLtgbOm52XNbefdkGwvpakx3BT3
         uo5w==
X-Forwarded-Encrypted: i=1; AFNElJ93P0+g1PHZ6WFERKndP+4V9AlyO+8xgDKhGsFNc8JUdFlZIWAj/2B2lW+tFIteDy76E/WVFAA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1O7D44bbe9jJYfjPguKY3sG27pGSWThG8dlxWNVFOXGNbKBfU
	hCwnUO68CwCtWSiGqd8EXh8BY4zzTP3MUwNFCAgjllUjo2+tK2b5pO7TrZ4pVhzJt0Z8PBWAZLs
	a1+5ZQmXpC02iEgOyaDUd0wu83yUCBNtwghw7rcjnNlQ4GHtIchHEW/eLrw==
X-Gm-Gg: AeBDietoq5ct6w9tJa590SVhfkODwgdKZvRfkW80aTZu3Pe3n9zFR1cYtp3S3NXTb6c
	IAfQqb2wViRDNIf08a0yQY9KD4D7v8Ebmw94dkhYomUhDcc0SubdzfoYXGn/X1VmiMoFyU1fIbY
	v0v1IC42QBDfOYkcbxnFAUVmRwGxfPG7vfZXHyWVuEty9YDfpBdf7niQTFk/HJBLLVF02XR5eRR
	A/ocqcmEbMdOMm7O0Qk1zecDdXd3SGI3kPtRwEdEcuuCAvQEWYNzpX4q4Nl+vdUwH0kwL0bLeuj
	A0HGOSw8+n15fnTj7H+vYK2SM4sKcuFX7c2gpdmdZM1uFgOumd4jISuvQZUrG+NJVgQUaLh2bze
	Ct90/FXO3fiLXXgWIolBc0XbaHd9wNKISJTZTuA==
X-Received: by 2002:a05:600c:6992:b0:48a:56de:d62a with SMTP id 5b1f17b1804b1-48a83d7b059mr51482285e9.11.1777554281998;
        Thu, 30 Apr 2026 06:04:41 -0700 (PDT)
X-Received: by 2002:a05:600c:6992:b0:48a:56de:d62a with SMTP id 5b1f17b1804b1-48a83d7b059mr51481435e9.11.1777554281407;
        Thu, 30 Apr 2026 06:04:41 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82301b7bsm71336415e9.11.2026.04.30.06.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 06:04:40 -0700 (PDT)
Date: Thu, 30 Apr 2026 15:04:37 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Yiqi Sun <sunyiqixm@gmail.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stefanha@redhat.com, 
	sgarzare@redhat.com, mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH] vsock/virtio: fix vsockmon info leak in non-linear tap
 copy
Message-ID: <afND89LDgovPpanE@leonardi-redhat>
References: <20260430071110.380509-1-sunyiqixm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260430071110.380509-1-sunyiqixm@gmail.com>
X-Rspamd-Queue-Id: 94C6B4A32F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282851-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonardi@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu, Apr 30, 2026 at 03:11:10PM +0800, Yiqi Sun wrote:
>vsockmon mirrors packets through virtio_transport_build_skb(), which
>builds a new skb and copies the payload into it. For non-linear skbs,
>this goes through virtio_transport_copy_nonlinear_skb().
>
>Helper manually initializes a iov_iter, but leaves iov_iter.count unset.
>As a result, skb_copy_datagram_iter() sees zero writable bytes
>in the destination iterator and copies no payload data.
>
>This becomes an info leak because virtio_transport_build_skb() has
>already reserved payload_len bytes in the new skb with skb_put(). The
>skb is then returned to the tap path with that payload area still
>uninitialized, so userspace reading from a vsockmon device can observe
>heap contents and potentially kernel address.
>
>Fix it by initializing iov_iter.count to the number of bytes to copy.
>
>Fixes: 4b0bf10eb077 ("vsock/virtio: non-linear skb handling for tap")
>Signed-off-by: Yiqi Sun <sunyiqixm@gmail.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 416d533f493d..6b26ee57ccab 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -152,7 +152,7 @@ static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
> 	iov_iter.nr_segs = 1;
>
> 	to_copy = min_t(size_t, len, skb->len);
>-
>+	iov_iter.count = to_copy;
> 	skb_copy_datagram_iter(skb, VIRTIO_VSOCK_SKB_CB(skb)->offset,
> 			       &iov_iter, to_copy);
> }
>-- 
>2.34.1
>

Thanks for the fix!

Tested using vsock_loopback sending zero-copy packets. Payload is always
zero before the fix.

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


