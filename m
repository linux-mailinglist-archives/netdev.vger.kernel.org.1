Return-Path: <netdev+bounces-94852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F598C0DD0
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 11:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 327F228481D
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 09:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A066B14AD14;
	Thu,  9 May 2024 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="OYvu2Ya8"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E1314A638
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 09:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715248379; cv=none; b=BmWIFeCGDftCeFCQ1nHlMWvhMtupjrnEhxzLdu+wk8BBNMkbOOtWrB3tAaiaRPWMs2az3lupHAttDE8fVOpbJkIYNIolNBht7tcn1PPzYUz3WTt5dw4rXyVjxUEMlrqFaNgGdbPp0kNj5tRYY41p2L2peSAiHYOktCZP5llqlUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715248379; c=relaxed/simple;
	bh=BPiNM3gYqrPLiegyXLabr7dBcPmIHHf8dlo7Qk1EMu0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YLixs5UAaOTF8arBPE8vTDXscngfDL6U3FZmHQbWDkF8WPN7vv85gWmTS3ownKfPHLm9ffQl1rp5blSvA7V6iul85O9YDbCmTcYzoStJbNamkQcP5s9gOcSHagCsYrSnJBpGJBvW8IfVIeC1vkutEc+ICwgCNIPxNK0htbmpbIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=OYvu2Ya8; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1715248367; x=1715853167; i=hfdevel@gmx.net;
	bh=BPiNM3gYqrPLiegyXLabr7dBcPmIHHf8dlo7Qk1EMu0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OYvu2Ya8JIHkEiPV6FhHi+K3IfCHTdF1qFE1n44QdMiQ3xtKxJ8XYQg+GfehENkd
	 VPNw9EYruyopcd/03SbIhIbgSb5QsGYC7ph/GYdzQN0At9u51HMbw1EPBgM5YhOap
	 qFQFlrfXEyv6kYcDWOtRdyv9iw8Jx6E6lQeJtm7wcXOj619Z1RVa1l5p40bFJ1k8a
	 WoTCYOjuGPPuV2992K+dLC4uS9BVdBZ+1XArVHb7CTKzyYFs5P1WDFkU4QOl0IIqB
	 0jaF0/LQaFjCIFfohZ7LjCDRljb5FUYYO+nZQFUALUofH7o5fdd6VrWPILWLsecXl
	 YV/VpxiCgx4Lw/1zpA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.0.23] ([77.33.175.99]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2f5Z-1s2WPZ3WAx-0048p8; Thu, 09
 May 2024 11:52:46 +0200
Message-ID: <6388dcc8-2152-45bd-8e0f-2fb558c6fce9@gmx.net>
Date: Thu, 9 May 2024 11:52:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 5/6] net: tn40xx: add mdio bus support
From: Hans-Frieder Vogt <hfdevel@gmx.net>
To: Andrew Lunn <andrew@lunn.ch>, FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org,
 jiri@resnulli.us, pabeni@redhat.com
References: <1f28bc3c-3489-4fc7-b5de-20824631e5df@gmx.net>
 <12394ae6-6a2d-4575-9ba1-1b39ca983264@lunn.ch>
 <71d4a673-73b6-4ebe-a669-de3ae6c9af5f@gmx.net>
Content-Language: en-US
In-Reply-To: <71d4a673-73b6-4ebe-a669-de3ae6c9af5f@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HpmZrhPT0KAISimDwgkfyAOFMa+Cb5MHTsac1pnPpQK/XDktIy9
 +R0iiXx+LW+ZAAQkjZzcgXFEdNxMQg5sfSYp0ww5TYJfvwRnsHHLjG4tXTWjMj9iRzGnOG7
 GqgUidoqKLXTu1tLEGezsGMip5pIAsiV4ZbXyNkrGS+OxEx631loKCKCVDwDNFy39yKYCnT
 xzEDwYvPjrSXgtlLK4anA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gRXp8N4FzSg=;3f1hoVHA1PnZxf5sfAn4vPEn5MZ
 /ods3eR6vly1aPkGg4n9j3gka3HLGaKJRuqYCORvQOr46ZcBaFhsjPMgG0IjU6ia2TfnJVfni
 xh9DA51538JNCoSm6x2HAERK1UjsIIsEguBYLN3w6rkSbOJpCYgVb4fhh9T03NHoFk/YfMDDt
 lxR1xliwJlucSO0NaN9cdPK7sn06RYFme/Xp6EGCpNaFS6DqaFv8uxGrS2Ho/nO0Xy0gzUMUt
 Wl9ZhmdH5gLqvIdnzWQCLPyZ1A/M8AakP7nc1mrB+8m6UOD1V7dUOCcCOD7myWfRbsIpoq+hm
 /eT2zdI6s9pJQHrxbjA0oZMT7BLEiJpF0PT0ILnqvB7yRdlydBQto9fYhV7SfEosUDzmBmpPa
 BKZtGgmUeOT1cD4bdmqEnMt2P1E4t3pdQRFls1GnfDZns9jfWf2RNq6RSOdXZlciJgPz9NzuR
 G1reiL1xlT9m3G0JHSQu9tUZqXfWQlcklldKImulXsIjwmO9uPiu2XenVYJp7qCYobXYvD2oG
 pIc+T5XtfiVNbsiFxm40qIZn5chWP0DT/GyzFwsd71PD5bj/81KaOQpeJ66tWhTcB69T5u+u5
 tkVEXymX+7W1OrmwQYP0pb56L0TqLGb+qHOlfJuZ/R6gPBerJD6XerS6nPGtpu/nRmyVXeClH
 kpz0UqS021MSKq20HNG7XjrEq9Gpx+q3/42R+zxsbZtTkjSmeDWSQnVWEBXfZqVgFovecZFe/
 Nsxplme4f94N17QcvAi57O4XXULSCr2z+2vawC9fkmkuVfO40D6Y4rqAlZgprs9ngglPCmFr0
 wzAnSmxxNf+G7QbkC/OXwIBwChQkD/xQB7nGZuikN+tcs=

On 08.05.2024 21.30, Hans-Frieder Vogt wrote:

> On 08.05.2024 20.25, Andrew Lunn wrote:
>>>> +=C2=A0=C2=A0=C2=A0 writel(((1 << 15) | i), regs + TN40_REG_MDIO_CMD)=
;
>>> similarly here:
>>>
>>> writel((MDIO_PHY_ID_C45 | i), regs + TN40_REG_MDIO_CMD);
>> This one i don't agree with. It happens to work, but there is no
>> reason to think the hardware has been designed around how Linux
>> combines the different parts of a C45 address into one word, using the
>> top bit to indicate it is actually a C45 address, not a C22.
>>
>> I would much prefer a TN40_ define is added for this bit.
> OK, yes, very valid point.

A small addition here:
digging through an old Tehuti linux river for the TN30xx (revision
7.33.5.1) I found revealing comments:
in bdx_mdio_read:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Write read command */
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 writel(MDIO_CMD_STAT_VAL(1, de=
vice, port), regs +
regMDIO_CMD_STAT);
in bdx_mdio_write:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Write write command */
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 writel(MDIO_CMD_STAT_VAL(0, de=
vice, port), regs +
regMDIO_CMD_STAT);

The CMD register has a different layout in the TN40xx, but the logic is
similar.
Therefore, I conclude now that the value (1 << 15)=C2=A0 is in fact a read
flag. Maybe it could be defined like:

#define TN40_MDIO_READ=C2=A0=C2=A0=C2=A0 BIT(15)

>>
>>>> +=C2=A0=C2=A0=C2=A0 writel(((device & 0x1F) | ((port & 0x1F) << 5)),
>>> and also here, similarly:
>>>
>>> writel((device & MDIO_PHY_ID_DEVAD) | ((port << 5) &
>>> MDIO_PHY_ID_PRTAD),
>> Similarly here, this happens to work, but that is just because the
>> hardware matches a software construct Linux uses. It would be better
>> to add TN40_ macros to describe the hardware.
> agreed, I assume I just interpreted too much into the constants.
>>
>> =C2=A0=C2=A0=C2=A0 Andrew
>
> Thanks!
> Hans
>
Thanks for challenging my initial assumptions,
Hans

