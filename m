Return-Path: <netdev+bounces-19600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AD575B583
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 19:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F994282063
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 17:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289182FA54;
	Thu, 20 Jul 2023 17:21:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D23B2FA4B
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 17:21:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919D02727
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 10:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689873676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wSM6GucX481b3eiLRGSzd0Yk4eXovV4UB3ZZIve6VjA=;
	b=dZrxO9bkjHr/cSMwMhUjWO4iGnW8rAk+NyLzs93R1CgHSw80jPGRqgqnk9qzze9qu1hnBH
	Nkt1B8iAWwDJUTDg64tjELB+vDoBtQl/szI6y/iwqCP2U4htmS+h0aa7q39BFtsHEfFW1T
	sY+HAdhq32XcToBjsKafPT03y8bm26s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-ISzOghTFNrCmzfm8jzdLDw-1; Thu, 20 Jul 2023 13:21:14 -0400
X-MC-Unique: ISzOghTFNrCmzfm8jzdLDw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-316f24a72e8so619599f8f.1
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 10:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689873672; x=1690478472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSM6GucX481b3eiLRGSzd0Yk4eXovV4UB3ZZIve6VjA=;
        b=gN8iHeE8IuTuAmKog/YSpX8cQVRES/whHWMO7CeeURAk6DdQYZb/aVIyoECknPbMMT
         F3zVBSgO0g4TcKQpFFlWjGliMQEn+8Pve5sFPq+tXYLgxJmQ5yKOx54Yn+QgaTdtdsJh
         5ryh0dAmyPni5fL2MFdkmZZfUqGM10W07KJgILfVJvJzmAyJZNwBRvvDfAlgIGGBTNtI
         nBWDOMDFZocje0Idy9bawdOl7aAbi2l+X4U+ju9K8jOZ+JK2eEzmigoSfBHQjHIsc/+W
         pRgY3pDT4V3CCUnr59YDFaR7JdCni6ZdYiIjLWjg+Iwv5bHL/YLomaeTm/tk2SfjCTxh
         IcbQ==
X-Gm-Message-State: ABy/qLYk4NQtQtI+jVoha7hp+86WyOEt/Byube/y499SC2WxFA1jLhLp
	yrOGDa+wrOsdx0HK16qEMy1pACmpALT8SlomCQAy0zNz+lutgDTL9G3mV6/cszaQG/8ewUvgTM2
	wC9IiO+7wRQZb6Ybi
X-Received: by 2002:a5d:6649:0:b0:314:1224:dbb8 with SMTP id f9-20020a5d6649000000b003141224dbb8mr2499447wrw.21.1689873672596;
        Thu, 20 Jul 2023 10:21:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF007YE1yWjdVWFoof0oyKSncqv4aObnTbLud+fUTRyjhlewOkL5ydanAjocCMP5uLzKLoEew==
X-Received: by 2002:a5d:6649:0:b0:314:1224:dbb8 with SMTP id f9-20020a5d6649000000b003141224dbb8mr2499428wrw.21.1689873672296;
        Thu, 20 Jul 2023 10:21:12 -0700 (PDT)
Received: from redhat.com ([2.52.16.41])
        by smtp.gmail.com with ESMTPSA id a5-20020adfdd05000000b0031433d8af0dsm1873233wrm.18.2023.07.20.10.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 10:21:11 -0700 (PDT)
Date: Thu, 20 Jul 2023 13:21:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
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
Message-ID: <20230720131928-mutt-send-email-mst@kernel.org>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-6-xuanzhuo@linux.alibaba.com>
 <ZK/cxNHzI23I6efc@infradead.org>
 <20230713104805-mutt-send-email-mst@kernel.org>
 <ZLjSsmTfcpaL6H/I@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLjSsmTfcpaL6H/I@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 11:22:42PM -0700, Christoph Hellwig wrote:
> On Thu, Jul 13, 2023 at 10:51:59AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Jul 13, 2023 at 04:15:16AM -0700, Christoph Hellwig wrote:
> > > On Mon, Jul 10, 2023 at 11:42:32AM +0800, Xuan Zhuo wrote:
> > > > Added virtqueue_dma_dev() to get DMA device for virtio. Then the
> > > > caller can do dma operation in advance. The purpose is to keep memory
> > > > mapped across multiple add/get buf operations.
> > > 
> > > This is just poking holes into the abstraction..
> > 
> > More specifically?
> 
> Because now you expose a device that can't be used for the non-dma
> mapping case and shoud be hidden.


Ah, ok.
Well I think we can add wrappers like virtio_dma_sync and so on.
There are NOP for non-dma so passing the dma device is harmless.

-- 
MST


