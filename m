Return-Path: <netdev+bounces-43945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D584E7D5891
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 18:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 115E11C208E1
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 16:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFDC2B5DB;
	Tue, 24 Oct 2023 16:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHOmlLya"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F713A268;
	Tue, 24 Oct 2023 16:36:40 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D32DA;
	Tue, 24 Oct 2023 09:36:39 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-41b7ec4cceeso29502671cf.1;
        Tue, 24 Oct 2023 09:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698165398; x=1698770198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JvTKMURH52PMu+L5w2Of9mflbcwT1+fb5UT7Km5ZrRA=;
        b=QHOmlLya9Sw4BfT92FP+/boLKEgbSyE8tf+FGQdnKeffb06klcOKd5RJBgGQGmrW6k
         R7s8iB84ATb/sh+wUPordJX9L8Jev5kaUrKGZ8snCXGqrDSoXfyFUAPxRYXfhviSS6H9
         5dDnea3ly6RLSc3qO2Gn5yyS+UM9/3qsn4220AcTQ2wCtupBeG2frq28SWEyrfUbTuIz
         KYTDqZlkroBtl6uGKC75ekY7YpZs+yK5VvTNgB4lGUdCmKi7GckaJ1SQ2Kd2d+RyhlhS
         ORNS+9c4wp6u6rlcahbokQVvZai1vgIvpYf5r1M2ymIWOWkQiK2qiB12hD2r5Wtxnp/a
         A8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698165398; x=1698770198;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JvTKMURH52PMu+L5w2Of9mflbcwT1+fb5UT7Km5ZrRA=;
        b=XX0E7buKJ4wCa0LRaOX7KAoVgMD1IuAqheRNXAXXXqRAoG43LKH8+lmeEpJ0ZDGfJ+
         XF3TSlfQEy0ViG9oBAvuOj2y/K991Ff5cSU0YAKLg0NKPcL6wPcUZrA1nxG0OwTbqoJ0
         lCEJyQ7ihMqfT5/AGDfGlRGX+rt/v0+8Y1N87RVBM8X0qeZPNa60leYZbA/Satub5mCS
         7ZWYiC5JPXjjhQ5ET8YADS3FAbenfSS8FWwtIgZVjxXfGoZ3jIZ6PLfjansi3Z0kBNJq
         Ulc5EzGiRJsmQnRX02/kOEXoUm30lwOWxDODVbFiScn/PhifiDA8Z60BS7CK9uAOzrW5
         e6zg==
X-Gm-Message-State: AOJu0YyUu69N4AssqC9bYdaShor6i211Ll3Q/O+zHZCL4daUneAUD8OR
	VTgwuSprdl3ZlgYBc7lt9+TkLdo3a1k=
X-Google-Smtp-Source: AGHT+IF5c1R2mVDESBuxmE8cWZg8DgJbJQU8a+DvBNUq+xlwThchQXQ4SQDmphZ8OCPgi+xTSxuQXA==
X-Received: by 2002:ac8:5785:0:b0:41e:2d77:c727 with SMTP id v5-20020ac85785000000b0041e2d77c727mr1914748qta.29.1698165398545;
        Tue, 24 Oct 2023 09:36:38 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id h21-20020ac87455000000b00419b094537esm3590812qtr.59.2023.10.24.09.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 09:36:37 -0700 (PDT)
Message-ID: <83819717-22ea-4cdc-a112-f3c5c482690b@gmail.com>
Date: Tue, 24 Oct 2023 09:36:35 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 4/7] ARM: dts: nxp: Fix some common switch
 mistakes
Content-Language: en-US
To: Linus Walleij <linus.walleij@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20231024-marvell-88e6152-wan-led-v7-0-2869347697d1@linaro.org>
 <20231024-marvell-88e6152-wan-led-v7-4-2869347697d1@linaro.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231024-marvell-88e6152-wan-led-v7-4-2869347697d1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/24/23 06:20, Linus Walleij wrote:
> Fix some errors in the Marvell MV88E6xxx switch descriptions:
> - switch0@0 is not OK, should be ethernet-switch@0
> - ports should be ethernet-ports
> - port should be ethernet-port
> - phy should be ethernet-phy
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


