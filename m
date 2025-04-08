Return-Path: <netdev+bounces-180234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A08A80C36
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9DC6505502
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 13:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25C92288D2;
	Tue,  8 Apr 2025 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xTZ8sCXL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2161E226CE4;
	Tue,  8 Apr 2025 13:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744117922; cv=none; b=QuOU05t9onNUuUXB291muGytO+LLX5aj1pQUCM6qk1X8M5Q5fFDlq6gcmjzbwY5vBlMSyZiWiNNjge4VfsxAp8/UtpSp6cTFr41evKDY1y8m47YhU9bDIs73JKGi/SOCQTZA69MtEim8NZkMGIXdY4C2xyU5H2dJhusW+6Td6JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744117922; c=relaxed/simple;
	bh=ps4chw34OHJ0V+JbdkNGtAxeh60Col1rVzxxMHsVFjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MObqTNkoMxsALqT+MUaDhkqx11kWWklyo5Mhop0INJOIHtuD18cGdeUDGmnHtRQnNL3gfKNUHH64UFYqgbeLZ0oZOyD+JA25MPRUlS4tD2lykXR1mBNqABtmDrqFvV2idfWBMECpii4USS/u8B437MjAqmpfCG43pxLpDte7t1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xTZ8sCXL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UCzoQEukubcn8L70JJd4rpAlW2PfrAAtWJTRZbroIZk=; b=xTZ8sCXL9XcC7sa3PC9OupCBHr
	7mqfZ+nBbA40wZOEMIKX5HuZ000SIL7hGbyIrw/I3srRcI/hxQC14FsgqJ6+PSd1G2tlubDdCa55F
	xTuPbVJdlYAjF7RMMpM5F4oyjjq7GcUVu9InSa3ou0zx/nbhk7wBcirRK8WiKMBX6Pn8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u28jt-008OHY-9d; Tue, 08 Apr 2025 15:11:41 +0200
Date: Tue, 8 Apr 2025 15:11:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Frank Sae <Frank.Sae@motor-comm.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Parthiban.Veerasooran@microchip.com, linux-kernel@vger.kernel.org,
	"andrew+netdev @ lunn . ch" <andrew+netdev@lunn.ch>, lee@trager.us,
	horms@kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net,
	geert+renesas@glider.be, xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com, hua.sun@motor-comm.com
Subject: Re: [PATCH net-next v4 07/14] net:phy:motorcomm: Add
 PHY_INTERFACE_MODE_INTERNAL to support YT6801
Message-ID: <37354708-0fce-42ca-b7f9-6bb83ad87d10@lunn.ch>
References: <20250408092835.3952-1-Frank.Sae@motor-comm.com>
 <20250408092835.3952-8-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408092835.3952-8-Frank.Sae@motor-comm.com>

On Tue, Apr 08, 2025 at 05:28:28PM +0800, Frank Sae wrote:
> YT6801 NIC Integrated a PHY that is YT8531S, but it used GMII interface.
> Add a case of PHY_INTERFACE_MODE_INTERNAL to support YT6801.
> 
> Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
> ---
>  drivers/net/phy/motorcomm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> index 0e91f5d1a..ac3a46939 100644
> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c
> @@ -896,6 +896,12 @@ static int ytphy_rgmii_clk_delay_config(struct phy_device *phydev)
>  		val |= FIELD_PREP(YT8521_RC1R_RX_DELAY_MASK, rx_reg) |
>  		       FIELD_PREP(YT8521_RC1R_GE_TX_DELAY_MASK, tx_reg);
>  		break;
> +	case PHY_INTERFACE_MODE_INTERNAL:
> +		if (phydev->drv->phy_id != PHY_ID_YT8531S)
> +			return -EOPNOTSUPP;
> +
> +		dev_info_once(&phydev->mdio.dev, "Integrated YT8531S phy of YT6801.\n");

Drivers should be silent unless something going wrong. dev_dbg() or
nothing please.

	Andrew

