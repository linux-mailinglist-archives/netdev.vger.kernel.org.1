Return-Path: <netdev+bounces-150371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C74F19EA040
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 21:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 029F1281FB6
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 20:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C569F199E84;
	Mon,  9 Dec 2024 20:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="K5UAnZH9"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8AA137930;
	Mon,  9 Dec 2024 20:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733776118; cv=none; b=qWJrq56Q1VlIaVBA2gquFwv/b7OSfSFMNx8oTkw5DueWSHBUri0r/XuOhDwA5f33h3+Jw1CQ3l5gh3xaimAX8SIbuJxeFCygOxbDQRG2MpUSB+9e3Z4+InenGjotTx3Ckqn9GXl0NiI19LE2y9V1vePXwaHI43665KJ4SLPX46Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733776118; c=relaxed/simple;
	bh=7QuADeCtgt+7r+IcVHoHNyONh5uPvUsN9FpSQmaPdnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mv7bW06IVSBg6sVcpTIvY+lmqyZwWcDr6PoaVA8NLGkaux1iM8gJ04eAv/vFeWEvAA9J5Z2H3zejEbFOaOQeFhWzSb9pOE1aGTt16P1vlgmIVNnSzXgvNnWTDXY7wuJw4CLqPdxmOavYQ8G1s2tC/sXgSKG3oM4AOmTUZvWY5fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=K5UAnZH9; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id B56C4896DC;
	Mon,  9 Dec 2024 21:28:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1733776115;
	bh=kqO+qNbDaASSZD90mwuR3nDdiSgV1rdKf5IacQWABfw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K5UAnZH92iSt5h18mJFDi2BIlgZM4u5RX5pCm2fDA5IdD56FLX4J7CPiKzTaiMTzU
	 C9yarRvwdNGQ4U77Q438qJyKksc3i+7GbHkDQhmOcUvaInLToawsFixTYjkvL4RlcD
	 g1DoTWnz2VN5ADhu7lkIl4DE20wIUOYazQ3/jbqNi1NbJYwmq7xN0LDxbUQ/Dm+5lz
	 LAxukatO1lHTXqkKTUuBduUpcHTaj8sr0DUuuxGCR3ljC9bMWd2gwXfF39gSX5Pu3j
	 350UAWOyECt46M7Qd1VwdQKjsNmf5ApZOBl3jcQYlvleBmz41qF3jCJv/6hWNcLdcQ
	 746ZFjtsg23NQ==
Message-ID: <c970bdbc-5831-470c-9040-b37c4f76baf2@denx.de>
Date: Mon, 9 Dec 2024 21:26:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] net: dsa: microchip: Add of config for LED
 mode for ksz87xx and ksz88x3
To: Andrew Lunn <andrew@lunn.ch>, Fedor Ross <fedor.ross@ifm.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Tristram Ha <tristram.ha@microchip.com>
References: <20241209-netdev-net-next-ksz8_led-mode-v1-0-c7b52c2ebf1b@ifm.com>
 <c934f10d-1a75-4ca8-bd0b-f08544c7d333@lunn.ch>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <c934f10d-1a75-4ca8-bd0b-f08544c7d333@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 12/9/24 7:22 PM, Andrew Lunn wrote:
> On Mon, Dec 09, 2024 at 06:58:50PM +0100, Fedor Ross wrote:
>> Add support for the led-mode property for the following PHYs which have
>> a single LED mode configuration value.
>>
>> KSZ8765, KSZ8794 and KSZ8795 use register 0x0b bits 5,4 to control the
>> LED configuration.
>>
>> KSZ8863 and KSZ8873 use register 0xc3 bits 5,4 to control the LED
>> configuration.
> 
> PHY and MAC LEDs should be configured via /sys/class/leds. Please take
> a look at how the Marvell PHY and DSA driver, qca8k driver etc do
> LEDs.
According to KSZ8794 datasheet, this register 0xb is Global Control:

Register 11 (0x0B): Global Control 9

So this does not seems like per-port LED control, but rather some global 
control for all LEDs on all ports on the chip ?

