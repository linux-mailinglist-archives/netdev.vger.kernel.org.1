Return-Path: <netdev+bounces-43947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7477D58C0
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 18:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20E7AB20FF7
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 16:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2893F339AA;
	Tue, 24 Oct 2023 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVWeL1Dd"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EA73A293;
	Tue, 24 Oct 2023 16:39:53 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DC4AF;
	Tue, 24 Oct 2023 09:39:52 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6934202b8bdso4523242b3a.1;
        Tue, 24 Oct 2023 09:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698165592; x=1698770392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OL5bDK50tcs98bZIleCwvDnVh2k3MyUg3yarFjzHcSw=;
        b=hVWeL1Dd+UPj8g/YMkmwBJOgk6Y8DKA5IOpkFX2skPoJig9op1ifScX3VSiFYetnyG
         TrSm8pwn9uk5EIUkv1AypxqEL96WVdZJ8ldKeMefC+cP4jhnCYXtknzVLE7u2R91j0Uf
         2st60vadqSrcSqWi0wueqFuQ8IbkbRcmG48kyM54BujCm06SCsh0xq88d0aniluhFChQ
         j86BX24Q6vOoidXsdBZVQATdqh2IGwNB8uVnDem5VYPBA1QxN0hloR7gXEkukcmJZ/5F
         UZAnTg1Agqm6NcE/0spZDmB38v2UfiABCuazejT41pJw/yWKb4LCkj+oeTUtJWySI81y
         e1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698165592; x=1698770392;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OL5bDK50tcs98bZIleCwvDnVh2k3MyUg3yarFjzHcSw=;
        b=GPidpyhng7/X1FEuPqL61rMyGhc+IYYH7WMrC1SKI0myuIxqYrnJrfW3OjTfI0OTi/
         fNQNObNO3Eqya0mWrLADhROAPHrNzanQPPF3W+OW+orpZGpbjK982JeY6owoASrcPdlg
         v4+8WZNbjmMml0sftPNvGf4QxVUDGgOSsgxTk4W1jhzu5iwfYS6lcQD+EdxjGivXJinW
         EydtV05iGUWmrqGBbBh7TtCUKN7dNLHnPbB9LK3aO5SJSZwxnzssjV8lcvlk9iB7D/1w
         dti0nNbFwqTMkIrRXPb8+ZX0KB5L2Z/8hJT7AuCJVAIrE/sNJ0eDUtqvsm8OKo3dxNCA
         RedQ==
X-Gm-Message-State: AOJu0YyWgC+k8v8URGNaUh1Sa91diwRv6r5cs+y3gIIDvgr8tpdUX7/Q
	OvNtwgAj7ufGpbLH/Kjct3M=
X-Google-Smtp-Source: AGHT+IGjSp2xMB0kdvOO22CTete4leUwfMXgErxoo1qdo7bIOCnwya+gLJVlsKJBmvTmkZtA4fR3tw==
X-Received: by 2002:a05:6a20:5486:b0:16a:b651:dcd6 with SMTP id i6-20020a056a20548600b0016ab651dcd6mr3401523pzk.7.1698165592243;
        Tue, 24 Oct 2023 09:39:52 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id r3-20020aa79ec3000000b0063b898b3502sm7798480pfq.153.2023.10.24.09.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 09:39:51 -0700 (PDT)
Message-ID: <8f19496a-b809-4ba6-a5b5-f8dadcf4bcec@gmail.com>
Date: Tue, 24 Oct 2023 09:39:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 6/7] dt-bindings: marvell: Rewrite MV88E6xxx
 in schema
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
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Rob Herring <robh@kernel.org>
References: <20231024-marvell-88e6152-wan-led-v7-0-2869347697d1@linaro.org>
 <20231024-marvell-88e6152-wan-led-v7-6-2869347697d1@linaro.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231024-marvell-88e6152-wan-led-v7-6-2869347697d1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/24/23 06:20, Linus Walleij wrote:
> This is an attempt to rewrite the Marvell MV88E6xxx switch bindings
> in YAML schema.
> 
> The current text binding says:
>    WARNING: This binding is currently unstable. Do not program it into a
>    FLASH never to be changed again. Once this binding is stable, this
>    warning will be removed.
> 
> Well that never happened before we switched to YAML markup,
> we can't have it like this, what about fixing the mess?
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


