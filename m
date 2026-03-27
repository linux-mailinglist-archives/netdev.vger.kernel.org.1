Return-Path: <netdev+bounces-272470-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AE4mNq5HxmmgIAUAu9opvQ
	(envelope-from <netdev+bounces-272470-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 10:02:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 789163416D3
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 10:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3F3F30AB8DD
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8294F3D9DD6;
	Fri, 27 Mar 2026 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="aa3QmBDW"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ACC3D8134;
	Fri, 27 Mar 2026 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774601867; cv=none; b=P+3RV18zFqqBgQOHfQWIWtzSrispFBbocZUwiM0OFyQFjZMtXQhcSftOf8KXMqoZMCLyTXNVAwfl09z//6gQESnKNz7U0b+6k0fzYJXudfreXK35IxzCFsVCS5hz3JSpolUtpuTPmoGWfe3L8iV1+BXy+CsNdx6OyxFgDnVC2kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774601867; c=relaxed/simple;
	bh=kHJq8setAZEsfRHd4stEatwht/Olv8u9dxt7GFy7T6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCG1+JrNo2RFggiqBRiZBr2bPGRsM44wB4tq2+TqmqAoaPRGrtH5UT2fpUfGUVREoYlo79mljWnVFgC8mUFmkA5QaOTu+tlMvKfAHXnk26F+wXZqGn/tkwvoP+Sq/IzLZP/ggn3FZFrWJNhyPUNC3d65V4tulAaoapojfFirWQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=aa3QmBDW; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hOmW/AC1iGNv4AqBFSpENvhIBT9qucm0GxDr6Sgffg4=; b=aa3QmBDWKXnh8+E4kNAEUGwxiz
	MVcYhjda7HLYfa8P1+HMh+2b7VHt9sBmqimONpa/l7P2sv5LvDs7MVnFtfU33bb6j4ws59n4VyOEE
	nvZZwHJO5SV3LbSVp0nwVlg582EHqK5Lo62sTi6VJW0yO38lJQ3oxQ8jTFMRDwU2Fd5J/gvlghjtU
	geVQZ8UCxowTMMshkdCVDDstTrkTstf5PVD7wyiXO3zIGFTjQOYMxCdUFHXSMn7O0gsO6Et85L5l6
	U+f4kUNPaetxftkhT8RA1EsPqtZZlnR3O+kRwtEs49drgZwr8LYWnPlZiRLUwU5FwgLiZoK2voFwj
	YyhsyC6g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43984)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w630b-000000005u1-0Qbj;
	Fri, 27 Mar 2026 08:57:37 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w630Z-000000007uc-0yqq;
	Fri, 27 Mar 2026 08:57:35 +0000
Date: Fri, 27 Mar 2026 08:57:35 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, Raju.Lakkaraju@microchip.com,
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: lan743x: add support for RMII interface
Message-ID: <acZGf53Ls7hpFdXd@shell.armlinux.org.uk>
References: <20260327054008.79294-1-thangaraj.s@microchip.com>
 <20260327054008.79294-3-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327054008.79294-3-thangaraj.s@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272470-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[microchip.com:query timed out];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[thangaraj.s.microchip.com:query timed out];
	NEURAL_HAM(-0.00)[-0.656];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:email,armlinux.org.uk:url]
X-Rspamd-Queue-Id: 789163416D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 11:10:08AM +0530, Thangaraj Samynathan wrote:
> Enable RMII interface in the lan743x driver for PHY and MAC
> configuration.
> 
> - Select RMII interface in lan743x_phy_interface_select().
> - Update phylink supported_interfaces and MAC capabilities.
> - Enable RMII via RMII_CTL in lan743x_hardware_init().
> - Define RMII_CTL register and enable bit in lan743x_main.h.
> 
> Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
> ---
>  drivers/net/ethernet/microchip/lan743x_main.c | 18 ++++++++++++++++++
>  drivers/net/ethernet/microchip/lan743x_main.h |  3 +++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
> index b7b1584d867d..86d35810460f 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -1370,6 +1370,8 @@ static void lan743x_phy_interface_select(struct lan743x_adapter *adapter)
>  
>  	if (adapter->is_pci11x1x && adapter->is_sgmii_en)
>  		adapter->phy_interface = PHY_INTERFACE_MODE_SGMII;
> +	else if (adapter->is_pci11x1x && adapter->is_rmii_en)
> +		adapter->phy_interface = PHY_INTERFACE_MODE_RMII;
>  	else if (id_rev == ID_REV_ID_LAN7430_)
>  		adapter->phy_interface = PHY_INTERFACE_MODE_GMII;
>  	else if ((id_rev == ID_REV_ID_LAN7431_) && (data & MAC_CR_MII_EN_))
> @@ -3158,6 +3160,13 @@ static int lan743x_phylink_create(struct lan743x_adapter *adapter)
>  		__set_bit(PHY_INTERFACE_MODE_MII,
>  			  adapter->phylink_config.supported_interfaces);
>  		break;
> +	case PHY_INTERFACE_MODE_RMII:
> +		__set_bit(PHY_INTERFACE_MODE_RMII,
> +			  adapter->phylink_config.supported_interfaces);
> +		adapter->phylink_config.mac_capabilities &= ~MAC_1000FD;

Phylink already knows that gigabit isn't supported with RMII. See
phy_caps_from_interface():

        case PHY_INTERFACE_MODE_REVRMII:
        case PHY_INTERFACE_MODE_RMII:
        case PHY_INTERFACE_MODE_SMII:
        case PHY_INTERFACE_MODE_REVMII:
        case PHY_INTERFACE_MODE_MII:
                link_caps |= BIT(LINK_CAPA_10HD) | BIT(LINK_CAPA_10FD);
                fallthrough;

        case PHY_INTERFACE_MODE_100BASEX:
                link_caps |= BIT(LINK_CAPA_100HD) | BIT(LINK_CAPA_100FD);
                break;

which is used by phylink_get_capabilities() to reduce the MAC
capabilities depending on the interface and rate matching.

The only case to do this is where the MAC really has no 1G support.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

