Return-Path: <netdev+bounces-242911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BB3C9633A
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 09:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9301F3A2B01
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 08:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141452DECB4;
	Mon,  1 Dec 2025 08:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRQuh49S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6B62BF3F3;
	Mon,  1 Dec 2025 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764578283; cv=none; b=UXDWMHAfxI4FeUPjJKsKVQI4zuD28/xBOPgU1U5W22GCkutasLPceio04O75jPpuQZnkNCPrjHzU4SSpbHaBGu1qDn5tNGBPzsvwTA7I9hGyiQCFSvZ8RJUrxOZ+2Jkj6SfFdf4k9aNCeffNoMINwUljiJ/sCPIMgboot2AVkYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764578283; c=relaxed/simple;
	bh=vgbgKs+CIgCE3wPA/E4Yb6WCwekK3Mvgjmi/ncx+CRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgcxpd/Noo3JfmfHJLY1Dm1Lgz5TAf4C66gs+5naF0cOZvERu1pNlewXa/bg13C64cMFuczqP99k29EN4VuaVRtugvHoszLhPakxh2HyJ5oyXHPL8iyTcyZKQpO6uXTuGv2aTg2uG/lswPwx5qrGCTLBfOb9vWdan8FhfFtlKhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRQuh49S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB9BC4CEF1;
	Mon,  1 Dec 2025 08:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764578282;
	bh=vgbgKs+CIgCE3wPA/E4Yb6WCwekK3Mvgjmi/ncx+CRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LRQuh49SNTjWYzSLBlfkC54mDUI09XOgjyRgmn11odtLc5TTQfWnuLNy4bSxNg/cK
	 0bU7fI2M136nd9qFVZm9/tEF33O1LDYZU4W4JKOOEySm3cMFu3uMKjEHBehsStNkhd
	 CKd5EDbtaLDZSvJQySIksO2D+vKI8m3oBwfYya7rusTqzkNXjuZIcXAs7vWQOs0O53
	 5KXYoGAvYGFO6W79QoXI1wlM3HqGhrzblroWDYv9ttbovUu9ArXDhL4EnLG6MqOKsO
	 +e7VyF6yeuj2Gg3P+Zdz7dpbr0qRI1hgx9aNMqrjJ63pH6D+I9mddqVq74kS4Y4tDo
	 DWgcPkMh2kFeQ==
Date: Mon, 1 Dec 2025 14:07:58 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH net-next 5/9] phy: add phy_get_rx_polarity() and
 phy_get_tx_polarity()
Message-ID: <aS1T5i3pCHsNVql6@vaman>
References: <20251122193341.332324-1-vladimir.oltean@nxp.com>
 <20251122193341.332324-6-vladimir.oltean@nxp.com>
 <20251124200121.5b82f09e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124200121.5b82f09e@kernel.org>

On 24-11-25, 20:01, Jakub Kicinski wrote:
> On Sat, 22 Nov 2025 21:33:37 +0200 Vladimir Oltean wrote:
> > Add helpers in the generic PHY folder which can be used using 'select
> > GENERIC_PHY_COMMON_PROPS' from Kconfig, without otherwise needing to
> > enable GENERIC_PHY.
> > 
> > These helpers need to deal with the slight messiness of the fact that
> > the polarity properties are arrays per protocol, and with the fact that
> > there is no default value mandated by the standard properties, all
> > default values depend on driver and protocol (PHY_POL_NORMAL may be a
> > good default for SGMII, whereas PHY_POL_AUTO may be a good default for
> > PCIe).
> > 
> > Push the supported mask of polarities to these helpers, to simplify
> > drivers such that they don't need to validate what's in the device tree
> > (or other firmware description).
> > 
> > The proposed maintainership model is joint custody between netdev and
> > linux-phy, because of the fact that these properties can be applied to
> > Ethernet PCS blocks just as well as Generic PHY devices. I've added as
> > maintainers those from "ETHERNET PHY LIBRARY", "NETWORKING DRIVERS" and
> > "GENERIC PHY FRAMEWORK".
> 
> I dunno.. ain't no such thing as "joint custody" maintainership.
> We have to pick one tree. Given the set of Ms here, I suspect 
> the best course of action may be to bubble this up to its own tree.
> Ask Konstantin for a tree in k.org, then you can "co-post" the patches
> for review + PR link in the cover letter (e.g. how Tony from Intel
> submits their patches). This way not networking and PHY can pull
> the shared changes with stable commit IDs.

How much is the volume of the changes that we are talking about, we can
always ack and pull into each other trees..?

BR
-- 
~Vinod

