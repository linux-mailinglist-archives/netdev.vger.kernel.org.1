Return-Path: <netdev+bounces-101719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F01A8FFDD6
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 10:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 431D828AEE0
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 08:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7ACF15ADA5;
	Fri,  7 Jun 2024 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="h53hGQBX"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A811C2AF
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 08:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717747872; cv=none; b=sHHC/gRu3YUXWllbPb13/v7SldiObFG7dzZgXZ1/qVd9A5rSz7AvFyzqtkNUzLtsadrE99OVg0/arABRj40dqE1Er6agur0hZvyE+WA+ruUd7uu6dCgUOm7BDPNcFmlh8RHIn+V1/xE2LDppbvXGjuwY0oIVv5wP28tG6xRYqY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717747872; c=relaxed/simple;
	bh=UiibZOV8dv3gVGo6/ftmKfYdRgB2AQl876abtG8iN0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SQ/ZPIfeO+4dRHuqDM9MZ0Rd1wqRb0cGpIidkY9AQ5+Zv/633DgMi+wraTBIPJxsmI3LcNAnZWqtUp36Nr5LdmJ5mvth2tbKccGVmxlULOhWK9dhXKYpklSnrphuykV+zlcvTv9OodAhZEdHkEFnNsmEKhEs1gyEi65Za1ThmTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=h53hGQBX; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 79F759C5961;
	Fri,  7 Jun 2024 04:11:07 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id zrPEdqXrvnvH; Fri,  7 Jun 2024 04:11:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 4E06E9C58D5;
	Fri,  7 Jun 2024 04:11:04 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 4E06E9C58D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1717747864; bh=uI9In71hCyKrJQdE+I1daVDesOnB1DoiPa70KM+E+mM=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=h53hGQBXE+UV7apBZFQX38IQa4Qm9rDjtWMwOgg3dmRKGA8w0iX7rVdxmJezOXvw6
	 ykuXNBJDRrPoeuPtWPZXmVs7rA39UuSnZwUkm0kdoW15tc27Ie8XrW4piBzoUoroGj
	 r1y9a0FnCyzOfqtCRDQXMjye5d0ZItPffh86woF0cbyzGyZ8qfyWf1O60Hp2xd0Bp/
	 69VItpMvxWxCsXaBjXF4JjWFxwukIl8nldFMLU+ehvX6tlWm7VwFSmCMRhvAbCfffq
	 Yykn+t7BkhjlXv/ScOT/4U8yVMnk8jFo/vSF8ANbfrz3ir2d7UwkpGd28uCLahLrhJ
	 MGOTaSaJQooVw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id A3xJb059RVKR; Fri,  7 Jun 2024 04:11:04 -0400 (EDT)
Received: from [192.168.216.123] (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 0EEA89C585F;
	Fri,  7 Jun 2024 04:11:02 -0400 (EDT)
Message-ID: <2e37f014-d9f5-4a09-93b2-81543399d2c4@savoirfairelinux.com>
Date: Fri, 7 Jun 2024 10:11:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 1/4] net: phy: micrel: add Microchip KSZ 9897
 Switch PHY support
To: Woojung.Huh@microchip.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 UNGLinuxDriver@microchip.com, horms@kernel.org, Tristram.Ha@microchip.com,
 Arun.Ramadoss@microchip.com, netdev@vger.kernel.org
References: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240604092304.314636-2-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <BL0PR11MB2913D8FC28BA3569FDADD4A7E7F82@BL0PR11MB2913.namprd11.prod.outlook.com>
 <19eef958-5222-4663-bd94-5a5fb3d65caf@savoirfairelinux.com>
 <BL0PR11MB29133CF39DA619F1AAF1DE95E7FA2@BL0PR11MB2913.namprd11.prod.outlook.com>
Content-Language: en-US
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
In-Reply-To: <BL0PR11MB29133CF39DA619F1AAF1DE95E7FA2@BL0PR11MB2913.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hello,

The exact hardware is a Phycore-i.MX6ULL. ENET2 is directly the 
i.MX6ULL's FEC that connects to port 6 of the KSZ9897R (GMAC6) in RMII:

  - X_ENET2_TX_CLK -- TX_CLK6
  - X_ENET2_TX_EN  -- TX_CTL6
  - X_ENET2_TX_D1  -- TXD6_1
  - X_ENET2_TX_D0  -- TXD6_0
  - X_ENET2_RX_EN  -- RX_CTL6
  - X_ENET2_RX_ER  -- RX_ER6
  - X_ENET2_RX_D1  -- RXD6_1
  - X_ENET2_RX_D0  -- RXD6_0

The DSA control is using SPI, but not involved in reading the phy_id in 
my case.

This is materialized in my device tree:

```c
ethernet@20b4000 {
	compatible = "fsl,imx6ul-fec\0fsl,imx6q-fec";
	...
	phy-mode = "rmii";
	phy-handle = <0x15>;
	fixed-link {
		speed = <0x64>;
		full-duplex;
	};
};

// MDIO bus is only defined on eth1 but shared with eth2
ethernet@2188000 {
         ...
	mdio {
                 ...
		ksz9897port5@1 {
			compatible = "ethernet-phy-ieee802.3-c22";
			...
			clock-names = "rmii-ref";
			phandle = <0x15>;
		};
};

spi@2010000 {
         ...
	ksz9897@0 {
		compatible = "microchip,ksz9897";
		...
		ports {
			...
			// GMAC6
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
```

Before I implemented the pseudo phy_id, it was read in the generic IEEE 
clause 22 PHY registers, through the compatible 
"ethernet-phy-ieee802.3-c22". That would be implemented in 
get_phy_c22_id() in MII_PHYSID1/2 registers at 0x2 of the MDIO device.

It is not read through SPI registers 0x6104-0x6105 which are not defined 
in the datasheet for port 6/7 (section 5.2.2.3):
	Address: 0xN104, Size: 16 bits, Port N: 1-5

Do you have other suggestions to read the phy_id?

Thanks for your support,
Enguerrand de Ribaucourt


On 07/06/2024 00:57, Woojung.Huh@microchip.com wrote:
> Hi Enguerrand,
> 
> We still can't reproduce what you observed with KSZ9897.
> 
> Just to be sure, you accessed PHY register of Port 6 which is GMAC6.
> It is directly connected to MAC of i.MX6ULL over RMII.
> I guess the PHY ID access is register 0x6104-0x6105 of KSZ9897.
> And, return value of PHY ID is 0x0022-0x1561.
> 
> Correct understanding?
> > Thanks.
> Woojung
> 
>> -----Original Message-----
>> From: Enguerrand de Ribaucourt <enguerrand.de-
>> ribaucourt@savoirfairelinux.com>
>> Sent: Wednesday, June 5, 2024 4:34 AM
>> To: Woojung Huh - C21699 <Woojung.Huh@microchip.com>
>> Cc: andrew@lunn.ch; hkallweit1@gmail.com; linux@armlinux.org.uk;
>> UNGLinuxDriver <UNGLinuxDriver@microchip.com>; horms@kernel.org; Tristram Ha
>> - C24268 <Tristram.Ha@microchip.com>; Arun Ramadoss - I17769
>> <Arun.Ramadoss@microchip.com>; netdev@vger.kernel.org
>> Subject: Re: [PATCH net v5 1/4] net: phy: micrel: add Microchip KSZ 9897
>> Switch PHY support
>>
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the
>> content is safe
>>
>> Hello,
>>
>> On 04/06/2024 22:49, Woojung.Huh@microchip.com wrote:
>>> Hi Enguerrand,
>>>
>>> Can you help me to understand your setup? I could see you are using
>>>    - Host CPU : i.MX6ULL
>>>    - DSA Switch : KSZ9897R (https://www.microchip.com/en-us/product/ksz9897)
>>>    - Host-to-KSZ interface : RGMII for data path & SPI for control
>>> Based on this, CPU port is either GMAC6 or GMAC7 (Figure 2-1 of [1])
>>>
>>> I have two questions for you.
>>> 1. PHY on CPU port
>>>      Which GMAC (or port number) is connected between Host CPU and KSZ9897R?
>>>      If CPU port is either GMAC6 or GMAC7, it is just a MAC-to-MAC
>> connection over RGMII.
>>
>> I'm using port number 6 as the CPU port for KSZ9897R. GMAC6 is directly
>> connected to the MAC of i.MX6ULL (driver is i.MX fec). I'm using RMII
>> since gigabit is not supported by the i.MX6ULL.
>>
>>> 2. PHY ID
>>>      Its PHY ID is different when checking datasheet of KSZ9897 and KSZ8081.
>>>      PHY ID of Port 1-5 of KSZ9897 is 0x0022-0x1631 per [1]
>>>      PHY ID of KSZ8081 is 0x0022-0x0156x per [2]
>> That's true for port 1-5, however, I found out that the phy_id emitted
>> by GMAC6 is 0x00221561. It is the same as KSZ8081-revA3 according to the
>> datasheet. I also studied all registers at runtime for a reliable
>> difference to implement something like ksz8051_ksz8795_match_phy_device
>> between GMAC6 and KSZ8081, but none appeared to me. Following
>> suggestions by Andrew Lunn, I added this virtual phy_id (0x002217ff) to
>> hardcode in the devicetree. I'm happy with this solution.
>>>
>>> Beside patch, you can create a ticket to Microchip site
>> (https://microchipsupport.force.com/s/supportservice)
>>> if you think it is easier to solve your problem.
>> I created a joined ticket for tracking (Case number 01457279).
>>>
>>
>> Thank you very much for your time,
>>
>> Enguerrand de Ribaucourt
>>
>>> Best regards,
>>> Woojung
>>>
>>> [1]
>> https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocume
>> nts/DataSheets/KSZ9897R-Data-Sheet-DS00002330D.pdf
>>> [2] https://www.microchip.com/en-us/product/ksz8081#document-table
>>>
>>>> -----Original Message-----
>>>> From: Enguerrand de Ribaucourt <enguerrand.de-
>>>> ribaucourt@savoirfairelinux.com>
>>>> Sent: Tuesday, June 4, 2024 5:23 AM
>>>> To: netdev@vger.kernel.org
>>>> Cc: andrew@lunn.ch; hkallweit1@gmail.com; linux@armlinux.org.uk; Woojung
>> Huh
>>>> - C21699 <Woojung.Huh@microchip.com>; UNGLinuxDriver
>>>> <UNGLinuxDriver@microchip.com>; horms@kernel.org; Tristram Ha - C24268
>>>> <Tristram.Ha@microchip.com>; Arun Ramadoss - I17769
>>>> <Arun.Ramadoss@microchip.com>; Enguerrand de Ribaucourt <enguerrand.de-
>>>> ribaucourt@savoirfairelinux.com>
>>>> Subject: [PATCH net v5 1/4] net: phy: micrel: add Microchip KSZ 9897
>> Switch
>>>> PHY support
>>>>
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know
>> the
>>>> content is safe
>>>>
>>>> There is a DSA driver for microchip,ksz9897 which can be controlled
>>>> through SPI or I2C. This patch adds support for it's CPU ports PHYs to
>>>> also allow network access to the switch's CPU port.
>>>>
>>>> The CPU ports PHYs of the KSZ9897 are not documented in the datasheet.
>>>> They weirdly use the same PHY ID as the KSZ8081, which is a different
>>>> PHY and that driver isn't compatible with KSZ9897. Before this patch,
>>>> the KSZ8081 driver was used for the CPU ports of the KSZ9897 but the
>>>> link would never come up.
>>>>
>>>> A new driver for the KSZ9897 is added, based on the compatible KSZ87XX.
>>>> I could not test if Gigabit Ethernet works, but the link comes up and
>>>> can successfully allow packets to be sent and received with DSA tags.
>>>>
>>>> To resolve the KSZ8081/KSZ9897 phy_id conflicts, I could not find any
>>>> stable register to distinguish them. Instead of a match_phy_device() ,
>>>> I've declared a virtual phy_id with the highest value in Microchip's OUI
>>>> range.
>>>>
>>>> Example usage in the device tree:
>>>>           compatible = "ethernet-phy-id0022.17ff";
>>>>
>>>> A discussion to find better alternatives had been opened with the
>>>> Microchip team, with no response yet.
>>>>
>>>> See https://lore.kernel.org/all/20220207174532.362781-1-enguerrand.de-
>>>> ribaucourt@savoirfairelinux.com/
>>>>
>>>> Fixes: b987e98e50ab ("dsa: add DSA switch driver for Microchip KSZ9477")
>>>> Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-
>>>> ribaucourt@savoirfairelinux.com>
>>>> ---
>>>> v5:
>>>>    - rewrap comments
>>>>    - restore suspend/resume for KSZ9897
>>>> v4: https://lore.kernel.org/all/20240531142430.678198-2-enguerrand.de-
>>>> ribaucourt@savoirfairelinux.com/
>>>>    - rebase on net/main
>>>>    - add Fixes tag
>>>>    - use pseudo phy_id instead of of_tree search
>>>> v3: https://lore.kernel.org/all/20240530102436.226189-2-enguerrand.de-
>>>> ribaucourt@savoirfairelinux.com/
>>>> ---
>>>>    drivers/net/phy/micrel.c   | 13 ++++++++++++-
>>>>    include/linux/micrel_phy.h |  4 ++++
>>>>    2 files changed, 16 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
>>>> index 8c20cf937530..11e58fc628df 100644
>>>> --- a/drivers/net/phy/micrel.c
>>>> +++ b/drivers/net/phy/micrel.c
>>>> @@ -16,7 +16,7 @@
>>>>     *                        ksz8081, ksz8091,
>>>>     *                        ksz8061,
>>>>     *             Switch : ksz8873, ksz886x
>>>> - *                      ksz9477, lan8804
>>>> + *                      ksz9477, ksz9897, lan8804
>>>>     */
>>>>
>>>>    #include <linux/bitfield.h>
>>>> @@ -5545,6 +5545,16 @@ static struct phy_driver ksphy_driver[] = {
>>>>           .suspend        = genphy_suspend,
>>>>           .resume         = ksz9477_resume,
>>>>           .get_features   = ksz9477_get_features,
>>>> +}, {
>>>> +       .phy_id         = PHY_ID_KSZ9897,
>>>> +       .phy_id_mask    = MICREL_PHY_ID_MASK,
>>>> +       .name           = "Microchip KSZ9897 Switch",
>>>> +       /* PHY_BASIC_FEATURES */
>>>> +       .config_init    = kszphy_config_init,
>>>> +       .config_aneg    = ksz8873mll_config_aneg,
>>>> +       .read_status    = ksz8873mll_read_status,
>>>> +       .suspend        = genphy_suspend,
>>>> +       .resume         = genphy_resume,
>>>>    } };
>>>>
>>>>    module_phy_driver(ksphy_driver);
>>>> @@ -5570,6 +5580,7 @@ static struct mdio_device_id __maybe_unused
>>>> micrel_tbl[] = {
>>>>           { PHY_ID_LAN8814, MICREL_PHY_ID_MASK },
>>>>           { PHY_ID_LAN8804, MICREL_PHY_ID_MASK },
>>>>           { PHY_ID_LAN8841, MICREL_PHY_ID_MASK },
>>>> +       { PHY_ID_KSZ9897, MICREL_PHY_ID_MASK },
>>>>           { }
>>>>    };
>>>>
>>>> diff --git a/include/linux/micrel_phy.h b/include/linux/micrel_phy.h
>>>> index 591bf5b5e8dc..81cc16dc2ddf 100644
>>>> --- a/include/linux/micrel_phy.h
>>>> +++ b/include/linux/micrel_phy.h
>>>> @@ -39,6 +39,10 @@
>>>>    #define PHY_ID_KSZ87XX         0x00221550
>>>>
>>>>    #define        PHY_ID_KSZ9477          0x00221631
>>>> +/* Pseudo ID to specify in compatible field of device tree.
>>>> + * Otherwise the device reports the same ID as KSZ8081 on CPU ports.
>>>> + */
>>>> +#define        PHY_ID_KSZ9897          0x002217ff
>>>>
>>>>    /* struct phy_device dev_flags definitions */
>>>>    #define MICREL_PHY_50MHZ_CLK   BIT(0)
>>>> --
>>>> 2.34.1
>>>


