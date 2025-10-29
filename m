Return-Path: <netdev+bounces-234041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC81C1BE8F
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 17:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15CE45A96F5
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 15:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B712E8E00;
	Wed, 29 Oct 2025 15:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eB6wzXTC"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9C02D879A
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751840; cv=none; b=Ka0fT2u7OKSl6b5B0uqeKWPu8AzpCQC9BQU9jEjjkNF3cbY+/3yn432i0qWqCWaX0yLXEv36xuLEEBLrc4x7PR9vGWKUmYOytHL7wyATTo9nam5pPiuAGd08Ev85QrhHJVqDpUopHx0TBLJILesDYUFfoS4w6KN0szLWekHhx4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751840; c=relaxed/simple;
	bh=czqUyHu3APMJiqqPr8Ae2kVqLVKK6zfWutM89e13YLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FO9hFZqpQLzPFUBYphhh6HS6bCUCxqTvyxMI9Pk/oqgbwbVRLqohghsuDFNzGKdUZoWDsXySn1+gTmgRN+F1dZXZgL3D1ccmiOmf0hET0FRzwmRuMFoYo04Z5KD/6FPbxpXvefAv1lNspWARFliYFNTPQjJas24kp9WPGRlDfXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eB6wzXTC; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3A0FE1A1742;
	Wed, 29 Oct 2025 15:30:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F1C7F606E8;
	Wed, 29 Oct 2025 15:30:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AEB67117F828E;
	Wed, 29 Oct 2025 16:30:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761751835; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=+ofRlSsFnhj/Eeu/sD0PofisXJqQ/KuD7u+eEwaLVpo=;
	b=eB6wzXTCe/N3Q7dnaf6E9dD6yIWqSPDSn9o8vSlwVuWiOke9KspcmyR3CG1QVsw+HezX0y
	1X3jvFHAgVvLW7k+aUOuDRVmTgLNHUEO3Jb3BuAhw8b9nT00u7344feagp5jWlgxn+6ShB
	uFOtaX+PLP3cVmuPojb2e71INjODRojB3xvSIxQjBymXckqYskJBKFpCrtS8SsVpnVDBTJ
	n2W65bWJ73uXwf92pagwrmpkPIHj9zHjYnhiqecpGzL/r9vScHejb19tGlB2XiXcXEvJhA
	ZB7DFlblrUEZSB76ilrkkTxXfu2APGPgSKtbo+H5ODgnR9r6xURX9SY93+4I3Q==
Message-ID: <a58f9a1c-a2f7-4c61-838e-7808e157ae25@bootlin.com>
Date: Wed, 29 Oct 2025 16:30:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] net: stmmac: socfpga: Agilex5 EMAC platform
 configuration
To: "G Thomas, Rohan" <rohan.g.thomas@altera.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251029-agilex5_ext-v1-0-1931132d77d6@altera.com>
 <20251029-agilex5_ext-v1-1-1931132d77d6@altera.com>
 <a871daac-364e-4c2c-8343-d458b373e1fd@bootlin.com>
 <db213912-2250-4d3e-9b2c-a4e36e92e1cb@altera.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <db213912-2250-4d3e-9b2c-a4e36e92e1cb@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 29/10/2025 15:53, G Thomas, Rohan wrote:
> Hi Maxime,
> 
> On 10/29/2025 7:04 PM, Maxime Chevallier wrote:
>> Hi Rohan,
>>
>> On 29/10/2025 09:06, Rohan G Thomas via B4 Relay wrote:
>>> From: Rohan G Thomas <rohan.g.thomas@altera.com>
>>>
>>> Agilex5 HPS EMAC uses the dwxgmac-3.10a IP, unlike previous socfpga
>>> platforms which use dwmac1000 IP. Due to differences in platform
>>> configuration, Agilex5 requires a distinct setup.
>>>
>>> Introduce a setup_plat_dat() callback in socfpga_dwmac_ops to handle
>>> platform-specific setup. This callback is invoked before
>>> stmmac_dvr_probe() to ensure the platform data is correctly
>>> configured. Also, implemented separate setup_plat_dat() callback for
>>> current socfpga platforms and Agilex5.
>>>
>>> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
>>> ---
>>>   .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    | 53 ++++++++++++++++++----
>>>   1 file changed, 43 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
>>> index 2ff5db6d41ca08a1652d57f3eb73923b9a9558bf..3dae4f3c103802ed1c2cd390634bd5473192d4ee 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
>>> @@ -44,6 +44,7 @@
>>>   struct socfpga_dwmac;
>>>   struct socfpga_dwmac_ops {
>>>   	int (*set_phy_mode)(struct socfpga_dwmac *dwmac_priv);
>>> +	void (*setup_plat_dat)(struct socfpga_dwmac *dwmac_priv);
>>>   };
>>>   
>>>   struct socfpga_dwmac {
>>> @@ -441,6 +442,39 @@ static int socfpga_dwmac_init(struct platform_device *pdev, void *bsp_priv)
>>>   	return dwmac->ops->set_phy_mode(dwmac);
>>>   }
>>>   
>>> +static void socfpga_common_plat_dat(struct socfpga_dwmac *dwmac)
>>> +{
>>> +	struct plat_stmmacenet_data *plat_dat = dwmac->plat_dat;
>>> +
>>> +	plat_dat->bsp_priv = dwmac;
>>> +	plat_dat->fix_mac_speed = socfpga_dwmac_fix_mac_speed;
>>> +	plat_dat->init = socfpga_dwmac_init;
>>> +	plat_dat->pcs_init = socfpga_dwmac_pcs_init;
>>> +	plat_dat->pcs_exit = socfpga_dwmac_pcs_exit;
>>> +	plat_dat->select_pcs = socfpga_dwmac_select_pcs;
>>> +}
>>> +
>>> +static void socfpga_gen5_setup_plat_dat(struct socfpga_dwmac *dwmac)
>>> +{
>>> +	struct plat_stmmacenet_data *plat_dat = dwmac->plat_dat;
>>> +
>>> +	socfpga_common_plat_dat(dwmac);
>>> +
>>> +	plat_dat->core_type = DWMAC_CORE_GMAC;
>>> +
>>> +	/* Rx watchdog timer in dwmac is buggy in this hw */
>>> +	plat_dat->riwt_off = 1;
>>> +}
>>> +
>>> +static void socfpga_agilex5_setup_plat_dat(struct socfpga_dwmac *dwmac)
>>> +{
>>> +	struct plat_stmmacenet_data *plat_dat = dwmac->plat_dat;
>>> +
>>> +	socfpga_common_plat_dat(dwmac);
>>
>> I"m not familiar with this device (I only have a Cyclone V on hand), does
>> it still make sense to try to instantiate a Lynx (i.e. Altera TSE) PCS
>> for that IP ?
> 
> AFAIK, yes it is supported by Agilex V device family also.
> https://www.altera.com/products/ip/a1jui0000049uuomam/triple-speed-ethernet-fpga-ip

Ah nice to know, thanks !

this looks correct then :)

Maxime

> 
>>
>> Maxime
>>
> 
> Best Regards,
> Rohan
> 


