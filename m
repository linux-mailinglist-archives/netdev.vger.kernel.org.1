Return-Path: <netdev+bounces-121997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1162195F83C
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 19:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F34B1F2384F
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 17:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EBB198E9E;
	Mon, 26 Aug 2024 17:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="jPJDZERc"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3700198E88
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693749; cv=none; b=aT2S7askKe7nlUGAd1OAwZ57mI6tRZ80QWptPAN+yHk/l1PE6SXzNdPjyj5nPflSFRjx4QM97UGZp72XbFaabz3owUgxL7o7iPYQ9rw1vKCHbozzsuPRKk5YYocAkmrgnG1VRxDtw4eNO7ieqQ6b2JttKsQyoyhcXoclaculMfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693749; c=relaxed/simple;
	bh=1samvkhDvzTOP0gikDIQ509zs8bqq5QXczVt8Pkw9Mk=;
	h=Message-ID:Date:MIME-Version:Subject:References:To:Cc:From:
	 In-Reply-To:Content-Type; b=Dh1MRcfMH//1YH3tM8LmYHqCo4mBaIgLGbi5QaXt7cuT8zHwK1ZbFVp1zJBvBMXclb887tUQHw8+EzWiLxqec15VdqzeO28h7OLYU48Fm6s6Mh4VXu37AvDGRFdepr0NP5x++8x/tRHN19r9QQhHGVpwQpBrvu4wWsvvnP/7Yv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=jPJDZERc; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1724693734; x=1725298534; i=hfdevel@gmx.net;
	bh=Oe2MOEf2g2KWh0THJXV/wJ2j/HoWrQ4t4yyoDO1alEU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:
	 References:To:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jPJDZERc334YDRC9PbmxJ9jR9BZ2BrCM56Lo5PBp7XcFiHYNem1XGsMDWqE1Tf5h
	 HKyqRtX02/etp/7sXCGhMZjzGo5PTlKavS/e1zz4OQSOWmDOP4qzKCCRCAgikqRRz
	 ajOh8z4N7/eiVkKEncFnCQkdlDVWnxUPL9JXHq75cTQzrBgRfkcajHMshKT7eExYx
	 3WTTErlcd/ljdexi4D/VMA5Iuj+s/D4KklgtlIWhnzMO4BjmfID2FpkOrPUQg/ASu
	 Oxbb/54kpURviMOPZB8LjtEIXAc6Dx3/bE0n4dX0JYIzSA1t5yO+NR2PVN315yEoa
	 B0eDDDhiHRiAZ3GOXg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.0.23] ([77.33.175.99]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8ob6-1s4Mq33Lug-0153Vb; Mon, 26
 Aug 2024 19:35:33 +0200
Message-ID: <a5eb4909-afd4-4a23-93f9-7d9c1d9ac893@gmx.net>
Date: Mon, 26 Aug 2024 19:35:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: phy: aquantia: create firmware name for
 aqr PHYs at runtime
Content-Language: en-US
References: <e8b4f44f-97e2-4532-9d0a-a024958fc0a0@gmx.net>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>
From: Hans-Frieder Vogt <hfdevel@gmx.net>
In-Reply-To: <e8b4f44f-97e2-4532-9d0a-a024958fc0a0@gmx.net>
X-Forwarded-Message-Id: <e8b4f44f-97e2-4532-9d0a-a024958fc0a0@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/rppaMB441CQGClcDSaxm2KykIDnjJivTxL8Rf66efqLqBZeYHj
 jp4LMck4wqxatGwkRnX4ufpXZLrkxF6/JjLRVR7vMfdCGQNN90jkJkHmQit4ohT1avI8vkd
 ew4iwYsSnmkaZObOZ9lyI3PaeB3lHNzYtU8+KZRffVUGuWHb7XXg6cRVGxieVJpOvuBYb72
 coupwtPQBvEAaUzpEmeXg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:weSWFKfnskE=;hJ8DYNLVnjNY8xw0TXsjLOnWOP6
 RvaDaBN07KYnaxeLg14DcXnON547Ny5wAVUycWzPRTNOjcgoO11dKtgixCESww4tWnGM1Rv7s
 FTt9AJMB7H8WWctz7IFWV9nsguV7HsPvF6Y6s9itbyIEzoyCKPGgrFFM4PfYCqiYsIdL3ePFs
 Sy7azYuk8jACzV9mK1XEeMWXvnV2khm+BhQwKlGyee6vR5Fp8gxd6no9HIqEScZm+dMBi2j0d
 ZbmwrQ/a/O17/7eAGzESQ740DPT3AvcDYhRaX+XLVuVUFDH0ynykGcVa5SMkt9Ym46mddaCcq
 pkKRlRjGlv1GMBPLWGhdcVD8g8d+dw5wBYLivWmnq/G3Vry8KalAQn7kVz1O8V8TiJU1PtYIK
 kffRLGcYVJklHVKrsMI5dZIx1dYEthOwscn3aaIgpQ4qPpwy2Vt2YH6Mdq/na+hqJqQPJl+xK
 HFRss4DdeactviAMXi2I+XjK/cG/fpS/x+LUXyWWM2k7vK8Z8TN3VX+SCyXgTf0kbv5Lh0mE9
 NtGOOem8SmlE76c2uouEJg3cbG41GsQstAqD7yy8iCCQ6aAsndVUTp0T/4VWXbbGS75s997T9
 wIiiy4Pz5uVdzCuMUEI9yNNADyXD+/48hVjEvKoR0tiSwdgv7h1NNKlEF2UCNpqC7i1fKJ2Ms
 anOl8dcuMWXxdWHWnY1bG+rVNZtA0jwgV5UfDWraQL62ig4naVFw2+HepdEMVtX52dfReA8GT
 RN68LWIW5vZ217hUbJsGtYs4/LM+aPH26eQKM/OFoBZhcJ86uVLHEnbGBoii5pFqsQ4IMZLR6
 ne/oMdIlD/fXoC3G+lgsFwYg==

On 25.08.2024 10.43, Simon Horman wrote:
> On Sat, Aug 24, 2024 at 07:34:07PM +0200, Hans-Frieder Vogt wrote:
>> Aquantia PHYs without EEPROM have to load the firmware via the file sys=
tem and
>> upload it to the PHY via MDIO.
>> Because the Aquantia PHY firmware is different for the same PHY dependi=
ng on the
>> MAC it is connected to, it is not possible to statically define the fir=
mware name.
>> When in an embedded environment, the device-tree can provide the file n=
ame. But when the PHY is on a PCIe card, the file name needs to be provide=
d in a different
>> way.
>>
>> This patch creates a firmware file name at run time, based on the Aquan=
tia PHY
>> name and the MDIO name. By this, firmware files for ths same PHY, but c=
ombined
>> with different MACs are distinguishable.
>>
>> The proposed naming uses the scheme:
>> 	mdio/phy-mdio_suffix
>> Or, in the case of the Tehuti TN9510 card (TN4010 MAC and AQR105 PHY), =
the firmware
>> file name will be
>> 	tn40xx/aqr105-tn40xx_fw.cld
>>
>> This naming style has been chosen in order to make the filename unique,=
 but also
>> to place the firmware in a directory named after the MAC, where differe=
nt firmwares
>> could be collected.
>>
>> Signed-off-by: Hans-Frieder Vogt<hfdevel@gmx.net>
> Please consider running this patch through:
>
> ./scripts/checkpatch.pl --strict --codespell --max-line-length=3D80
Sure, will do.
>> ---
>>   drivers/net/phy/aquantia/aquantia_firmware.c | 78 +++++++++++++++++++=
+
>>   1 file changed, 78 insertions(+)
>>
>> diff --git a/drivers/net/phy/aquantia/aquantia_firmware.c b/drivers/net=
/phy/aquantia/aquantia_firmware.c
>> index 524627a36c6f..265bd6ee21da 100644
>> --- a/drivers/net/phy/aquantia/aquantia_firmware.c
>> +++ b/drivers/net/phy/aquantia/aquantia_firmware.c
>> @@ -5,6 +5,7 @@
>>   #include <linux/firmware.h>
>>   #include <linux/crc-itu-t.h>
>>   #include <linux/nvmem-consumer.h>
>> +#include <linux/ctype.h>	/* for tolower() */
>>
>>   #include <asm/unaligned.h>
>>
>> @@ -321,6 +322,81 @@ static int aqr_firmware_load_nvmem(struct phy_devi=
ce *phydev)
>>   	return ret;
>>   }
>>
>> +/* derive the filename of the firmware file from the PHY and the MDIO =
names
>> + * Parts of filename:
>> + *   mdio/phy-mdio_suffix
>> + *    1    2   3    4
>> + * allow name components 1 (=3D 3) and 2 to have same maximum length
>> + */
>> +static int aqr_firmware_name(struct phy_device *phydev, const char **n=
ame)
>> +{
>> +#define AQUANTIA_FW_SUFFIX "_fw.cld"
>> +#define AQUANTIA_NAME "Aquantia "
>> +/* including the trailing zero */
>> +#define FIRMWARE_NAME_SIZE 64
>> +/* length of the name components 1, 2, 3 without the trailing zero */
>> +#define NAME_PART_SIZE ((FIRMWARE_NAME_SIZE - sizeof(AQUANTIA_FW_SUFFI=
X) - 2) / 3)
> nit: I would have made these declarations outside of aqr_firmware_name()=
,
>       probably near the top of this file.
will follow=C2=A0 your advice (if still needed in the next version of the =
patch)
>> +	ssize_t len, mac_len;
>> +	char *fw_name;
>> +	int i, j;
>> +
>> +	/* sanity check: the phydev drv name needs to start with AQUANTIA_NAM=
E */
>> +	if (strncmp(AQUANTIA_NAME, phydev->drv->name, strlen(AQUANTIA_NAME)))
>> +		return -EINVAL;
> A general comment: I've been over the string handling in this file.
> And it seems correct to me. But it is pretty hairy, and I could
> well have missed a problem. String handling in C is like that.
To be honest, I am also not overly happy about the string handling. At
least I
tried to implement it as safe as possible by using strscpy wherever I
saw a risk.
>> +
>> +	/* sanity check: the phydev drv name may not be longer than NAME_PART=
_SIZE */
>> +	if (strlen(phydev->drv->name) - strlen(AQUANTIA_NAME) > NAME_PART_SIZ=
E)
>> +		return -E2BIG;
>> +
>> +	/* sanity check: the MDIO name must not be empty */
>> +	if (!phydev->mdio.bus->id[0])
>> +		return -EINVAL;
>> +
>> +	fw_name =3D devm_kzalloc(&phydev->mdio.dev, FIRMWARE_NAME_SIZE, GFP_K=
ERNEL);
>> +	if (!fw_name)
>> +		return -ENOMEM;
>> +
>> +	/* first the directory name =3D MDIO bus name
>> +	 * (only name component, firmware name part 1; remove busids and the =
likes)
>> +	 * ignore the return value of strscpy: if the MAC/MDIO name is too lo=
ng,
>> +	 * it will just be truncated
>> +	 */
>> +	strscpy(fw_name, phydev->mdio.bus->id, NAME_PART_SIZE + 1);
>> +	for (i =3D 0; fw_name[i]; i++) {
>> +		if (fw_name[i] =3D=3D '-' || fw_name[i] =3D=3D '_' || fw_name[i] =3D=
=3D ':')
>> +			break;
>> +	}
>> +	mac_len =3D i;	/* without trailing zero */
>> +
>> +	fw_name[i++] =3D '/';
>> +
>> +	/* copy name part beyond AQUANTIA_NAME into our name buffer - name pa=
rt 2 */
>> +	len =3D strscpy(&fw_name[i], phydev->drv->name + strlen(AQUANTIA_NAME=
),
>> +		      FIRMWARE_NAME_SIZE - i);
>> +	if (len < 0)
>> +		return len;	/* should never happen */
>> +
>> +	/* convert the name to lower case */
>> +	for (j =3D i; j < i + len; j++)
>> +		fw_name[j] =3D tolower(fw_name[j]);
>> +	i +=3D len;
>> +
>> +	/* split the phy and mdio components with a dash */
>> +	fw_name[i++] =3D '-';
>> +
>> +	/* copy again the mac_name into fw_name - name part 3 */
>> +	memcpy(&fw_name[i], fw_name, mac_len);
> Are you completely sure that there are mac_len bytes available here?
> I appreciate that you need to clamp the number of source bytes.
> But elsewhere, where strscpy(), the space available at the destination
> is bounded for safety. And that is missing here.
mac_len is always defined and between 0 and NAME_PART_SIZE. And by
ensuring that
NAME_PART_SIZE is less than 1/3 of the length of the allocated string, I
consider
this safe.
However, it is definitely not beautiful.
>> +
>> +	/* copy file suffix (name part 4 - don't forget the trailing '\0') */
>> +	len =3D strscpy(&fw_name[i + mac_len], AQUANTIA_FW_SUFFIX, FIRMWARE_N=
AME_SIZE - i - mac_len);
> nit: I might have incremented i by mac_len to slightly simplify the abov=
e.
good point!
>> +	if (len < 0)
>> +		return len;	/* should never happen */
>> +
>> +	if (name)
> name is never NULL. I would drop this condition.
sure.
>> +		*name =3D fw_name;
>> +	return 0;
>> +}
>> +
>>   static int aqr_firmware_load_fs(struct phy_device *phydev)
>>   {
>>   	struct device *dev =3D &phydev->mdio.dev;
>> @@ -330,6 +406,8 @@ static int aqr_firmware_load_fs(struct phy_device *=
phydev)
>>
>>   	ret =3D of_property_read_string(dev->of_node, "firmware-name",
>>   				      &fw_name);
>> +	if (ret)
>> +		ret =3D aqr_firmware_name(phydev, &fw_name);
>>   	if (ret)
>>   		return ret;
>>
>> --
>> 2.43.0
>>
>>
Thanks Simon, for your review comments!

