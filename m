Return-Path: <netdev+bounces-45687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC337DF067
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 11:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4F25281A69
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 10:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC71479D9;
	Thu,  2 Nov 2023 10:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGpbWCsU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471466FAD;
	Thu,  2 Nov 2023 10:44:10 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E219ADE;
	Thu,  2 Nov 2023 03:44:08 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9d0b4dfd60dso115628466b.1;
        Thu, 02 Nov 2023 03:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698921847; x=1699526647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hu7EtFOH4JYWHYQGq+Gs8n0hPFQIaBrv99tERFYYNBw=;
        b=YGpbWCsUlWSpRokNMKLkNzU+18o8jNDdabss0LMaqEan18v1EFSs3oO/vd1oSGKRsC
         B2uMcW1AVaL1eka+ltog4pr7Dz7bUqNiMA+FutgfAa/A6HZP/cKylPn2ZRDlD2iYHjT3
         mA+YF85bH/bpzcP3LfruV3GVcB2u40euD9B5G1tcSxSFjiLlOljAdfDmBH79qc1KMtTE
         LbAK2MqmfVv0aVOje8E2qbUQi4+lf1eB5+v3dZ0QfggXVt1ob1qaTHZrr/E/IDV4KdYD
         T88KaQTWhBYWS7UbxIO195neKWflkgxOFauQrtyuGlAQ3mr/Si+t0+8B1emy1UilArbQ
         A71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698921847; x=1699526647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hu7EtFOH4JYWHYQGq+Gs8n0hPFQIaBrv99tERFYYNBw=;
        b=HZHACv6ccs+hU/+7kRLbKfiNedGE3zL7F18QkwT9/HANTGVqmEQOW+Etw8tQBEFYYD
         Ct6miFN1HSGWPofzTS1bgb2IiRobTIgGD6JZczzAZO1R+2KPrGu26R2z9jIccxm6F7/Y
         tEeDxBdJe167CruzueM8YJ/GlCAatsUvBoGgfSpSN9kufjhK3R2QqYBucT80l8V9AWKY
         ndfb+5jOmibxe5u0z71oxRa3oyD9RxpCA38aSJOybH7r9UYGh0srcdv6Iy7z46VLPT+z
         9FMwn0kKNZoNPVP3cXIhJ9GJDyhZVU3+QAH2dVgcCYZj9P8DBXgGXZ8qTNhT8wIJMNIP
         plig==
X-Gm-Message-State: AOJu0Yye9i6vq1CJehMJB6fXFK9DtJH1zH+hXNFlV19RCOvNh0M9AEOh
	QGl4yoihVT7cTWCpiUQ7XP4=
X-Google-Smtp-Source: AGHT+IGHjsA1afvMWYAL5vywLxLyQHm3EaLa8cmgoOWrUDetbsSbhLsd9PvAp5GsTbBun9wjYsJTYQ==
X-Received: by 2002:a17:906:ce4a:b0:9d7:1388:e554 with SMTP id se10-20020a170906ce4a00b009d71388e554mr3321646ejb.17.1698921847127;
        Thu, 02 Nov 2023 03:44:07 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id o15-20020aa7dd4f000000b00530a9488623sm2144543edw.46.2023.11.02.03.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 03:44:06 -0700 (PDT)
Date: Thu, 2 Nov 2023 12:44:04 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Ante Knezic <ante.knezic@helmholz.de>,
	conor+dt@kernel.org, UNGLinuxDriver@microchip.com,
	davem@davemloft.net, devicetree@vger.kernel.org,
	edumazet@google.com, f.fainelli@gmail.com,
	krzysztof.kozlowski+dt@linaro.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, marex@denx.de, netdev@vger.kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org, woojung.huh@microchip.com
Subject: Re: [PATCH net-next v4 2/2] net:dsa:microchip: add property to select
Message-ID: <20231102104404.c5vsnduro232jdoq@skbuf>
References: <20231024142426.GE3803936@pengutronix.de>
 <20231027063743.28747-1-ante.knezic@helmholz.de>
 <20231030174225.hqhc3afbayi7dmos@skbuf>
 <aad5ac41-3c05-421d-a483-0546b579585c@lunn.ch>
 <20231031072847.GP3803936@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031072847.GP3803936@pengutronix.de>

On Tue, Oct 31, 2023 at 08:28:47AM +0100, Oleksij Rempel wrote:
> Transferring these issues to KSZ8863, we might face difficulties configuring
> STMMAC if KSZ8863, acting as the clock provider, isn't enabled early before MAC
> driver probing, a tricky scenario in the DSA framework.

So for each driver, there are 2 components to using CCF for MAC/PHY
interface clocks, one is providing what you have, and the other is
requesting what you need.

To avoid circular dependencies, we should make the clock provider per
DSA port be independent of the DSA driver itself. That is because, as
you point out in your example, the conduit interface (stmmac) may depend
on a clock provided by the switch, but the switch also depends on the
conduit being fully probed.

Stronger separation / more granular dependencies was one reason why I
wanted for more DSA drivers to follow Colin Foster's suit, but I stopped
working on that too:
https://lore.kernel.org/lkml/20221222134844.lbzyx5hz7z5n763n@skbuf/

but in the case of interface clocks, the separation is not so clear.
I would expect that for most if not all switches, the interface clock is
implicitly provided by enabling and configuring the respective MAC, the
same MAC that is intrinsically controlled through phylink by the main
DSA (switching IP) driver. So we have 2 APIs for controlling the same
piece of hardware, I'm not sure how conflicting requests are supposed to
be resolved.

This piece of the puzzle is quite complicated to fit into the larger
architecture in a coherent way, although I'm not arguing that there will
also be benefits.

