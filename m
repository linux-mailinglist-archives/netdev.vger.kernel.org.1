Return-Path: <netdev+bounces-20544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3117B76003E
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 22:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E017928140B
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 20:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25571094C;
	Mon, 24 Jul 2023 20:06:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937D4101CF
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 20:06:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97D710D8
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 13:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690229157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LYP2jsSM7wu6tSo9cTMLY8NXdl2pRsOxDL4GNzMi1ow=;
	b=CNR+BUo56n98a7o8dhCFyx9e53UXFB1HPN4zDTeyZ3ALzyxZ9XwXDRvtqhpXC1uwX3bE5D
	fp+bFUYSg8Oa/KCVFie1Dc6MIWxgH62fxNOJ8/UUHu4oCEEG7N953K7k5NxqUdW9u/jgVh
	LKyANYY9AWMkbHXeMR5hVF0C1olglLc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-BXJn3QthMjC5R_j4qHt-PA-1; Mon, 24 Jul 2023 16:05:56 -0400
X-MC-Unique: BXJn3QthMjC5R_j4qHt-PA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fbb34f7224so29062735e9.2
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 13:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690229155; x=1690833955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYP2jsSM7wu6tSo9cTMLY8NXdl2pRsOxDL4GNzMi1ow=;
        b=WtbiDAVMRiqZRMaakBHicgn/agg2uWfHTCOG/ItH22fxvc8mbi6xwiZMukmNRrrCLO
         YJanfwCW4o535yLK/8N5D/FxOZUvD+lBtA5XlQE7uUG5U4IGOt9YjmIXy8G0BVCK2QhE
         zAhqfxUupT3pvJNKPn7CJJsE6JSAuX1hWdnmOQNWbONL1m/GuerFjSBDxcd1JTNNZSX9
         0YZxYIcSzTDNYrA+ucfe6iKIYmxqlcYSwVvOrtF7rPUSuKaW7xpGBsJAQPXpbHdqfvwk
         wqBZhKe6sUEr+IKEQ1j/l3rdIfsjcmjPa96Enr2T0yJP0+4QH3BzD/4OizX4oaBVo4dJ
         bkeA==
X-Gm-Message-State: ABy/qLbJcqExbbL+c+7pOjmIaaYBO6UP14xgkrM0aelWDe6t2T5hfhCf
	WhYRsFKtUzXRPXitO0lH0/SZBJTVcYbHFV8jSaGdGRzoRum+c+a2bYUGua3Pzj3QusAODQmRHtR
	HB5s6nxMmBlDDGmyY
X-Received: by 2002:adf:eb05:0:b0:315:a043:5e03 with SMTP id s5-20020adfeb05000000b00315a0435e03mr8052322wrn.55.1690229154963;
        Mon, 24 Jul 2023 13:05:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF8FTgAqrCH/MKiiYnFPararbVVgu6QGFkBPQebzHQooTua9/IeyBAZ0Zi401PXfeUNSe4JJA==
X-Received: by 2002:adf:eb05:0:b0:315:a043:5e03 with SMTP id s5-20020adfeb05000000b00315a0435e03mr8052311wrn.55.1690229154666;
        Mon, 24 Jul 2023 13:05:54 -0700 (PDT)
Received: from redhat.com ([2.55.164.187])
        by smtp.gmail.com with ESMTPSA id d15-20020aa7ce0f000000b0052238bc70ccsm1181121edv.89.2023.07.24.13.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 13:05:53 -0700 (PDT)
Date: Mon, 24 Jul 2023 16:05:50 -0400
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
Message-ID: <20230724160511-mutt-send-email-mst@kernel.org>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-6-xuanzhuo@linux.alibaba.com>
 <ZK/cxNHzI23I6efc@infradead.org>
 <20230713104805-mutt-send-email-mst@kernel.org>
 <ZLjSsmTfcpaL6H/I@infradead.org>
 <1689835514.217712-8-xuanzhuo@linux.alibaba.com>
 <ZLja73TJ1Ow19xdr@infradead.org>
 <1689838441.2670174-9-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1689838441.2670174-9-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 03:34:01PM +0800, Xuan Zhuo wrote:
> On Wed, 19 Jul 2023 23:57:51 -0700, Christoph Hellwig <hch@infradead.org> wrote:
> > On Thu, Jul 20, 2023 at 02:45:14PM +0800, Xuan Zhuo wrote:
> > >  virtqueue_dma_dev() return the device that working with the DMA APIs.
> > >  Then that can be used like other devices. So what is the problem.
> > >
> > >  I always think the code path without the DMA APIs is the trouble for you.
> >
> > Because we now have an API where the upper level drivers sometimes
> > see the dma device and sometimes not.
> 
> No dma device is just for the old devices.
> 
> The API without DMA dev are only compatible with older devices. We can't give up
> these old devices, but we also have to embrace new features.
> 
> > This will be abused and cause
> > trouble sooner than you can say "layering".
> 
> I don't understand what the possible trouble here is.
> 
> When no dma device, the driver just does the same thing as before.
> 
> Thanks.

Instead of skipping operations, Christoph wants wrappers that
do nothing for non dma case.

-- 
MST


