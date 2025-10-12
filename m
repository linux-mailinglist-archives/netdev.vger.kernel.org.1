Return-Path: <netdev+bounces-228632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0AEBD0481
	for <lists+netdev@lfdr.de>; Sun, 12 Oct 2025 17:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E08FC347FE4
	for <lists+netdev@lfdr.de>; Sun, 12 Oct 2025 15:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA3028DB52;
	Sun, 12 Oct 2025 15:04:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34D51624C5
	for <netdev@vger.kernel.org>; Sun, 12 Oct 2025 15:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760281487; cv=none; b=Kf+y7nAvk4R6Do63Xk7WJniYdJHSB2M1/CTWJXGad4WewHHS3gkk4DHmzQ3nMyFDDKMvctgIA7fNYvcOXZTSU2dPWc7VwMS7FALkNZFLftPsCj2TrAMyD9GtipXapqnZLR9rCeBS1j/bABfDPsRXgzDeygVZdALzI5qsKzXvAZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760281487; c=relaxed/simple;
	bh=OeCCMF9AcXLG29Pk7q6X5M/KcH0ku8Exfiu7RFLfqZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VuRUolN+ed+78THWgugaND+N2fd77H2pBX80tUefntFKDzcihqptSNb0B0CSq+gC7m+YVJIWrMjSHecDrjX7RANnfxO3xQVHhMumxqaqk/4SgUK+1yeypIIWNHTvW9jscSABD92wVs9UoX4rklsH6ebeuq+q/n+sxwptxezGE7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1v7xcb-0007bV-LG; Sun, 12 Oct 2025 17:04:29 +0200
Message-ID: <adc5287f-416d-4bb9-8ae9-b65a59b0ea93@pengutronix.de>
Date: Sun, 12 Oct 2025 17:04:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: dts: add Protonic PRT8ML board
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, David Jander <david@protonic.nl>,
 Lucas Stach <l.stach@pengutronix.de>,
 Oleksij Rempel <o.rempel@pengutronix.de>
References: <20250924-imx8mp-prt8ml-v3-0-f498d7f71a94@pengutronix.de>
 <20250924-imx8mp-prt8ml-v3-3-f498d7f71a94@pengutronix.de>
 <20251012023714.GF20642@nxa18884-linux.ap.freescale.net>
Content-Language: en-US
From: Jonas Rebmann <jre@pengutronix.de>
In-Reply-To: <20251012023714.GF20642@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Peng

On 2025-10-12 04:37, Peng Fan wrote:
> On Wed, Sep 24, 2025 at 10:34:14AM +0200, Jonas Rebmann wrote:
>> +&a53_opp_table {
>> +	opp-1200000000 {
>> +		opp-microvolt = <900000>;
>> +	};
>> +
>> +	opp-1600000000 {
>> +		opp-microvolt = <980000>;
>> +	};
>> +
>> +	/delete-node/ opp-1800000000;
> 
> Why drop this?
> 

The board is designed for the industrial variant of the i.MX 8M Plus and
therefore only for the 1.2GHz and 1.6GHz modes. There exist however some
units which which where assembled with the consumer variant. As the
power supply is not outfitted for their 1.8GHz mode, it must be
disabled.

I'll add a comment in v4.

>> +};
>> +
>> +&ecspi2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_ecspi2>;
>> +	cs-gpios = <&gpio5 13 GPIO_ACTIVE_HIGH>;
> 
>> +	/delete-property/ dmas;
>> +	/delete-property/ dma-names;
> 
> Why remove dmas?

Sadly, in drivers/spi-imx.c we don't have proper heuristics to choose on
which chips to use dma or to use polling at which speeds and transfer
sizes. Therefore in cases where there is a high number of small
transfers, for which dma is inefficient, this way of manually disabling
dma is the only current way of meeting specific performance
requirements.

I'll add a comment in v4.

>> +	status = "okay";
>> +
>> +
>> +&iomuxc {
>> +
>> +	pinctrl_tps65987ddh_0: tps65987ddh_0grp {
> 
> tps65987ddh_0grp - > tps65987ddh-0grp
> 
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12	0x1d0
>> +		>;
>> +	};
>> +
>> +	pinctrl_tps65987ddh_1: tps65987ddh_1grp {
> 
> tps65987ddh_1grp -> tps65987ddh-1grp

Will rename those in 4v.

Regards,
Jonas

-- 
Pengutronix e.K.                           | Jonas Rebmann               |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |

