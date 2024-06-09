Return-Path: <netdev+bounces-102133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEF29017E4
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 20:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956851C208BA
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 18:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438DB482FF;
	Sun,  9 Jun 2024 18:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="uY22L8Z1"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2073543AC4
	for <netdev@vger.kernel.org>; Sun,  9 Jun 2024 18:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717958580; cv=none; b=C+GBXFXyPD0/IgABOnNrGsLMpCkA/LTiRFIYUhteXnrPYXbg21Hc4T1Vu4PxW5G+S3SamnaUxvZaCGADPSxcg5hWf41TbnUhHRQfbaHP6+4JKjj/MH2luNsId0UTNsmVe3BlReLBshEvIHLeFWiuUJzWwz2qqZyb03qvf7Ap8rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717958580; c=relaxed/simple;
	bh=ozGAEUw36cDvOjqcOIhFBfcWXKwqM8CifUjd85AfFt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/hiQ2UsNM2sz6xlEp+pU+V9ahUpXxAmLSo5VTiEL3kmslhYyX+kUWB9Mxy2FgHPF1qzOp+wM1B+6Bsc2QC+mxOCd4Au/PuShr9Xe5X1AHTAGcysPxu5iKnpmbl0XhHxLWNUFW5k+1ieWgvh7fBWo1yilqyBiok+l6V/oP0KFhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=uY22L8Z1; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1717958564; x=1718563364; i=hfdevel@gmx.net;
	bh=BXPI30Ae4wdTX/ZvTVKrGR5blwSr9Qv+u88oLkSvc54=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uY22L8Z1UHcJGh7YD97JNm0YlqGb0OBZQSjS0wo7ECDqLryR3WY3kP+ESvrVDfsK
	 gKjiNMEGF8cN8zT8cKl8ufE2AwfdNlXJHkPCAt/3QLrZc5njos0G2COK/sEn+msCK
	 pBWygSmmeZ6xbXEugDwy51J5MBR3xvb/RhKk4vOUURDpUQ6Elz8HV2oiJ+eh8Q+6Y
	 WC6wIgZUxC8ZeVeeR82BFCf/KmbXI70iAduzJle4TaEhCsuOGJO6ehWv2Wfe/NIZ3
	 vE/rrDy7ClSVzxZgmszzhr0K2hj3WXFuCA/tfpyG0JxPr/FvINxk+AGMSZDIWzGtX
	 RTqJ4XqsqzPKPKKk3g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.0.23] ([77.33.175.99]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgNcz-1svCEl0KgZ-00jZFw; Sun, 09
 Jun 2024 20:42:44 +0200
Message-ID: <c124efe0-0b2e-4d8e-b16c-8a8afd0814c1@gmx.net>
Date: Sun, 9 Jun 2024 20:42:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 0/6] add ethernet driver for Tehuti Networks
 TN40xx chips
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
 andrew@lunn.ch, horms@kernel.org, kuba@kernel.org, jiri@resnulli.us,
 pabeni@redhat.com, naveenm@marvell.com, jdamato@fastly.com
References: <20240605232608.65471-1-fujita.tomonori@gmail.com>
 <7fbf409d-a3bc-42e0-ba32-47a1db017b57@gmx.net>
 <ZmWG/ZQ4e/susuo6@shell.armlinux.org.uk>
 <e461ce5b-e8d0-413f-a872-2394f41a15d4@gmx.net>
 <ZmWyufzdM9vKjBDc@shell.armlinux.org.uk>
Content-Language: en-US
From: Hans-Frieder Vogt <hfdevel@gmx.net>
In-Reply-To: <ZmWyufzdM9vKjBDc@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YyJE73JmoLk09y6AG7hSaT8rKFpvVuxpI/FedMJz7LnXJATjtZZ
 Hzx93YqGKp63LGMUWvC+XGU1+7TAvGJk7qJp17H8FmFpD90eEUqAtKUKgvLw4w5Ch7TQDYl
 +eDS0D0lrBkyW7agysP5Du9RK4QvqxEYx/QEl0kZDppjerVQBvUc4MTf/qI5NYFSc2RxO6k
 BeD9DJ86xDy5Ad0/CEhPw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:O5vL9ELM1oc=;+6tnDUkQipOkaSWHFID1djd0j6H
 m0pLa2yuH3FN0icVijxVzqfyL12wkG+AK6EwiZG4fWTNkwPJ6oUVWEIbxQ/gz/JaqRQ8R1TGK
 5KOXpE53E+9Q5UolkFMxqd5bLLfjNa5MGPV90hcvDGZ3XDbqWiYTnjhpFb8x0Z5aRBTh/xUe6
 3U98SfPye7a7RpzWUBydp7Nmae6tJD4MXINYBpn/tel2zWkT+YG0uq4lNRGTfIXMbp/eayQ0J
 GqbKC7Ws3kkRCiYQJvLVAbznnSvq7It9mKePzMJbMDk1NidZAUQwxZ2R8a+EpgY/ZlQvoE5TD
 Nr7uAkO8EpGMs3IUc1w9qV+0vBJX+W11/lUj4BuTpaKq229oIU+e0jJMaCSiY5VJzcHgD05XW
 JD33f1eYaUVGd53iA7ToUx9Y/BfxaPaFSFY5AvwJ2VfFvV6UG0XGcQVZBnFY6kkMLQQQl8lmk
 obdtpo+sGjuyn99tMnhDm9ESEjSsigJ2gKNe1BYb25DLy5PybRphFNDl6/kdopxAvAy2XuV9j
 eVYrxpdpcTGw7juV5e7ZDRYQ95BbnIbwC+Crqx5mD4h5CCiqz7w1DlkJmDI8hN9iq7lpOGf0V
 YfWifl0QCQsJL0jvMfdYrZtADGo67FFjiEKGzmvVGwE3a/TdwjlpBe7lQca0DTud/YwljjxJi
 vGqlYGvPXnCsU54138bwkxZ8Z/5yzNrNoMwT6IHSVhb2PlkhEwj6BGH1F3MxwT1iWBwqwldoT
 8y6kZYs1ZVa3apYPFAw9bdxfhaj7jaeg1QsoQG/aWHCJauzzg1o0KDe62woVCXYju8jS6Mqm3
 TjY3Ql3/QrUeQ0E4Je8GxP1DsT3Y1s0FphZRz/oPQc+yA=

On 09.06.2024 15.48, Russell King (Oracle) wrote:

> On Sun, Jun 09, 2024 at 02:40:03PM +0200, Hans-Frieder Vogt wrote:
>> --- a/drivers/net/ethernet/tehuti/tn40_phy.c=C2=A0=C2=A0=C2=A0 2024-06-=
06
>> 06:43:40.865474664 +0200
>> +++ b/drivers/net/ethernet/tehuti/tn40_phy.c=C2=A0=C2=A0=C2=A0 2024-06-=
06
>> 18:57:01.978776712 +0200
>> @@ -54,6 +54,8 @@ int tn40_phy_register(struct tn40_priv *
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -1;
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(PHY_INTERFACE_MODE_XAUI=
, phydev->host_interfaces);
>> +
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 config =3D &priv->phylink_c=
onfig;
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 config->dev =3D &priv->ndev=
->dev;
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 config->type =3D PHYLINK_NE=
TDEV;
> This shouldn't be done - host_interfaces is really only for SFPs, and
> it suggests that the 88x3310 isn't properly configured with pinstrapping
> for the correct MAC type (which determines the interface mode to be used
> to communicate with the MAC.)
I already wondered why host_interfaces was only used in the 88x3310, but
not in the aqr105 phy driver. Makes sense because the 88x3310 supports
both directly BASE-T and an SFP+ cage.
>
> I'm not sure what to suggest here, other than further debug (e.g. what
> interface mode is the 88x3310 trying to use without this?)
The message is:
tn40xx 0000:10:00.0 enp16s0: PHY has no common interfaces
tn40xx 0000:10:00.0 enp16s0: validation of xaui with support
00,00000000,00018000,0000706f and advertisement
00,00000000,00018000,0000706f failed: -22

You are probably right that the interfaceis not properly pinstrapped.
bits 2:0 in 1f.f001 are initially 0, which means RXAUI, and the vendor
driver just forces the bits to 1 (XAUI with rate matching). Maybe it is
a quirk (or a design flaw of the Tehuti reference card). Just a thought:
if it cannot be autodetected then maybe the simplest solution is adding
a module parameter.
>> I have to mention, though, that the phy-drivers for x3310 and aqr105 ar=
e
>> not yet ready and will also need some changes related to the firmware
>> loading, because for most (all?) of the Tehuti-based cards the phy
>> firmware has to be uploaded via MDIO.
> That's problematical - as I understand it, the 88x3310 firmware at least
> is not freely redistributable (we've run into this with other
> platforms that do not program the SPI flash attached to the 88x3310
> and been told my Marvell that the firmware can't be made available as
> part of e.g. linux-firmware.)
>
> So quite what we do with the 88x3310 based boards that don't have
> firmware, I'm not sure, but it seems given the non-distributable
> firmware issue, that's going to be hard.
>
I followed this discussion, but was hoping that the situation would change=
.
I think I will give the card with AQR105 phy priority, assuming that the
firmware topic is easier to solve for the Aquantia line of Marvell product=
s.

Thanks, Russel!

BR, Hans

