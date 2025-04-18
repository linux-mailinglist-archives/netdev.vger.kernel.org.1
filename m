Return-Path: <netdev+bounces-184096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0A1A9351D
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 11:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F299517357B
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 09:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBABA26FDA2;
	Fri, 18 Apr 2025 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="eczCAv+a"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A47826FD82;
	Fri, 18 Apr 2025 09:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744967350; cv=none; b=MMn75mH6QvJ/YgxshcdPTlxl1AC29rKA0/raFZDajg+xCNLR+fCk9x413aEV7VoaK4NN31O+yI+u4V1WJzyNT6FFBcobJW4UIqvbM2J1/+M9kPIljw/VVe2vyHoIUhHfcESl7iQ7mpWQVTP/Xwb5x3684snuK5X/e11lfOsnPQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744967350; c=relaxed/simple;
	bh=VCWX9TW4R/j67PiZzSFd7CI7wtEGCBJKfWgcfm/BQBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VlPB2ANOctDRs+exq6jP2DpVj63+yDUBCIS61LdN5pezZOvRb0XFHb3eVuWX279Ik8IwsMsssq9zEWkFGl6mDTammfaCHr4YgEUW++q5ZLQu4iXyhhwNRZ/HXcMr5CApWl7IEtB6yt8QFOYnUhNX8nPKGys6/YCGVt8eE/FL8Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=eczCAv+a; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1744967327; x=1745572127; i=wahrenst@gmx.net;
	bh=5FZc7ijLzZ2awcKizBx2RPk4e1oOriMZYbJpema2nnI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=eczCAv+abhgWdoxy1Mix0q/m/ZnqSJ0yy6kYtW0DccEKlpMK1bIQxK4g+eVhjayf
	 92IyDLfb5bm9U2b2SQtyQ9UkMq5QkhOZ7+vLRk8d0Yn10wQgUEmWwV/W3Toucp1EA
	 2hN51ishKi3DY/mp9cTF8sg8H0ZmakW2gvxNTNtY765ty4bg1a4RQivEFNzhctToK
	 EyaiEIvlZc0paBssbqDFoY0lauA79cZ+e01T9SGMM1FePAfxQPOsW5QxyKLD+Rlz2
	 Kx/51ajcHnp5eMWp92Scf3rQMpmV/4p+Szny+M7JzuspZybzUfjG8l2epaxmkvRT/
	 Sb26sbd94gt/0AgIhQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.107] ([37.4.251.153]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7zBb-1v9eAv3w8p-011UvF; Fri, 18
 Apr 2025 11:08:47 +0200
Message-ID: <a137daef-8a09-4899-a6e2-380b8ed6061f@gmx.net>
Date: Fri, 18 Apr 2025 11:08:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v6 4/7] net: mtip: The L2 switch driver for imx287
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Simon Horman <horms@kernel.org>
References: <20250418060716.3498031-1-lukma@denx.de>
 <20250418060716.3498031-5-lukma@denx.de>
 <38f36d00-e461-4fc5-a98b-9b2d94d93c69@gmx.net> <20250418110223.594f586f@wsk>
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
In-Reply-To: <20250418110223.594f586f@wsk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:kS0UagTK8PoQnNEVtIOjGWpVgZgAq2O+D9TGo1zAnTtvyzwaiH3
 uXUWIVLE7mVrJZO5stgbME0xxiVaagxiUFgghMEOc652iRQVo6TbQzDTSheldbiAGvPYXVM
 Q68wyqYDoilc6hLfJlHs62mANwnTN/aJrTbb2PIOGaFpy9B7FsBS5Oq2fSaexxnykKfkLze
 5FdSTbke3PNpnmINhv1PA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3NBNlW/Hmh0=;wauUYAffRTWEjRv+TI+uG33zAoU
 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
 L0d1fZBtYNknfs24UweW9fZU+vTOKmU=

Am 18.04.25 um 11:02 schrieb Lukasz Majewski:
> Hi Stefan,
>
>> Am 18.04.25 um 08:07 schrieb Lukasz Majewski:
>>> This patch series provides support for More Than IP L2 switch
>>> embedded in the imx287 SoC.
>>>
>>> This is a two port switch (placed between uDMA[01] and MAC-NET[01]),
>>> which can be used for offloading the network traffic.
>>>
>>> It can be used interchangeably with current FEC driver - to be more
>>> specific: one can use either of it, depending on the requirements.
>>>
>>> The biggest difference is the usage of DMA - when FEC is used,
>>> separate DMAs are available for each ENET-MAC block.
>>> However, with switch enabled - only the DMA0 is used to
>>> send/receive data to/form switch (and then switch sends them to
>>> respecitive ports).
>>>
>>> Signed-off-by: Lukasz Majewski <lukma@denx.de>
>> After changing the IRQ name part mention in patch 1, you can add
>>
>> Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
>>
> Shall I add RoB tag to all patches?
In case you mean Reviewed-by: yes
>
> I will wait for ACK from at least Andrew and then reset the v7 with all
> tags collected.
>
>> Thanks
>
>
>
> Best regards,
>
> Lukasz Majewski
>
> --
>
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de


