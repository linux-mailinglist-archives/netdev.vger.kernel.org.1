Return-Path: <netdev+bounces-26547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E21C7780FB
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 21:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 181FE280D42
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 19:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F354822EFE;
	Thu, 10 Aug 2023 19:04:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D9A20FB4
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 19:04:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC8C2717
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 12:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691694276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f/d485k4GYGK+Hhxc7O7Vh9Y7TOuExVY3FHsGQcP80A=;
	b=Cb3WdRWfm3vdRov2ecktTcMzdJqThwB6HnpvGwrrBUwMM0CTo3mJPHr45ahxHH48YTez6t
	8qa+OtIQaGaQtVbjPSe//oKVkC6eIUdi5y+NpvDMyfzQIohiK3phge9DUljZUW4uyHZwpJ
	IFjRGttr+yWvWqMbAmUJgIPDlGu3gLE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-b5vc0xyBNEuHpVhHhxBZTw-1; Thu, 10 Aug 2023 15:04:33 -0400
X-MC-Unique: b5vc0xyBNEuHpVhHhxBZTw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fe25f8c4bfso8061135e9.2
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 12:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691694272; x=1692299072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/d485k4GYGK+Hhxc7O7Vh9Y7TOuExVY3FHsGQcP80A=;
        b=XT7WKC0ambUkYISfw4ErbKYNLIT5TpK31QUXbKbcRbI3hXlKbUY4xjbL088rLiQitW
         bVIB48yb1znpAQ3EXdlBTjQsCZr4a3NJw0PiMTBB/hpLku0EUp126vtO1Mm7Pry7yC/n
         vSGu4BMSThuh1RCTuPdmQp6V73oxElHDKLNELgRzgMKqKQy0T19wJ8oGX/uRFQkVX0IM
         fDXxt99y+8wsILHvEtM4KyFftg5GToV/eGhP04VX4Xsba4O3SZ4gsFTWBn9qac6VxuTh
         oMHnV/pZwNdnqoZjKzIfMuJzd71cFUBj5ojepZFpGZRChW60DaBgYBZewLRLEdz2uxSl
         PrNw==
X-Gm-Message-State: AOJu0Yyy0L/5Pu2aZ1omUXDIhLK+dRuhVoE7dJMZQQU1rH7IWixAsKUl
	nN9bpDRKfd2ken0+ecLxOtejMuPC9AxX+jHfNQRtxOD6WzxP49pW/ih41f2LMjMBOzNisvpPFAm
	vxEAoFiYPCf0bF+RD
X-Received: by 2002:a1c:f716:0:b0:3fc:92:73d6 with SMTP id v22-20020a1cf716000000b003fc009273d6mr2665608wmh.11.1691694272141;
        Thu, 10 Aug 2023 12:04:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7XXbeFXHjJXPtbXknI7UArQUoxvGNLo3LCjH5yIBicBM7CJNAjsPriiFtN22BWjuicw51CA==
X-Received: by 2002:a1c:f716:0:b0:3fc:92:73d6 with SMTP id v22-20020a1cf716000000b003fc009273d6mr2665591wmh.11.1691694271848;
        Thu, 10 Aug 2023 12:04:31 -0700 (PDT)
Received: from redhat.com ([2.55.27.97])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c205000b003fe26bf65e7sm2928355wmg.13.2023.08.10.12.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 12:04:31 -0700 (PDT)
Date: Thu, 10 Aug 2023 15:04:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: xieyongji@bytedance.com, jasowang@redhat.com, david.marchand@redhat.com,
	lulu@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com
Subject: Re: [PATCH v3 0/3] vduse: add support for networking devices
Message-ID: <20230810150347-mutt-send-email-mst@kernel.org>
References: <20230705100430.61927-1-maxime.coquelin@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705100430.61927-1-maxime.coquelin@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 05, 2023 at 12:04:27PM +0200, Maxime Coquelin wrote:
> This small series enables virtio-net device type in VDUSE.
> With it, basic operation have been tested, both with
> virtio-vdpa and vhost-vdpa using DPDK Vhost library series
> adding VDUSE support using split rings layout (merged in
> DPDK v23.07-rc1).
> 
> Control queue support (and so multiqueue) has also been
> tested, but requires a Kernel series from Jason Wang
> relaxing control queue polling [1] to function reliably,
> so while Jason rework is done, a patch is added to disable
> CVQ and features that depend on it (tested also with DPDK
> v23.07-rc1).


So I can put this in next, the issue I think is
that of security: currently selinux can if necessary block
access to creating virtio block devices.
But if we have more than one type we need a way for selinux to
block specific types. Can be a patch on top but pls work to
address.

Another question is that with this userspace can inject
packets directly into net stack. Should we check CAP_NET_ADMIN
or such?



> [1]: https://lore.kernel.org/lkml/CACGkMEtgrxN3PPwsDo4oOsnsSLJfEmBEZ0WvjGRr3whU+QasUg@mail.gmail.com/T/
> 
> v2 -> v3 changes:
> =================
> - Use allow list instead of deny list (Michael)
> 
> v1 -> v2 changes:
> =================
> - Add a patch to disable CVQ (Michael)
> 
> RFC -> v1 changes:
> ==================
> - Fail device init if it does not support VERSION_1 (Jason)
> 
> Maxime Coquelin (3):
>   vduse: validate block features only with block devices
>   vduse: enable Virtio-net device type
>   vduse: Temporarily disable control queue features
> 
>  drivers/vdpa/vdpa_user/vduse_dev.c | 51 +++++++++++++++++++++++++++---
>  1 file changed, 47 insertions(+), 4 deletions(-)
> 
> -- 
> 2.41.0


