Return-Path: <netdev+bounces-42528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238B67CF30D
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 10:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD84281F75
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 08:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C9C15ADA;
	Thu, 19 Oct 2023 08:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9jH7pcJ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0EE15AC1
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 08:43:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E791987
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 01:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697704984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AlqhhHztKcdEt3pYJWxTUFdsjzqtezTAvUlB2zTyOgA=;
	b=a9jH7pcJCR6DVbvpHNeXpnHF+iixdYT4v5chFfsVGoOqZeid+TyajgxRNAdN7LarF0LsNb
	81cFR8R89xxfj/n5Co8+GZDGpmZWjt4t9WxLII4znedgKuhv1ietHuZ4gw+8v/8sC0mbhy
	/kdi2qBxfKrkRw44HI9+/l5XPa/Pf3Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-abVsJ9m2PteYlJZSoOrMhQ-1; Thu, 19 Oct 2023 04:43:03 -0400
X-MC-Unique: abVsJ9m2PteYlJZSoOrMhQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40845fe2d1cso2221285e9.0
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 01:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697704982; x=1698309782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlqhhHztKcdEt3pYJWxTUFdsjzqtezTAvUlB2zTyOgA=;
        b=VdbZBhwjdfGoTVgRl/UL8AQj0IU3601C9u1mJZTIr2NtMw3YiN5bLF7U6bXocY9zyE
         LQSJzDYHNom8wE7qgwfFc99xnRSw2Y2y8utOtr+tMRHdu9Ed6nhG58mKtxdqm/ga48Gk
         bI7kGRGbfK3L7G5qGX9Wls2u6UUKkSNycCgw0MJkF+9hPwjmXYf+tPLebSoYfLPoY1FE
         Fi3wax7eiZhMxJReZ+Ayhk7xlPMIRCgX7F4FXHTQWsreyiNTEjIycKmxrR0qvG9b/vCH
         tyS02oAEDmSqcVgJdvvSar+z83xJ5SkWzWrMjpKhULc5p9HFKHQNZPRoZMUJi+RAE8WB
         b3WA==
X-Gm-Message-State: AOJu0Yw+RahqR/HZHuacoBtnySkYxy3mH8T62tkKfdItYkXdDnhF1m0Y
	AKjxvAaIzm44WImEEAd7xBUZzWCywa3GB1yoJzb0cggpUlMcpEcpcaEk2zoHddecn1U9rZIB0YJ
	4YCLrdQESpRqsklY/
X-Received: by 2002:a05:600c:19ca:b0:407:5b54:bb0c with SMTP id u10-20020a05600c19ca00b004075b54bb0cmr1374842wmq.19.1697704981958;
        Thu, 19 Oct 2023 01:43:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcs+PI3KpQMhigTtyQ8yweB5gsDVKRRB+EK96wCv4w25J7K7DMddnUtKuq/gzlzEZ+F/Hmfw==
X-Received: by 2002:a05:600c:19ca:b0:407:5b54:bb0c with SMTP id u10-20020a05600c19ca00b004075b54bb0cmr1374826wmq.19.1697704981619;
        Thu, 19 Oct 2023 01:43:01 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
        by smtp.gmail.com with ESMTPSA id o30-20020a05600c511e00b004063cd8105csm3878145wms.22.2023.10.19.01.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 01:43:01 -0700 (PDT)
Date: Thu, 19 Oct 2023 04:42:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v1 13/19] virtio_net: xsk: tx:
 virtnet_free_old_xmit() distinguishes xsk buffer
Message-ID: <20231019043958-mutt-send-email-mst@kernel.org>
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <20231016120033.26933-14-xuanzhuo@linux.alibaba.com>
 <20231016164434.3a1a51e1@kernel.org>
 <1697508125.07194-1-xuanzhuo@linux.alibaba.com>
 <20231019023739-mutt-send-email-mst@kernel.org>
 <1697699628.4189832-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1697699628.4189832-1-xuanzhuo@linux.alibaba.com>

On Thu, Oct 19, 2023 at 03:13:48PM +0800, Xuan Zhuo wrote:
> On Thu, 19 Oct 2023 02:38:16 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Tue, Oct 17, 2023 at 10:02:05AM +0800, Xuan Zhuo wrote:
> > > On Mon, 16 Oct 2023 16:44:34 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> > > > On Mon, 16 Oct 2023 20:00:27 +0800 Xuan Zhuo wrote:
> > > > > @@ -305,9 +311,15 @@ static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
> > > > >
> > > > >  			stats->bytes += xdp_get_frame_len(frame);
> > > > >  			xdp_return_frame(frame);
> > > > > +		} else {
> > > > > +			stats->bytes += virtnet_ptr_to_xsk(ptr);
> > > > > +			++xsknum;
> > > > >  		}
> > > > >  		stats->packets++;
> > > > >  	}
> > > > > +
> > > > > +	if (xsknum)
> > > > > +		xsk_tx_completed(sq->xsk.pool, xsknum);
> > > > >  }
> > > >
> > > > sparse complains:
> > > >
> > > > drivers/net/virtio/virtio_net.h:322:41: warning: incorrect type in argument 1 (different address spaces)
> > > > drivers/net/virtio/virtio_net.h:322:41:    expected struct xsk_buff_pool *pool
> > > > drivers/net/virtio/virtio_net.h:322:41:    got struct xsk_buff_pool
> > > > [noderef] __rcu *pool
> > > >
> > > > please build test with W=1 C=1
> > >
> > > OK. I will add C=1 to may script.
> > >
> > > Thanks.
> >
> > And I hope we all understand, rcu has to be used properly it's not just
> > about casting the warning away.
> 
> 
> Yes. I see. I will use rcu_dereference() and rcu_read_xxx().
> 
> Thanks.

When you do, pls don't forget to add comments documenting what does
rcu_read_lock and synchronize_rcu.


-- 
MST


