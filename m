Return-Path: <netdev+bounces-170643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4035A496D2
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 11:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06E56175CE7
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 10:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F1025F7B5;
	Fri, 28 Feb 2025 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Kv44qeJF"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C69F25D1FD;
	Fri, 28 Feb 2025 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737716; cv=none; b=IlD6rcHvm/CfY61nKe7wYnAiYAV9sts4+A+f+xgye/6AfkiL9ageIZEBcMX8VgcRlpbctzVSbR1bX1xiZRIeyc9D8AjJ51ACLuY+sZkGvRWm4GbzwrynQFdCRSX7Qny9Ck0DKt3/ea+CmDnGzV4xyiY+CpqL9FpTteHZzhpT0E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737716; c=relaxed/simple;
	bh=Lgdtyvw5VOQRvn4vyklvWaffP6nCPDn4Cpf3ZEXtkbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEz1odq7O2m1DoVTkL9N1LaEgSoYY8QdDO5opBSmb8Q5EQ0WNidPr67s268B8SyVPLmLVPEzCUU3KI0U4IErXN/suppABODSErGeSpRjqq42MTR2zygfBT8oF8l1vFr6CHwe8rOi/HhL3iKj9fFwwjCl7MDcRB36LTAUBcWkwgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Kv44qeJF; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=go8pUwv2BEOCfHi2CIo0QOUqPUvdYiGQFAYsAccxmBA=; b=Kv44qeJF55UudRllLrsFEPj4hr
	dtX42k4CGvq9fp1PFOJkSL77scgp7tUFUWg7KtCwILi/hx5ElAr8EwrDijCVcIk2dMAjZXuwxiAHg
	YedlHtV0lrYFcyj0L6z4s9d+D1A6CUV1aq8TY805bIeE9JZ/x+w/SqvvBw+S12lAWSEMKNti6DrjI
	aDoGyh8+VS/lXE0bXQIX8owJaD3GD2r1tyL22iOOgqed64QWca+pR4zvIZE1oI9CxokA2m21fpJlB
	JL/1czh4Gr8LgLyPm7inaXklJDAZx5Yhm9KSBaHmSPgjRwG5QoObFrtjqOSHL9dDGLz65Qtt9A/uD
	+XlmbQGA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56448)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tnxOY-0001Zk-07;
	Fri, 28 Feb 2025 10:15:02 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tnxOT-0000ev-27;
	Fri, 28 Feb 2025 10:14:57 +0000
Date: Fri, 28 Feb 2025 10:14:57 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Frank Sae <Frank.Sae@motor-comm.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Parthiban.Veerasooran@microchip.com, linux-kernel@vger.kernel.org,
	xiaogang.fan@motor-comm.com, fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com
Subject: Re: [PATCH net-next v3 07/14] phy:motorcomm: Add
 PHY_INTERFACE_MODE_INTERNAL to support YT6801
Message-ID: <Z8GMobKzK7BZLDKI@shell.armlinux.org.uk>
References: <20250228100020.3944-1-Frank.Sae@motor-comm.com>
 <20250228100020.3944-8-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228100020.3944-8-Frank.Sae@motor-comm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Feb 28, 2025 at 06:00:13PM +0800, Frank Sae wrote:
> YT6801 NIC Integrated a PHY that is YT8531S, but it used GMII interface.
> Add a case of PHY_INTERFACE_MODE_INTERNAL to support YT6801.
> 
> Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
> ---
>  drivers/net/phy/motorcomm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> index 0e91f5d1a..371acafd5 100644
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
> +		phydev_info(phydev, "Integrated YT8531S phy of YT6801.\n");

Why should this be printed every time the PHY is configured?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

