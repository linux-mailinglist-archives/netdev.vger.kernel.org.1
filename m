Return-Path: <netdev+bounces-240415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 387D0C74969
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 15:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id F085B30940
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 14:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F8227FB34;
	Thu, 20 Nov 2025 14:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="c9/+Xw7P"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDF8279DA2;
	Thu, 20 Nov 2025 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763649316; cv=none; b=OEWmQdPKWMZrF7aFadskbKPlcAEnndulRrnScPUQ8Ej7g0mxID2//hEZpCiURXxBkFPuTLsD+q+49rPQrQRxk66A3ZdWmDSWlgz2Tr7HA4jDKsx4VvpEI9yIMLkQuXbQ7FhNwRKiGnlQjC4SwaUGoKopYmKP6/G+GB+Jbhqf6so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763649316; c=relaxed/simple;
	bh=XUGGSkAVuPvR8VjCEXTxpMVeDoQkboBdTdML0twAlog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S7pUFQYVJvIrtUgxVulnRJ8wTxx27KpS0k5L+lc+F2Om8730g52yiE40yFzSRUpJ2EaBFHpoSZbldcgaaCNXXgoeCjWvpV9YVVO5tTO+aOSAGu5FVREWNJiNvQnlPCC0lb5RySQxerDxwevTtdhObiQycaVBD9U3gD2QjJMDdgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=c9/+Xw7P; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9E73A4E417E5;
	Thu, 20 Nov 2025 14:35:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 64C5E6068C;
	Thu, 20 Nov 2025 14:35:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E690410371BC7;
	Thu, 20 Nov 2025 15:35:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763649309; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=myJX+EbqUMHfePZ6NP3v+A2rBdvfOFs876oKDs9+xKA=;
	b=c9/+Xw7PsWUSWNgII4CSs8oPhideO6dOFA3eVU+8Q7L95PPTUYNKKIRWC/DlN9meOhZZTd
	OodbVaGzEIaxo9RZam1kOSLCeQbhDNXNLOFJWI3koi69mtZhFIkTEqVnHGm5jw95JALobn
	sodQJn3XrOzhWLUXn5BfnneqhUtPTtJksY3h1zHaXN4Tlexj+1zmd8B/FMCnxMYldbAMKv
	GAn8YHhyt9nywkWLAna7L37wlOnwO+iayqq3p2d8gSkvzxYAWcENMZbSJaIzAAVIUmXGZd
	9DePqPuVIcSN00B+TXQpyTN7AuKLtBbIR2Ms7lZGYK6FUrJWiywLSUya0f4f4A==
Message-ID: <942f62f9-4c79-4c35-ad03-40bf7c6111b4@bootlin.com>
Date: Thu, 20 Nov 2025 15:35:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 02/15] net: mdio-regmap: permit working with
 non-MMIO regmaps
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
 <20251118190530.580267-3-vladimir.oltean@nxp.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251118190530.580267-3-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Vladimir,

On 18/11/2025 20:05, Vladimir Oltean wrote:
> The regmap world is seemingly split into two groups which attempt to
> solve different problems. Effectively, this means that not all regmap
> providers are compatible with all regmap consumers.
> 
> First, we have the group where the current mdio-regmap users fit:
> altera_tse_main.c and dwmac-socfpga.c use devm_regmap_init_mmio() to
> ioremap their pcs_base and obtain a regmap where address zero is the
> first PCS register.
> 
> Second, we have the group where MFD parent drivers call
> mfd_add_devices(), having previously initialized a non-MMIO (SPI, I2C)
> regmap and added it to their devres list, and MFD child drivers use
> dev_get_regmap(dev->parent, NULL) in their probe function, to find the
> first (and single) regmap of the MFD parent. The address zero of this
> regmap is global to the entire parent, so the children need to be
> parent-aware and add their own offsets for the registers that they
> should manage.
> 
> This is essentially because MFD is seemingly coming from a world where
> peripheral registers are all entangled with each other, but what I'm
> trying to support via MFD are potentially multiple instances of the same
> kind of device, at well separated address space regions.
> 
> To use MFD but provide isolated regmaps for each child device would
> essentially mean to fight against the system. The problem that needs to
> be now solved is that each child device needs to find the correct
> regmap, which means that "dev_get_regmap(dev->parent, NULL)" transforms
> either in:
> - dev_get_regmap(dev, NULL): search in the child device's devres list,
>   not in the parent's. But MFD does not give us a hook in between
>   platform_device_alloc() and platform_device_add() where we could make
>   the devm_regmap_init_spi() call for the child device. We have to make
>   it for the parent.
> - dev_get_regmap(dev->parent, "unique-regmap-name"): now the child
>   device needs to know, in case there are multiple instances of it,
>   which one is it, to ask for the right one. I've seen
>   drivers/mfd/ocelot-core.c work around this rather elegantly, providing
>   a resource to the child, and then the child uses resource->name to
>   find the regmap of the same name in the parent. But then I also
>   stumbled upon drivers/net/pcs/pcs-xpcs-plat.c which I need to support
>   as an MFD child, and that superimposes its own naming scheme for the
>   resources: "direct" or "indirect" - scheme which is obviously
>   incompatible with namespacing per instance.
> 
> So a MFD parent needs to decide whether it is in the boat that provides
> one isolated regmap for each child, or one big regmap for all. The "one
> big regmap" is the lowest common denominator when considering children
> like pcs-xpcs-plat.c.
> 
> This means that from mdio-regmap's perspective, it needs to deal with
> regmaps coming from both kinds of providers, as neither of them is going
> away.
> 
> Users who provide a big regmap but want to access only a window into it
> should provide as a struct mdio_regmap_config field a resource that
> describes the start and end of that window. Currently we only use the
> start as an offset into the regmap, and hope that MDIO reads and writes
> won't go past the end.
> 
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

That sounds good to me ! Thanks for expanding this driver :) I agree
with keeping the entire resource instead of just 'start'.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

