Return-Path: <netdev+bounces-241387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FABC83495
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 05:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 025584E3858
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 04:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADC614A60F;
	Tue, 25 Nov 2025 04:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qb4W4Rf6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAA31A08BC;
	Tue, 25 Nov 2025 04:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764043283; cv=none; b=Wk873pG87ldha0u4BZiyo93llx1H8pjTZ8up7yQ271+N18MQykzMTLqOTqW/QYgFmDrBaxqwEmIu/NQnygmErwcGcMq1WcPtX8Dwo3BwCvS/nfEEgTGZvqipwabSAWmBFsCQGK63Ve3grdHXEoyOnRxFe9FWFFRcWxjK2wk48+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764043283; c=relaxed/simple;
	bh=noWNmsId45ZeifrOlfH6mMR0VrmwkWZ6zYS8nnrBPoY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=folqLJRNmjbDhysLkXkszUqBFVOZuPsQ0J1zDCJfDkG0WlT8EnCbwDgcm/RSRpeEUAjXeYyP5FGPbiqg56+b3NzyDqB9VRecIeP/Z8AW8zBeL/TZ3FS3ccbZ2w/jhDFASY8BOtMquS18pWFMzhs0q9DP4cOucufQHQVsRP7WO14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qb4W4Rf6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7257C4CEF1;
	Tue, 25 Nov 2025 04:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764043283;
	bh=noWNmsId45ZeifrOlfH6mMR0VrmwkWZ6zYS8nnrBPoY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qb4W4Rf6dcMuhndBOCJQPmNvmiFZMdJBcyJv3vvyldUdON0Bmt6qM+LfgW6osuSNK
	 U38o9WsY9lI+bUq53QM6ZZhTFAXLau8K1phukRoPrXJh2j/AXDyhQCinlBctfG+fgp
	 6S7J3eOc7OTXdlvNipXaN54KCBAH/+DHl6mEblEiKXs386QpoqIH+69GBL7iIvfwwv
	 kQrKSO/pGakH4jz2x2vIwvSFL9nExiGeiNvnlDkhu/OiCnbc8Dx/e1xam4Q99UFzsI
	 LWTIgsAWsD4Ygh3O1/jyuBiot4F4fMU9uYSC/rAmw74hk3JAU+u70LTvAGmW38Obgk
	 oTQqFyRbTDb/A==
Date: Mon, 24 Nov 2025 20:01:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Daniel Golle <daniel@makrotopia.org>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham
 I <kishon@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Eric
 Woudstra <ericwouds@gmail.com>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, Lee Jones <lee@kernel.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>
Subject: Re: [PATCH net-next 5/9] phy: add phy_get_rx_polarity() and
 phy_get_tx_polarity()
Message-ID: <20251124200121.5b82f09e@kernel.org>
In-Reply-To: <20251122193341.332324-6-vladimir.oltean@nxp.com>
References: <20251122193341.332324-1-vladimir.oltean@nxp.com>
	<20251122193341.332324-6-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Nov 2025 21:33:37 +0200 Vladimir Oltean wrote:
> Add helpers in the generic PHY folder which can be used using 'select
> GENERIC_PHY_COMMON_PROPS' from Kconfig, without otherwise needing to
> enable GENERIC_PHY.
> 
> These helpers need to deal with the slight messiness of the fact that
> the polarity properties are arrays per protocol, and with the fact that
> there is no default value mandated by the standard properties, all
> default values depend on driver and protocol (PHY_POL_NORMAL may be a
> good default for SGMII, whereas PHY_POL_AUTO may be a good default for
> PCIe).
> 
> Push the supported mask of polarities to these helpers, to simplify
> drivers such that they don't need to validate what's in the device tree
> (or other firmware description).
> 
> The proposed maintainership model is joint custody between netdev and
> linux-phy, because of the fact that these properties can be applied to
> Ethernet PCS blocks just as well as Generic PHY devices. I've added as
> maintainers those from "ETHERNET PHY LIBRARY", "NETWORKING DRIVERS" and
> "GENERIC PHY FRAMEWORK".

I dunno.. ain't no such thing as "joint custody" maintainership.
We have to pick one tree. Given the set of Ms here, I suspect 
the best course of action may be to bubble this up to its own tree.
Ask Konstantin for a tree in k.org, then you can "co-post" the patches
for review + PR link in the cover letter (e.g. how Tony from Intel
submits their patches). This way not networking and PHY can pull
the shared changes with stable commit IDs.

We can do out-of-sequence netdev call tomorrow if folks want to talk
this thru (8:30am Pacific)

> +GENERIC PHY COMMON PROPERTIES
> +M:	Andrew Lunn <andrew@lunn.ch>
> +M:	"David S. Miller" <davem@davemloft.net>
> +M:	Eric Dumazet <edumazet@google.com>
> +M:	Heiner Kallweit <hkallweit1@gmail.com>
> +M:	Jakub Kicinski <kuba@kernel.org>
> +M:	Kishon Vijay Abraham I <kishon@kernel.org>
> +M:	Paolo Abeni <pabeni@redhat.com>
> +R:	Russell King <linux@armlinux.org.uk>
> +M:	Vinod Koul <vkoul@kernel.org>

checkpatch nit: apparently it wants all Ms first, then all Rs.

> +L:	linux-phy@lists.infradead.org
> +L:	netdev@vger.kernel.org
> +S:	Maintained
> +Q:	https://patchwork.kernel.org/project/linux-phy/list/
> +Q:	https://patchwork.kernel.org/project/netdevbpf/list/
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git
> +F:	Documentation/devicetree/bindings/phy/phy-common-props.yaml
> +F:	drivers/phy/phy-common-props.c
-- 
pw-bot: cr

