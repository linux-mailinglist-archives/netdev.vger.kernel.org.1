Return-Path: <netdev+bounces-128580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB9C97A70F
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 19:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D00EA1C2756F
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 17:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66291165EFA;
	Mon, 16 Sep 2024 17:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZsIA6MC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A1615C146;
	Mon, 16 Sep 2024 17:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726509430; cv=none; b=IAqe2XMDRe3I2dszxkKXx+rDpfRZJfCivd0Za5OCoD/ZSMoChYwd0ikz22i6TYfjMxHPThCDPZriNH2ScbrAYgO/tweqG7cgrD+l/RqL8EIy1m+ngw/RsUIsDfc/J4/vVJ58PtIxdU+ff5bTEoh9ooeKzZwDaNTQghK2NWyusiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726509430; c=relaxed/simple;
	bh=mQN9rGOjG8lSGvtdD6PLP3HyBy26FmNXdM6XxYgAXf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AixlnzpZE8OladUxWt+rbtx1Qpk5D0EfgCc42kJxyjtZGlkb/fVYUj7XP1sNEFBXY+n3aQxUKTUOlNbg2xUF26Q4YiWU2y/o+kb+qBs6sDEuo4F4uBJr4ZTF2IF6XsXYbKqlDzPhDje8IT1H/ismVKnZ+GyY2z1tgo0uHi43SYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZsIA6MC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFC4C4CEC5;
	Mon, 16 Sep 2024 17:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726509430;
	bh=mQN9rGOjG8lSGvtdD6PLP3HyBy26FmNXdM6XxYgAXf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HZsIA6MC9ymqn/1g3ln8l8r4xHIWBYfErq9GvoxD3YsgzI7PyowTt5hQy51pPTrKK
	 Q8wDML49Am3Hkf6B0pRT8ONgM8uaVRDdgRbKMfYfLpDev31/naweyPT4RXf3ex0ptx
	 kinTrao11wUFZz/8Uv80M+l+QDFP6LvO/fKgiw/Fqm/nK/ry1otItGaD2eqS2KA8Lt
	 STLSPDyGagBvvB1zx5jhQhmBBN5k3GbvrljHU+nRXdsz+yqkUPimhQI+AG20c2jTKp
	 UDOvBkkf28JvFZAWud537wm/1XP4WDAH9eN40aBRbiyuZeucnK5BsikcNI8JDe1DAb
	 iDX1pW2gzoUng==
Date: Mon, 16 Sep 2024 12:57:08 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Russell King <linux@armlinux.org.uk>, Jakub Kicinski <kuba@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Eric Dumazet <edumazet@google.com>, kernel@pengutronix.de,
	"David S. Miller" <davem@davemloft.net>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: ethernet-phy: Add
 timing-role role property for ethernet PHYs
Message-ID: <172650942796.881251.17049262123032833023.robh@kernel.org>
References: <20240913084022.3343903-1-o.rempel@pengutronix.de>
 <20240913084022.3343903-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913084022.3343903-2-o.rempel@pengutronix.de>


On Fri, 13 Sep 2024 10:40:21 +0200, Oleksij Rempel wrote:
> This patch introduces a new `timing-role` property in the device tree
> bindings for configuring the master/slave role of PHYs. This is
> essential for scenarios where hardware strap pins are unavailable or
> incorrectly configured.
> 
> The `timing-role` property supports the following values:
> - `force-master`: Forces the PHY to operate as a master (clock source).
> - `force-slave`: Forces the PHY to operate as a slave (clock receiver).
> - `prefer-master`: Prefers the PHY to be master but allows negotiation.
> - `prefer-slave`: Prefers the PHY to be slave but allows negotiation.
> 
> The terms "master" and "slave" are retained in this context to align
> with the IEEE 802.3 standards, where they are used to describe the roles
> of PHY devices in managing clock signals for data transmission. In
> particular, the terms are used in specifications for 1000Base-T and
> MultiGBASE-T PHYs, among others. Although there is an effort to adopt
> more inclusive terminology, replacing these terms could create
> discrepancies between the Linux kernel and the established standards,
> documentation, and existing hardware interfaces.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> changes v3:
> - rename "master-slave" to "timing-role"
> changes v2:
> - use string property instead of multiple flags
> ---
>  .../devicetree/bindings/net/ethernet-phy.yaml | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


