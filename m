Return-Path: <netdev+bounces-171356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 537BFA4CA19
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 18:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816ED1889A17
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 17:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DA520E706;
	Mon,  3 Mar 2025 17:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="Q5/eWSJu"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3872B1DE2BF;
	Mon,  3 Mar 2025 17:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741023311; cv=none; b=ODvvd3rA3pwD4VBJCeCBzCy65SueVoSwi4sT3exgulHkTjtjWW/5UHlwU1KmoELWpXSpIbsFThqGw1R3LlwJf30WMi95zgNQjlTw6WQTIA+lJfobfyjQNn6H4nTI2TpyscLx26JgFeq+WLHwalHJqC8RfSRz2L8kH2Lb7n5h0pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741023311; c=relaxed/simple;
	bh=EoMRGVDo4FZxd5nlUs9gZNZg2b2BUEFNjawnEOFMg0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sVgC+VjgmgPyvnC/4vYakqqH2uOMeespfhmEO2aKjghbxKcTvgd+s5a/2gqGKsaTDq4t0Ow4zeSJLkl+7DKp1GLkWwBuqL8JgW8s1j5ukKlpmvirf1ePHruG/xnKcvpaNme8QWFDtR02e35++OBDHqX0zoQAOXO9XLVuTYQBTXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=Q5/eWSJu; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id DF48A204CE;
	Mon,  3 Mar 2025 17:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1741023307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TEok21Mpkz5RPutY5HcOjkANyfwnJwTHijWGy9H+c9g=;
	b=Q5/eWSJudErQsWL5JWITlbebWfU1eQou5HQGJ+0yPRfrtVpJ8f/t8KOMYNdw4jtlWMFtUA
	1KCPYqoBncikdeeuhNZQpJdb/l5Gq8LJz7A+KUJGlhnb3hz00JJWGzORZtWAkuL+njDx7j
	ZSMLrVlTWO3KKSWVeE6Aw9bhsAcb+BYQLBJ33CNHTi6xI3OC2u4GiQbhLLUiiMHeoE8G0q
	VidqH+EwcirLuaJRmZkodDOJvnB9JlxzNj/yozm5s2Xq8US+QeGgDGQUyixwpS7xpFgPK8
	U+yXgsEJal2ufak1U0SGasNSl9JBRKmkJo3ZX9fqKSCyq4i0VoziV5dbGCwhqA==
Message-ID: <aaf511ad-d7eb-454c-83c0-84f0d14f323d@yoseli.org>
Date: Mon, 3 Mar 2025 18:35:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: phy: dp83826: Add support for straps reading
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Catalin Popescu <catalin.popescu@leica-geosystems.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250303-dp83826-fixes-v1-0-6901a04f262d@yoseli.org>
 <20250303-dp83826-fixes-v1-2-6901a04f262d@yoseli.org>
 <Z8Xl9blPRVXQiOSm@shell.armlinux.org.uk>
Content-Language: en-US
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <Z8Xl9blPRVXQiOSm@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleejgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeflvggrnhdqofhitghhvghlucfjrghuthgsohhishcuoehjvggrnhhmihgthhgvlhdrhhgruhhtsghoihhsseihohhsvghlihdrohhrgheqnecuggftrfgrthhtvghrnhepfeeiteeghedvgefggfffteehhefhteekfeehhfegueehteeuffeuieekgfffffetnecukfhppeeluddrudeihedrudeihedrudeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeluddrudeihedrudeihedrudeljedphhgvlhhopegludelvddrudeikedruddriegnpdhmrghilhhfrhhomhepjhgvrghnmhhitghhvghlrdhhrghuthgsohhisheshihoshgvlhhirdhorhhgpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhgl
 hgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptggrthgrlhhinhdrphhophgvshgtuheslhgvihgtrgdqghgvohhshihsthgvmhhsrdgtohhm
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi Russel,

On 03/03/2025 18:25, Russell King (Oracle) wrote:
> On Mon, Mar 03, 2025 at 06:05:52PM +0100, Jean-Michel Hautbois wrote:
>> +	/* Bit 10: MDIX mode */
>> +	if (val & BIT(10))
>> +		phydev_dbg(phydev, "MDIX mode enabled\n");
>> +
>> +	/* Bit 9: auto-MDIX disable */
>> +	if (val & BIT(9))
>> +		phydev_dbg(phydev, "Auto-MDIX disabled\n");
>> +
>> +	/* Bit 8: RMII */
>> +	if (val & BIT(8)) {
>> +		phydev_dbg(phydev, "RMII mode enabled\n");
>> +		phydev->interface = PHY_INTERFACE_MODE_RMII;
>> +	}
> 
> Do all users of this PHY driver support having phydev->interface
> changed?
> 

I don't know, what is the correct way to know and do it ?
Other phys did something similar (bcm84881_read_status is an example I 
took).

>> +
>> +	/* Bit 5: Slave mode */
>> +	if (val & BIT(5))
>> +		phydev_dbg(phydev, "RMII slave mode enabled\n");
>> +
>> +	/* Bit 0: autoneg disable */
>> +	if (val & BIT(0)) {
>> +		phydev_dbg(phydev, "Auto-negotiation disabled\n");
>> +		phydev->autoneg = AUTONEG_DISABLE;
>> +		phydev->speed = SPEED_100;
>> +		phydev->duplex = DUPLEX_FULL;
>> +	}
> 
> This doesn't force phylib to disallow autoneg.
> 

Is it needed to call phy_lookup_setting() or something else ?

Thanks for your feedback,
JM

