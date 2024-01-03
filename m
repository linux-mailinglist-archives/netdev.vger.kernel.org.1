Return-Path: <netdev+bounces-61347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC6282379E
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 23:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737F41F25F2A
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 22:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634C81DA3D;
	Wed,  3 Jan 2024 22:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQ+yc2fS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0101DA46
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 22:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704320323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NVvD+OONW3KVBBfzwOKbjoTXnyj2MLQ9M3imyFTNcV0=;
	b=hQ+yc2fSGx7V15hevN3AHjpNGLu5bNAs161YlPleUVYoTemzkSpA1+AarACARTV66Urk2B
	dPHmCU19Z+5Oa7OH2gGt1W9b58IGXkDMDKJRvN6bmcWxeqz2YoIBX1LKbNBZScxJ5G3gJk
	fl7g9KzRXOZj+iTitZLmwgVSsWZgvLs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-9CD9J2MmMaiqYRzWhTDefw-1; Wed, 03 Jan 2024 17:18:37 -0500
X-MC-Unique: 9CD9J2MmMaiqYRzWhTDefw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3368698f0caso7788009f8f.1
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 14:18:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704320316; x=1704925116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVvD+OONW3KVBBfzwOKbjoTXnyj2MLQ9M3imyFTNcV0=;
        b=mlWH99ADpTGHcGYjkDZhfZrdm8+/xhqqbDYsr/woReA65qJ3JEnnRYT/IjszyLpAHM
         t0tI6+0AdNNRDOnos80tS0VOlyQS9F4dKmeZQxUZcHILAFCmF+ULf/3HVIy2GWSpFgYd
         x3mFPjHBOrLcjUWq8RUJlPlI0f03sEJ1OQOWUBZCIpzjBS4r9sBNSLaPJndDAmwT5YVv
         05py1YTVdxavS1GU6Q5YrOLSLqdK2o853qPiuzqdwn6eSM1CILi+iTcBdkXNEw630QCm
         NLK4jJw1xOsmd8LCVP0WKxZpmYtA81dC0XIofR6nP0kZJD0ooHYcZF5SzJTAFIVA6bPU
         b1gA==
X-Gm-Message-State: AOJu0YwNbrkVPYwjx34SeK9dKBX36A/NMkgGZuGnIE0s38lFFihe4S+Q
	g/LvNZK2mj6D2J38G7C6yrgRS6ljqjZFKHhsH+au9zJ8M6imjVoHsg5isBSRRdVQyIbm0qLot7W
	yIOF+bCpL59EcL5B3paxARZVWT1dXTusB
X-Received: by 2002:a05:600c:520b:b0:40d:88f3:a68d with SMTP id fb11-20020a05600c520b00b0040d88f3a68dmr1513197wmb.209.1704320315872;
        Wed, 03 Jan 2024 14:18:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWCoxB985xTGnKum4aAAMUmi92Y8eaJ1I0Lr2U7JE9EGJHFvOCANK9tPiNsUkZoDGTNBIVmQ==
X-Received: by 2002:a05:600c:520b:b0:40d:88f3:a68d with SMTP id fb11-20020a05600c520b00b0040d88f3a68dmr1513194wmb.209.1704320315584;
        Wed, 03 Jan 2024 14:18:35 -0800 (PST)
Received: from redhat.com ([2.52.4.45])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0040d91930f93sm2798635wmk.11.2024.01.03.14.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 14:18:34 -0800 (PST)
Date: Wed, 3 Jan 2024 17:18:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux-foundation.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2] virtio_net: fix missing dma unmap for resize
Message-ID: <20240103171814-mutt-send-email-mst@kernel.org>
References: <20231226094333.47740-1-xuanzhuo@linux.alibaba.com>
 <20240103135803.24dddfe9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103135803.24dddfe9@kernel.org>

On Wed, Jan 03, 2024 at 01:58:03PM -0800, Jakub Kicinski wrote:
> On Tue, 26 Dec 2023 17:43:33 +0800 Xuan Zhuo wrote:
> > For rq, we have three cases getting buffers from virtio core:
> > 
> > 1. virtqueue_get_buf{,_ctx}
> > 2. virtqueue_detach_unused_buf
> > 3. callback for virtqueue_resize
> > 
> > But in commit 295525e29a5b("virtio_net: merge dma operations when
> > filling mergeable buffers"), I missed the dma unmap for the #3 case.
> > 
> > That will leak some memory, because I did not release the pages referred
> > by the unused buffers.
> > 
> > If we do such script, we will make the system OOM.
> > 
> >     while true
> >     do
> >             ethtool -G ens4 rx 128
> >             ethtool -G ens4 rx 256
> >             free -m
> >     done
> > 
> > Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling mergeable buffers")
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> 
> Michael, Jason, looks good? Worth pushing it to v6.7?

I'd say yes.

Acked-by: Michael S. Tsirkin <mst@redhat.com>


