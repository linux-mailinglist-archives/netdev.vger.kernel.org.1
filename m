Return-Path: <netdev+bounces-17609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 693ED752598
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 16:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4B51C20B9E
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 14:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A279C18AE9;
	Thu, 13 Jul 2023 14:52:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9437811C9D
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 14:52:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B246919B
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 07:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689259971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a2zCtBlVMSfdNhn49F5fvGTfds6ip8Yk0SLr5SlzCTc=;
	b=ed/otZgvy/UyyX9Q+zmgkKF0WMj4VvaSOiQOuSpM/jZxh2mgeb2Bq0GTiSWg6Wp6Jxf1/+
	eVPsS78e7H/pGP1jFNz8vrCD76WKdNSHOCvjaI/b2eEZFm0V/AXmasoyJ3obL0F4MAO/IP
	wT7LniqQ5Y7bexPpFahoFIifjOFaXzs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-sYQX1ipMPZWkGgXgYW0DqA-1; Thu, 13 Jul 2023 10:52:49 -0400
X-MC-Unique: sYQX1ipMPZWkGgXgYW0DqA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31429e93f26so585024f8f.2
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 07:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689259968; x=1691851968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2zCtBlVMSfdNhn49F5fvGTfds6ip8Yk0SLr5SlzCTc=;
        b=U0zCwR/qa5q4c2c19XYSz4BIRv1Ho1dzwcTuLBEpANsrOIPYO3LUzELanP7+n9OwRV
         EOCsaMApGfYWwRYToj0QzwZnsvc9eMlP6UWI4202GN2ZZj1GXj6MEY3YHsK5Km9OF08/
         kxMB0CeykzcBxhZpZIXZPd6t1YtTqyP+RzJju+Do793HtCS35uJm970hkG3Tj7X1g+qy
         Aso2hxqLqFWAyTr77Js7GXcWa2I1738LGUCy5ZIurBnjiAwOhm3ZGfL96yFyLiCgAeYQ
         6YYxEsGi5GlGrbnLh3jZZ6gI/dq4FDBLJt62WJ101wkSYpVU+Z+j3bG4GOWxPFWFJhYZ
         Eamw==
X-Gm-Message-State: ABy/qLaMlR+ooYk0Ufj7euU0+R2n8TR0WPNkU75UHmDEVGsbzlv/y1vp
	hb0Mw16MC+zDQFFJRPuqcz3+WOnvQ/0FpI7ofi2+tAu0FT1/lc+aYO+Vyz/UYjjoK+NDa853cG3
	1b7y914XUbbC+y8Fu
X-Received: by 2002:adf:f802:0:b0:314:3503:15ac with SMTP id s2-20020adff802000000b00314350315acmr1739349wrp.10.1689259968668;
        Thu, 13 Jul 2023 07:52:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHIe9bIwU8uwonGb/X776+z7KNCl4G7bhOiTrPif1cQEJqDIP/Vb7HU5xOiBtQ+0jRV7Mj+VA==
X-Received: by 2002:adf:f802:0:b0:314:3503:15ac with SMTP id s2-20020adff802000000b00314350315acmr1739345wrp.10.1689259968500;
        Thu, 13 Jul 2023 07:52:48 -0700 (PDT)
Received: from redhat.com ([2.52.158.233])
        by smtp.gmail.com with ESMTPSA id s14-20020adfea8e000000b00301a351a8d6sm8230571wrm.84.2023.07.13.07.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 07:52:48 -0700 (PDT)
Date: Thu, 13 Jul 2023 10:52:44 -0400
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
Subject: Re: [PATCH vhost v11 03/10] virtio_ring: introduce
 virtqueue_set_premapped()
Message-ID: <20230713105230-mutt-send-email-mst@kernel.org>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-4-xuanzhuo@linux.alibaba.com>
 <ZK/cpSceLMovhmfR@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK/cpSceLMovhmfR@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 04:14:45AM -0700, Christoph Hellwig wrote:
> On Mon, Jul 10, 2023 at 11:42:30AM +0800, Xuan Zhuo wrote:
> > This helper allows the driver change the dma mode to premapped mode.
> > Under the premapped mode, the virtio core do not do dma mapping
> > internally.
> > 
> > This just work when the use_dma_api is true. If the use_dma_api is false,
> > the dma options is not through the DMA APIs, that is not the standard
> > way of the linux kernel.
> 
> I have a hard time parsing this.

Me too unfortunately.

-- 
MST


