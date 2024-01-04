Return-Path: <netdev+bounces-61646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3403824780
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 18:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E65D7B21614
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 17:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21A025549;
	Thu,  4 Jan 2024 17:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPkAexm8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8098D286AD
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 17:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-35fd5a13285so2210635ab.3
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 09:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704389554; x=1704994354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+8CCnAXJ3pT9UCkGC4rsKDHp1Rey2mb91m19tTflMhs=;
        b=QPkAexm8tCxbJuDqbPkKSoC3yM2p4oBBLNWhilGOfEU9lKbntiGCH99SOdf5/GrUqx
         BweZO86Yfv8VhSbnJ9rc0rNr1IBrN5ArDl5BvBjWLkhetrTy6lvEhptYzEnWTvthkAVU
         XH/Hlc9C35Kq8yw0pm3bQxJfLYwNnNwetiZnH6GzLmsQ2NXUMG2Wk7eVGQBUTHQJ7oK3
         V2wUojCKD2+uBLrvm+d4K7ifi/4t/8S2gcwC4Rnx4fUGsjgs4s+46fYm+rsKpb+u4Bj4
         tdUcgMW4wwBpndPyCs4rAYBaFxl1Jv1PfrpMV1u4E16Q6JAftbJ8mrwpbjQkgtvgwb10
         48fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704389554; x=1704994354;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+8CCnAXJ3pT9UCkGC4rsKDHp1Rey2mb91m19tTflMhs=;
        b=J8EK1DOu1grhsWwlW8XZA5h4VDE+7uRizQqZaKwAPcMj03i+Gcv2ZnMC/X1FPZpxDY
         ymf6vSD9+1o8yCwl5vaRqWEtIlCq7gqPsxoYEgVMqbPz1m8ANi0/J/pTNkU6zegf4qmZ
         3nu59HjkdZcMBaBCr7Eqx0KD6CF+FTszNjoZ9RYC3QPGq320pfY2xDDB7PkQ2zcgeq7a
         GlGNFHFtn4wsRiRDEzoHPNN4S8cz0K2PHNzJDxxjwvbZaTMcgV9E7UTQtg5vts6m4tI9
         BusrD5Xsn7Vvdc4q909araUAjYTS3TA3oQCQHANE/1p7tAMHTkA+r2Aw7eaUrTp9Tv27
         FUlQ==
X-Gm-Message-State: AOJu0YzjI5TPQ/M4+WQC5//BG0FpWUMLMdiubTo13dKqTTkgusP2qec5
	+PAlIu5haSYo1i1SZEfelAo=
X-Google-Smtp-Source: AGHT+IFYKOZwlge6ek5n+07e9t+/cCZ6JX6kE6XRfJkPA03PAAp2SF21FHJ6bClH0woFXkEV7ElFpg==
X-Received: by 2002:a05:6e02:219a:b0:35f:b106:9091 with SMTP id j26-20020a056e02219a00b0035fb1069091mr1000806ila.38.1704389554337;
        Thu, 04 Jan 2024 09:32:34 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id v5-20020a632f05000000b005c259cef481sm24489077pgv.59.2024.01.04.09.32.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 09:32:33 -0800 (PST)
Message-ID: <0c2531fb-309d-4b22-8a2c-33b8b3b85bda@gmail.com>
Date: Thu, 4 Jan 2024 09:32:32 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 09/10] net: dsa: bcm_sf2: stop assigning an OF
 node to the ds->user_mii_bus
Content-Language: en-US
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 Luiz Angelo Daros de Luca <luizluca@gmail.com>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Linus Walleij <linus.walleij@linaro.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Hauke Mehrtens <hauke@hauke-m.de>, Christian Marangi <ansuelsmth@gmail.com>,
 =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
References: <20240104140037.374166-1-vladimir.oltean@nxp.com>
 <20240104140037.374166-10-vladimir.oltean@nxp.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240104140037.374166-10-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/4/24 06:00, Vladimir Oltean wrote:
> The bcm_sf2 driver does something strange. Instead of calling
> of_mdiobus_register() with an OF node argument, it manually assigns the
> bus->dev->of_node and then calls the non-OF mdiobus_register(). This
> circumvents some code from __of_mdiobus_register() from running, which
> sets the auto-scan mask, parses some device tree properties, etc.
> 
> I'm going to go out on a limb and say that the OF node isn't, in fact,
> needed at all, and can be removed. The MDIO diversion as initially
> implemented in commit 461cd1b03e32 ("net: dsa: bcm_sf2: Register our
> slave MDIO bus") looked quite different than it is now, after commit
> 771089c2a485 ("net: dsa: bcm_sf2: Ensure that MDIO diversion is used").
> Initially, it made sense, as bcm_sf2 was registering another set of
> driver ops for the "brcm,unimac-mdio" OF node. But now, it deletes all
> phandles, which makes "phy-handle"s unable to find PHYs, which means
> that it always goes through the OF-unaware dsa_user_phy_connect().
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


