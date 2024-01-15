Return-Path: <netdev+bounces-63591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 024C282E29F
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 23:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129721C21810
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 22:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B95847B;
	Mon, 15 Jan 2024 22:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Brmyy/EU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0941B5AC
	for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 22:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705357948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eP0VxXSEEil+R0UNdZpa6aVY75gYpHAxm/3u1ydWXpo=;
	b=Brmyy/EU/cJX4NhvrElOOdtPLEi8bGMQUO83J9N2XjjaTehhqDvxfe9cTK4jFkK2xYHoIt
	nIgjYvb49eetthbKnG4pQTfWNyarRCc2X1Fhgf9kYqlWNl+lGmiJSZo7V3wCSToIv6f5V7
	NI5LTtJeLrBdhj435DevjmIhIO/0TCY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-K98kWp6zObyBFtRa3JRnDg-1; Mon, 15 Jan 2024 17:32:27 -0500
X-MC-Unique: K98kWp6zObyBFtRa3JRnDg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40e41740b6eso80870085e9.3
        for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 14:32:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705357946; x=1705962746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eP0VxXSEEil+R0UNdZpa6aVY75gYpHAxm/3u1ydWXpo=;
        b=ONNhhOc7SK3ZTj0Q+aW4pTtWqfoOYhQd/7oNRmwhsmCys6exOGTkNmSgXLkIJhKNHC
         1wcEzAhdyp/hR5XQqnTCdDOXpwdMUTIFZZqwFtJ56yxd2l+CWZq+IrYXkZ21bG4MJEW2
         bDjSAbXHJShHZX4zf5pe1Eo3JfcZjarlli1JXg94/zxS0pPVTypmqreNLg6Sf5ZRrkKy
         6wYWagkc2XFaGc2cnH/ry25le+D5jB9udTvhRKGcbVyXXh5woT8Mm8jPIveZppSua+mL
         QnrkxkX9aaIZs3p1Z0+iRwykWpw/EnK+ngm7kP2RpbuxXA2Dq4Lk8T84iIJtfxQrkC+G
         FgCg==
X-Gm-Message-State: AOJu0Yx/tHuvFHE5GTNxeC8PrgZ04TE9chSj9cqR0/pN+m3PxJTFHybv
	C8N6UqrNSh8yeLzvA0YpPENO2hJ5ND1PAziPR+Kz8+U3+w0InUhriSOuZi4tsXqIuWRzpORJC0O
	4UlNb+rSkeLNo4Yjcs2UWASA5
X-Received: by 2002:a05:600c:4a9b:b0:40e:57f2:5948 with SMTP id b27-20020a05600c4a9b00b0040e57f25948mr2947001wmp.72.1705357946080;
        Mon, 15 Jan 2024 14:32:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkeJKqYDhM/whQk/nCZZw+VXl4wzetnaox4MjVkcLxDiSEjq0eYyRMgzXTkyhuF5WMBxlqJQ==
X-Received: by 2002:a05:600c:4a9b:b0:40e:57f2:5948 with SMTP id b27-20020a05600c4a9b00b0040e57f25948mr2946992wmp.72.1705357945790;
        Mon, 15 Jan 2024 14:32:25 -0800 (PST)
Received: from redhat.com ([2.52.29.192])
        by smtp.gmail.com with ESMTPSA id m8-20020adfe948000000b00336710ddea0sm12980913wrn.59.2024.01.15.14.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 14:32:25 -0800 (PST)
Date: Mon, 15 Jan 2024 17:32:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Melnychenko <andrew@daynix.com>
Cc: jasowang@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yuri.benditovich@daynix.com,
	yan@daynix.com
Subject: Re: [PATCH 1/1] vhost: Added pad cleanup if vnet_hdr is not present.
Message-ID: <20240115172837-mutt-send-email-mst@kernel.org>
References: <20240115194840.1183077-1-andrew@daynix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115194840.1183077-1-andrew@daynix.com>

On Mon, Jan 15, 2024 at 09:48:40PM +0200, Andrew Melnychenko wrote:
> When the Qemu launched with vhost but without tap vnet_hdr,
> vhost tries to copy vnet_hdr from socket iter with size 0
> to the page that may contain some trash.
> That trash can be interpreted as unpredictable values for
> vnet_hdr.
> That leads to dropping some packets and in some cases to
> stalling vhost routine when the vhost_net tries to process
> packets and fails in a loop.
> 
> Qemu options:
>   -netdev tap,vhost=on,vnet_hdr=off,...
> 
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>  drivers/vhost/net.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index f2ed7167c848..57411ac2d08b 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -735,6 +735,9 @@ static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
>  	hdr = buf;
>  	gso = &hdr->gso;
>  
> +	if (!sock_hlen)
> +		memset(buf, 0, pad);
> +
>  	if ((gso->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
>  	    vhost16_to_cpu(vq, gso->csum_start) +
>  	    vhost16_to_cpu(vq, gso->csum_offset) + 2 >


Hmm need to analyse it to make sure there are no cases where we leak
some data to guest here in case where sock_hlen is set ...
> -- 
> 2.43.0


