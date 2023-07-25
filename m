Return-Path: <netdev+bounces-20713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB906760BFB
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 09:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2341C20E2F
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 07:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079809454;
	Tue, 25 Jul 2023 07:35:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCF28F72
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 07:35:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBCF1BF8
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 00:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690270482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KlVTXLyWcMpMPMMm7emcajIWT4tUJXS33YzR+iu8MUw=;
	b=WFzYSvc8fS4ekvBWJ645ATUf4YDeGDKUpK9E6iplByVi7LflHwtxgY/q8PpY1wxS/3sTsE
	13RbEKXQRnOEVG6X3eg0FYaxQ9/ErUCfP10ZVcJ7XIftcH0ncNH593Bf4bcwjdMbGf5N8v
	ymhypeXmp0U73t4VXwh2EbXzAzD+OTU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-GGbXoWORPOu_ZQEgTM-Otw-1; Tue, 25 Jul 2023 03:34:40 -0400
X-MC-Unique: GGbXoWORPOu_ZQEgTM-Otw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-99388334de6so386587466b.0
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 00:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690270480; x=1690875280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlVTXLyWcMpMPMMm7emcajIWT4tUJXS33YzR+iu8MUw=;
        b=c8amuzmbGWWUYCnQ7FCra8/Y8Mrk8lSH/+oCIU64LGCF0iJGcO6Ua3VMk1hUf3EO8S
         zBsiqgMhXiwrHynbUPV4vIY73BKXaEgBC44pMplDogcClTetzqow2C3RNGx2dDsX08VY
         wlgo+3hvz8fWnoTTcEH1xckwW9YM2kxZ6KdpNgEmW7antM4+t06h3YksYvqX4SclgjgC
         1QaD/Epw/BE1/9uXlyuLYHjPmjl1xTkDSW96PkxWEHw5CeaYufGprupoP403jAay8Hmt
         hOJs/MxSDDE6cipQ36GX11JCPFzfUtysm36Cb+/o9AVTUj88h46JN65Fn0MHvYoA+ZbL
         GSFw==
X-Gm-Message-State: ABy/qLY5fFt8Y1fkf/LBf8qtbbEGv3pWFqLHIoEK0DuYxh06BBtQOD6K
	7i2BXhxtnV7EGJ3zG6tNM1I/INtx3X6X6WCspSCxLQ1qYH70Amez+EG9PbIyFcERxLAN38Sqf81
	wYyqv8W3/B2iW2JXF
X-Received: by 2002:a17:906:3281:b0:99b:48d3:5488 with SMTP id 1-20020a170906328100b0099b48d35488mr12217616ejw.24.1690270479824;
        Tue, 25 Jul 2023 00:34:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHNg+hM1hzoNAK32i8hsz4doeAFqPyABedd7VMtD2jNuY0tQh5xK77D0UqFEO1XA6riO6GpBA==
X-Received: by 2002:a17:906:3281:b0:99b:48d3:5488 with SMTP id 1-20020a170906328100b0099b48d35488mr12217587ejw.24.1690270479464;
        Tue, 25 Jul 2023 00:34:39 -0700 (PDT)
Received: from redhat.com ([2.55.164.187])
        by smtp.gmail.com with ESMTPSA id k16-20020a1709063fd000b009894b476310sm7790738ejj.163.2023.07.25.00.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 00:34:38 -0700 (PDT)
Date: Tue, 25 Jul 2023 03:34:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	virtualization@lists.linux-foundation.org,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce
 virtqueue_dma_dev()
Message-ID: <20230725033321-mutt-send-email-mst@kernel.org>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-6-xuanzhuo@linux.alibaba.com>
 <ZK/cxNHzI23I6efc@infradead.org>
 <20230713104805-mutt-send-email-mst@kernel.org>
 <ZLjSsmTfcpaL6H/I@infradead.org>
 <20230720131928-mutt-send-email-mst@kernel.org>
 <ZL6qPvd6X1CgUD4S@infradead.org>
 <1690251228.3455179-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690251228.3455179-1-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 10:13:48AM +0800, Xuan Zhuo wrote:
> On Mon, 24 Jul 2023 09:43:42 -0700, Christoph Hellwig <hch@infradead.org> wrote:
> > On Thu, Jul 20, 2023 at 01:21:07PM -0400, Michael S. Tsirkin wrote:
> > > Well I think we can add wrappers like virtio_dma_sync and so on.
> > > There are NOP for non-dma so passing the dma device is harmless.
> >
> > Yes, please.
> 
> 
> I am not sure I got this fully.
> 
> Are you mean this:
> https://lore.kernel.org/all/20230214072704.126660-8-xuanzhuo@linux.alibaba.com/
> https://lore.kernel.org/all/20230214072704.126660-9-xuanzhuo@linux.alibaba.com/
> 
> Then the driver must do dma operation(map and sync) by these virtio_dma_* APIs.
> No care the device is non-dma device or dma device.

yes

> Then the AF_XDP must use these virtio_dma_* APIs for virtio device.

We'll worry about AF_XDP when the patch is posted.

-- 
MST


