Return-Path: <netdev+bounces-51943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F32147FCC73
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 02:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5093FB214E2
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 01:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973451FB2;
	Wed, 29 Nov 2023 01:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+nEpHp7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6AC10E2
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 17:57:14 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-332e40322f0so3870794f8f.3
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 17:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701223033; x=1701827833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5k+P5Jds5m1AANN0TWo1kV1u+EQQ8SW3QQSlFLz2l20=;
        b=f+nEpHp7PKifSwiO4TKV3jDtXJi42qu5NL7xCQOv4sdV+VOJ1LyrigqJOAANqWNChB
         TFybvP/Q+B/qZIEtaaPvR200WIHrBMlNqnX+11fym3ZeNzm0qx4ZcoGF13VBQC89DnFm
         IVHCzkeagogA58R5We0RJHt0feH0o+p2QrNYatQR+AuOaEjoxJWyvmjr+dYasGz7D8Iu
         BjFm5Vk9PDxPQlPZHwX3nhTWmSSYpVIc2EZZ3QkuoMbxejOSm220pbDNRNug9KVRkK2q
         r2UhOk52geeVSDxQJUNLWg6L+PVygzzUh+QzQpMtFLZHebNldPlnBnfYMAmc3lEu73gg
         QfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701223033; x=1701827833;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5k+P5Jds5m1AANN0TWo1kV1u+EQQ8SW3QQSlFLz2l20=;
        b=kUtzUp1tJuCntjKkmDpBrVn64J6TRUuA5adXCmKUuV2qQRQiM9LpMtUNK0PPLGYDTh
         PZJK6jl1/+5egS935BBafcLmUj+1nP+x9d9GBRfPfkIFoo2oZ2/WoptaN8ysWsV7t1Gg
         s4jk774sSZN9evJ90Lr+tJOHy0Tvwyz67rJbFjeX2osvQN/OmLl9Y9+blHKX8cLaoJZb
         dz/z96tOsrpbOmJUXKsnvhc5ZQs2NkqW6tZKJ37jhaPwZf9EbUdUXbXlcPSjc3JBotwM
         53KswIBZglRXIf2FJpIfxe5mT5vTU35iiGc1ygSlM1Y0UVfqJHXFsO4CoIf5RSZN5Xpk
         M3EQ==
X-Gm-Message-State: AOJu0Yw9stC8xnZmw/WJ400w7n7KppYfeQsC05o9lr43Rri/AY2jaUMR
	j/o9mzImyNs3SXgWN6TvDq92O7b5ZDY=
X-Google-Smtp-Source: AGHT+IEYnkBVxZhn7EjCabxcgdRNOEJMjnlYbenfS3j/h4s8ekVjwNezaSEKJrQ6hJThkfRX5IS2LA==
X-Received: by 2002:a5d:5966:0:b0:32d:9a20:c9e0 with SMTP id e38-20020a5d5966000000b0032d9a20c9e0mr10078619wri.61.1701223032971;
        Tue, 28 Nov 2023 17:57:12 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id u7-20020adfeb47000000b003330a1d35b6sm3800320wrn.115.2023.11.28.17.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 17:57:12 -0800 (PST)
Message-ID: <65669a78.df0a0220.ed934.f001@mx.google.com>
X-Google-Original-Message-ID: <ZWaad4li5KCqR7dd@Ansuel-xps.>
Date: Wed, 29 Nov 2023 02:57:11 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev <netdev@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH RFC net-next 0/8] DSA LED infrastructure, mv88e6xxx and
 QCA8K
References: <20231128232135.358638-1-andrew@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128232135.358638-1-andrew@lunn.ch>

On Wed, Nov 29, 2023 at 12:21:27AM +0100, Andrew Lunn wrote:
> This patchset extends the DSA core to add support for port LEDs being
> controlled via sys/class/leds, and offloading blinking via
> ledtrig-netdev. The core parses the device tree binding, and registers
> LEDs. The DSA switch ops structure is extended with the needed
> functions.
> 
> The mv88e6xxx support is partially added. Support for setting the
> brightness and blinking is provided, but offloading of blinking is not
> yet available. To demonstrate this, the wrt1900ac device tree is
> extended with LEDs.
> 
> The existing QCA8K code is refactored to make use of this shared code.
> 
> RFC:
> 
> Linus, can you rework your code into this for offloading blinking ?
> And test with ports 5 & 6.
> 
> Christian: Please test QCA8K. I would not be surprised if there is an
> off-by-one.

Good news! I tested this and with the requested change, the thing works
correctly.

> 
> This code can also be found in
> 
> https://github.com/lunn/ v6.7-rc2-net-next-mv88e6xxx-leds
> 
> Andrew Lunn (8):
>   net: dsa: mv88e6xxx: Add helpers for 6352 LED blink and brightness
>   net: dsa: mv88e6xxx: Tie the low level LED functions to device ops
>   net: dsa: Plumb LED brightnes and blink into switch API
>   dsa: Create port LEDs based on DT binding
>   dsa: Plumb in LED calls needed for hardware offload
>   dsa: mv88e6xxx: Plumb in LED offload functions
>   arm: boot: dts: mvebu: linksys-mamba: Add Ethernet LEDs
>   dsa: qca8k: Use DSA common code for LEDs
> 
>  .../dts/marvell/armada-xp-linksys-mamba.dts   |  66 +++++
>  drivers/net/dsa/mv88e6xxx/chip.c              | 103 +++++++
>  drivers/net/dsa/mv88e6xxx/chip.h              |  14 +
>  drivers/net/dsa/mv88e6xxx/port.c              |  99 +++++++
>  drivers/net/dsa/mv88e6xxx/port.h              |  76 +++++-
>  drivers/net/dsa/qca/qca8k-8xxx.c              |  11 +-
>  drivers/net/dsa/qca/qca8k-leds.c              | 255 +++---------------
>  drivers/net/dsa/qca/qca8k.h                   |   9 -
>  drivers/net/dsa/qca/qca8k_leds.h              |  21 +-
>  include/net/dsa.h                             |  17 ++
>  net/dsa/dsa.c                                 | 190 +++++++++++++
>  11 files changed, 620 insertions(+), 241 deletions(-)
> 
> -- 
> 2.42.0
> 

-- 
	Ansuel

