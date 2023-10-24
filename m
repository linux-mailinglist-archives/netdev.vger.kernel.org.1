Return-Path: <netdev+bounces-43950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 934557D58D4
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 18:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C43F01C20CF6
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 16:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DFE37176;
	Tue, 24 Oct 2023 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y93CTfkd"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9CF3AC2B;
	Tue, 24 Oct 2023 16:40:26 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36F310E0;
	Tue, 24 Oct 2023 09:40:21 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6bd32d1a040so4634978b3a.3;
        Tue, 24 Oct 2023 09:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698165621; x=1698770421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=31F3WOynZ5m4GHq6NUu2sQx3qyYWIuGHHZ5aY5Fy/F4=;
        b=Y93CTfkdOlWZbawf0TKc+E5ZgZDFTxeboilcdwqUeDDj19OYZ9/9MXPqJARNoyzMtX
         g7UxufmYjXfAoF202OUj4HvhYy/BItAC13RQrX/3pNVA3SX0/I2/KofIsPnKI8s0WbeS
         SrgJ43amqtu2DTCtdFdeAC//fkSx2T0dvw4ZWR5vaHqKOFqp5c6gRl5EEgZjdBUQw9HH
         e9rZdMe0GzN1MKtt2kxqVHmVmqtKAQqNZ/iMFKyOclIvrTnKp1gErfQw9IBf2UkVV1TU
         uYCshMk4d+4VoTPZvU6Nh+OPmVRGS4b/SDA5gllopEHmXHRW6iTVoroLeKchp+cA7e9H
         vPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698165621; x=1698770421;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=31F3WOynZ5m4GHq6NUu2sQx3qyYWIuGHHZ5aY5Fy/F4=;
        b=UBKlZIp8MS/4qjXrEygBsVQGtp1bfB6RVaZ2cDF2tvz3pJwKzYpg+p+Bv2fMDy3ANo
         skk6h0GZxOzO9Ig69IhWLork/fuGwIk3Dgi1OyVaJpLSQcWV8C51jtC4mg9+C96dk1GN
         s6KHxBuP2c+7OQrg8vkkAsTcSk7BsCyY+9KqugOo4yr3mYGyOKs+XxHOjxaI/hOPUcFz
         dBohCR7mnV4kKxYuVnYhmGDWF3l8idpKT9VGLlGZcaewnEWKpbOx8XCRzZlFPRkQDGyc
         stMlpegMRcSBTLG4pod/dFMJ0N8WHpB1VfLDrms7k338LAkCV7ONH0BEqvXkcTuAgug/
         NYOw==
X-Gm-Message-State: AOJu0YxVBMDMvrEfWsP7d9HlVWiRyCSIh3/mUddX/kKx8I9IdQ+WA3uf
	fTfvAZvxPDmDtCPbvnnuVvw=
X-Google-Smtp-Source: AGHT+IEXKKh0kgPPui7KSu8xTVHCM9yLkKv5aloD9D4pg3Ynr9RXsCdtfwdf7u+niH5Ory+Omdym0w==
X-Received: by 2002:a05:6a00:84f:b0:6bd:b3b9:649f with SMTP id q15-20020a056a00084f00b006bdb3b9649fmr14667102pfk.7.1698165621032;
        Tue, 24 Oct 2023 09:40:21 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id r3-20020aa79ec3000000b0063b898b3502sm7798480pfq.153.2023.10.24.09.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 09:40:20 -0700 (PDT)
Message-ID: <839809ac-e16f-4683-a6ec-14dcf2ff5990@gmail.com>
Date: Tue, 24 Oct 2023 09:40:18 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 7/7] dt-bindings: marvell: Add Marvell
 MV88E6060 DSA schema
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
 Vladimir Oltean <vladimir.oltean@nxp.com>, Rob Herring <robh@kernel.org>
References: <20231024-marvell-88e6152-wan-led-v7-0-2869347697d1@linaro.org>
 <20231024-marvell-88e6152-wan-led-v7-7-2869347697d1@linaro.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231024-marvell-88e6152-wan-led-v7-7-2869347697d1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/24/23 06:20, Linus Walleij wrote:
> The Marvell MV88E6060 is one of the oldest DSA switches from
> Marvell, and it has DT bindings used in the wild. Let's define
> them properly.
> 
> It is different enough from the rest of the MV88E6xxx switches
> that it deserves its own binding.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


