Return-Path: <netdev+bounces-58623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE1E817955
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 19:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135941F225C8
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 18:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DBF5BFB5;
	Mon, 18 Dec 2023 18:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="lU/Dul2r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC11E5BFA2
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 18:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e33fe3856so1929066e87.1
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 10:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1702922565; x=1703527365; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=O97uj9e08s7i9aDFJjFTarMdK1KNX1EjP0tGTzMNUfY=;
        b=lU/Dul2rHvHzDJJAL07vWE0RX5l7/RZt1WB7UGIcMkur4wNppgJ1QQJr71txsvxx9Z
         Q6+C2ZsS8XWDanRu0dD72fyjYDXshkuhLhc63BTELgUea476pnweRknF+I9WsELr5ieG
         0Fv4zvKPmdWruIBFI00vowpAizZuvty+LqlBwhMYCV4YMpExj0hSG+m5SWRg88Z3YUK8
         c8Yhw9n1N75/5/h+2Ydi4bOSTxLQGiXmBYFv2HhZP9YF6tq7UsNGBFbb+l6ysJ6yiq5a
         ptYlLmvLyfZEN5j6xCDacvUbucWOa64ZnOxdLHFLDsIxMc6Y1/NdTHPpOpMyLaNwHyO4
         vGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702922565; x=1703527365;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O97uj9e08s7i9aDFJjFTarMdK1KNX1EjP0tGTzMNUfY=;
        b=ey0pxP0KSVWHF8lOar82Ip2WZiOCzOKmkba116qouCotzrNdYXZrBCCk7ogPUaCrSf
         3fjRhrBNlGF3beit4Q9Z9HePCEHKbVu6S3iy88oXuY/793Sy46stIkZi+28O/6aOTK3Z
         /0S1zHZ+Bndk2OjHT3yqVtk1n/1uf70AsmLTa+CvRsHCVo7TWwntuQubdYHSSmC0rAdN
         WW3OTFJNbMX6W/RURtwUeNldJ32i3emWmmYKxPdYBHgw3od+arSx2rzkAMmS+x80M+CQ
         XMsKed5ByGtN8LG4eU8pVhF2KKQ/uxdsNHB4uQIaFVbdum9RbazDchDpBrXgNaZUWcMl
         bX9Q==
X-Gm-Message-State: AOJu0YwGKf19qia2PDtHuxoE8V99LwymaBXcgYu46CXo0NvpTIrUAVP/
	VKkSOmakbvvGUmo4+WHtNexDUA==
X-Google-Smtp-Source: AGHT+IGeBDtRuHT4pEAlzpm7lZdQbY5RWwW8araiEEgTbOTDMdKguqOI6mkQ3QIsoZKYSZrlc5gdzg==
X-Received: by 2002:ac2:4ec4:0:b0:50e:3e13:ae89 with SMTP id p4-20020ac24ec4000000b0050e3e13ae89mr420029lfr.66.1702922564804;
        Mon, 18 Dec 2023 10:02:44 -0800 (PST)
Received: from wkz-x13 (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id o22-20020ac24bd6000000b0050d1672f10csm2839691lfq.39.2023.12.18.10.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 10:02:43 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: davem@davemloft.net, kuba@kernel.org, kabel@kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: phy: marvell10g: Fix power-up when
 strapped to start powered down
In-Reply-To: <ZXx0eVzJ3I1PwOa0@shell.armlinux.org.uk>
References: <20231214201442.660447-1-tobias@waldekranz.com>
 <20231214201442.660447-3-tobias@waldekranz.com>
 <ZXx0eVzJ3I1PwOa0@shell.armlinux.org.uk>
Date: Mon, 18 Dec 2023 19:02:43 +0100
Message-ID: <87y1dr75j0.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On fre, dec 15, 2023 at 15:44, "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> On Thu, Dec 14, 2023 at 09:14:40PM +0100, Tobias Waldekranz wrote:
>> On devices which are hardware strapped to start powered down (PDSTATE
>> == 1), make sure that we clear the power-down bit on all units
>> affected by this setting.
>> 
>> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>> ---
>>  drivers/net/phy/marvell10g.c | 17 ++++++++++++++---
>>  1 file changed, 14 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
>> index 83233b30d7b0..1c1333d867fb 100644
>> --- a/drivers/net/phy/marvell10g.c
>> +++ b/drivers/net/phy/marvell10g.c
>> @@ -344,11 +344,22 @@ static int mv3310_power_down(struct phy_device *phydev)
>>  
>>  static int mv3310_power_up(struct phy_device *phydev)
>>  {
>> +	static const u16 resets[][2] = {
>> +		{ MDIO_MMD_PCS,    MV_PCS_BASE_R    + MDIO_CTRL1 },
>> +		{ MDIO_MMD_PCS,    MV_PCS_1000BASEX + MDIO_CTRL1 },
>
> This is not necessary. The documentation states that the power down
> bit found at each of these is the same physical bit appearing in two
> different locations. So only one is necessary.

Right, I'll remove the entry for 1000BASE-X in v2.

>> +		{ MDIO_MMD_PCS,    MV_PCS_BASE_T    + MDIO_CTRL1 },
>> +		{ MDIO_MMD_PMAPMD, MDIO_CTRL1 },
>> +		{ MDIO_MMD_VEND2,  MV_V2_PORT_CTRL },
>> +	};
>>  	struct mv3310_priv *priv = dev_get_drvdata(&phydev->mdio.dev);
>> -	int ret;
>> +	int i, ret;
>>  
>> -	ret = phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2, MV_V2_PORT_CTRL,
>> -				 MV_V2_PORT_CTRL_PWRDOWN);
>> +	for (i = 0; i < ARRAY_SIZE(resets); i++) {
>> +		ret = phy_clear_bits_mmd(phydev, resets[i][0], resets[i][1],
>> +					 MV_V2_PORT_CTRL_PWRDOWN);
>
> While MV_V2_PORT_CTRL_PWRDOWN may correspond with the correct bit for
> the MDIO CTRL1 register, we have MDIO_CTRL1_LPOWER which describes
> this bit. Probably the simplest solution would be to leave the
> existing phy_clear_bits_mmd(), remove the vendor 2 entry from the
> table, and run through that table first.

Yes, I'll fix this in v2.

> Lastly, how does this impact a device which has firmware, and the
> firmware manages the power-down state (the manual states that unused
> blocks will be powered down - I assume by the firmware.) If this
> causes blocks which had been powered down by the firmware because
> they're not being used to then be powered up, that is a regression.
> Please check that this is not the case.

This will be very hard for me to test, as I only have access to boards
without dedicated FLASHes. That said, I don't think I understand how
this is related to how the devices load their firmware. As I understand
it, we should pick up the device in the exact same state after the MDIO
load as we would if it had booted on its own, via a serial FLASH.

The selection of PDSTATE, based on the sample-at-reset pins, is
independent of how firmware is loaded.

From the manual:

    The following registers can be set to force the units to power down.

I interpret this as the power-down bits only acting as gates to stop
firmware from powering up a particular unit. Conversely, clearing one of
these bits merely indicates that the firmware is free to power up the
unit in question.

On a device strapped to PDSTATE==0, I would expect all of these bits to
already be cleared, since the manual states that the value of PDSTATE is
latched into all these bits at reset.



