Return-Path: <netdev+bounces-45774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 962E47DF789
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 17:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C733A1C20E8D
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 16:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5A01DA49;
	Thu,  2 Nov 2023 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxlek7ft"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF8014A92
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 16:21:37 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BEBE3
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 09:21:36 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so1908736a12.1
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 09:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698942095; x=1699546895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EG2gxy7zJW2KAOlwAdkoYfIZGOdjkb7Gq1bBWafYyvM=;
        b=lxlek7ftB6HBWY+7d2d38ctUh6rN3yOLHyvRpf/7MhM1CzhEkKTtnooQ0i63UMijh/
         15kxySQEkbII1gefIP82HxYCc0FGSKMeyQ8uQNRVy06DneWZba0wKOfV4GyK+A05abi/
         mnclXwkD6Xp9hNOF0+xa4mbjXT+QSgUDAV0m8rayJB7mBOead8HK5/YlakjOY4Lan50f
         cNmqVs4w8+5vtdGXe4505ZFm7uHKBXZgHbG/MN0mZ/bJSY8BykZOkirc0d26ESW7GFVI
         XWQeCgAyux4I15QtrgtoMI8Wl1woflxDqC9E2Mh1yU321WKXZGDN7cnQ17g2UC6NV1Yw
         XvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698942095; x=1699546895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EG2gxy7zJW2KAOlwAdkoYfIZGOdjkb7Gq1bBWafYyvM=;
        b=EqSMSR7Z5i8QM+5/XNg010FGNyZzJIzbwHkZnLtq85xPpTQ+iVoA7ihBJobayz31bx
         Cb6dH3HAaRn6uKXrA5Qqgn45290ICgqFqwelFVc921L2+8/bSSwlO3sbEULrCLokW0HE
         2ZpXyB1s3vkMKxcv5lCXHoOFvyLyZdXd5rAj+976hcHUUcoi8WNY5L6LoYRYrVLHwJCk
         xAw94IELnTW1fO8Iw8E4UBw67SDPdqoAnHXXcJGTayjHQpKTnphd75M51a/bNw/WXw17
         ao5YgAVkqVvrqJn/QR0lITuIQSuP5E+J8jAHd1A7bPx+yEhyk3Ivm8R5n5X0YLPhKyjb
         kIoQ==
X-Gm-Message-State: AOJu0YzrmBzdhVLX/vyWnGzMjdnQaOoRFPIpx+856dvkWNvyUrrokESM
	zU6DrExtwfJ9/hYqBC5u75I=
X-Google-Smtp-Source: AGHT+IGnJGNm+d/2nhzIH2cJRJyFY5SrDQo6ZHL9tx9I5RMjwUzXaVq1hh4YUDz0myiBslDaGe0d2w==
X-Received: by 2002:a05:6402:299:b0:53f:731a:e513 with SMTP id l25-20020a056402029900b0053f731ae513mr14313899edv.25.1698942094714;
        Thu, 02 Nov 2023 09:21:34 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id q22-20020a50cc96000000b0053e408aec8bsm62766edi.6.2023.11.02.09.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 09:21:34 -0700 (PDT)
Date: Thu, 2 Nov 2023 18:21:32 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org,
	alsi@bang-olufsen.dk, andrew@lunn.ch, vivien.didelot@gmail.com,
	f.fainelli@gmail.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org, krzk+dt@kernel.org,
	arinc.unal@arinc9.com
Subject: Re: [PATCH net-next v2 3/3] net: dsa: realtek: support reset
 controller
Message-ID: <20231102162132.ksfv5ba3kc2efc63@skbuf>
References: <20231027190910.27044-1-luizluca@gmail.com>
 <20231027190910.27044-4-luizluca@gmail.com>
 <20231030205025.b4dryzqzuunrjils@skbuf>
 <CAJq09z6KV-Oz_8tt4QHKxMx1fjb_81C+XpvFRjLu5vXJHNWKOQ@mail.gmail.com>
 <CAJq09z6f3AA4t7t+FvdRg9wS9DftNbibu6pssUAPA3u4qih0rg@mail.gmail.com>
 <CACRpkdairxqm_YVshEuk_KbnZw9oH2sKiHapY_sTrgc85_+AmQ@mail.gmail.com>
 <20231102155521.2yo5qpugdhkjy22x@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102155521.2yo5qpugdhkjy22x@skbuf>

On Thu, Nov 02, 2023 at 05:55:21PM +0200, Vladimir Oltean wrote:
> +static int __init realtek_interface_init(void)
> +{
> +	int err;
> +
> +	err = realtek_mdio_init();
> +	if (err)
> +		return err;
> +
> +	err = realtek_smi_init();
> +	if (err) {
> +		realtek_smi_exit();

One more correction, this was supposed to be realtek_mdio_exit().

> +		return err;
> +	}
> +
> +	return 0;
> +}
> +module_init(realtek_interface_init);

