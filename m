Return-Path: <netdev+bounces-31977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF2E791C1B
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 19:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E194528100E
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 17:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEA1C8E1;
	Mon,  4 Sep 2023 17:47:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2DE3D8B
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 17:47:06 +0000 (UTC)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6776EAF
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 10:47:04 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-265c94064b8so290111a91.0
        for <netdev@vger.kernel.org>; Mon, 04 Sep 2023 10:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693849624; x=1694454424; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8bxAh1Wqp7uFS5rVwZ79WAMvjUuU1Cta6p/67LVTBTo=;
        b=T/ITPMXidDiiivmcQqnFLunrBzCB27CDYSAX/i9fsyEs8W4+mJIos+qUHYXrC7Ole1
         qgmezqrJ5QopmM7Ki54YzmZoNSLHwicxOTHXoHEI8qDjKzdZ0YslvHrKM28tVv4uZIfk
         IuQAoDsQiiLJWUg/3A3RvAtkQdaqWdgTD4i+vXPyasv1dQ5zKz3tAAta9OEhJfPJi1QD
         U4dTSnANW+8UvZOAnAyI3iNDvfIgYOud30kyHLP8+UdGPG0qEQWiuNJ69jB9eUe3L4+s
         xMYo/RN9oGzfxD2FfhTPahzm+5CzmJ6HLalYGEJsFLK93ucLF/XqSJgqzKfq9SZdPJ24
         TGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693849624; x=1694454424;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8bxAh1Wqp7uFS5rVwZ79WAMvjUuU1Cta6p/67LVTBTo=;
        b=Gws19WA31q+0aywKG8bEoRVUSK16OT3l6TCfyR5qfgoeVU+NJX1kMlq8IzXKwJpBu4
         HLXxDeLGSvyskvFbQDWmTj7mLXkL3y7OoPzS/cYpdH+FqLguzmytzTuvTlGQm/sYlEov
         geqvfU1HeXohuc7TRtI76Hmn5SFRlMokQIr7nzMUBE4Oybg24nusk9tTI/DrhRvxOZ4O
         wOkh8RaYUVFl1C7E7Y3ZbdO16pBwX3DdoEJuw4WpokvWBbA07LCqGbuIJa7EErjzgHvU
         w6Lt/egRGRsY+ZiEkw+a1YS9dr9YeD7iL9JWVdQ2zS77W7/XAtvzkmzkB22bjRwLZITa
         hsbA==
X-Gm-Message-State: AOJu0YxoGxevGJfY0m0HuxtjgA+0HHL05cph68R8j8p7YTuWD9mqYAa7
	hfP3XG5G9U9aNx8KRN2V1aY=
X-Google-Smtp-Source: AGHT+IEymrYlQcJWjOfExz8cwu5fWpOL7Sd0djjeqEF+jCZTs8HqLkhsm2KDQ+bhdwkyA32juS1jSA==
X-Received: by 2002:a17:902:e54e:b0:1bb:83ec:832 with SMTP id n14-20020a170902e54e00b001bb83ec0832mr12875628plf.2.1693849623725;
        Mon, 04 Sep 2023 10:47:03 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id j22-20020a170902759600b001b8ad8382a4sm7723137pll.216.2023.09.04.10.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 10:47:03 -0700 (PDT)
Date: Mon, 4 Sep 2023 10:47:00 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	netdev@vger.kernel.org, glipus@gmail.com,
	maxime.chevallier@bootlin.com, vadim.fedorenko@linux.dev,
	gerhard@engleder-embedded.com, thomas.petazzoni@bootlin.com,
	krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Subject: Re: [PATCH net-next RFC v4 2/5] net: Expose available time stamping
 layers to user space.
Message-ID: <ZPYYFFxhALYnmXrx@hoboy.vegasvil.org>
References: <20230511210237.nmjmcex47xadx6eo@skbuf>
 <20230511150902.57d9a437@kernel.org>
 <20230511230717.hg7gtrq5ppvuzmcx@skbuf>
 <20230511161625.2e3f0161@kernel.org>
 <20230512102911.qnosuqnzwbmlupg6@skbuf>
 <20230512103852.64fd608b@kernel.org>
 <20230517121925.518473aa@kernel.org>
 <2f89e35e-b1c9-4e08-9f60-73a96cc6e51a@lunn.ch>
 <20230517130706.3432203b@kernel.org>
 <20230904172245.1fa149fd@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230904172245.1fa149fd@kmaincent-XPS-13-7390>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 04, 2023 at 05:22:45PM +0200, Köry Maincent wrote:
> Hello I am resuming my work on selectable timestamping layers.
> 
> On Wed, 17 May 2023 13:07:06 -0700
> Jakub Kicinski <kuba@kernel.org> wrote:
> 
> > On Wed, 17 May 2023 21:46:43 +0200 Andrew Lunn wrote:
> > > As i said in an earlier thread, with a bit of a stretch, there could
> > > be 7 places to take time stamps in the system. We need some sort of
> > > identifier to indicate which of these stampers to use.
> > > 
> > > Is clock ID unique? In a switch, i think there could be multiple
> > > stampers, one per MAC port, sharing one clock? So you actually need
> > > more than a clock ID.  

Let's not mix things up.  A clock ID identifies a dynamic posix clock,
just like the name suggests.  A clock is a device that supports
operations like gettime and settime.

A given clock might or might not generate time stamps.

The time stamp API is completely separate.

> > Clock ID is a bit vague too, granted, but in practice clock ID should
> > correspond to the driver fairly well? My thinking was - use clock ID
> > to select the (silicon) device, use a different attribute to select 
> > the stamping point.

I've never heard of a device that has different time stamping points.
If one ever appeared, then it ought to present two interfaces.

> > IOW try to use the existing attribute before inventing a new one.
> 
> What do you think of using the clock ID to select the timestamp layer, and add
> a ts_layer field in ts_info that will describe the timestamp layer. This allow
> to have more information than the vague clock ID. We set it in the driver.
> With it, we could easily add new layers different than simple mac and phy.
> I am currently working on this implementation.

I think you should model the layers explicitly.

Thanks,
Richard

