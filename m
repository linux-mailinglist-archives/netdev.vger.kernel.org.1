Return-Path: <netdev+bounces-178647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E387A78083
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 18:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06491651E4
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 16:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E065204C02;
	Tue,  1 Apr 2025 16:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="KgHXM3g3"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE41C1519B8;
	Tue,  1 Apr 2025 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743525193; cv=none; b=LGDtvj+Vq9nNNbku5mvHZjDxvbfDdMAS1IPk5nttTWnM7d7JWdr0F/xfzHxjD2rhE0kCUQedxtr9Fv1Yv4egXOu6zulVSxq+r8psS6IQ9rduSeKlbqaiogH3THT7lB01xOrnZi+AwEsiiCV9FS598/lboc8behUSj9QGIdgaQf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743525193; c=relaxed/simple;
	bh=HBV3OATyBLffFwvC9GNpwqJ+RXlCjrFh9WfrEBF2cPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kTb/nBnfQD8x+WKONzzc9D3urP+F5CHSJcUXVsp1fae/rND4EY2rHVicOmZ8Bki8NsbJyG1NTR5HkbJ6+Z4OATx23hmZvRCmPP8pvQc9+ZMKsFwjKfx3ER6PmznEdnQK5o/JarqNkDokn2l7z+UEJGUPIC4Dvtj7QjUM+FIyHJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=KgHXM3g3; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1743525185; x=1744129985; i=wahrenst@gmx.net;
	bh=HBV3OATyBLffFwvC9GNpwqJ+RXlCjrFh9WfrEBF2cPU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KgHXM3g3wvKkus+hNzDX4KqqdHvpya2UPFML7PmBqacNzT+gp90UKidMdhQpqice
	 41kWym4I6DRCuXDGEBDgMeJR0qroOq16ROVzr0xgtX/65dLRblNT3hfYSjD8VBXIq
	 S76KUVz9uuWqisaKiqX7aaGOs2RKzBG0WpOh5a0lMXp0KpN4h7RpRHurXUjB4AOUs
	 ZbvJzZYjcS0NIe0d8hjAdM80FFwutYZu4bju+4M2GfmFhzQCAb/2GErcZ6CwA3zD9
	 yCCaJeStIY3yZdOL7Gd60h4YmFEYJyk/e5eVuKxEfkvWl5ha5N9KvxHntyrxbtmy5
	 crLEEtpZs2vXZc+fhA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.107] ([37.4.251.153]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdvmO-1tQ2cB2W0M-00ljrU; Tue, 01
 Apr 2025 18:33:05 +0200
Message-ID: <3321314e-7a7f-4d7f-9a9e-6325515dc54c@gmx.net>
Date: Tue, 1 Apr 2025 18:33:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] net: mtip: Add support for MTIP imx287 L2 switch
 driver
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20250331103116.2223899-1-lukma@denx.de>
 <20250331101036.68afd26a@kernel.org> <20250331211125.79badeaf@wsk>
 <ec703b87-91a4-4ed0-a604-aceb90769ab0@gmx.net> <20250331234228.5d8249ac@wsk>
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
In-Reply-To: <20250331234228.5d8249ac@wsk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:68p8hz1F08ZmKCxbkhgcqwkIdROGb+6sGIkTANYH8O7UQdh0Oua
 eeiOaVLGDtFm9vAyJ/dCjGDI3wReTJlo4Gl0jw24kaN+nedqhpWmi9Q8Y4xrCma/cDAOWoC
 N+inzLFLNuUNjkOTteQ9kcCA97oiH+1alEEIarJU4maY/l8XQL9vWvhEW5kTe93Qxe9P63b
 VJfeWo+HiKpA5OZkgEEGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VqfWaRwx+Hg=;Fvssj492yIuTEIYQDlpSfvdmJhp
 xQA5iGGsE+WReEIKKpJcXwTZzPa0DHxxWkKg5gq2m40q4cHtuC0qzbER57LiN7X7IFXYdHCir
 8qxY5rxON4iixQk+tiBdcA3O5OZLOhbhipuzyIwT3MszLrXTF7ITHEIpJD0UzW3JApTgYSRcY
 Qq6009tKfOt7Hl/7PwgExj1wpkjXrM8s3X/HhsbVC96ojFuf79DZYopr2MoW/rZY6UonIuVGt
 eE6PFuyOKEICa77x4FWqFzKIglddP4PT56KWMJta27OK/zs3aRk9OXwHf2DTy8DYxZ8p1e19D
 23q2XMImtyGXCE16K50hmif+4pKccgcQqIFBFhTN327qhNXNIItamBdR1t7vmUbYFQYReiy3z
 zFp89QT0QYyZhkMIWz4RshFKOiUMsVj8QJJjlloqZLlm5jE0E3EPu5CP+hE+CurV7Ji7qvo1z
 D06poD78NGOJTyQZ17uyfPKH0dXkpn2wx3+bMmpqbTAbV16/SAway+2vMuw/X3G51ZHd6F/xd
 4SlTZaIOGLA/aLT0XAtRDV6zHzWM3jfu1AaiUtBe7qE4R7a03oWtvKHCk4MRn3tOG/MEZ4IbT
 TEcXQpS018dRGOYMbTGmXWJy7Gd7jesqpQ5jlrRlgZhQoWF0nZ06P4IbSxbrsIHe2o8KlLDeQ
 nyGiidWAsIrA+xz7vBYjv2S1PMEPUZ8QPAMZMKqpTYpru7BvIByyw/m+LnjI0lyomWR4F1ckU
 uAYBUDz55LmAKiI0D4ua1WcUasK/YHOAP4WAjmmJocI0KfCiIbHFlnR9/ZmgC1EWiM7y8KmoD
 lfYFfAJxDKW0dWjcJaBpFhI28oqLAHjfPQ4d511Jd2H5zwLZwuR4BCjwxKrB9kdvZk8P8GtpK
 vmP5A3OkwQevU36VG8jgICrWna/E/Xt+SEuFsMjLJ7SrTxc/AMxsNOsVUg6Zei1RHxEVCBMin
 9NDE0njXBOTXO+MBDJODz4KQRs+BirwdpaZeTzgXDjeYniQnDg+ElhTsq6p5K2nSyl8iuXO3B
 N5ET6Fp5zZ29UA+/H1l9xXsl/cPyHkXvEXi75NvBLgMbK8gJOH0NpyZJtZadbKI5JnwVw15xg
 fk6BUhb6UCCYZLG25uclTxYVwDGRY//Ybvp9i04zJpSzz6XmfdR6oSiGJa63a5th3/Pn4JlMu
 VnwIv1EkHrAQH+cboqGgLF6XzAmmjQSSOtyJEgLrjcy32f58bBchSW+a+zIx9aG0yMQwcgHv8
 j5+m8vMw+gCASBEwAsz6bYQna7E2B8vG8RY6vmoE6TcJ1TW3ndhAEVNRRgprdqOUi5T7gj2lR
 wotcO2Rissl2nnqE5f+05BB2gWJX42s/mL4ukq4dZiYHLzRy5L1onRwkqE+tNtgfEjXhyyNaz
 FnQHb2NgfzfwSHsQ0rDDQnxVjVPTDb/2okqk1jivJiindjnELeRGnN9LW9dZ9mVaVbLI1+XMj
 9J7X8PUUqEI2xybQK3wnJ8tmOINpqs4xNSPOKyvB9sP32rNfbCXYJ0of7wKMz+cGKm8b32Fyj
 r3oFErA43f2H51SeVD0=

Am 31.03.25 um 23:42 schrieb Lukasz Majewski:
> Hi Stefan,
>
>> Hi Lukasz,
>>
>> Am 31.03.25 um 21:11 schrieb Lukasz Majewski:
>>> Hi Jakub,
>>>
>>>> On Mon, 31 Mar 2025 12:31:12 +0200 Lukasz Majewski wrote:
>>>>> This patch series adds support for More Than IP's L2 switch driver
>>>>> embedded in some NXP's SoCs. This one has been tested on imx287,
>>>>> but is also available in the vf610.
>>>> Lukasz, please post with RFC in the subject tags during the merge
>>>> window. As I already said net-next is closed.
>>> Ach, Ok.
>>>
>>> I hope, that we will finish all reviews till 07.04, so v4 would be
>>> the final version.
>> well i appreciate your work on this driver,
> Do you maintain some vf610 or imx28 devices, which would like to use L2
> switch?
I've have been working with some i.MX28 devices and still "maintain" one
i.MX28 platform of my employer. But it doesn't have a L2 switch.

Many years again, I tried to mainline a driver for the on-chip regulator
of i.MX28 SoC with cpufreq support at the end.

https://github.com/lategoodbye/linux-mxs-power

Regards

