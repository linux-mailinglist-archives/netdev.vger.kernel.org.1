Return-Path: <netdev+bounces-40306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7826A7C69CC
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 11:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A48AF1C20F33
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 09:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AE821351;
	Thu, 12 Oct 2023 09:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fXh3qIjB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99628FC13
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 09:37:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66901B7
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 02:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697103423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Og6raZ6jMMyD5EqCW+syNcRq/tuwwhy1dUriBPTt9yk=;
	b=fXh3qIjBMeibSOOOWJ3X7uOFiCiffiG4kUUBmYclgdaywfXh43/d/5x1y8MfRMPDIKCx/1
	kRjSSWq7PEfHE017EYKgQf6+NkgIolW7wm6NSeNKq80BQM6WTN/EPelblh9uwIy+7ceSak
	cQNT2AZYDYZ0mf44jCwWTwSOuagOFik=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-cgIjRrhsPoK1Bs6d8sA8Og-1; Thu, 12 Oct 2023 05:37:02 -0400
X-MC-Unique: cgIjRrhsPoK1Bs6d8sA8Og-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f41a04a297so6363715e9.3
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 02:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697103421; x=1697708221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Og6raZ6jMMyD5EqCW+syNcRq/tuwwhy1dUriBPTt9yk=;
        b=NejK+lW113cfc+tBxdXNF1csNDPU+zPpJ8GqixZfA0MBTtS4qnS8547aVX82fCAjxp
         P94H3N40TAgm38D9/7t5Ep6szWTNuBMB6u7IPtH9yVr7IFDy39Gks6sQ0rmVOtuZBh4y
         9KMCIGc1bF+4bf+FaBM2mGMNFEm4tXPMofeX7yAFVx3Jy44mtjggAnD8tJhI0MZbHTEp
         6jr6+uEkav2gLlylhlaif4ov3UFQMqVbi+ChbP8bpVa7PbybGVJYZUf+WbAs7cHbofve
         BzV7MNgSHm8q4lfYPGr/CRqvg3xqdeM2FjKYroO4cXATr7H8PqcLevwJsG3WrhpeLFIH
         fo7A==
X-Gm-Message-State: AOJu0Yy1Rz8OmoJBHfCoMxV5iwYFbtgO5AZLpx6jUlOHDkuW+ohix5S7
	VWaJ0GL2OHk1fcXEvWW9xee+RRFbD1qfwYT2Cx7gmqueiNOHJYHeFH/jublkbjyY5nobGiv0Bns
	8ea9DtiA6hRw+wY2w
X-Received: by 2002:a05:600c:252:b0:402:f536:2d3e with SMTP id 18-20020a05600c025200b00402f5362d3emr20099636wmj.14.1697103421208;
        Thu, 12 Oct 2023 02:37:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9fq1jjgKP01Xp12dXEJDHMAnxRgZMq82IS2jTsardKR/fkkLRB52Ezc7m3vDYYuSCK2nZGQ==
X-Received: by 2002:a05:600c:252:b0:402:f536:2d3e with SMTP id 18-20020a05600c025200b00402f5362d3emr20099607wmj.14.1697103420786;
        Thu, 12 Oct 2023 02:37:00 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
        by smtp.gmail.com with ESMTPSA id az41-20020a05600c602900b004068495910csm21393884wmb.23.2023.10.12.02.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 02:36:59 -0700 (PDT)
Date: Thu, 12 Oct 2023 05:36:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH vhost 21/22] virtio_net: update tx timeout record
Message-ID: <20231012052017-mutt-send-email-mst@kernel.org>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011092728.105904-22-xuanzhuo@linux.alibaba.com>
 <20231012050936-mutt-send-email-mst@kernel.org>
 <1697101953.6236846-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1697101953.6236846-1-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 05:12:33PM +0800, Xuan Zhuo wrote:
> On Thu, 12 Oct 2023 05:10:55 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Wed, Oct 11, 2023 at 05:27:27PM +0800, Xuan Zhuo wrote:
> > > If send queue sent some packets, we update the tx timeout
> > > record to prevent the tx timeout.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio/xsk.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> > > index 7abd46bb0e3d..e605f860edb6 100644
> > > --- a/drivers/net/virtio/xsk.c
> > > +++ b/drivers/net/virtio/xsk.c
> > > @@ -274,6 +274,16 @@ bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
> > >
> > >  	virtnet_xsk_check_queue(sq);
> > >
> > > +	if (stats.packets) {
> > > +		struct netdev_queue *txq;
> > > +		struct virtnet_info *vi;
> > > +
> > > +		vi = sq->vq->vdev->priv;
> > > +
> > > +		txq = netdev_get_tx_queue(vi->dev, sq - vi->sq);
> > > +		txq_trans_cond_update(txq);
> > > +	}
> > > +
> > >  	u64_stats_update_begin(&sq->stats.syncp);
> > >  	sq->stats.packets += stats.packets;
> > >  	sq->stats.bytes += stats.bytes;
> >
> > I don't get what this is doing. Is there some kind of race here you
> > are trying to address? And what introduced the race?
> 
> 
> Because the xsk xmit shares the send queue with the kernel xmit,
> then when I do benchmark, the xsk will always use the send queue,
> so the kernel may have no chance to do xmit, the tx watchdog
> thinks that the send queue is hang and prints tx timeout log.
> 
> So I call the txq_trans_cond_update() to tell the tx watchdog
> that the send queue is working.
> 
> Thanks.

Don't like this hack.
So packets are stuck in queue - that's not good is it?
Is ours the only driver that shares queues like this?

> 
> >
> > > --
> > > 2.32.0.3.g01195cf9f
> >
> >


