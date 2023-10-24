Return-Path: <netdev+bounces-43943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6327D5887
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 18:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA87A281B29
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 16:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB9B2C864;
	Tue, 24 Oct 2023 16:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frCqSOdk"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49683A276;
	Tue, 24 Oct 2023 16:35:53 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F1C10D3;
	Tue, 24 Oct 2023 09:35:48 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1e9db321ed1so3022299fac.3;
        Tue, 24 Oct 2023 09:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698165347; x=1698770147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SiXjd3lHwNlG9XfDOV60tOj1eqCKqaJ2kyB26qez8OM=;
        b=frCqSOdkUMMr8lnRp2Oq0TFfNe20phpJ77WFeXG2DgL5dqPIepB06UicIkYahI9BU8
         O1oYl0XBccb+zUxMQrPF+thbt2jk15o6boUQVBPgEJdbpsRu9RvCljhX3EX/1mkVnT/v
         /HjhqJlXGtrsX4oDsDl/J2uYEwhlhS6zPzo8uilO7vw8UYE4aZQ3GvNaHDBKkmcpGkXk
         h5TCjcIJpTh4tm0gidJuiEW648x49zzXvb8ZQdl7sgGr+arofSf3fKghd4s9PSVjE5+A
         JuUnT7bhthf9fNVtxgfbufkgM/2DwMVomZrdLk99RITE6+yF+RQi2npKN3ETnePyl48a
         kQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698165347; x=1698770147;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SiXjd3lHwNlG9XfDOV60tOj1eqCKqaJ2kyB26qez8OM=;
        b=F9Y9X2uJfw99Ldo7tQxBqgQkzuZqN5Z36L42gfanv3pbk21DXxwemOEuKpQBR3/POf
         j1QJZPA1NcmvB/MzzLLMZeeTCpqXqwx4xeAWUXRA0Mw5zuW8zUdEUq2PM73gaRWyo8iv
         hA0AXSJwlZBVNE4yHeV8oSVC4a3QjAGL0KsBXh1ZaYS/pV0SOf0X+NIklmQGUO6h2g3H
         tQyR+yF2yMpRTEw3zSfNwPqXG8QZnjJo1Nan7FO2FeXtfg0lGUhs/Hdx/QUPqlFjeyzO
         J6A3Xa7/+5yZWigjEO/G3QkVa663kCTrOs7r/KTDOi01A69egss3tSguqwf06Cm9902v
         /SzQ==
X-Gm-Message-State: AOJu0YzDID+sh/bDKq4KUTAT/psfjYJ/6Kgk99BR/Qwlg504enCAzJcG
	ahYebF5OSghlM1MImiO/oSM=
X-Google-Smtp-Source: AGHT+IGh4XoHnDdrZEGGp4zKLTmH/Z3m9UGgy7G1efFlfEu4YEVYuOWG8XIlt3pU1FFl6x9zkulRbQ==
X-Received: by 2002:a05:6871:520e:b0:1ea:3525:9ed5 with SMTP id ht14-20020a056871520e00b001ea35259ed5mr15300300oac.57.1698165347474;
        Tue, 24 Oct 2023 09:35:47 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id h21-20020ac87455000000b00419b094537esm3590812qtr.59.2023.10.24.09.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 09:35:46 -0700 (PDT)
Message-ID: <885ec5bd-9c0e-4c03-9347-f88e29c5691c@gmail.com>
Date: Tue, 24 Oct 2023 09:35:43 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 3/7] ARM: dts: marvell: Fix some common switch
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
 <20231024-marvell-88e6152-wan-led-v7-3-2869347697d1@linaro.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231024-marvell-88e6152-wan-led-v7-3-2869347697d1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/24/23 06:20, Linus Walleij wrote:
> Fix some errors in the Marvell MV88E6xxx switch descriptions:
> - The top node had no address size or cells.
> - switch0@0 is not OK, should be ethernet-switch@0.
> - The ports node should be named ethernet-ports
> - The ethernet-ports node should have port@0 etc children, no
>    plural "ports" in the children.
> - Ports should be named ethernet-port@0 etc
> - PHYs should be named ethernet-phy@0 etc
> 
> This serves as an example of fixes needed for introducing a
> schema for the bindings, but the patch can simply be applied.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


