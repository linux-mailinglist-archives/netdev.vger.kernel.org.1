Return-Path: <netdev+bounces-46833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB18B7E6980
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 12:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7554C280E82
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 11:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA70199D5;
	Thu,  9 Nov 2023 11:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g6ygF4Tp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E711A594
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 11:26:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9582D2D63
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 03:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699529200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1QOLIHzEKPeNCh/zgabkL+jzDMFaxREx6dKV9oDb1WM=;
	b=g6ygF4TpiYxbfJQXKTL+37Z1QLUMmm1ixYEl7WsxvK2MgenJJIZ3bHThUP63Af04z8+hzz
	Tluckfmmxttlacdr+9IJFqU7sIOVBNsX5uE98Iyoxao6aqRr16ZfbYuwVhlZrg/R6He6u2
	NQ9zY3r8AurFtJoeeVZokul1JAdyYZM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-RViqJFCaNuq3nQIAX0Utqw-1; Thu, 09 Nov 2023 06:26:39 -0500
X-MC-Unique: RViqJFCaNuq3nQIAX0Utqw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-41cbafdb4b6so2265731cf.0
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 03:26:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699529179; x=1700133979;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1QOLIHzEKPeNCh/zgabkL+jzDMFaxREx6dKV9oDb1WM=;
        b=ekytPYaQjpu6tNtS+byj1caW03ZRD3kvjd6xQhGgUWFsvEy1qBr3ItddfoqH7CEyrY
         /hYpgaOxtNy/HdLabSHB+yq9lTlCkc0kCOB6npzVUS2V+zB9Q7/kpeI+PyZkx+vhCGRu
         f4LPRw+N1uTwFQMzpt57kd3bq8lwzQEtO9HO6sPl+Vw4ybOCFMhq01fekJ3EGUJHLmqM
         gffG2B3EQUsodC70rd8lglNXf87XaMKm3wpUgstJFFNGbqsU1WG22UbHhRTCNIH9OJAU
         OOF12T+Jj5frf+Ej4HYm9ivcOYFmWBCngmPrTOG8/xo0mU95aFhqg8OtOEjNJ7VDETde
         IIXg==
X-Gm-Message-State: AOJu0YxPEMnwKZ5NtkbtouCzHWQY2Z28uMsegLgmc+UqJ2APtb5/oqIv
	EBfPCr/w70L5iWNnpBPy6odES3QOVr19cg9UiIR5nctIOtkVh0qwj5JS1fOEx0DRVIkOKLM9kug
	ZwZmJSeDhe7/paN37K8uNh78J
X-Received: by 2002:a05:620a:45a9:b0:76e:f686:cad5 with SMTP id bp41-20020a05620a45a900b0076ef686cad5mr5084599qkb.5.1699529179544;
        Thu, 09 Nov 2023 03:26:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzhfzLTv0xAs1B5hXemffnBR5aKAeewM9gbMza+Bp+J3sYeUTQb2pJEf4lKCHCpO5xH8zhig==
X-Received: by 2002:a05:620a:45a9:b0:76e:f686:cad5 with SMTP id bp41-20020a05620a45a900b0076ef686cad5mr5084586qkb.5.1699529179275;
        Thu, 09 Nov 2023 03:26:19 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-228-197.dyn.eolo.it. [146.241.228.197])
        by smtp.gmail.com with ESMTPSA id k18-20020a05620a415200b007659935ce64sm1923132qko.71.2023.11.09.03.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 03:26:18 -0800 (PST)
Message-ID: <3f8e80f702eaceb7491ba7117663034eb48cff3d.camel@redhat.com>
Subject: Re: [PATCH net] virtio_net: fix missing dma unmap for resize
From: Paolo Abeni <pabeni@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
  "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 virtualization@lists.linux-foundation.org
Date: Thu, 09 Nov 2023 12:26:16 +0100
In-Reply-To: <20231106081832.668-1-xuanzhuo@linux.alibaba.com>
References: <20231106081832.668-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-11-06 at 16:18 +0800, Xuan Zhuo wrote:
> For rq, we have three cases getting buffers from virtio core:
>=20
> 1. virtqueue_get_buf{,_ctx}
> 2. virtqueue_detach_unused_buf
> 3. callback for virtqueue_resize
>=20
> But in commit 295525e29a5b("virtio_net: merge dma operations when
> filling mergeable buffers"), I missed the dma unmap for the #3 case.
>=20
> That will leak some memory, because I did not release the pages referred
> by the unused buffers.
>=20
> If we do such script, we will make the system OOM.
>=20
>     while true
>     do
>             ethtool -G ens4 rx 128
>             ethtool -G ens4 rx 256
>             free -m
>     done
>=20
> Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling merge=
able buffers")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

@Micheal, @Jason: this fix LGTM, but I guess it deserve an explicit ack
from you before merging, thanks!

Paolo


