Return-Path: <netdev+bounces-184089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40183A934CC
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 10:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE331B6189D
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 08:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3C226E164;
	Fri, 18 Apr 2025 08:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="UNW2tfwC"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3BEFBF6;
	Fri, 18 Apr 2025 08:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744965870; cv=none; b=W9x/dN01bYeKXvsIJeqnO81p9qk3n9EVXxlHL21ZVvU7XA1tu4ZdIf2MPjFcZbBEXtEDUPcKkZ+zGWXEpDNPsNeKZulmIG9qmZWBNQbXBZ91WUmLoOOnJSujNfFS6RDMwJFp03OqsCT1/Wy72BkhfekcYIiAoz0OGgdJmN9136w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744965870; c=relaxed/simple;
	bh=8zXkVO/L/HV+fnApmnOg4jqoQW+6ALcgNwo09wyCcY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HP2IG8jpoei+CAqPhNgHYjMLLFtgrjatEz/qjVaOEdFa8cfsDShX+tzR2mpmXmbtI4y7NSSkezAVyOCA8SGQ4WbSakf4nuytjFaUGWDRT7b/GXWhlAIrCqS1X8Ba4mAKnbEi4oi3TqRnsr2OCLI4TncbXYOzQVLt2Nh83BwnrjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=UNW2tfwC; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1744965855; x=1745570655; i=wahrenst@gmx.net;
	bh=8zXkVO/L/HV+fnApmnOg4jqoQW+6ALcgNwo09wyCcY8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UNW2tfwCXPBYNAbHzwcDzF4BQAPUpaxJ+a/RpTdrKNJGGP4BDGmtZPR9maqTdn3u
	 BNkI4JpXgVvYCHfwzhDYYcvTTE9QLFvtrZBwbMdddgJr3Wso2ngvqo1d3lyYnHWaA
	 nf+MTdqaB6KQbCs9UPxxmFp2DOxfczQoGYDacV84DhxN5kfyGgRWIxPG+UEJlFGjs
	 X7GxU4FPLk0geMibU3PAMlHtalAWwKxgKaWCmBnIgSJmXQ9GocnWS3X8z8PMPfNuz
	 +mZXBcsYd7vcZwnXhE4XO61riOMCDJN2yhjQ7MhA4ng5/LGceWwu7XuKH8a7HlYw5
	 Nk2B3jf6LEfjH7PUQA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.107] ([37.4.251.153]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUowV-1uWTWh3AYL-00Oj6t; Fri, 18
 Apr 2025 10:44:14 +0200
Message-ID: <38f36d00-e461-4fc5-a98b-9b2d94d93c69@gmx.net>
Date: Fri, 18 Apr 2025 10:44:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v6 4/7] net: mtip: The L2 switch driver for imx287
To: Lukasz Majewski <lukma@denx.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Simon Horman <horms@kernel.org>
References: <20250418060716.3498031-1-lukma@denx.de>
 <20250418060716.3498031-5-lukma@denx.de>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20250418060716.3498031-5-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:k39CviP8heJ+cbDTMlGNDWVxe30Oaz+7P6chPR/R4ICdRZqNw+z
 w/zCZFcy4g1D1pCDNzXJ05yHw2NoXY3FmqmnVJS+ZIpegbzfb/8aj+oTJlX9MoiQUrPqIAT
 md+AvrcLreCrD0JB1ijeWbeTtc5pRxBGmSYlS/nhAYIC+1aCK7jEUKnHh9RWOuz/3NHDFfg
 srlKEG0AK00xezPEj0mZg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8h78fwPHcSI=;S13FLM+D4E+XSp5tNWT+4GFFIAZ
 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
 bLmAa+pF0qfXl7xORUobqIvNwRxCK8k=

Am 18.04.25 um 08:07 schrieb Lukasz Majewski:
> This patch series provides support for More Than IP L2 switch embedded
> in the imx287 SoC.
>
> This is a two port switch (placed between uDMA[01] and MAC-NET[01]),
> which can be used for offloading the network traffic.
>
> It can be used interchangeably with current FEC driver - to be more
> specific: one can use either of it, depending on the requirements.
>
> The biggest difference is the usage of DMA - when FEC is used, separate
> DMAs are available for each ENET-MAC block.
> However, with switch enabled - only the DMA0 is used to send/receive data
> to/form switch (and then switch sends them to respecitive ports).
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
After changing the IRQ name part mention in patch 1, you can add

Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

Thanks

