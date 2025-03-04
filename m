Return-Path: <netdev+bounces-171776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE29A4E9C7
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 18:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A973117A8AB
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 17:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A111E2D1F58;
	Tue,  4 Mar 2025 17:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=online.de header.i=max.schulze@online.de header.b="b3B+6bb1"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450D5259C95
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108730; cv=none; b=VWEb4zzwdYI8RsbBKcVKxZDcoQ/l/pkMjq8hxPveZfLYSzUE5ahCoBsuVP98AHjzV2jWl5MKaowmO6VXiFsI4KngoG2ELrLC0+Pv+SFV3R8z34QNteE7X4QdHTzmZRfsCRNMLM6qqN+FWB4cKyJFti2T4IkhN+aeqw+QoWAngf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108730; c=relaxed/simple;
	bh=RChwhJp5w4XWsWU8KrZKuD1IP9UlbNZwc754dw3iruA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8TUMFtVC6hSSod3UrZWDVkYqbH6cDjkRSF7ugPa7m4q4Iu/n6IYxMNaQlMqQHuN/Ze3A5LV+gH6kJoTmmhEHtpQsUOJNf9aJxzlLj4+n/97MKpYpA76Rth/6ba+OEdTVcL9GLrA77FFzqk8449DEarknjYOYCwTrLfbEMmIu0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de; spf=pass smtp.mailfrom=online.de; dkim=pass (2048-bit key) header.d=online.de header.i=max.schulze@online.de header.b=b3B+6bb1; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=online.de;
	s=s42582890; t=1741108724; x=1741713524; i=max.schulze@online.de;
	bh=bKBYI6uFzm0+MrGwlATuTSjHl6FQ/wOIMG/S3sOoj+I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=b3B+6bb1I5uSxmpcR3nAkFppuHTAn6IXghCtizr6xW+E6WXhbgL9e7WuFgWAd+C4
	 oe1UJfHH2LphbBlD6xLKMKCKc41zJuMFA2ZTS4Nb5iJu++IdgPerJF2MRuZ9AGEUe
	 WmgOcZNDraaSb8cI2jsD9WGekuFybgofye3YjhwK7DCpNtR66KkZX/ILpn2WDw6wz
	 5SOYZuOz3pa0BU8wZ+xMSwwE6aBVBaWWx5iBXuIe9V+s0AySy4nsyzXCEB2pUEWUL
	 FLKGHYPdGHLgb5eKmBFlVWhvmzsCXT3oTEtEmoV25Vfa8t+noYFZ17QtkejLi7SvG
	 RuJAqjZZ8FL+Rprsaw==
X-UI-Sender-Class: 6003b46c-3fee-4677-9b8b-2b628d989298
Received: from [192.168.151.48] ([84.160.55.49]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mzhax-1t31rJ0XYH-00zYz9; Tue, 04 Mar 2025 18:18:44 +0100
Message-ID: <b2296450-74bb-4812-ac1a-6939ef869741@online.de>
Date: Tue, 4 Mar 2025 18:18:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: tn40xx / qt2025: cannot load firmware, error -2
To: Andrew Lunn <andrew@lunn.ch>, FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: hfdevel@gmx.net, netdev@vger.kernel.org
References: <5f649558-b6a0-4562-b8e5-713cb8138d9a@online.de>
 <20250304.214223.562994455289524982.fujita.tomonori@gmail.com>
 <89515e61-6aeb-4063-bc47-52a9ea982a26@lunn.ch>
Content-Language: en-US
From: Max Schulze <max.schulze@online.de>
In-Reply-To: <89515e61-6aeb-4063-bc47-52a9ea982a26@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lW+RJJuS97n5xgHRSYbXP98Sz+dOnk6Hk5UbNLzJbhcbqkSt0bz
 j1jKRQO/S3LfeP32TEwHMp/5xi0uPgaTexDuVY1GUu1SQJ4hcKQlE8u7KZJBZPuxdsNEo/B
 yHryXY93HWeGP7mwVdf10lIT8LcBF6HAs1mifmDNjHOIBPbUS2zeuE1fAU5u1yC4ptj4gHB
 MhwAHnfpr3doUsXy4vgfA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6s/GOwAxASY=;ZAHkY55ilgDve84IvekLHkebk5b
 WpuGGXjWOKBimrbwjHgf6fy7x1XV1BKDjhygX0zd5zGrZDIVrkLoPeRTYoaC0aC8RpSwAxgJM
 oFD1QlKSjQrr/Ebz9Y8CVhbbPeUlTY8bI7Ef0xWag9rUD4Wo9BNIEYOeHdyTJoKril/mRcEIS
 zQ8Sey/Ie0zrNDVE9rZ3GsTg0Sz3vV+HPxOj8IO3Ee48DjgaBeEjoGhBTOEprvUu/dcgie6Ui
 R6a6/44hwc15m+P5G3BWsR9Ql9D/9KNwpvNA8JVWbXiVAtsxjej0RDkoZKONUOY8+5zZKZWs0
 5TXLT25bP28UCYVWElsxeR4uqEhieIT4LncprXaAtEH8KjM0nXsb3mq0vdtBUhyH5K3kWkKsO
 FC6VVWA70GlEwV3EATEXFtXhcU1ttT63Mvgab1vCqZjYV9XJs+KRAvPIEpU9cJaNcNtH5JNLh
 /5xc0aCbWV5wHu0RjTyeBzXykOR7QSTtNf1GNOuPyJ72/RwXNd+Ip/I49VqToYbLnfqxQbZOp
 ATJx9ZSoBjQOpFWAV8XPsKlJzdj82YINpYFy5guf+QbyldGofDJcu79hlTajmmP8aottY5zQY
 bPILLIkhhsmKO5iIU1NofOpzaJ6vSDuNdecA9I95RENk0BV1k5TC9D6nP5Ou6OJ1m7cS+jB92
 XBwQmBc0q2+D+z15Ckq3+mAmvCnneLyUmYhZS7k2/2TGDQPShPG+svUaQE20gp//0shTxIy+r
 KUpibaaT+92a2+TdisginDTSvcPXDIne1pcBox/O/VtvyMf9ImJoVe9lDhp+/PnEBmmeRwkzX
 nQ/vMPGJDPH+YKa2qNneloF3IzJ06g9zmIDePV6DuwYrNQE8KJxNgDrW7fRUzd7TLH7ESIXqE
 PQ3aE6nwaR2ku7OrnTVc1PSlLRaRFuc2qjProbbKdu9ADbwZJ2IsxU0EApdras5CUBE79ugQN
 sQGtEEmnsQ5xuRERQOBxP1msfWnGIeeqlA88vyJLKW8AvvHKzovYULJpiPZEvhe9andjJ7ZHb
 KLjEwTzaoClgVcS3mnC9kXenyhD5V4DqctjanWU1DYB7SxgYx0yGPxvbM5Fax73cmpjZxOqsy
 5qgIy+VR2VxKn1wujc2ObkZdohsQMVGYpnBjpM8Yd1sS+i7pz5lwKPCFujBScMLpWSW2+4q+A
 R5agTeJ6nzqz3h3CeU/UulP5ol6FT9fTl1erugpvk6Vbdk1RAAFHMKeMN0IrvoRi4Y90iw0xJ
 gyRIFWyUp2Dxf8W//VFDg2Syoxx41qKxrOSaMBI852CKCynxZyPjCPaPTzmoR7YnG8mmCGQV4
 D4+7dxHTMgOrA8Qao4ulUiYk4s/2OZAseUdZ+iBVrQOtcHbgpmFK4oGF8CDG6PQP44B



On 04.03.25 17:21, Andrew Lunn wrote:
>> You hit the error during boot? In that case, the firmware file might
>> not be included in the initramfs.

Yes, thanks, it wasn't. Might have messed up the file before initramfs cre=
ation.

> sudo update-initramfs -k all -u -v

showed the firmware being included and for now the message disappeared.


>
> With a C driver, you would add a MODULE_FIRMWARE() macro indicating
> the firmware filename. The tools building the initramfs should then be
> able to pull the firmware in. I see you have:
>
> kernel::module_phy_driver! {
>     drivers: [PhyQT2025],
>     ...
>     firmware: ["qt2025-2.0.3.3.fw"],
> }
>
> Does this last line do the equivalent of MODULE_FIRMWARE()?
>

I suspect it does. This looks right:

> $ modinfo qt2025
> filename:       /lib/modules/6.13.5my-g11cf239e363f/kernel/drivers/net/p=
hy/qt2025.ko
> firmware:       qt2025-2.0.3.3.fw
[...]



However, I have no idea how to put it to use now.

Shouldn't ethtool -m report something?

> $ sudo ethtool -m enp3s0
> netlink error: Operation not supported

Does it really only support 10GBe, and not 1GBe or 100BaseSX ?
> $ sudo ethtool enp3s0
> Settings for enp3s0:
> 	Supported ports: [  ]
> 	Supported link modes:   10000baseSR/Full
> 	Supported pause frame use: No
> 	Supports auto-negotiation: No
> 	Supported FEC modes: Not reported
> 	Advertised link modes:  10000baseSR/Full
> 	Advertised pause frame use: No
> 	Advertised auto-negotiation: No
> 	Advertised FEC modes: Not reported
> 	Speed: 10000Mb/s
> 	Duplex: Full
> 	Auto-negotiation: off
> 	Port: Twisted Pair
> 	PHYAD: 1
> 	Transceiver: external
> 	MDI-X: Unknown
> 	Link detected: yes


Must go around shopping for an endpoint then...

Best,
Max

