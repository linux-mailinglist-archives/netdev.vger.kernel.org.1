Return-Path: <netdev+bounces-53966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A6F805732
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 15:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FDCD1F21599
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 14:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D4265EB6;
	Tue,  5 Dec 2023 14:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GgmZ7moS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A9119F
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 06:22:57 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-db4422fff15so3412777276.1
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 06:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701786176; x=1702390976; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G/Frwe5NoLiVErGGo0J2Fc9HYe79JYyuyxPi79nNvzQ=;
        b=GgmZ7moSb2Ls8Jzwp9GUedkL79ChZbe5Vn57Lcos0mXNbLufzaVZ/GoPFho+EEK//6
         r2/nmV9N6nmQH3TXCoCMSbI36hqlB1Z1WjMrcXj09US4WQwitsx6oqyl8KQ4m91RyXKr
         DistxXkG+oxDmdXjHcaLgY5nGPARlIhChV2ExZyhsvU/SiaWNCsMJB0qPzZjp9slVSmz
         boRTL/NHScMihGZzq0OU0MnoIll09LmammOAcC9PB2TbahTX3TBoHQuWpsWvH9Z3bkeM
         JnD2SdmkPIS8M6D3zLa1/tgKj9RQuIjcz7XF4+ieYf7ZijxhaqAb6R6TqfY39RIBAGW2
         awMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701786176; x=1702390976;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G/Frwe5NoLiVErGGo0J2Fc9HYe79JYyuyxPi79nNvzQ=;
        b=sQNHNhF0aLUHpOFIqMICKufhvP3I/Up2qOsr+z4I/Q/fe0CgTXJMq1UHrhE4ISkohI
         C79qYYSW7HX39eJ1FXIUqhYzWJEFqAxCqyMkhsyXYIc1hWcYrQjUfSmVx55vkM6VEFHh
         P6YssEF+MBLkHfIBT+Z+onJHJhJkjDKXbghhpk5CVAoi+jTT4RjZ8qDnWC6AxpVGHCdz
         /EP7a7LGOBuuj0geB16TuUXpdj09mqUHKRR4FlJs1+Rg6xG9br81yh2T1ZjeEx/OOVuP
         j7H6i22RplQb8w8Ou4fqCl2WSKgeNieMh5t5DR2/QZYPjHazkXhuvqrMggPcUlWN7Y5B
         CPmA==
X-Gm-Message-State: AOJu0YyCkT5E1l9ulTRt2VlFJk1yyR2N0RzCm59GQ/ZaQBu7GXNy6hMt
	J50oT15VV6qFTts9/RelcPECCLEfRfjaGKR8JcAA9g==
X-Google-Smtp-Source: AGHT+IGyrKcpMlCc6HKeOLyBPWiYuASZdAWLwG2aWAnGxzTUHOjqtc2yXhgIigkdzOlV5dwo5Ofz4JjxN6ezYXE4viE=
X-Received: by 2002:a05:6902:248:b0:db7:dad0:76b5 with SMTP id
 k8-20020a056902024800b00db7dad076b5mr3673602ybs.81.1701786176179; Tue, 05 Dec
 2023 06:22:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230607152427.108607-1-manivannan.sadhasivam@linaro.org>
 <20230607094922.43106896@kernel.org> <20230607171153.GA109456@thinkpad>
 <20230607104350.03a51711@kernel.org> <20230608123720.GC5672@thinkpad>
 <20231117070602.GA10361@thinkpad> <20231117162638.7cdb3e7d@kernel.org>
 <20231127060439.GA2505@thinkpad> <20231127084639.6be47207@kernel.org>
 <CAA8EJppL0YHHjHj=teCnAwPDkNhwR1EWYuLPnDue1QdfZ3RS_w@mail.gmail.com>
 <20231128125808.7a5f0028@kernel.org> <CAA8EJpqGAK-7be1v8VktFRPpBHhUTwKJ=6JTTrFaWh341JAQEQ@mail.gmail.com>
 <20231204081222.31bb980a@kernel.org>
In-Reply-To: <20231204081222.31bb980a@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 5 Dec 2023 16:22:45 +0200
Message-ID: <CAA8EJprrcH3T8_aA7bZhZXKiWMXjUTZkvLkQzteHUG4_7e4i8w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add MHI Endpoint network driver
To: Jakub Kicinski <kuba@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, mhi@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loic.poulain@linaro.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Dec 2023 at 18:12, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Mon, 4 Dec 2023 14:12:12 +0200 Dmitry Baryshkov wrote:
> > Ok, here you are talking about the control path. I can then assume
> > that you consider it to be fine to use netdev for the EP data path, if
> > the control path is kept separate and those two can not be mixed. Does
> > that sound correct?
>
> If datapath == traffic which is intended to leave the card via
> the external port, then yes.

Then I think I understand what causes the confusion.

The MHI netdev is used to deliver network traffic to the modem CPU,
but it is not the controlpath.
For the control path we have non-IP MHI channels (QMI, IPCR, etc).
This can be the traffic targeting e.g. SSH or HTTP server running on
the EP side of the link.

I probably fail to see the difference between this scenario and the
proper virtio netdev which also allows us to send the same IPv4/v6
traffic to the CPU on the EP side.

-- 
With best wishes
Dmitry

