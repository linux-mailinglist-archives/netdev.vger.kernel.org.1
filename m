Return-Path: <netdev+bounces-235414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F28DC302FF
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 10:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C6A24EE06A
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 09:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4CE29D27A;
	Tue,  4 Nov 2025 09:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aPVPylMf"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B4F1A238F
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 09:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247287; cv=none; b=EdRy6gU7lsFJd9t6yacPbNKtr9ii/lMUPztTRcUirIjYU/Hzesz/RPcaVf/fb2lQBQ1xsz7Z3qBq89sTb2pxV7c43JPNRzt5pS8DIAPW4PrLBEfyu7Z0+EXiagfm6f0E3Ee1FsB9VYCywPQFdYzRjwUH3rUSYG1WSX13Hz+fGpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247287; c=relaxed/simple;
	bh=I5meXsbfDv4eqSgOU75PkFg654Y2B9HIEkAHF3oTK4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=suG03EN5LI6OfvUUvoOuOsmiS7f9eN4QP213L/iXAj5roalVQZv/Nq2Z96eWzcmU7C6J2ONRxKW753eKHGzo6pti3y1f64N6uQk64PQcNoZN2MiQ7hCwV0cqMeEte4LcZqHbRIpyBVCHs4RkUihKZcbMNvtoQ9FaJ7J0ClhIKFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aPVPylMf; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 188A4C0E604;
	Tue,  4 Nov 2025 09:07:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D2ACD606EF;
	Tue,  4 Nov 2025 09:08:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 87FD110B50499;
	Tue,  4 Nov 2025 10:07:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762247281; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=IqrKvT/39GIw4bETHcXxm6B86XwJZy5zQulp7Zkzg80=;
	b=aPVPylMf2uPJTc5vq8FUwy26OuucAub5M8J+o+CEOCkoo6sjLGddx2uuKXPLxChca5uE9n
	rCXLuYN1N5fV0jjH/bgGSLJaTrW4CvemCkaJB58wOL+bN8kMOtZUORX0zHjAvWGVCblCRL
	1mOBICgLxRa47LV5NCBmyt104DOWZex53RAm0Lhb9Yok62+5FpbXSPK3BuCkl9tKKzmAUQ
	tbxFO3TU5e2f50fJyb69LnMQWuCzGv6/9rCll6F26cvAbX8GJofb+wJvvg2nZA3WXgI79A
	/g9jd600NqLXDLBVOrJk4PHYNpsN0UOSDA7OAEXG7oR8YBNadRWHBTijAJ96/w==
Message-ID: <4f029450-df4f-419d-adb4-493a8ca03e63@bootlin.com>
Date: Tue, 4 Nov 2025 10:07:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 04/11] net: stmmac: add stmmac_get_phy_intf_sel()
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
 Jakub Kicinski <kuba@kernel.org>, Jan Petrous <jan.petrous@oss.nxp.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, s32@nxp.com,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
References: <aQiWzyrXU_2hGJ4j@shell.armlinux.org.uk>
 <E1vFt4c-0000000Choe-3SII@rmk-PC.armlinux.org.uk>
 <db01f926-d5bb-4317-beac-e6dcc0025a80@bootlin.com>
 <aQm-LnN0LifBvkoz@shell.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <aQm-LnN0LifBvkoz@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 04/11/2025 09:49, Russell King (Oracle) wrote:
> On Tue, Nov 04, 2025 at 09:34:31AM +0100, Maxime Chevallier wrote:
>>> +int stmmac_get_phy_intf_sel(phy_interface_t interface)
>>> +{
>>> +	int phy_intf_sel = -EINVAL;
>>> +
>>> +	if (interface == PHY_INTERFACE_MODE_MII ||
>>> +	    interface == PHY_INTERFACE_MODE_GMII)
>>> +		phy_intf_sel = PHY_INTF_SEL_GMII_MII;
>>> +	else if (phy_interface_mode_is_rgmii(interface))
>>> +		phy_intf_sel = PHY_INTF_SEL_RGMII;
>>> +	else if (interface == PHY_INTERFACE_MODE_SGMII)
>>> +		phy_intf_sel = PHY_INTF_SEL_SGMII;
>>> +	else if (interface == PHY_INTERFACE_MODE_RMII)
>>> +		phy_intf_sel = PHY_INTF_SEL_RMII;
>>> +	else if (interface == PHY_INTERFACE_MODE_REVMII)
>>> +		phy_intf_sel = PHY_INTF_SEL_REVMII;
>>> +
>>> +	return phy_intf_sel;
>>> +}
>>> +EXPORT_SYMBOL_GPL(stmmac_get_phy_intf_sel);
>>
>> Nothng wrong with your code, this is out of curiosity.
>>
>> I'm wondering how we are going to support cases like socfpga (and
>> probably some other) where the PHY_INTF_SEL_xxx doesn't directly
>> translate to the phy_interface, i.e.  when you have a PCS or other
>> IP that serialises the MAC interface ?
> 
> It also doesn't differentiate between MII and GMII. That's fine for
> this - this is about producing the configuration for the dwmac's
> phy_intf_sel_i signals. It isn't for configuring the glue hardware
> for any other parameters such as RGMII delays.
>  
>> for socfpga for example, we need to set the PHY_INTF_SEL to GMII_MII
>> when we want to use SGMII / 1000BaseX, but we do set it to RGMII when
>> we need to output RGMII.
> 
> From what I remember for socfpga, you use an external PCS that needs
> GMII. This function doesn't take account of external PCS, and thus
> platform glue that makes use of an external PCS can't implement
> .set_phy_intf_sel() yet.

Makes sense

> As noted, it also doesn't handle TBI (which,
> although we have PHY_INTERFACE_MODE_TBI, Synopsys intended this mode
> to be used to connect to a SerDes for 1000BASE-X.)

That's fine by me, thanks for the clarifications :)

> 
>> Do you have a plan in mind for that ? (maybe a .get_phy_intf_sel() ops ?)
> 
> Yes, there will need to be a way to override this when an external
> PCS is being used. I suspect that all external 1G PCS will use GMII,
> thus we can probably work it out in core code.
> 
> Note, however, that socfpga doesn't use the phy_intf_sel encoding:
> 
> #define SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_GMII_MII 0x0
> #define SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_RGMII 0x1
> #define SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_RMII 0x2
> 
> #define PHY_INTF_SEL_GMII_MII   0
> #define PHY_INTF_SEL_RGMII      1
> #define PHY_INTF_SEL_RMII       4
> 
> It's close, but it isn't the phy_intf_sel_i[2:0] signal values.

> 
Yeah :/

I'll give this series a try on dwmac-imx once I get a bit of time then !

thanks,

Maxime

