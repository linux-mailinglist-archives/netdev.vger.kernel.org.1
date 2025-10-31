Return-Path: <netdev+bounces-234640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC5CC24F8C
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 13:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3AD83B9530
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 12:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800CE2E1743;
	Fri, 31 Oct 2025 12:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3yJa5+kd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F12D2DC78A
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 12:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913310; cv=none; b=lUI5KbpwoWCM/FvT327l64U4nik9qf1UGNtekpHDNWxIQ+SPnhqN5GSoLe/ZY7txmR28O9qZtWrQJwdM51w3oz+jLMVZJAa7ufsOC+teRhtOCZ4oLHC9NzfkS1sbSxG7Ysc0zuo/3s31w4w4TNkfspCIKXPePrG+ayUebaFHyKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913310; c=relaxed/simple;
	bh=Zko9juVkvIIh48a/bM+zG5jLocb+/N896GHA2aLmShQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M08f+VqAZKuRCXMW3c3+dJeEmbdlADqzSz1Hr6bw7nL73KmhXUxaMIlH+hOYWVG29lMFD5dKXvLRKNsuDzZ3kBG0UVyC4e9Tb0JXPGkolc1xSFh6ulUbsLdNQfaT8t3Gbf4CggN6ggJSQ30B64+LljJKLt6oTAHLDUMwnK1SLWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3yJa5+kd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0aQxS3qZPtArJu1pqBZJOeWmjkfSHxjHJp7/EyCwfGU=; b=3yJa5+kdw0UcZZpDIctbxnhBpR
	7Fl3FHHy4PBZNO3GIQTq6FAME4qZiHlKca+BrI33kpwVjlevsiwFEx2nON/SF/q8IM+vmwQDCObfQ
	omJyv/vv+eJdpM9I9FuKv3f9xh+LHa7v0cLWWffGIbJEBYEHRh+vJ9pmlu2oFAklMFEA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vEo8A-00Cazd-KI; Fri, 31 Oct 2025 13:21:22 +0100
Date: Fri, 31 Oct 2025 13:21:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yi Cong <cong.yi@linux.dev>
Cc: Frank.Sae@motor-comm.com, davem@davemloft.net, hkallweit1@gmail.com,
	kuba@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
	yicong@kylinos.cn
Subject: Re: [PATCH net-next 1/2] net: phy: motorcomm: correct the default rx
 delay config for the rgmii
Message-ID: <ccbf01a4-71e7-446f-b13b-5c090d5a621e@lunn.ch>
References: <5b97f70c-45c3-41c2-ba7b-d383864f0003@lunn.ch>
 <20251031022700.492740-1-cong.yi@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031022700.492740-1-cong.yi@linux.dev>

> > However, in general, Linux should not rely on the BIOS, Linux should
> > correctly configure the hardware, and in this case, it is trivial to
> > do, since it is already all implemented.
> 
> The phy-mode is read by the MAC from ACPI. The same MAC paired with
> different PHYs, or different vendors using the same MAC+PHY combination
> but with varying motherboard designs, may result in differences here
> (I've encountered both rgmii-id and rgmii-rxid).

There are two basic PCB designs. The PCB provides the 2ns delay by
using extra long clock lines. If that is the case, DT says 'rgmii'.
If the PCB does not have extra long clock lines, the MAC/PHY pair
needs to provide the delays, so DT says 'rgmii-id'. Very few designs
have the PCB add delays, so 95% of boards use 'rgmii-id'. There is one
board i know of which has one extra long clock line, one not, so it
uses rgmii-rxid, or maybe rgmii-txid in DT. I don't remember which.

If you are doing an ACPI binding the same should apply.

> Returning to the current patch: changing the default value to match the
> datasheet will not affect any phy-mode directly. This is because the delay value
> is first obtained, and then its application is determined based on the phy-mode:
> ```
> static int ytphy_rgmii_clk_delay_config(struct phy_device *phydev)
> {
> 	...
> 	/* get rx/tx delay value */
> 	rx_reg = ytphy_get_delay_reg_value(phydev, "rx-internal-delay-ps",
> 					   ytphy_rgmii_delays, tb_size,
> 					   &rxc_dly_en,
> 					   YT8521_RC1R_RGMII_0_000_NS);
> 	tx_reg = ytphy_get_delay_reg_value(phydev, "tx-internal-delay-ps",
> 					   ytphy_rgmii_delays, tb_size, NULL,
> 					   YT8521_RC1R_RGMII_NONLINEAR_0_750_NS);
> 
> 	/* Set it based on different phy-mode */
> 	switch (phydev->interface) {
> 	case PHY_INTERFACE_MODE_RGMII:
> 		rxc_dly_en = 0;
> 		break;
> 	case PHY_INTERFACE_MODE_RGMII_RXID:
> 		val |= FIELD_PREP(YT8521_RC1R_RX_DELAY_MASK, rx_reg);
> 		break;
> 	case PHY_INTERFACE_MODE_RGMII_TXID:
> 		rxc_dly_en = 0;
> 		val |= FIELD_PREP(YT8521_RC1R_GE_TX_DELAY_MASK, tx_reg);
> 		break;
> 	case PHY_INTERFACE_MODE_RGMII_ID:
> 		val |= FIELD_PREP(YT8521_RC1R_RX_DELAY_MASK, rx_reg) |
> 		       FIELD_PREP(YT8521_RC1R_GE_TX_DELAY_MASK, tx_reg);
> 		break;
> 	default: /* do not support other modes */
> 		return -EOPNOTSUPP;
> 	}

Now think about what PHY_INTERFACE_MODE_RGMII_ID means. It means, the
PCB does not add the 2ns delays. The MAC/PHY combination must add the
delays, and when the MAC has called phy_connect(), it has passed
PHY_INTERFACE_MODE_RGMII_ID, asking the PHY to add the 2ns delay. It
can add a range of delays, but the default is 1.95ns, which is the
closest it can get to the 2ns defined in the RGMII standard.

If the PHY actually added 0ns delay, the board is broken, because it
is missing the delays. The default is correct and there are shipping
boards making use of it.

Any issues you are having are because you are not using the APIs
correctly. If the PCB is adding the delays, use 'rgmii' in DT. If the
MAC is adding delays, which we do not recommend, pass
PHY_INTERFACE_MODE_RGMII to the PHY. This is all explained in one of
the links i gave you.

   Andrew

