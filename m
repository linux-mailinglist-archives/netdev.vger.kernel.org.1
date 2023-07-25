Return-Path: <netdev+bounces-20851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8528E761941
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 15:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64F21C20E93
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 13:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DDB1F174;
	Tue, 25 Jul 2023 13:06:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B561F16C
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 13:06:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5B71FD6
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 06:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690290370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K1X8yDKyRljjlgsdrNt2jAkyf6vXFbNpPQPsSIK0WH0=;
	b=I4Bmg4F9jSblxWBTjewMbOkDXhn/ssUHopnOGDVr8Gjk1h7S8eHHghlsB+KcER8k1tZd5S
	1Omr/yn23tbDn6aKyIynrYvQ6WnirqRBFDyuEU3vFMdMJr7Y5m7znNfx9NOlG5spwJ/q7H
	sscAnPMgznK/Kg5VZ69zaJDkyHXwyQU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-CgYF6ku-NPqHZKqAVbVqGA-1; Tue, 25 Jul 2023 09:06:08 -0400
X-MC-Unique: CgYF6ku-NPqHZKqAVbVqGA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94a355c9028so406608166b.3
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 06:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690290367; x=1690895167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1X8yDKyRljjlgsdrNt2jAkyf6vXFbNpPQPsSIK0WH0=;
        b=VZ1duIoRSuS7T19yH7eNPsR7yVb1huwWe9wruI/WxcfD26eaQ8tvxZJREjp+EkQYtR
         rZooHnEmCv5Dao54WocIxY+8rRwxYSvscIBVHfD/X3oDWgpjHuNMHpPXHk8zH930Ne0P
         xkBM4OzFmskZBt1tY95lidQlUzhOfAQ2K5EX6H1OtUW97BpPAic33Zyck4CdQ5kkoWDZ
         J+/Myl+yO5lp0nJ+hebk43A97Dr1SWBSi7AaPk9KJehI8AbaNXW46zhpS0jwLZelehXl
         zHJkd73g7TGgIKy1j0okrDTs7aKaRL5TWSoCnsr18Kbdr+kHOsyZ5LGer/CiBRM+9ezJ
         FuCA==
X-Gm-Message-State: ABy/qLb8rB4Hjdq1vpAr9tQt0Mu4svac1xs3mnE3szw6obUcbMGX9hTR
	JaxQSBfK8Gek41Jm2h6fetGpxtp1fJk25qEbTcxe/BA9exlPrVstLBCdmaFMY4YRsQrtaPH5Xg+
	enL2IzGll+GYud9dC
X-Received: by 2002:a17:907:7784:b0:982:2278:bcef with SMTP id ky4-20020a170907778400b009822278bcefmr12112964ejc.60.1690290367675;
        Tue, 25 Jul 2023 06:06:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFKe/e8kfIwy1WsKWMlpZ+w+bWS7V5xC/G665qa9FumF0OUD5sCTH9kWU/ysoN0KlGWemAgsA==
X-Received: by 2002:a17:907:7784:b0:982:2278:bcef with SMTP id ky4-20020a170907778400b009822278bcefmr12112938ejc.60.1690290367254;
        Tue, 25 Jul 2023 06:06:07 -0700 (PDT)
Received: from redhat.com ([2.55.164.187])
        by smtp.gmail.com with ESMTPSA id r7-20020a170906c28700b0099b42c90830sm8133731ejz.36.2023.07.25.06.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 06:06:06 -0700 (PDT)
Date: Tue, 25 Jul 2023 09:06:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Arseniy Krasnov <avkrasnov@sberdevices.ru>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@sberdevices.ru,
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v3 4/4] vsock/virtio: MSG_ZEROCOPY flag support
Message-ID: <20230725090514-mutt-send-email-mst@kernel.org>
References: <20230720214245.457298-1-AVKrasnov@sberdevices.ru>
 <20230720214245.457298-5-AVKrasnov@sberdevices.ru>
 <091c067b-43a0-da7f-265f-30c8c7e62977@sberdevices.ru>
 <20230725042544-mutt-send-email-mst@kernel.org>
 <mul7yiwl2pspfegeanqyezhmw6ol4cxsdshch7ln6w3i2b54bw@7na6bf5kfxwy>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mul7yiwl2pspfegeanqyezhmw6ol4cxsdshch7ln6w3i2b54bw@7na6bf5kfxwy>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 02:53:39PM +0200, Stefano Garzarella wrote:
> On Tue, Jul 25, 2023 at 07:50:53AM -0400, Michael S. Tsirkin wrote:
> > On Fri, Jul 21, 2023 at 08:09:03AM +0300, Arseniy Krasnov wrote:
> > > 
> > > 
> > > On 21.07.2023 00:42, Arseniy Krasnov wrote:
> > > > This adds handling of MSG_ZEROCOPY flag on transmission path: if this
> > > > flag is set and zerocopy transmission is possible (enabled in socket
> > > > options and transport allows zerocopy), then non-linear skb will be
> > > > created and filled with the pages of user's buffer. Pages of user's
> > > > buffer are locked in memory by 'get_user_pages()'. Second thing that
> > > > this patch does is replace type of skb owning: instead of calling
> > > > 'skb_set_owner_sk_safe()' it calls 'skb_set_owner_w()'. Reason of this
> > > > change is that '__zerocopy_sg_from_iter()' increments 'sk_wmem_alloc'
> > > > of socket, so to decrease this field correctly proper skb destructor is
> > > > needed: 'sock_wfree()'. This destructor is set by 'skb_set_owner_w()'.
> > > >
> > > > Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> > > > ---
> > > >  Changelog:
> > > >  v5(big patchset) -> v1:
> > > >   * Refactorings of 'if' conditions.
> > > >   * Remove extra blank line.
> > > >   * Remove 'frag_off' field unneeded init.
> > > >   * Add function 'virtio_transport_fill_skb()' which fills both linear
> > > >     and non-linear skb with provided data.
> > > >  v1 -> v2:
> > > >   * Use original order of last four arguments in 'virtio_transport_alloc_skb()'.
> > > >  v2 -> v3:
> > > >   * Add new transport callback: 'msgzerocopy_check_iov'. It checks that
> > > >     provided 'iov_iter' with data could be sent in a zerocopy mode.
> > > >     If this callback is not set in transport - transport allows to send
> > > >     any 'iov_iter' in zerocopy mode. Otherwise - if callback returns 'true'
> > > >     then zerocopy is allowed. Reason of this callback is that in case of
> > > >     G2H transmission we insert whole skb to the tx virtio queue and such
> > > >     skb must fit to the size of the virtio queue to be sent in a single
> > > >     iteration (may be tx logic in 'virtio_transport.c' could be reworked
> > > >     as in vhost to support partial send of current skb). This callback
> > > >     will be enabled only for G2H path. For details pls see comment
> > > >     'Check that tx queue...' below.
> > > >
> > > >  include/net/af_vsock.h                  |   3 +
> > > >  net/vmw_vsock/virtio_transport.c        |  39 ++++
> > > >  net/vmw_vsock/virtio_transport_common.c | 257 ++++++++++++++++++------
> > > >  3 files changed, 241 insertions(+), 58 deletions(-)
> > > >
> > > > diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> > > > index 0e7504a42925..a6b346eeeb8e 100644
> > > > --- a/include/net/af_vsock.h
> > > > +++ b/include/net/af_vsock.h
> > > > @@ -177,6 +177,9 @@ struct vsock_transport {
> > > >
> > > >  	/* Read a single skb */
> > > >  	int (*read_skb)(struct vsock_sock *, skb_read_actor_t);
> > > > +
> > > > +	/* Zero-copy. */
> > > > +	bool (*msgzerocopy_check_iov)(const struct iov_iter *);
> > > >  };
> > > >
> > > >  /**** CORE ****/
> > > > diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> > > > index 7bbcc8093e51..23cb8ed638c4 100644
> > > > --- a/net/vmw_vsock/virtio_transport.c
> > > > +++ b/net/vmw_vsock/virtio_transport.c
> > > > @@ -442,6 +442,43 @@ static void virtio_vsock_rx_done(struct virtqueue *vq)
> > > >  	queue_work(virtio_vsock_workqueue, &vsock->rx_work);
> > > >  }
> > > >
> > > > +static bool virtio_transport_msgzerocopy_check_iov(const struct iov_iter *iov)
> > > > +{
> > > > +	struct virtio_vsock *vsock;
> > > > +	bool res = false;
> > > > +
> > > > +	rcu_read_lock();
> > > > +
> > > > +	vsock = rcu_dereference(the_virtio_vsock);
> > > > +	if (vsock) {
> > > > +		struct virtqueue *vq;
> > > > +		int iov_pages;
> > > > +
> > > > +		vq = vsock->vqs[VSOCK_VQ_TX];
> > > > +
> > > > +		iov_pages = round_up(iov->count, PAGE_SIZE) / PAGE_SIZE;
> > > > +
> > > > +		/* Check that tx queue is large enough to keep whole
> > > > +		 * data to send. This is needed, because when there is
> > > > +		 * not enough free space in the queue, current skb to
> > > > +		 * send will be reinserted to the head of tx list of
> > > > +		 * the socket to retry transmission later, so if skb
> > > > +		 * is bigger than whole queue, it will be reinserted
> > > > +		 * again and again, thus blocking other skbs to be sent.
> > > > +		 * Each page of the user provided buffer will be added
> > > > +		 * as a single buffer to the tx virtqueue, so compare
> > > > +		 * number of pages against maximum capacity of the queue.
> > > > +		 * +1 means buffer for the packet header.
> > > > +		 */
> > > > +		if (iov_pages + 1 <= vq->num_max)
> > > 
> > > I think this check is actual only for case one we don't have indirect buffer feature.
> > > With indirect mode whole data to send will be packed into one indirect buffer.
> > > 
> > > Thanks, Arseniy
> > 
> > Actually the reverse. With indirect you are limited to num_max.
> > Without you are limited to whatever space is left in the
> > queue (which you did not check here, so you should).
> > 
> > 
> > > > +			res = true;
> > > > +	}
> > > > +
> > > > +	rcu_read_unlock();
> > 
> > Just curious:
> > is the point of all this RCU dance to allow vsock
> > to change from under us? then why is it ok to
> > have it change? the virtio_transport_msgzerocopy_check_iov
> > will then refer to the old vsock ...
> 
> IIRC we introduced the RCU to handle hot-unplug issues:
> commit 0deab087b16a ("vsock/virtio: use RCU to avoid use-after-free on
> the_virtio_vsock")
> 
> When we remove the device, we flush all the works, etc. so we should
> not be in this case (referring the old vsock), except for an irrelevant
> transient as the device is disappearing.
> 
> Stefano

what if old device goes away then new one appears?

-- 
MST


