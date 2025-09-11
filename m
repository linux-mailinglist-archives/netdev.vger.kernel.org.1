Return-Path: <netdev+bounces-221980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D70BDB5289C
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 08:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91426A0552F
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 06:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A212580EC;
	Thu, 11 Sep 2025 06:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mvek0Zjq"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4786AF4FA;
	Thu, 11 Sep 2025 06:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757571424; cv=none; b=mEhG/mx+/BM0IGT3kBEOd3auURDXoWsvgtwZYgWTrbW63+HQ8gXHo5CnScx1/RS2mIfIpPlfSj9h7e+OdONF75MWJ9dVTGfaT3NVKmXq1Id6nT/JuMzv7TCwIi7hAvkU/mTR+XAvXyRhrmEqzp5yK7vggVcPp6bj0su2VxUWsew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757571424; c=relaxed/simple;
	bh=6ER7NmlEmraWod3pVcUyD++3p1gLNbMgEjXMejMJ/TY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ec9D7dvZRVDFvz/SSrPpDUjRy5yKopmmLfu0h2HoXj5zOVYtbOPOVArset1C6lQQbTlb7uCi/en0InOGloqQONVKRm7pDY0ANxCx/Pdonl2Y9KjRPIv4XhsXNagO1NyHWmZrs2izsxpAguCDrWpx41g/n6qZgYT6vhiGX9g7JZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mvek0Zjq; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 26A864E40BA4;
	Thu, 11 Sep 2025 06:16:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D126B606D6;
	Thu, 11 Sep 2025 06:16:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6C51D102F29D2;
	Thu, 11 Sep 2025 08:16:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757571417; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=2VfQIzqjmdvrj2wF3mCiNeqmLyVAPi3fnAIClyJ+Xek=;
	b=mvek0ZjqP8arBxPfzTtaJd0OmQcyEUs0lNC4tP0Vft5Dh2JLYm8/QrLjQdvSCH9zKV/u/2
	7trMPMvsMu7aqDZZD/QCoG3+yYd8Dn03DVPt86r+nib40pIosPS/SWqwoZMYmWgj8KNwbF
	Hh77mzogQgcy+GOTR8SsssfVs8WhofvTv+YG66osEKLX0E3NAlhBGXelQpFNiG/H/u4ZXT
	rJubhcvYzcTjrrsHOdhoo92/dsyQEuSkgkeqBzrbduA8+xOeDYjayx2U6Tp1dZ36Y6aS5h
	BMYsDxu4BtpZpSFZ8EWzVHJr1gD+XOtxfjEIifrBSwSQQHrJ4rd8IbjIjcIaBg==
Message-ID: <85faa80c-0536-46d8-8f3a-00ae78499fd0@bootlin.com>
Date: Thu, 11 Sep 2025 08:16:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: microchip: Select SPI_MODE 0 for KSZ8463
To: Tristram.Ha@microchip.com
Cc: thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com,
 Woojung.Huh@microchip.com, pascal.eberhard@se.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com
References: <20250910-fix-omap-spi-v1-1-fd732c42b7be@bootlin.com>
 <DM3PR11MB87367B6B13B1497C5994884BEC0EA@DM3PR11MB8736.namprd11.prod.outlook.com>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <DM3PR11MB87367B6B13B1497C5994884BEC0EA@DM3PR11MB8736.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Tristram

On 9/11/25 12:10 AM, Tristram.Ha@microchip.com wrote:
>> KSZ8463 expects the SPI clock to be low on idle and samples data on
>> rising edges. This fits SPI mode 0 (CPOL = 0 / CPHA = 0) but the SPI
>> mode is set to 3 for all the switches supported by the driver. This
>> can lead to invalid read/write on the SPI bus.
>>
>> Set SPI mode to 0 for the KSZ8463.
>> Leave SPI mode 3 as default for the other switches.
>>
>> Signed-off-by: Bastien Curutchet (Schneider Electric)
>> <bastien.curutchet@bootlin.com>
>> Fixes: 84c47bfc5b3b ("net: dsa: microchip: Add KSZ8463 switch support to KSZ DSA
>> driver")
>> ---
>>   drivers/net/dsa/microchip/ksz_spi.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/dsa/microchip/ksz_spi.c
>> b/drivers/net/dsa/microchip/ksz_spi.c
>> index
>> d8001734b05741446fa78a1e88c2f82e894835ce..dcc0dbddf7b9d70fbfb31d4b260b80
>> ca78a65975 100644
>> --- a/drivers/net/dsa/microchip/ksz_spi.c
>> +++ b/drivers/net/dsa/microchip/ksz_spi.c
>> @@ -139,6 +139,7 @@ static int ksz_spi_probe(struct spi_device *spi)
>>          const struct regmap_config *regmap_config;
>>          const struct ksz_chip_data *chip;
>>          struct device *ddev = &spi->dev;
>> +       u32 spi_mode = SPI_MODE_3;
>>          struct regmap_config rc;
>>          struct ksz_device *dev;
>>          int i, ret = 0;
>> @@ -155,8 +156,10 @@ static int ksz_spi_probe(struct spi_device *spi)
>>          dev->chip_id = chip->chip_id;
>>          if (chip->chip_id == KSZ88X3_CHIP_ID)
>>                  regmap_config = ksz8863_regmap_config;
>> -       else if (chip->chip_id == KSZ8463_CHIP_ID)
>> +       else if (chip->chip_id == KSZ8463_CHIP_ID) {
>>                  regmap_config = ksz8463_regmap_config;
>> +               spi_mode = SPI_MODE_0;
>> +       }
>>          else if (chip->chip_id == KSZ8795_CHIP_ID ||
>>                   chip->chip_id == KSZ8794_CHIP_ID ||
>>                   chip->chip_id == KSZ8765_CHIP_ID)
>> @@ -185,7 +188,7 @@ static int ksz_spi_probe(struct spi_device *spi)
>>                  dev->pdata = spi->dev.platform_data;
>>
>>          /* setup spi */
>> -       spi->mode = SPI_MODE_3;
>> +       spi->mode = spi_mode;
>>          ret = spi_setup(spi);
>>          if (ret)
>>                  return ret;
>>
>> ---
>> base-commit: c65e2aee8971eb9d4bc2b8edc3a3a62dc98f0410
>> change-id: 20250910-fix-omap-spi-d7c64f2416df
> 
> Actually it is best to completely remove the code.  The SPI mode should
> be dictated by spi-cpol and spi-cpha settings in the device tree.  I do
> not know why that code was there from the beginning.
> 

Ok, I didn't know these settings were available on the device-tree, I 
can remove the spi->mode setting in a new patch.

> All KSZ switches can use SPI mode 0 and 3, and 3 is recommended for high
> SPI frequency.  Sometimes a bug/quirk in the SPI bus driver prevents the
> very first SPI transfer to be successful in mode 3 because of a missed
> rising edge clock signal, so it is forced to use mode 0.  (The Atmel SPI
> bus driver has this issue in some old kernel versions.)
> 
> As for KSZ8463 I have always used mode 3 and do not know of any issue of
> using that mode.
> 

I have issues on the first transfer with the AM335x's spi-omap2-mcspi 
driver. I first tried to fix this driver but since the KSZ8463's 
datasheet explicitly mentions that it expects the CLK to be low at idle, 
I thought this was the right fix.

But I'll fix the SPI driver then, thanks.


Best regards,
-- 
Bastien Curutchet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


