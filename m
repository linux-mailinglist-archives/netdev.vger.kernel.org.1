Return-Path: <netdev+bounces-260042-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WF6wB55anGmzEgQAu9opvQ
	(envelope-from <netdev+bounces-260042-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:48:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA421773D7
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 961A6304D159
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 13:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D7B24E4AF;
	Mon, 23 Feb 2026 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YKXr/1uL"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED646246BC0;
	Mon, 23 Feb 2026 13:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854441; cv=none; b=YU22D8zW1+jJN4UwPoDwMiluSdLv7lTh0Vv3wwoZZEFI68Pi6WUZ4lp0P+fgxFyo6nQrubHTDMPIN+aArHkc4dnSw418BLSrabXxPvjqynjZvFIMA94ycS+g7TgLV8zZ5qNunLodRGnqEtN97qVzi5u4L8ln90QvqyWiaNQRDrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854441; c=relaxed/simple;
	bh=7oBM+VgLvhixHqlmsvTeeBj2Zzny06GOUYBa8qLzvPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dby0xX66mr1lMO623ZtUVcCG/k4juruw4ddsEZrRdM1uKQ1Maq8vH6IIiILnO91GT6QjPltuPOpF64XwZNgcALoBmuI8kP7ttKeCNBT1/0fzPuiswaMEetPIZ2+mgBj5qhvZyvU2OaL80uTSeSy1nmLXMmuuWf9aRSf6sIN2Gtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=YKXr/1uL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tGF/G9VZgwv5uDw1cDEKac6MbcUJTCMmbChRNc3rhyU=; b=YKXr/1uLiFlLjtTWx/94BTDEY4
	PWsXqFPZ7hzVbsvDV7OwZxL5gRAoeagWEG42AaxNXU+5yidUIQn9+u+/bgcF6yQq1kYNDR/Cx7Ak5
	HYmm2mo41VFEAdLt4bROjOQiy5gBryfzrOjk4Zl37LTPBCIc1QdUq3GF5fdFCbFVFL49d/vDJ2D/4
	Tfh+JXbDsNAEstdP2O1B1W6Q1Zxz8Mrevd3ESMmND+XeZbUD0ktAOSdGYpvZXiij7w+UzmxmtxlTS
	Buk39hdi/nTKDPZiRXqlj279EVslGoFr2NqsJdatWYOe1FtjvB0Hl+FfT+uiRyYaDbML6lisqL/TR
	vAvBIC4g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50878)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vuWH2-0000000049Y-3Ilb;
	Mon, 23 Feb 2026 13:46:56 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vuWGw-000000007QI-0wgd;
	Mon, 23 Feb 2026 13:46:50 +0000
Date: Mon, 23 Feb 2026 13:46:50 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, maxime.chevallier@bootlin.com,
	boon.khai.ng@altera.com, rohan.g.thomas@altera.com,
	vladimir.oltean@nxp.com, hayashi.kunihiko@socionext.com,
	matthew.gerlach@altera.com, vee.khee.wong@intel.com,
	boon.leong.ong@intel.com, kim.tatt.chuah@intel.com,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/4] net: stmmac: Fix VLAN handling when
 interface is down
Message-ID: <aZxaSq1mrfInWClI@shell.armlinux.org.uk>
References: <20260223124102.120432-1-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223124102.120432-1-ovidiu.panait.rb@renesas.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260042-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,bootlin.com,altera.com,nxp.com,socionext.com,intel.com,vger.kernel.org,lists.infradead.org,st-md-mailman.stormreply.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,armlinux.org.uk:url,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 9FA421773D7
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 12:40:58PM +0000, Ovidiu Panait wrote:
> VLAN register accesses on the MAC side require the PHY RX clock to be
> active. When the network interface is down, the PHY is suspended and
> the RX clock is unavailable, causing VLAN operations to fail with
> timeouts.
> 
> The VLAN core automatically removes VID 0 after the interface goes down
> and re-adds it when it comes back up, so these timeouts happen during
> normal interface down/up:
> 
>     # ip link set end1 down
>     renesas-gbeth 15c40000.ethernet end1: Timeout accessing MAC_VLAN_Tag_Filter
>     renesas-gbeth 15c40000.ethernet end1: failed to kill vid 0081/0
> 
> Adding VLANs while the interface is down also fails:
> 
>     # ip link add link end1 name end1.10 type vlan id 10
>     renesas-gbeth 15c40000.ethernet end1: Timeout accessing MAC_VLAN_Tag_Filter
>     RTNETLINK answers: Device or resource busy
> 
> Patches 3-4 address this by deferring hardware writes when the
> interface is down and reconfiguring the VLAN state on interface up.
> 
> Patches 1-2 fix some issues in the existing VLAN implementation.

First point to make is that when the netdev supports
NETIF_F_VLAN_FEATURES, receive clock stop is disabled. In stmmac:

        /* Disable EEE RX clock stop to ensure VLAN register access works
         * correctly.
         */
        if (!(priv->plat->flags & STMMAC_FLAG_RX_CLK_RUNS_IN_LPI) &&
            !(priv->dev->features & NETIF_F_VLAN_FEATURES))
                config->eee_rx_clk_stop_enable = true;

in phylink:

        if (pl->mac_supports_eee_ops) {
                /* Explicitly configure whether the PHY is allowed to stop it's
                 * receive clock.
                 */
                ret = phy_eee_rx_clock_stop(phy,
                                            pl->config->eee_rx_clk_stop_enable);

and also in phylink's phylink_rx_clk_stop_block():

        /* Disable PHY receive clock stop if this is the first time this
         * function has been called and clock-stop was previously enabled.
         */
        if (pl->mac_rx_clk_stop_blocked++ == 0 &&
            pl->mac_supports_eee_ops && pl->phydev &&
            pl->config->eee_rx_clk_stop_enable)
                phy_eee_rx_clock_stop(pl->phydev, false);

So, given that when stmmac supports VLAN, eee_rx_clk_stop_enable will be
false, so phylink_rx_clk_stop_block() does nothing useful and receive
clock stop at the PHY will be disabled.


So a few questions:

1) when the network interface is opened or resumed, a DMA reset is
performed which resets all hardware state, including VLAN state. On
resume, we call stmmac_restore_hw_vlan_rx_fltr(), but to me it looks
like that is incomplete, and bits of the VLAN configuration don't get
restored on resume. Please can you look at this and confirm whether
this is indeed the problem.

2) If we can fully restore the VLAN configuration on resume, I suspect
the driver will be doing the same work at resume as at open time, so
this code should be shared.

Please can you look at both of these points.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

