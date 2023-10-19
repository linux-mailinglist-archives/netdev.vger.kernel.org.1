Return-Path: <netdev+bounces-42507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AECAC7CF035
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 08:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57E58B20DE7
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 06:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F54446671;
	Thu, 19 Oct 2023 06:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c2f5P9yJ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DD18C07
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 06:38:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DFBBE
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 23:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697697514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Blqwk8CZOAuxak9k7tu36Lndth1mX4n5z0UG75CC1Vc=;
	b=c2f5P9yJM4Mx+EXLr9aGW6a8ddtt29niz27T6OdaS3Zfiin/nNfQhcjS08M5Dj7KjaJpgR
	pGjeL9/fwRuy90br9E4XxXTFMBedXnofl1UxloWe+9nQW61naBSQozon6mAdRhXjm7KeRF
	iTRGp51m0+ZDEr+l6eS7TQCWGTMyaIM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-bLKYZySlMNKLW8WdVJ8H4Q-1; Thu, 19 Oct 2023 02:38:23 -0400
X-MC-Unique: bLKYZySlMNKLW8WdVJ8H4Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4084a9e637eso560705e9.2
        for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 23:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697697502; x=1698302302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Blqwk8CZOAuxak9k7tu36Lndth1mX4n5z0UG75CC1Vc=;
        b=IPmZjg7C0gMyabUa2fXgmJf1EWlng6M/WCFV3p0EtvbRgYby5WWu/tBo6y1C/Cjnz/
         RIk3Dc8P3XkF0oYEwzbliMowBC4CPV+sorG9ARRQIua6LaE68rVGm5BeKK3ApILysZLG
         xtpWndpZPA6m84ZbEW+I0ZyQzzA3GI/Flwt2KQTvpXbM7I93M4CNgWAYcFEz4kgGKlpw
         ua1qF8rxyoBm1/kXrIynxK9rX6FOeb7nir4DMfHAbDsGG6fjWrjMwMi8liPZQNPAd2Zc
         fwMsLV5e3Wa4luvu9FqtEFLhUfE+jbQcDMIWh1fDeVw9InQK2cw2r9xxPdnkwoenCv7E
         tu/w==
X-Gm-Message-State: AOJu0YxplpF7ustOGCcN8EZIz8eQp/1MsjYX4Prv4z1XD0YzWjoNAdc9
	Wfd1k0SiwrMAXH7eDQ4xiYiRyZrrEhiLRosz5cujspb1uup+aKAiwTtSg188FPIZb+tMfVNm8Rm
	nNCeSBA8l5oRjKha1d+J/1x70hc8=
X-Received: by 2002:a05:600c:c0c:b0:407:7e5f:ffb9 with SMTP id fm12-20020a05600c0c0c00b004077e5fffb9mr1104340wmb.9.1697697502082;
        Wed, 18 Oct 2023 23:38:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9qh0cDCENMRB0qEBa29pUmbeWcdQ3FQ1ygusFYggBDj+0Bntc+WUE/xD8GAaiDYHR1Jei5w==
X-Received: by 2002:a05:600c:c0c:b0:407:7e5f:ffb9 with SMTP id fm12-20020a05600c0c0c00b004077e5fffb9mr1104320wmb.9.1697697501762;
        Wed, 18 Oct 2023 23:38:21 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
        by smtp.gmail.com with ESMTPSA id j20-20020a05600c1c1400b004065daba6casm3604423wms.46.2023.10.18.23.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 23:38:21 -0700 (PDT)
Date: Thu, 19 Oct 2023 02:38:16 -0400
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
Message-ID: <20231019023739-mutt-send-email-mst@kernel.org>
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <20231016120033.26933-14-xuanzhuo@linux.alibaba.com>
 <20231016164434.3a1a51e1@kernel.org>
 <1697508125.07194-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1697508125.07194-1-xuanzhuo@linux.alibaba.com>

On Tue, Oct 17, 2023 at 10:02:05AM +0800, Xuan Zhuo wrote:
> On Mon, 16 Oct 2023 16:44:34 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> > On Mon, 16 Oct 2023 20:00:27 +0800 Xuan Zhuo wrote:
> > > @@ -305,9 +311,15 @@ static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
> > >
> > >  			stats->bytes += xdp_get_frame_len(frame);
> > >  			xdp_return_frame(frame);
> > > +		} else {
> > > +			stats->bytes += virtnet_ptr_to_xsk(ptr);
> > > +			++xsknum;
> > >  		}
> > >  		stats->packets++;
> > >  	}
> > > +
> > > +	if (xsknum)
> > > +		xsk_tx_completed(sq->xsk.pool, xsknum);
> > >  }
> >
> > sparse complains:
> >
> > drivers/net/virtio/virtio_net.h:322:41: warning: incorrect type in argument 1 (different address spaces)
> > drivers/net/virtio/virtio_net.h:322:41:    expected struct xsk_buff_pool *pool
> > drivers/net/virtio/virtio_net.h:322:41:    got struct xsk_buff_pool
> > [noderef] __rcu *pool
> >
> > please build test with W=1 C=1
> 
> OK. I will add C=1 to may script.
> 
> Thanks.

And I hope we all understand, rcu has to be used properly it's not just
about casting the warning away.

-- 
MST


