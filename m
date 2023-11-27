Return-Path: <netdev+bounces-51375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBC97FA670
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 17:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8221928193D
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 16:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCD831739;
	Mon, 27 Nov 2023 16:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b="bzDJlciM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E63DE
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 08:32:46 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c9a5d2e77bso11693901fa.2
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 08:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1701102764; x=1701707564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mVpHuQFa6WA4nsRZaYZzAE/wCMgENUIng7Mv/kONotE=;
        b=bzDJlciMb7/X1AONc7uSVRYVAb7PpFTeKpHsxzw59F5rtsDoDGzNRg3xiEMTA1106f
         USYIXg5st+0G6jgMIZ3m414Bsd1oDZtvGHYe9J8mNQKOsrink+sJSu18LrT7/P1jBNCE
         gWBI6JRz+0ncrW6G3u1k5LVZQzhOHsymfOB3i5DVfnFdyRTbbnfrp5EYKGY+EFpoodil
         ANzFUpBd+L9aufndPcY1uRB9xcWzt/s7sLf+2BdfKeiob+NchDzMwBVmgoCcZRjt53di
         y7XiRUAmAtqE7C8q8eC+z3JNDW/21EpQwnhG6iuVpET/nrFgTJkILfqRXsFqYPU4+342
         1Blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701102764; x=1701707564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVpHuQFa6WA4nsRZaYZzAE/wCMgENUIng7Mv/kONotE=;
        b=dA3vc+BGfTgXtL8fonQuPqjBSQoKPG7HAciYRTGhSHQSBr9TZwZUx/V12+Xh9Vr7iP
         qV+LZJ1NjbIsD9QY/MAwDI7VVTYxjyXwpZILQsjt0i5EGkcQGympYN/7Q0AkXMXU/zgx
         Kb9bNsXMm60bZOv/vXLrYjE4qTelI5tvhv7Gk+Vqa9NKkMaa4kDve6i9YxZkdAVT3jts
         sZbS/GH+7GS0xk5V/aNH4DHpcKWt+UNzWYKoafmABJ0mK5EJnIpRUqaNMY8eJTksSnwl
         mXq5bMnWcJ+k6pLD8L9nv4g4koT89575PPpTEyfwEDpOLINk1a0z9E+gnHfEGTxScTQf
         Z5dg==
X-Gm-Message-State: AOJu0YzEC8Wzl8kCqEDkawrSc4CfZJ+KCugBeQqmEzXwfi6aER2bvSZt
	HxDu7hHPCLmsnd//lbxxrU3D4w==
X-Google-Smtp-Source: AGHT+IEfQlT78CJBw9qwf+qcFU5klRZs0b6yTOMcHN0VTodZ9E3tmzfKxloBy38dMuEPz5S6nTS55g==
X-Received: by 2002:a05:651c:38d:b0:2c9:99bf:36c7 with SMTP id e13-20020a05651c038d00b002c999bf36c7mr3659649ljp.5.1701102764465;
        Mon, 27 Nov 2023 08:32:44 -0800 (PST)
Received: from debian ([185.117.107.42])
        by smtp.gmail.com with ESMTPSA id bz14-20020a05651c0c8e00b002c12b823669sm1438121ljb.32.2023.11.27.08.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 08:32:43 -0800 (PST)
Date: Mon, 27 Nov 2023 17:32:41 +0100
From: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
To: Parthiban.Veerasooran@microchip.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] net: microchip_t1s: conditional collision detection
Message-ID: <ZWTEqXAwxIK1pSHo@debian>
References: <20231127104045.96722-1-ramon.nordin.rodriguez@ferroamp.se>
 <20231127104045.96722-4-ramon.nordin.rodriguez@ferroamp.se>
 <142ce54c-108c-45b4-b886-ce3ca45df9fe@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <142ce54c-108c-45b4-b886-ce3ca45df9fe@microchip.com>

On Mon, Nov 27, 2023 at 04:00:18PM +0000, Parthiban.Veerasooran@microchip.com wrote:
> Hi,
> 
> This implementation was introduced in the below patch itself.
> 
> https://lore.kernel.org/netdev/20230426205049.xlfqluzwcvlm6ihh@soft-dev3-1/T/#m9a52b6c03b7fa637f70aed306b50b442590e24a3
> 

But the change was dropped in that patchset right? It's not present in
netdev-next.

> As it is recommended to do it in a separate patch and also the 
> datasheets of LAN867X Rev.B1 and LAN865X Rev.B0 internal PHY have these 
> register is reserved, we were working for a feasible solution to 
> describe this for customer and mainline. By the time many other things 
> messed up and couldn't reach the mainline on time.
> 

Far as I can tell 'collision detect' is described in the following
sections of respective datasheet:

* 11.5.51 - LAN8650
* 5.4.48  - LAN8670

The rest of the bits are reserved though. The change I propose only
manipulate the documented (bit 15) collision bit.

Is your point that the lan8670 datasheet is only valid for rev.c and not
rev.b?

Andrew suggested on the cover letter that it be interesting to look at
completly disabling collision detect, any strings you can pull at
Microchip to investigate that?
Also any input on my suggested testing methodology is more than welcome.

> We also implemented LAN867X Rev.C1 support already in the driver and 
> published in our product site and in the process of preparing mainline 
> patches. But unfortunately it took little more time to make it.
> 
> https://ww1.microchip.com/downloads/aemDocuments/documents/AIS/ProductDocuments/CodeExamples/EVB-LAN8670-USB_Linux_Driver_1v0.zip

I'm aware, we've been using a derivative of that work at ferroamp for
development. But it's been driving me nuts, being the 't1s guy' at work,
and maintaining out of tree drivers for weird dev boxes.

It's not my intention to beat you to the punch, I just want a mainlined
driver so that I can spend less of my time on plumbing.

> 
> Anyway, thank you for the support. Good luck!

Likewise!
R

