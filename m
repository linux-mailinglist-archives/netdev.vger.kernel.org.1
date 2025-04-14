Return-Path: <netdev+bounces-182527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D42A8902E
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 01:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A15A5179B6B
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 23:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D891F3FC8;
	Mon, 14 Apr 2025 23:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovau/Vuu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87B985260;
	Mon, 14 Apr 2025 23:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744673802; cv=none; b=kZhgoAZVqs9rBJEhmJfIQ6jFcKcMJGpr+zf5oHzZ4c4wzKzKoQ8OYf4zZEwIC3Ju5vhw9W0TPFX7Wqe9ZmN1qgsqvdOzJvGKHAvNLtqvGey8+iIYM35aYuUxTPxCgp2L8Hah2yrEL1kDJuBaz2oCXAOu9uLziEE+TL5IbXjATXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744673802; c=relaxed/simple;
	bh=/i3ys/RcQTNOTrQ9BVAgQENYckbmNw9KyunJGMTDrgc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DML9U7e5uzKWDKfZTwK4Na/iPc9TCYTJe69Fd7UJKkxerzmANuYTQsH5/9lPA5u0dx02Pv+znk+TlH1LvX/W3ks8OYX2UBsWLYPMG0DstODITDniGLbftRdHgsRnio1Q4dp2ANCOdvcm4gOhV3IV59ug4jk5dq4UgkI9YWGmygA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovau/Vuu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EAC8C4CEE2;
	Mon, 14 Apr 2025 23:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744673802;
	bh=/i3ys/RcQTNOTrQ9BVAgQENYckbmNw9KyunJGMTDrgc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ovau/Vuufilnp1Gd5BmcEW0l+ACtX68GxqC4cUX4DMj5bJmwAFngy5e1xDO3mYM6g
	 4qmmVPGQ1TEWaAV0etq6xXaON/Pg3iw1SbkIM0h1s/o2f64PSGwERmQFdmL4dN2CY0
	 N+/s7N/zInQ+8cx7e/bo/eSMhsUoJgIlTVRarPGvLG6a4dXQg6PK/FBNNe1967THjE
	 kDVLG5CyaaT5CPqzsOMcHhHvJ4e7RvOd5xQQYO0qZ0Lsx7PdPwDpsInGWNvhfX7f7f
	 IQ6Aqxxq2k10ujJDRXdQUZB2fPexIMgAmIzFgCU+7DwgcsV3jZts6zCEj2X5WWKPq6
	 7jWYI5UuC2u3g==
Date: Mon, 14 Apr 2025 16:36:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: Christian Marangi <ansuelsmth@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, Andrei Botila <andrei.botila@oss.nxp.com>, Sabrina
 Dubroca <sd@queasysnail.net>, Eric Woudstra <ericwouds@gmail.com>, Daniel
 Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.or
Subject: Re: [net-next PATCH v7 5/6] net: phy: Add support for Aeonsemi
 AS21xxx PHYs
Message-ID: <20250414163640.548aa37b@kernel.org>
In-Reply-To: <20250410095443.30848-6-ansuelsmth@gmail.com>
References: <20250410095443.30848-1-ansuelsmth@gmail.com>
	<20250410095443.30848-6-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Apr 2025 11:53:35 +0200 Christian Marangi wrote:
> Add support for Aeonsemi AS21xxx 10G C45 PHYs. These PHYs integrate
> an IPC to setup some configuration and require special handling to
> sync with the parity bit. The parity bit is a way the IPC use to
> follow correct order of command sent.
> 
> Supported PHYs AS21011JB1, AS21011PB1, AS21010JB1, AS21010PB1,
> AS21511JB1, AS21511PB1, AS21510JB1, AS21510PB1, AS21210JB1,
> AS21210PB1 that all register with the PHY ID 0x7500 0x7510
> before the firmware is loaded.
> 
> They all support up to 5 LEDs with various HW mode supported.
> 
> While implementing it was found some strange coincidence with using the
> same logic for implementing C22 in MMD regs in Broadcom PHYs.
> 
> For reference here the AS21xxx PHY name logic:

Would any of the PHY maintainers be willing to cast their review tag
upon this patch? :)

