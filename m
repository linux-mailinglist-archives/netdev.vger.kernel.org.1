Return-Path: <netdev+bounces-182742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 358B0A89CB9
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDFD93A3309
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8C52918CF;
	Tue, 15 Apr 2025 11:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="noSycIe2"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C692E1D86F6;
	Tue, 15 Apr 2025 11:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744717360; cv=none; b=hgLwPgqt2JUAv3PgXvc3/dG8cpQwaxDr/uK7Ou7xvzo/0Vdg/WzQd0em91b4Tq1zewcm1c2bd955AcMdoDdtYfkIj7chnqPCKvAOFfao0EQq65H0UQHD+f9wjJIuHLtpu5T//VskBQAXZ5fYNMpqcV3U6rI0b4ty/LtKn+lUuv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744717360; c=relaxed/simple;
	bh=hm8aYJDNxysrMNHyUOe73MjsVB1mTcPsIfiAzmOy0xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=efCD7Emjhyx7zAGH0oz2AYZzZSMGQGPzBDwjHjnDk4GpC0EsBLOKD5hfNtf3V8mGd/xFVaN/WvUGh5c0+y/uUuA+IkGZS5OnJhEO7YMh6YegDY9EVM6pnvaLUBm2nc3iOoF3OZaHhgl2XMViVPajTm5KHT44903LcBAp/F7asdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=noSycIe2; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1744717355; x=1745322155; i=fiona.klute@gmx.de;
	bh=hm8aYJDNxysrMNHyUOe73MjsVB1mTcPsIfiAzmOy0xc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=noSycIe2klE5wF2wxN1aVTAOpODVHahFyzTfFMFnLxmuCmqWeivesdQDvwjMHdTr
	 VuEOUphjfeyyFCTZJRfWUKtMalXrs2BSa/MZPwQdtWU3f2yANfA9sf4mXPoRUa7Qs
	 gf0mfVxXl1DgNEvBkZ7GfxXMJhvaKvrUK3+6c5V5Y3CvCb1OJHym+j6eQz3ZxB/lr
	 Vzk8DK2Jd06YC4S2gMeoxaV4xlQbTl/soVkNuj8/DENt464V3FpIvg6Ii8iYv7Taa
	 VW2YI2dlVK9hbbiKHWi0RCk/k1czVpagyDwEB+g9dUmDxb3ySvX/2VAOhm0oxi07f
	 /LpKuKXFU6gMa5cmcw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.115.120]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0XCw-1t8RQt0V5Y-016GRv; Tue, 15
 Apr 2025 13:42:35 +0200
Message-ID: <db6b47a1-1a6c-476e-a679-aac3e5117c68@gmx.de>
Date: Tue, 15 Apr 2025 13:42:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: phy: microchip: force IRQ polling mode for
 lan88xx
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 Thangaraj Samynathan <Thangaraj.S@microchip.com>,
 Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
 UNGLinuxDriver@microchip.com, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-list@raspberrypi.com
References: <20250414152634.2786447-1-fiona.klute@gmx.de>
 <24541282-0564-4fb6-8bd1-430f6b1390b0@lunn.ch>
Content-Language: en-US, de-DE-1901, de-DE
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <24541282-0564-4fb6-8bd1-430f6b1390b0@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Uo9EvfEdp1sqjcgDxKDcHbPyka1TgzjSS1bXs5FwDEZ6eUbVZ40
 zZMaN4Kf5IGDSEJXR6amBhZVkaMNihDYuXWNRwYCTHzpmlExQ8m2/EPmlrUTYu3rPMTpprw
 6xfjyayQjv9nV20ayoUxWAGwE29F/3Gakr5VBOFHeENmTMcbiGdTG9j0aQXykNkdX7nfJ2J
 oL27TnlLqDrdz2nhiSnAg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HQYZc/gpNrU=;Z1bJbVssbSJ7Mw4vEkNvLSUlCys
 sjpsehVnjAksckxW6M7gkImZsK1Ev/dHFvMeUAgsIqgcbPnk2078ldTjALr4TshgRiQa5KMbU
 NrVDuzewYMNmvyCizZGrk6r6yGeFveoBIly3sMdk7BSW5APLVrSmKBn/LIzuum0RXphOoW5We
 KjBOiIqKfy8ToeHmglnUfcrLVgzIO4CfFbuj0sPPtJ8GexEFsT2aWPJ6rBR5dYkWLEDFjRwdz
 SRyNuMxxDcB9GNS/1YF4CE0NAb7l22cSEQVHJfTtVctmFqhisaWDSsWcbe2+viVDEVw7gO0na
 zzy6mS3AgIJUDvsjTyuF9+J+nWssdHJEzaLz6JWw3Pe/YHoAEsGqqeHJJVRfrtOfU2i6UrC+f
 4Ad5jbDK8GpaX8D92jEY70bBwGbHyXHEvxGWhGBO1Dzcf95jNWQIafODi0QqrqKrLYqTPNn6Q
 cA/ojUIcSiCqU/dB+APlE61l3MOcKQvR0yvvnxxG1igOwubfxCgaj9wxh0cLGZqvC6gVcoQZ/
 5ttP8kkN+qYkT3o6Fr9H6TagSJkX0F9w6mGMI0i+W/4x43mSwiwnpwRj5140mW4ZfVP4iGZQk
 LuAgZ68oDczKND7w2G+se9zhwGSZeI+6SBHqjg8ploihAkSE8PJWnzMWl2zMCBX4ps8DNgv29
 LH0N2+DgGvXsHpAAT3BkqebWO353ghlywtUNTTHHarsxlIzWBKG7TshLozyBRIdEQk35xZucD
 2mXsF1CbW1Lm2oGdhHRF/gms+oxyB4//7xPGEABq43zrBQ62Afw+N7BlPslJLnk2+GtBt5imf
 kNPOtLTTtuZA8fasXk/yNiB/ghcJXUVKPOYOGJSW9SHEGRl6mqQsE879JAWzNJ2Ovhxlyhm+4
 rm7mQp9I/Y0vWBTQuCrOBPHz9qC5JdOHyIgQ/hZ6exc3Bh/bUUUhPy0c/n0ilNLLV6NEByELF
 E4TqjNJefEoL7EwBon3KQP/HKv9odr2U6e8aw8dg4w+qOjrvL6Ft+xinO+VKH5xXxZ0tZsr1k
 hQUytmlsfhYMx3oM9A9ZDTvezENnUd/tQSiI9dzNJ9mlNyoLYyqfyHPzWDQEVWE8FoS7Jv2+m
 RvFJvSh6D+Kaly8q37r1S2RsEPTd2OAIlSiyCI64A5Kgb9/Tl9A1fain+dJoLvafjh70w2uti
 53kTwVb8CnFbT6z6fDw/tz/9XohLZYmiKO8bYqVN6HJpC6+l7QQ3F2SCjn2NyBLEfra/SUzop
 bM/7NKljOIff7Vdv366h7+rn7XksKxD5/u4BCe/7earE20/R4kwxZgBJn4/ayCtCVx8Knqc6M
 i/KA15XB5WD15n4WzMU3zwSnmwP6+1zIhnYlPqGdbO6dzPSM2X2e+6OZvA/jF9Z5Y8cuiGfqh
 H0DSAk+LUsF/ujG+yu+SYsDL5QOkZV/2UKOZUWuPmiCQq8aaXjoHPaKB0sk6vbhgo0Yu3I8yk
 mmRtXm6dCHHnu/b+u7if0i4/BMn64w0V91sHwOANs8QhgLfW6UcmbHRQWlsyDWfod95XHAQzG
 omE7rjvzwK0lmf8FTHo=

Am 14.04.25 um 17:43 schrieb Andrew Lunn:
> On Mon, Apr 14, 2025 at 05:26:33PM +0200, Fiona Klute wrote:
>> With lan88xx based devices the lan78xx driver can get stuck in an
>> interrupt loop while bringing the device up, flooding the kernel log
>> with messages like the following:
>>
>> lan78xx 2-3:1.0 enp1s0u3: kevent 4 may have been dropped
>>
>> Removing interrupt support from the lan88xx PHY driver forces the
>> driver to use polling instead, which avoids the problem.
>>
>> The issue has been observed with Raspberry Pi devices at least since
>> 4.14 (see [1], bug report for their downstream kernel), as well as
>> with Nvidia devices [2] in 2020, where disabling polling was the
>> vendor-suggested workaround (together with the claim that phylib
>> changes in 4.9 made the interrupt handling in lan78xx incompatible).
>>
>> Iperf reports well over 900Mbits/sec per direction with client in
>> --dualtest mode, so there does not seem to be a significant impact on
>> throughput (lan88xx device connected via switch to the peer).
>>
>> [1] https://github.com/raspberrypi/linux/issues/2447
>> [2] https://forums.developer.nvidia.com/t/jetson-xavier-and-lan7800-pro=
blem/142134/11
>>
>> Link: https://lore.kernel.org/0901d90d-3f20-4a10-b680-9c978e04ddda@lunn=
.ch
>> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
>> Cc: kernel-list@raspberrypi.com
>> Cc: stable@vger.kernel.org
>
> Thanks for submitting this. Two nit picks:
>
> It needed a Fixes: tag. Probably:
>
> Fixes: 792aec47d59d ("add microchip LAN88xx phy driver")
Sure, will add that (and a comment) and resend. I wasn't sure if I
should add it if I can't pinpoint exactly where the problem was
introduced, and it looks like the interrupt handling was changed a bit
after.

Best regards,
Fiona


