Return-Path: <netdev+bounces-175375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5348A657D7
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 17:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 856943A5FC6
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 16:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E2719D8A2;
	Mon, 17 Mar 2025 16:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNP6zHfb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D9174BE1;
	Mon, 17 Mar 2025 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742228466; cv=none; b=ZNnofXTwa4kv2bkbBiCBGHX6ElGjTX1Qfd0Hd4Z00ezKMDM9TKbV80JxTM2FxpQBAU+mlTPJgqImD2tJtSnGKMBUjr+lINos4X6OhQyboMrflYII44FXUK+QiHxA6gXpjKqOCGzU6VOEwWI99g1/pVrWuUqSoU5gfZB/jm260o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742228466; c=relaxed/simple;
	bh=vF7ad/Mcki5NOq2HyTnzqiMe2ZTcqukB3pbb+0Dn7dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2BGIyEBbETW/Kxfz2GWujy2W0Toj8w4TfBE1fdNLeO+ZsOu9xgaqp0FuK/Upogw/tiAfq+TBl5Qo1hsM3S11kjVWOd5nheXkBaceQuMGx2QPwU+FS/TJzUtfLydDPKLhMYETX+1Y+p6oBfZadbUg2WCfaxLoF/UnJbOtR9+niQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNP6zHfb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52745C4CEE3;
	Mon, 17 Mar 2025 16:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742228465;
	bh=vF7ad/Mcki5NOq2HyTnzqiMe2ZTcqukB3pbb+0Dn7dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UNP6zHfbeqKFnPIED0zdcRQimNpHnL50ZjQw/SF2NtUKHkJKf+WsK8Puc0q/HRC5Q
	 onsOiDyvNoV9I+gK/9P9UtAQWijdj+yFOF294HY5ZRdwOUJESoBpFeDSMjOUnV/tMb
	 LGl0pVHBIhsIpmJ4mCJBqxLGoyFSE8nwWvMrmpAR5euAb3/3Y4JF8rCW/r7HPLZ283
	 tEjE0x3ifwLcDaMyGL+724wsBU0E2DxXpycWU0RIX9dNzNk31tWJF72zZU1HWW4xSf
	 dOMKc63X/TiQUDyNsTttNXexINS3UNfcOMokM+zEqcHr+RjiWmygyhgkt9/MmX/MKB
	 fBchnaF6xNSFA==
Date: Mon, 17 Mar 2025 11:21:04 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>,
	linux-arm-kernel@lists.infradead.org,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-mediatek@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	upstream@airoha.com, Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [net-next PATCH v13 03/14] dt-bindings: net: dsa: Document
 support for Airoha AN8855 DSA Switch
Message-ID: <174222846382.166778.10361750788975293677.robh@kernel.org>
References: <20250315154407.26304-1-ansuelsmth@gmail.com>
 <20250315154407.26304-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315154407.26304-4-ansuelsmth@gmail.com>


On Sat, 15 Mar 2025 16:43:43 +0100, Christian Marangi wrote:
> Document support for Airoha AN8855 5-port Gigabit Switch.
> 
> It does expose the 5 Internal PHYs on the MDIO bus and each port
> can access the Switch register space by configurting the PHY page.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../net/dsa/airoha,an8855-switch.yaml         | 86 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


