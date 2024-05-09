Return-Path: <netdev+bounces-94876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFF08C0EC4
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DBB61C20DF5
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 11:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D75131180;
	Thu,  9 May 2024 11:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="fuRQOfyD"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DEC12FF8E
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 11:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715253387; cv=none; b=RqpxFz4uTTy/BbnUMHxeU8H77vv46grGSAbXVTHO8m2C99D5DRu/xHZqtKf5HMH+ZMKNKidzjC/QwUPyhhf9q6srklQTas2JI+z8VWKJtQ9w9mIDJvZuZaICxzYhgaZ8fziOJ4m5Lcb/xQrfcE+6HugOB8aDe6AsOyy5j4R2ZZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715253387; c=relaxed/simple;
	bh=klm92dOX89LD3maKXx5OVucWbe3vgSmqNAS8oM1sFDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OpNfhHugtFvnNI1yXL3rB5BVHtEQVBeu26TWTxfCvIrv9V/6L4MMb1zN/sqkcSFlIIKRYxaJt44YY4xFU7ZERr87UJrNVNpGAoblTiRxE290iSdMqCO5bimc9a4fUdiilzoR/ktoAh/F61iIivA7xWujTzqRdqq3lxx4F2JlE9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=fuRQOfyD; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1715253373; x=1715858173; i=hfdevel@gmx.net;
	bh=m25lksRxz9ay4yf4Z0TkKQyuMROwYj2hioFZNOfGpI4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fuRQOfyDgnvlTLV79TM2O0QmegLqW87Ks6UyBhMVwjo+H22N/xkl5Ov1muxf7AII
	 K0vy4spaXUpX5oTe4tIUfrm2o9U8WIdgjhVoqwMNvZHRZ+2L6/XtRkwLZ5WbgrD/y
	 7jUcL9qxwGNPfgt4nPx8cmCKP8VDOwPtSr0cUNF+Rd5f1V4r0T4t5llu8UOSTkD6e
	 DJkCkYwFf1nsxu2+C6YruTTwr/UMCPuuJLmFsLftpEnBbIq25UeWv0cUwDu/BmXC2
	 gj8+8Y0QF90uTqZONJyCghMIe9MG9RAVQLKsU1bbph0kbzFC63G43ElUZ0cZHRSnG
	 f/2SP1tZ/sDXTlDIjQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.0.23] ([77.33.175.99]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfYPi-1sXToT1ffE-00g03j; Thu, 09
 May 2024 13:16:13 +0200
Message-ID: <ada8f820-ee60-4fac-92cc-91f287e36041@gmx.net>
Date: Thu, 9 May 2024 13:16:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 5/6] net: tn40xx: add mdio bus support
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: andrew@lunn.ch, netdev@vger.kernel.org, horms@kernel.org,
 kuba@kernel.org, jiri@resnulli.us, pabeni@redhat.com
References: <12394ae6-6a2d-4575-9ba1-1b39ca983264@lunn.ch>
 <71d4a673-73b6-4ebe-a669-de3ae6c9af5f@gmx.net>
 <6388dcc8-2152-45bd-8e0f-2fb558c6fce9@gmx.net>
 <20240509.195906.2304840489846825725.fujita.tomonori@gmail.com>
Content-Language: en-US
From: Hans-Frieder Vogt <hfdevel@gmx.net>
In-Reply-To: <20240509.195906.2304840489846825725.fujita.tomonori@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LqbzbyB6v7r3H+tqTRtV7B+ZJLGpQLKjn5uDUYUjis+26fRwYrr
 qaAyQV35+gwXzz1kzI+igX5skoMBAzdBzMVgwvbNizaB1BsrHCyFTlwoXS5wTrM6f+a3VWM
 NHzUHvw+FATjzpWb5zF0wff/dMJGVwduETds823aAGOWooQJ8CouPJ1XJcigIfQ+j5+XE6B
 x0RT8yE2yktQ9wCsvnYdQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:h2Kwobky+I4=;MKigGw2iXi9Oq31eiuzgZs6F601
 pGlb6RphAIkEYpjRNeQ8ecLKx6/waKXi/MKHZMaZfTHEkXF59hiJOeGULj5Fqhf6Fti/2OpPb
 NzZuo/G0aPPwd9JEozac95/thd/mAINF6EiDYF9WAnQU3KmD9mlkeInMHqZcASj+uKrzDdn6Y
 JdXm7JMC/2ix5rdqthuvY7qNdCDXU4Lk1ROOgvnadnSDJNQ8vcCxOh9dCWrmLwuyS/DBwt4y6
 ownspmGfmTb8pkVvULqD7UnGc3VtXOq5BKSv8PhfQgMbKnP7kKHDvTBSvgJlu2SFTzZwDBqao
 mQYn1Kn7x41G+T4SGGTEEMn0tHarZsRPNrxyEhHWg8rG0YHBK+FPo0C4zFgpcAg6+mUdA5Wpy
 ErBOmwcGjDew6MROAUZXCdev8LPEuf17FM9Us1/VjFvpyNPUmgiKKx3e777aF+MBMNTL5qpYO
 UNkqevPoRp95OOH23MKYdsLLet7q+bkOoGzcqNC1BSTCkzKwK3jmivc+J184/W7YCU3zocDy4
 0nkdY5WJxbgfHx4PGbcgMFAh9Xmu/rT9XFDg3bG3ocwpUbe9rqlAzd62aQdNVW37w1jHxCUwI
 cbzcrrvBifLD9OHnrYSdd+596yLwaddiO2oXrx7IrDOd9tXmqHj5fIROjoHPa8CHtRxSA7T2e
 w6NgHbtLjGArRFYUiczoncNDWa1O3qYF1a+BMwHBRL9Y2cQ8jjsvFs7xztTeRpvF2RFFlVrgk
 DyrxXDfkn/BZfIk6oo2tcB4RPEudGuWQckDRg8QiGvy7X7GP1O3Gb6DtkElEoLU7CF7OL5CAy
 13ZGqlUE21TNmHvPgtMYKWrw5/7P6Ex5PTdnN3FMNioIE=

On 09.05.2024 12.59, FUJITA Tomonori wrote:
> Hi,
>
> On Thu, 9 May 2024 11:52:46 +0200
> Hans-Frieder Vogt <hfdevel@gmx.net> wrote:
>
>> A small addition here:
>> digging through an old Tehuti linux river for the TN30xx (revision
>> 7.33.5.1) I found revealing comments:
>> in bdx_mdio_read:
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Write read command */
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 writel(MDIO_CMD_STAT_VAL(1,=
 device, port), regs +
>> regMDIO_CMD_STAT);
>> in bdx_mdio_write:
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Write write command */
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 writel(MDIO_CMD_STAT_VAL(0,=
 device, port), regs +
>> regMDIO_CMD_STAT);
>>
>> The CMD register has a different layout in the TN40xx, but the logic
>> is
>> similar.
>> Therefore, I conclude now that the value (1 << 15)=C2=A0 is in fact a r=
ead
>> flag. Maybe it could be defined like:
>>
>> #define TN40_MDIO_READ=C2=A0=C2=A0=C2=A0 BIT(15)
> Thanks a lot!
>
> So worth adding MDIO_CMD_STAT_VAL macro and TN40_MDIO_CMD_READ
> definition?
>
>
> diff --git a/drivers/net/ethernet/tehuti/tn40_mdio.c b/drivers/net/ether=
net/tehuti/tn40_mdio.c
> index 64ef7f40f25d..d2e4b4d5ee9a 100644
> --- a/drivers/net/ethernet/tehuti/tn40_mdio.c
> +++ b/drivers/net/ethernet/tehuti/tn40_mdio.c
> @@ -7,6 +7,10 @@
>
>   #include "tn40.h"
>
> +#define TN40_MDIO_CMD_STAT_VAL(device, port) \
> +	(((device) & MDIO_PHY_ID_DEVAD) | (((port) << 5) & MDIO_PHY_ID_PRTAD))

As Andrew pointed out, using the definitions from uapi/linux/mdio.h is a
bad idea, because it is just a coincidence that the definitions work in
this case.
So it is better to use specific defines for TN40xx, for example:

#define TN40_MDIO_DEVAD_MASK=C2=A0=C2=A0=C2=A0 0x001f
#define TN40_MDIO_PRTAD_MASK=C2=A0=C2=A0=C2=A0 0x03e0
#define TN40_MDIO_CMD_VAL(device, port) \
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 (((device) & TN40_MDIO_DEVAD_MASK( =
| (((port) << 5) &
TN40_MDIO_PRTAD_MASK))

note that I left out the _STAT_ from the TN40_MDIO_CMD_VAL, because in
TN40xx the CMD and STAT registers are separate (different from the
TN30xx example).

> +#define TN40_MDIO_CMD_READ BIT(15)
> +
>   static void tn40_mdio_set_speed(struct tn40_priv *priv, u32 speed)
>   {
>   	void __iomem *regs =3D priv->regs;
> @@ -48,13 +52,13 @@ static int tn40_mdio_read(struct tn40_priv *priv, in=
t port, int device,
>   	if (tn40_mdio_get(priv, NULL))
>   		return -EIO;
>
> -	i =3D ((device & 0x1F) | ((port & 0x1F) << 5));
> +	i =3D TN40_MDIO_CMD_STAT_VAL(device, port);
>   	writel(i, regs + TN40_REG_MDIO_CMD);
>   	writel((u32)regnum, regs + TN40_REG_MDIO_ADDR);
>   	if (tn40_mdio_get(priv, NULL))
>   		return -EIO;
>
> -	writel(((1 << 15) | i), regs + TN40_REG_MDIO_CMD);
> +	writel(TN40_MDIO_CMD_READ | i, regs + TN40_REG_MDIO_CMD);
>   	/* read CMD_STAT until not busy */
>   	if (tn40_mdio_get(priv, NULL))
>   		return -EIO;
> @@ -73,8 +77,7 @@ static int tn40_mdio_write(struct tn40_priv *priv, int=
 port, int device,
>   	/* wait until MDIO is not busy */
>   	if (tn40_mdio_get(priv, NULL))
>   		return -EIO;
> -	writel(((device & 0x1F) | ((port & 0x1F) << 5)),
> -	       regs + TN40_REG_MDIO_CMD);
> +	writel(TN40_MDIO_CMD_STAT_VAL(device, port), regs + TN40_REG_MDIO_CMD)=
;
>   	writel((u32)regnum, regs + TN40_REG_MDIO_ADDR);
>   	if (tn40_mdio_get(priv, NULL))
>   		return -EIO;

Thanks!
Hans


