Return-Path: <netdev+bounces-243455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 036C5CA19F2
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 22:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A534302175D
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 21:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62992D0611;
	Wed,  3 Dec 2025 21:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sQ1hQhRi"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC05482EB;
	Wed,  3 Dec 2025 21:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764796034; cv=none; b=DjmBxtLZB53kpk27QpVb2DibRAywfpcgkrsA/G16J1HUHVtT0NYUMa4ni1hRuvu0Z28L7VxojtXH+2xlsrtrRiTUs0TgBJ1I6o7X2xKQXcvuUb8WcQZX8m63nYJVWEUoB/gHE0IV5V6nykOxrO2mPf9401d79xMVCaNatBogGjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764796034; c=relaxed/simple;
	bh=bnDq6d3jQ6FKKUfqKegdgJFbk/YWJWrWX2lE2cHa9Dc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=a1fafvgaUpt76onZpC12MAbm4i+AuUtX6YipeKJ9z8fzOZeNf2X8Mmf+pnFB+p9t4YKW+8j/fPywqdiZDpS02odzcqwC/gUorjPU0S+LIKl3lHLKvMGz2KBzo4bLJQlp4tI/O4q62JBNsXFv8IGiuRgE2KDPZ5/+Dhqi+LoUrts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=sQ1hQhRi; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dM9F955twz9t9P;
	Wed,  3 Dec 2025 22:07:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1764796029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fV9rty4MhOWTsXWsKMyQGwT6zFis69PObb8cZsb5NPU=;
	b=sQ1hQhRiQSuD2/PqyDmiI12tl/COqXjPbF+wVB2AEtBetacW5T/Q1UZ0Vh/QreIgVGFxz1
	cyy/uHz/Hr2EQYB6OSdSOMTSonQG16NfXCS0ypa0W3Rgr+hKtDqjmc8pnFuZJOn2EHrG/2
	kdF9eJd0jz9hauPmEe9gUyYC0KjBuhW6hET88Zfjb0rMJ2nvo3FsqlX2hepDRPMGTcHCCL
	fthXZgPhqRxGMU0ewxgpSAfcbWV+x2V47pN2xyzNYWDouYczzPD6Qf4m8Es1yaXaHmPu2A
	kd1PNRppE4OGw+Zv5MPOMKjD8Im+n6A6fe8YsrC5E2fNK56Vt8orl+eR2Ssl5A==
Message-ID: <acbbef86-9f8a-45fd-8643-24c8efcbbb01@mailbox.org>
Date: Wed, 3 Dec 2025 21:17:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: [net-next,PATCH 3/3] net: phy: realtek: Add property to enable
 SSC
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
 Ivan Galkin <ivan.galkin@axis.com>,
 Christophe Roullier <christophe.roullier@foss.st.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Aleksander Jan Bajkowski <olek2@wp.pl>, Andrew Lunn <andrew@lunn.ch>,
 Conor Dooley <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Michael Klein <michael@fossekall.de>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>,
 devicetree@vger.kernel.org
References: <20251130005843.234656-1-marek.vasut@mailbox.org>
 <20251130005843.234656-3-marek.vasut@mailbox.org>
 <20251203094224.jelvaizfq7h6jzke@skbuf>
Content-Language: en-US
In-Reply-To: <20251203094224.jelvaizfq7h6jzke@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 15e7d574e6c419c1153
X-MBO-RS-META: fn53akxmsfk4bwrohczmkekqwfywhdya

On 12/3/25 10:42 AM, Vladimir Oltean wrote:

Hello Vladimir,

>> +       ret = phy_write_paged(phydev, RTL8211F_SSC_PAGE, RTL8211F_SSC_RXC, 0x5f00);
>> +       if (ret < 0) {
>> +               dev_err(dev, "RXC SCC configuration failed: %pe\n", ERR_PTR(ret));
>> +               return ret;
>> +       }
> 
> I'm going to show a bit of lack of knowledge, but I'm thinking in the context
> of stmmac (user of phylink_config :: mac_requires_rxc), which I don't exactly
> know what it requires it for. Does it use the RGMII RXC as a system clock?

I believe dwmac (stmmac) uses RXC to drive at least (part of) its DMA.

+CC Christophe

> If so, I guess intentionally introducing jitter (via the spread spectrum
> feature) would be disastrous for it. In that case we should seriously consider
> separating the "spread spectrum for CLKOUT" and "spread spectrum for RGMII"
> device tree control properties.

I can split this into realtek,clkout-ssc-enable and realtek,rxc-ssc-enable.

Note that I use this exact configuration with both STM32MP13xx and 
STM32MP25xx RGMII / stmmac .

-- 
Best regards,
Marek Vasut

