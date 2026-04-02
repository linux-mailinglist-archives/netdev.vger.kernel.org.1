Return-Path: <netdev+bounces-274541-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBaJMnNtzmnxngYAu9opvQ
	(envelope-from <netdev+bounces-274541-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:21:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7112838999D
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 648A031AF203
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 13:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B1D34FF7D;
	Thu,  2 Apr 2026 13:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FLOPeTjx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OmSxKdpf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1047C3E2741
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775135311; cv=none; b=bfdj7kAhGwPE1a+Lej/Bek+6bIyJvaLBzkI8Ve3xXre0MzALeKP/yPFp9U3z6PwQMxOghby8Z863cPZ6m8anGlFAeyhKgwF4o1ddCqgLSWKa2HQoqPB9LtBOOVAUAaefbFJoHg8bIEEHUqslgeNWD33A069dWRKdiGUvolN10y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775135311; c=relaxed/simple;
	bh=wm02E3T0a1peGSnmnmR4/hZwBTf9XgjeCN8sySv09FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cx0kdD02J4Zr9aIUv9wefh2z6MghpAvBZtBZrgY61YVUPi6V1fXIQt6Kcl9NwNTTM24Wf+Ih5igGAhtQsgV31y72XdhH6GqI1TUmW2MWmAIOdKzvNE8P9Z/8lbzNyvmzzJvT8lScBz2TYK6FyZknYa/NgoT8BITGcQx1r2q9y1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FLOPeTjx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OmSxKdpf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775135306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+/AYnKJRH8mdswMQLrHJ90PhRLOmS9dKac7jjdIwogo=;
	b=FLOPeTjxpg/3okHeEusjE1dByn+D4i0NmR98cEnEEUmlJG/mx/IA+POgtc/rVMGRKCVSR0
	PDe9XJteSahY+riZpxxPX82WIjLFC+rPsk1QcPJ+dnbVNkUipEkif3BZvwMk0TJeFc/oZ3
	5jyz42Yurjxcvjh5QFei35yp/Op2/bk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-NKwGg3NNMsumzvMUHD_T-w-1; Thu, 02 Apr 2026 09:08:25 -0400
X-MC-Unique: NKwGg3NNMsumzvMUHD_T-w-1
X-Mimecast-MFC-AGG-ID: NKwGg3NNMsumzvMUHD_T-w_1775135305
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4887e4b338bso21200695e9.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 06:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775135304; x=1775740104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+/AYnKJRH8mdswMQLrHJ90PhRLOmS9dKac7jjdIwogo=;
        b=OmSxKdpfpWQwZPkeJwIqZwu+5Ls6i9ULG0Z1keqnATsFkVMOKeJC5GiNMvb2SQ7Eqb
         B9ghh3Pk/Es8IhF+ewROImIOaA+Y6jhz1mmBhAiF87R97SvqS898vVWY/ehRzEJOCe1x
         xTUBqKOvkHImBwDXCjfO2C9FdAsbj0sA1ge8EDyk+fPVvnwr5F41pFGRrZFG6PXoaNbT
         nquDP515shrYHkqe0sgToPRFbSHimwJyDRMoqn1r7c+8loVKwxkGG7rtRSDTGTy8liEt
         rWpVDWkQ9Jt8WKi4yJRrjnpTYNgPGd0CwWwJ4DEfjkDRFd/y7HsRAQxDSuWTaigGk50H
         5dcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775135304; x=1775740104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/AYnKJRH8mdswMQLrHJ90PhRLOmS9dKac7jjdIwogo=;
        b=KX+yzUSlNV4C1g5w3wBGTIykEDdqsX9WCYGGB0Lm26R15HbBAoyvP2YQ978CK8GxH5
         v1GlFkzmy0JzfaKc/u6U5L+Y6nRMwWmuO3hUqRMX6EgLVreEP26qUr3EKTf5qcf/iWmO
         R0meGwmrmNzV2GBsK4PmCUvn1LVMTjpctiAtEqXaatINpAW4h5ZMj1UN8uSy1IB72WHZ
         Ukx0v0/pcecqhVk4XQA+zeWhrg0lA0hj+DF+NkKV/boWboAWFqZmsAJWuyw5OIIShUUL
         kH0zdWuYaFEN7uDebD6h3FNOlO8VW0gLYvqVNlD6y/dRVSdwhJLoSL6/kR8RkFoXBVtT
         B1RQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1X8fA8nn7QLW82QHBC7xVfrcBXhVXHvXscRFoECZ7t5fLBgTQvgdeDYRoQaM6wSwQJWnnmR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVIGFo7aqlUVX60m1TL+DPUZjxobME6yYbtssmdiqM9XLZ+a4l
	QVTxKtwl+Lww5QI6eXpdDA02XP8KjtRTDkfWrqE4N7D7UeWuspUUYaZnYu/6zdcZsF1AJCNh5BS
	y4MwV3C9NI0l/Am4YkIS8wQGKBXmwH0irROpCDy10gPyeWDpyvTkmDCuuEg==
X-Gm-Gg: ATEYQzynuHEhvdjebnHpGPN6md6FxQhTRXc32m57xhvRd/Dnl7yHQd+qIexnGGeW0ba
	CULzC/9zJEftT3udWOqhMLpRnx7LCHvkItYH6ObIjn5oYz5AO63QYl5pYOyUBUhr1WL/Iw5DXp9
	oX9pPkuyym2N00o2s0FXBG17NrqI/l7iTKs4zBK1YEGaAReW6FUvL/whczN+7ThvAR2xhS5K2He
	JeKxOrBwA2UraZ94stNnntBky2JokcKaAnpaeQxgleXhH/PW4hY/DPaNzIEa8WAIofMrOSbKwNW
	O/tSQQ6N1Kdglb8Ma64goZlpVIiu9Ph2WNA9tQB2Vo8/46DIpCzxMZHLz6AkTBfbVMC/ANgfvPS
	rROrZNK88j1TesXgLanK93dpKt1XDMC+IIKcO9zT20iJKJ95IApXFHdP1yeAtSuaxEh1VF46XfC
	Qb
X-Received: by 2002:a05:600c:3496:b0:486:fbc4:8fe2 with SMTP id 5b1f17b1804b1-4888e0e47damr36924775e9.15.1775135304469;
        Thu, 02 Apr 2026 06:08:24 -0700 (PDT)
X-Received: by 2002:a05:600c:3496:b0:486:fbc4:8fe2 with SMTP id 5b1f17b1804b1-4888e0e47damr36924105e9.15.1775135303929;
        Thu, 02 Apr 2026 06:08:23 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-139-105.business.telecomitalia.it. [87.12.139.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e967badsm251669415e9.14.2026.04.02.06.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 06:08:23 -0700 (PDT)
Date: Thu, 2 Apr 2026 15:08:15 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] vsock/virtio: fix MSG_PEEK ignoring skb offset
 when calculating bytes to copy
Message-ID: <ac5pVRhTSc0Xr2xy@sgarzare-redhat>
References: <20260402-fix_peek-v1-0-ad274fcef77b@redhat.com>
 <20260402-fix_peek-v1-1-ad274fcef77b@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260402-fix_peek-v1-1-ad274fcef77b@redhat.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274541-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7112838999D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 10:18:01AM +0200, Luigi Leonardi wrote:
>`virtio_transport_stream_do_peek()` does not account for the skb offset
>when computing the number of bytes to copy.
>
>This means that, after a partial recv() that advances the offset, a peek
>requesting more bytes than are available in the sk_buff causes
>`skb_copy_datagram_iter()` to go past the valid payload, resulting in a -EFAULT.

nit:

WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#14: `skb_copy_datagram_iter()` to go past the valid payload, resulting 
in a -EFAULT.

>
>The dequeue path already handles this correctly.
>Apply the same logic to the peek path.
>
>Fixes: 0df7cd3c13e4 ("vsock/virtio/vhost: read data from non-linear skb")
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 8a9fb23c6e853dfea0a24d3787f7d6eb351dd6c6..4b65bfe5d875111f115e0fc4c6727adb66f34830 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -547,9 +547,8 @@ virtio_transport_stream_do_peek(struct vsock_sock *vsk,
> 	skb_queue_walk(&vvs->rx_queue, skb) {
> 		size_t bytes;
>
>-		bytes = len - total;
>-		if (bytes > skb->len)
>-			bytes = skb->len;
>+		bytes = min_t(size_t, len - total,
>+			      skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset);

I think we should add some helper like virtio_transport_skb_remain() or 
virtio_transport_skb_bytes() and use it here but also in places where we 
check offset < len or offset == len. But maybe better to do that in 
another patch/series for net-next.

This fix LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


