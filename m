Return-Path: <netdev+bounces-179152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 468C0A7ACBB
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 21:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D61BD7A75B2
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 19:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D21C285409;
	Thu,  3 Apr 2025 19:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JmDe/8X4"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F202853EE
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 19:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707321; cv=none; b=izcc2SwNSAdbqPO/0GC4HDqz9SNqfVvotKKonWYUJ1QljUp3XS7MHXUbqSceYKCohoc5G4udaRe997RsT7gLnXMWsVhRwaBZRAtvSvf+gn8wxoDL5yUSTblUrvHEUpvTGKW7RYrIRN61FGCAysh1C+wZtLmh/jO+XKFv9crOGaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707321; c=relaxed/simple;
	bh=eQsh8m6hMOt+s3jstiFbzZuYBXHxmqe0tzYTkubXJCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZe+1MEPLEVhsFKf7Hwxs2qDm8VabCFa80DYRm3k/IsNqb4y/OqcstzASR0vE+h/rYWLiAY9M/IvkoupNEN2wj97B3JhP5RxxdPYZ2tfndOapzRGpDbVm9LVY5i1s/64MgMPbrEFaGzJvmjN04FOMHOC9i9C7S+jIxbB0GKiI4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JmDe/8X4; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a3d33b5c-e0e3-4980-9556-beb36b985e84@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743707317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y59/c//cpQ59oY9i14cYGQHeNS5BEqmX5s/uupb1vtg=;
	b=JmDe/8X4luR40/rIhQqNsKJaEO70WjYqBzT4rVg2cEIUDHlUHZrRMvFjsy7kIx62ID12ZY
	indm9pPHWR0L1DgMjYhjTqvZdEp9xj9a+AK3Ps2OVn+PQJWBe1j7y4oTrbUgo490arOdZQ
	Cnm8UXop0zZtr3viPbPQAYMI+dE77os=
Date: Thu, 3 Apr 2025 15:08:31 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC net-next PATCH 06/13] net: phy: Export some functions
To: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org, Christian Marangi <ansuelsmth@gmail.com>,
 upstream@airoha.com, Heiner Kallweit <hkallweit1@gmail.com>
References: <20250403181907.1947517-1-sean.anderson@linux.dev>
 <20250403181907.1947517-7-sean.anderson@linux.dev>
 <0e2a50d9-ee7c-4c15-8c31-a42fff1522e6@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <0e2a50d9-ee7c-4c15-8c31-a42fff1522e6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/3/25 14:37, Florian Fainelli wrote:
> On 4/3/25 11:19, Sean Anderson wrote:
>> Export a few functions so they can be used outside the phy subsystem:
>>
>> get_phy_c22_id is useful when probing MDIO devices which present a
>> phy-like interface despite not using the Linux ethernet phy subsystem.
>>
>> mdio_device_bus_match is useful when creating MDIO devices manually
>> (e.g. on non-devicetree platforms).
>>
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>>
>>   drivers/net/phy/mdio_device.c | 1 +
>>   drivers/net/phy/phy_device.c  | 3 ++-
>>   include/linux/phy.h           | 1 +
>>   3 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
>> index e747ee63c665..cce3f405d1a4 100644
>> --- a/drivers/net/phy/mdio_device.c
>> +++ b/drivers/net/phy/mdio_device.c
>> @@ -45,6 +45,7 @@ int mdio_device_bus_match(struct device *dev, const struct device_driver *drv)
>>         return strcmp(mdiodev->modalias, drv->name) == 0;
>>   }
>> +EXPORT_SYMBOL_GPL(mdio_device_bus_match);
>>     struct mdio_device *mdio_device_create(struct mii_bus *bus, int addr)
>>   {
>> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
>> index 675fbd225378..45d8bc13eb64 100644
>> --- a/drivers/net/phy/phy_device.c
>> +++ b/drivers/net/phy/phy_device.c
>> @@ -859,7 +859,7 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr,
>>    * valid, %-EIO on bus access error, or %-ENODEV if no device responds
>>    * or invalid ID.
>>    */
>> -static int get_phy_c22_id(struct mii_bus *bus, int addr, u32 *phy_id)
>> +int get_phy_c22_id(struct mii_bus *bus, int addr, u32 *phy_id)
>>   {
>>       int phy_reg;
>>   @@ -887,6 +887,7 @@ static int get_phy_c22_id(struct mii_bus *bus, int addr, u32 *phy_id)
>>         return 0;
>>   }
>> +EXPORT_SYMBOL_GPL(get_phy_c22_id);
>>     /* Extract the phy ID from the compatible string of the form
>>    * ethernet-phy-idAAAA.BBBB.
>> diff --git a/include/linux/phy.h b/include/linux/phy.h
>> index a2bfae80c449..c648f1699c5c 100644
>> --- a/include/linux/phy.h
>> +++ b/include/linux/phy.h
>> @@ -1754,6 +1754,7 @@ struct phy_device *phy_device_create(struct mii_bus *bus, int addr, u32 phy_id,
>>                        bool is_c45,
>>                        struct phy_c45_device_ids *c45_ids);
>>   #if IS_ENABLED(CONFIG_PHYLIB)
>> +int get_phy_c22_id(struct mii_bus *bus, int addr, u32 *phy_id);
> 
> Seems like you will need to provide an empty inline stub for when CONFIG_PHYLIB=n?

The only user (CONFIG_PCS_XILINX) selects CONFIG_PHYLINK which selects
CONFIG_PHYLIB. So I don't think this can occur yet.

--Sean

