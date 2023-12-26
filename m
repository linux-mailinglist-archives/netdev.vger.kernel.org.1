Return-Path: <netdev+bounces-60317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A6981E8DD
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 19:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9DB91F21B52
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 18:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A02C51C27;
	Tue, 26 Dec 2023 18:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="crzNcRFw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D9851C2B
	for <netdev@vger.kernel.org>; Tue, 26 Dec 2023 18:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703614288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hT6GvBmX89c+TsvMimuxFBTAQCwbiQqPyRqut34DI6c=;
	b=crzNcRFwOaW5SPsV/bqvNd9yDHvD+51TznG5yz/EFWCgpKXozUrh34kftyMquf7OAFIVlr
	CAXsVjD4YyHaBkIL50Xh0TktIDgSFMJ7HUGr3HlNnJVfssQeuc0oJiEy/J76aP0TmmWY0X
	9M6ToTfA2VUEv8nJ1pQFL0HQxXyUKnw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-tsNZF8eJMGmxuAmtAkEmSw-1; Tue, 26 Dec 2023 13:11:26 -0500
X-MC-Unique: tsNZF8eJMGmxuAmtAkEmSw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33694552b9aso2782365f8f.1
        for <netdev@vger.kernel.org>; Tue, 26 Dec 2023 10:11:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703614283; x=1704219083;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hT6GvBmX89c+TsvMimuxFBTAQCwbiQqPyRqut34DI6c=;
        b=cT5Fkdzjg/86O/Nk3MYYvC+hgokEm9NusP+57/Pn384MWU6WW03BiGg+KvrPkK7lc2
         IvpR8ucTKlXDWrhAWyetbqCvn69luNYVEVA10jqEA2YfmjxvgAS6sxfWGO6daIXaKcOc
         pEXwj/3RUZxT+K9eWn4Qm2Nfi9UOZGlO4LDG7E8UW/jxHXnHBnlDxB6+Hcwq4Ke4FrUm
         QznsJRh/wgF+aT8TQLZS/net08NX83Op094WSZdan9PBxza8v5/wl/YfSwp3oApK7ksw
         jd/VSZRaQ4+inTNP8q8GB6Fuz5ZTEvaNT+VoUmCI9l4VDiWxpVI0JB4hixPRjgZ5qQtO
         ymEA==
X-Gm-Message-State: AOJu0YwStsu6PGeGxCRcyhxqrA4UhNjPVEGU0lqjIkIvppA9NnLdNjsZ
	xxWS5w2p6qxUm3z6MuKA9gRCfxOI/vnLAsFAvzkfDbm/v0PdjjJxqE2P+FK1RrhKHbKS86yGNm7
	7Jdz/tB7C61Iwq7r0IOcqanCE
X-Received: by 2002:a05:6000:1091:b0:336:4ba9:e2b3 with SMTP id y17-20020a056000109100b003364ba9e2b3mr4036886wrw.58.1703614282984;
        Tue, 26 Dec 2023 10:11:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGXob+rV7M1PH+RPj4+87x11/2hKBwDb4SfJTkxlS6lAfVaflaggsdNvr5HvrCeMfv5UKIxQ==
X-Received: by 2002:a05:6000:1091:b0:336:4ba9:e2b3 with SMTP id y17-20020a056000109100b003364ba9e2b3mr4036877wrw.58.1703614282620;
        Tue, 26 Dec 2023 10:11:22 -0800 (PST)
Received: from redhat.com ([2.55.177.189])
        by smtp.gmail.com with ESMTPSA id k15-20020adfe3cf000000b003367a51217csm13082390wrm.34.2023.12.26.10.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 10:11:21 -0800 (PST)
Date: Tue, 26 Dec 2023 13:11:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, Zhu Yanjun <yanjun.zhu@intel.com>,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] virtio_net: =?utf-8?Q?Fix_?=
 =?utf-8?B?IuKAmCVk4oCZIGRpcmVjdGl2ZSB3cml0aW4=?= =?utf-8?Q?g?= between 1 and
 11 bytes into a region of size 10" warnings
Message-ID: <20231226130707-mutt-send-email-mst@kernel.org>
References: <20231226114507.2447118-1-yanjun.zhu@intel.com>
 <b1034710-62df-4623-a0ad-d09a6bb12765@linux.dev>
 <20231226100113.4ea54838@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231226100113.4ea54838@hermes.local>

On Tue, Dec 26, 2023 at 10:01:13AM -0800, Stephen Hemminger wrote:
> On Tue, 26 Dec 2023 19:53:58 +0800
> Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
> 
> > The warnings are as below:
> > 
> > "
> > 
> > drivers/net/virtio_net.c: In function ‘init_vqs’:
> > drivers/net/virtio_net.c:4551:48: warning: ‘%d’ directive writing 
> > between 1 and 11 bytes into a region of size 10 [-Wformat-overflow=]
> >   4551 |                 sprintf(vi->rq[i].name, "input.%d", i);
> >        |                                                ^~
> > In function ‘virtnet_find_vqs’,
> >      inlined from ‘init_vqs’ at drivers/net/virtio_net.c:4645:8:
> > drivers/net/virtio_net.c:4551:41: note: directive argument in the range 
> > [-2147483643, 65534]
> >   4551 |                 sprintf(vi->rq[i].name, "input.%d", i);
> >        |                                         ^~~~~~~~~~
> > drivers/net/virtio_net.c:4551:17: note: ‘sprintf’ output between 8 and 
> > 18 bytes into a destination of size 16
> >   4551 |                 sprintf(vi->rq[i].name, "input.%d", i);
> >        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/net/virtio_net.c: In function ‘init_vqs’:
> > drivers/net/virtio_net.c:4552:49: warning: ‘%d’ directive writing 
> > between 1 and 11 bytes into a region of size 9 [-Wformat-overflow=]
> >   4552 |                 sprintf(vi->sq[i].name, "output.%d", i);
> >        |                                                 ^~
> > In function ‘virtnet_find_vqs’,
> >      inlined from ‘init_vqs’ at drivers/net/virtio_net.c:4645:8:
> > drivers/net/virtio_net.c:4552:41: note: directive argument in the range 
> > [-2147483643, 65534]
> >   4552 |                 sprintf(vi->sq[i].name, "output.%d", i);
> >        |                                         ^~~~~~~~~~~
> > drivers/net/virtio_net.c:4552:17: note: ‘sprintf’ output between 9 and 
> > 19 bytes into a destination of size 16
> >   4552 |                 sprintf(vi->sq[i].name, "output.%d", i);
> > 
> > "
> > 
> > Please review.
> > 
> > Best Regards,
> > 
> > Zhu Yanjun
> > 
> > 在 2023/12/26 19:45, Zhu Yanjun 写道:
> > > From: Zhu Yanjun <yanjun.zhu@linux.dev>
> > >
> > > Fix a warning when building virtio_net driver.
> > >
> > > Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> > > ---
> > >   drivers/net/virtio_net.c | 5 +++--
> > >   1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 49625638ad43..cf57eddf768a 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -4508,10 +4508,11 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> > >   {
> > >   	vq_callback_t **callbacks;
> > >   	struct virtqueue **vqs;
> > > -	int ret = -ENOMEM;
> > > -	int i, total_vqs;
> > >   	const char **names;
> > > +	int ret = -ENOMEM;
> > > +	int total_vqs;
> > >   	bool *ctx;
> > > +	u16 i;
> > >   
> > >   	/* We expect 1 RX virtqueue followed by 1 TX virtqueue, followed by
> > >   	 * possible N-1 RX/TX queue pairs used in multiqueue mode, followed by  
> > 
> 
> If you change the variable type to u16, then the format string should no
> longer use %d. Instead should be %u

I would just use unsigned FWIW. But it doesn't matter the range is
limited here. It's just that the compiler can't figure it out.

-- 
MST


