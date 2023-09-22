Return-Path: <netdev+bounces-35659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 345367AA7CB
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 06:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D7C37281CCE
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 04:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A5C386;
	Fri, 22 Sep 2023 04:30:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7A3CA56
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 04:30:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D47199
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 21:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695357003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/PovTQ/TL3i7ChhoR7kfzCjbbZuEsG+sEWglXJvK9wg=;
	b=eizOZpAIRBadLeMLLCFo1RQUYNQeRtrFS1a10jGu6EJe1gsq2W/VVbIXmwqS741voj2iWg
	65RrSaMVZ/CT3iW2IpwW+Rjf5o2GEO/UxgDz1uw52BlGUzdhOeDdZC3bhxcLpshVmaFhnj
	1QkLYLzYGQqJNsUW328Hhg8fDalkfbg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-tpfIovFsNPm2hjxShe5-QA-1; Fri, 22 Sep 2023 00:30:01 -0400
X-MC-Unique: tpfIovFsNPm2hjxShe5-QA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5043c463bf9so207551e87.0
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 21:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695357000; x=1695961800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/PovTQ/TL3i7ChhoR7kfzCjbbZuEsG+sEWglXJvK9wg=;
        b=sEw+Znos3aUxCiP09n6JhQl4pIMLU/eOBpxco+AK1VZjmLVeAKk10V+L7DCai65DQ0
         peyZMoqm5m4dsDgHFKTtlMYwp8NL1hexO3XeH442lIHT5ec/nrgan218jQDejP/7yFih
         +mdrYbBw1WnFVYEfh449ceNp7wdSxvmnk5BH2EZfuqJ15Lvm+EsLUO6sgDayCA4r1GD7
         BFSBDRFBQHLDQljR3OPJXqYosSwx52/IGDUOU3gultCWYOzwL9Njj1hVHktzc501qURr
         Cr1CkR6+jaMCGRY0OSP0T6ZAjlcMwYEaGypKTIYQPExsOVsnjBWOVciOjO2pb5+T511X
         OE7Q==
X-Gm-Message-State: AOJu0YwpbLGsTRdo15s8u9Hpsyh6CZ7/6Zx8lVZGUtJZlEmBpBPtw7Kx
	n2cSKt+5lRThrD48lq6aPNW8NXV4DDo1lwC8DkzNusFdn7+lkeYgXWQcQ7g6USxdbJDvIAzZEV0
	sE+/JsW+T4b9R5CQacSuBGOt2lGYmQJ8O
X-Received: by 2002:a19:4f4a:0:b0:4fe:7dcc:3dc1 with SMTP id a10-20020a194f4a000000b004fe7dcc3dc1mr5891762lfk.44.1695356999989;
        Thu, 21 Sep 2023 21:29:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVvXfqPY1fkr32aVf5UzABAZ8T9fCp6I6p9I62s9MuBKjaJsIAKr6jxsKfv0X+Ug0nDHEOxO8gVauzlLE8VSI=
X-Received: by 2002:a19:4f4a:0:b0:4fe:7dcc:3dc1 with SMTP id
 a10-20020a194f4a000000b004fe7dcc3dc1mr5891746lfk.44.1695356999730; Thu, 21
 Sep 2023 21:29:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230919074915.103110-1-hengqi@linux.alibaba.com> <20230919074915.103110-6-hengqi@linux.alibaba.com>
In-Reply-To: <20230919074915.103110-6-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Sep 2023 12:29:47 +0800
Message-ID: <CACGkMEuJjxAmr6WC9ETYAw2K9dp0AUoD6LSZCduQyUQ9y7oM3Q@mail.gmail.com>
Subject: Re: [PATCH net 5/6] virtio-net: fix the vq coalescing setting for vq resize
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	"Michael S . Tsirkin" <mst@redhat.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Gavin Li <gavinl@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 19, 2023 at 3:49=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> According to the definition of virtqueue coalescing spec[1]:
>
>   Upon disabling and re-enabling a transmit virtqueue, the device MUST se=
t
>   the coalescing parameters of the virtqueue to those configured through =
the
>   VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or, if the driver did not set
>   any TX coalescing parameters, to 0.
>
>   Upon disabling and re-enabling a receive virtqueue, the device MUST set
>   the coalescing parameters of the virtqueue to those configured through =
the
>   VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command, or, if the driver did not set
>   any RX coalescing parameters, to 0.
>
> We need to add this setting for vq resize (ethtool -G) where vq_reset hap=
pens.
>
> [1] https://lists.oasis-open.org/archives/virtio-dev/202303/msg00415.html
>
> Fixes: 394bd87764b6 ("virtio_net: support per queue interrupt coalesce co=
mmand")

I'm not sure this is a real fix as spec allows it to go zero?

Thanks


