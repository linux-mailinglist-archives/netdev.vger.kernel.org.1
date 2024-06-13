Return-Path: <netdev+bounces-103261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDABA90751B
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 16:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6171F21C8B
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 14:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86692142E73;
	Thu, 13 Jun 2024 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="CTFpJw+O"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5C91DFFC
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 14:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718288682; cv=none; b=su1zlq4kgbQ4MG5+lOUZrwJVaiPJ+GInsfD9d9cvJS6VDN+ehHscRAjsMqY0f6hOVLMvQ6x+H0ju/H37BGjsdc0zzzXiVidc2zWnXwHzhsVp78XAFul2IHrcivnVpICCC/74Maz06zNP2zaDqIQROzj08VLExSxhAlsWDNg7G7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718288682; c=relaxed/simple;
	bh=nnE8k3ub/icaxcx+8Qp9atFWGWYY9v/PFXRPJrdwH/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=khHD2YaJvt0aVEFgNjbh5U82M6qn92+QAnTv/KdjdqNKMt3iexfqcB476AuXKdOidntjQOn8TcjueYPC2atA9hYHDHX22FLbivnHW6EfJh7o9g8FITIAYphFTdlWpi2ux/AmLq3az3V00lqH/wkgStm/0of/mv6Z5Rp7k0moKOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=CTFpJw+O; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id A0D2E9C5795;
	Thu, 13 Jun 2024 10:24:30 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id ggDzvPW6WWnC; Thu, 13 Jun 2024 10:24:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 5B58F9C585F;
	Thu, 13 Jun 2024 10:24:29 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 5B58F9C585F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1718288669; bh=gAged8l7x9tNqLXikIwhQbJTvaMOe8LVS4SK+e8ODio=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=CTFpJw+Oya/L/LuCaIClnX3TF2XjKviO7xrqKvOpQ7YMPfgATriN+lwntrBoFvbZE
	 3bGh/EyIF2j8heRW2iA4HMYl+Xq8fpW7bv9arncLm80Ffepe4KG6V65UT79rfMPD1/
	 qEwY0/fju31Tnjlt5FxjvtF9WNUHgyz2PzrGGKVTTHoRw4aJWLWBchJtY+hmfvbZqD
	 yvY25bWi3rE+apIAnvHncAUsLWxsnb0e8ucl+fmqGnt9XIrQmevWfVZxiYZqCHrk4L
	 CcNEwfV97ZQA+d8dzFIIhqfJ+alc9b14wIdjpRLQ/aN3TcY8ofX416eNOH4toXespk
	 cX9SZMaT62mhw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id r_ECRb8mhKlJ; Thu, 13 Jun 2024 10:24:29 -0400 (EDT)
Received: from [192.168.216.123] (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id CF74F9C5795;
	Thu, 13 Jun 2024 10:24:28 -0400 (EDT)
Message-ID: <6972b36e-2ee2-4b8b-9a35-147fe842a8cd@savoirfairelinux.com>
Date: Thu, 13 Jun 2024 16:24:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KSZ9897 RMII ports support
To: Woojung.Huh@microchip.com
Cc: UNGLinuxDriver@microchip.com, netdev@vger.kernel.org
References: <21cd1015-dae8-414e-84d3-a250247a0b51@savoirfairelinux.com>
 <BL0PR11MB291351263F7C03607F84F965E7FB2@BL0PR11MB2913.namprd11.prod.outlook.com>
Content-Language: en-US
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
In-Reply-To: <BL0PR11MB291351263F7C03607F84F965E7FB2@BL0PR11MB2913.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I've simplified my dts accordingly (see bellow). However, I no longer 
receive packets on my bridge interface. Interfaces eth0, br0 and 
external ports properly report link UP and I can see RX counters going 
up on the external ports interfaces (sw0p*). Yet, ifconfig now reports 0 
RX packets on eth0 and br0 now, while I see 0 TX packets on sw0p*.

```
$ ifconfig
br0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:24 errors:0 dropped:0 overruns:0 carrier:0

eth0
           UP BROADCAST RUNNING MULTICAST  MTU:1506  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:62 errors:0 dropped:0 overruns:0 carrier:0

sw0p1
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:866 errors:862 dropped:862 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
```

My bridge configuration is based on the dsa documentation:
  - 
https://docs.kernel.org/networking/dsa/configuration.html#configuration-with-tagging-support

Could you help me understand what's missing to properly exchange packets 
through my bridge interface with the new RMII configuration?

It's possible the previous phy_id being read corresponded to the other 
SOM's Ethernet's PHY since it used the same MDIO address I had declared 
in the DTS.

Thanks for your support,

Enguerrand de Ribaucourt
Savoir-faire Linux

```c
ethernet@20b4000 {
	compatible = "fsl,imx6ul-fec\0fsl,imx6q-fec";
	...
	/delete-property/ phy-mode;
	/delete-property/ phy-handle;
	phandle = <0x0c>;
	fixed-link {
		speed = <0x64>;
		full-duplex;
	};
};

spi@2010000 {
	ksz9897@0 {
		ports {
			port@5 {
				reg = <0x05>;
				label = "cpu";
				ethernet = <0x0c>;
				phy-mode = "rmii";
				rx-internal-delay-ps = <0x5dc>;
				fixed-link {
					speed = <0x64>;
					full-duplex;
				};
			};
		};
	};
};

ethernet@2188000 {
	status = "disabled";
};
```

On 07/06/2024 17:39, Woojung.Huh@microchip.com wrote:
> Hi Enguerrand,
> 
> Thanks for creating new thread. Continue from [1].
> 
> You can check SAMA5 + KSZ9477 EVB DTS.
> [2] is host MAC side setting and
> [3] is host port setting of KSZ switch side.
> 
> Your ethernet@20b4000 has phy-handle which is not in [2].
> "phy-handle = <0x15>" specifies to "ksz9897port5@1" under "mdio".
> I think this is setting you don't need to specify.
> 
> "fixed-link" under "ethernet@20b4000" already specified
> there is no PHY (fixed phy) for "ethernet@20b4000" and it is enough.
> 
> KSZ9897 shares a pin on SDI/SDA/MDIO, no MDIO is active in your setup because
> SPI is enable for KSZ switch control access.
> I guess "ksz9897port5@1" under "mdio" causes phy scanning on host MDIO bus,
> and assume that there is KSZ8081 PHY on the host system (probably on NET1?)
> 
> Please let me know my assessment is not correct. We can continue to debug this issue.
> 
>> ```c
>> ethernet@20b4000 {
>>       compatible = "fsl,imx6ul-fec\0fsl,imx6q-fec";
>>       ...
>>       phy-mode = "rmii";
>>       phy-handle = <0x15>;
>>       fixed-link {
>>           speed = <0x64>;
>>           full-duplex;
>>       };
>> };
>>
>> // MDIO bus is only defined on eth1 but shared with eth2
>> ethernet@2188000 {
>>           ...
>>       mdio {
>>                   ...
>>           ksz9897port5@1 {
>>               compatible = "ethernet-phy-ieee802.3-c22";
>>               ...
>>               clock-names = "rmii-ref";
>>               phandle = <0x15>;
>>           };
>> };
>>
>> spi@2010000 {
>>           ...
>>       ksz9897@0 {
>>           compatible = "microchip,ksz9897";
>>           ...
>>           ports {
>>               ...
>>               // GMAC6
>>               port@5 {
>>                   reg = <0x05>;
>>                   label = "cpu";
>>                   ethernet = <0x0c>;
>>                   phy-mode = "rmii";
>>                   rx-internal-delay-ps = <0x5dc>;
>>                   fixed-link {
>>                       speed = <0x64>;
>>                       full-duplex;
>>                   };
>>               };
>>           };
>>       };
>> };
>> ```
> 
> 
> [1] https://lore.kernel.org/netdev/BL0PR11MB2913BABB130DAB1E768810EFE7FB2@BL0PR11MB2913.namprd11.prod.outlook.com/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts#n50
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts#n150
> 
>> -----Original Message-----
>> From: Enguerrand de Ribaucourt <enguerrand.de-
>> ribaucourt@savoirfairelinux.com>
>> Sent: Friday, June 7, 2024 9:57 AM
>> To: Woojung Huh - C21699 <Woojung.Huh@microchip.com>; netdev
>> <netdev@vger.kernel.org>
>> Cc: UNGLinuxDriver <UNGLinuxDriver@microchip.com>
>> Subject: KSZ9897 RMII ports support
>>
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the
>> content is safe
>>
>> Hello, this is a follow up to:
>>
>> https://lore.kernel.org/netdev/BL0PR11MB2913BABB130DAB1E768810EFE7FB2@BL0PR1
>> 1MB2913.namprd11.prod.outlook.com/
>>
>> I have submitted patches to support the KSZ9897 RMII port (GMAC6)
>> connected to an i.MX6ULL (See above discussion). The current patch
>> implements a pseudo PHY-ID because the one emitted by KSZ9897R collides
>> with KSZ8081.
>>
>> Are there other ways to support this RMII connection that we want to
>> explore?
>>
>> Best Regards,
>>
>> Enguerrand de Ribaucourt

