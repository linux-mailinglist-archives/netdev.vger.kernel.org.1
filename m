Return-Path: <netdev+bounces-272743-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABZgII6Ix2nhYgUAu9opvQ
	(envelope-from <netdev+bounces-272743-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 08:51:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C8934DB5C
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 08:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6602430238D8
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 07:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABF634F25C;
	Sat, 28 Mar 2026 07:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wbdEyCKW"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DC02C86D;
	Sat, 28 Mar 2026 07:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774684299; cv=none; b=h2pXsYUPvesbv3R+7OjYEBpnVTuJuiiiv3GR2E3J97cqe1O7G+Q7F7M15bBtpS8OxKXADf4N7NP5RgOspe0xQVS3RM3E3DipjDqqxUjygtav8OMd1OgbjxWUu8wAOTCU/yA4ltWFsMV9WJN1bCx9StVpJXlq41id+DAFtBLbJWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774684299; c=relaxed/simple;
	bh=S4/YFlTuNtrGE6iqHmbs+HMQEniTIFnuL2BWpw/AeAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9kBczwNJaJJ2AFCMuCk6GDC+eDVZvFT0aHS+Nfdv25xoZ0Yq/4cfvMKTsETvBRm1wZVLyJAAv1+FqfJFoJXT64K+McLibLZC9RqOkWJOA9NAu0c9eFWzLjbEvTbVn+PYA34fZJ78bHC7/+eRuwkgkOfwn48InhyEm1QSEX1o+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wbdEyCKW; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kcCUMbnn2xhlLhVQAjJxMMLH4aljs8rQ9ZN4v5JicAQ=; b=wbdEyCKWA3AD4xgAzskxbTq9XA
	MZZGTI34OwbhP/yFwga1b1nvz8daEXs+weOWQF+kDDRVWGsjteKf7PZALfs2F1ZNkBhn3OuEELNqt
	ukUAaaRSKU3O9kbjwZq/aU07jjhIWMoxBmIrkDPBW4IbU6cRglYIyINcoZgp9BmEKuxvTHmKSVeJl
	BosF2l3ogZCOjycMFu0LtbogLYXQN+2yOtx4Jyu+KZyGd8t2/l12vUnSJPtc9+y1gQshMUbuAkeW4
	iJqHs3hlgivtZEa4ohnzQGh5zfvWfmfqqckn7cc0PaeirfoxnOspgdeNR1h79rMVYVM4I2XJXJs5Z
	yd20lg0A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59968)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w6OS5-0000000071k-1KrD;
	Sat, 28 Mar 2026 07:51:25 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w6OS0-000000000Un-1IID;
	Sat, 28 Mar 2026 07:51:20 +0000
Date: Sat, 28 Mar 2026 07:51:20 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Michal Piekos <michal.piekos@mmpsystems.pl>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: stmmac: skip VLAN restore when VLAN hash ops are
 missing
Message-ID: <aceIeFWGAZwr1njk@shell.armlinux.org.uk>
References: <20260328-vlan-restore-error-v3-1-df47a039c6f6@mmpsystems.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260328-vlan-restore-error-v3-1-df47a039c6f6@mmpsystems.pl>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272743-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,renesas.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.815];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shell.armlinux.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:url,mmpsystems.pl:email]
X-Rspamd-Queue-Id: D3C8934DB5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 28, 2026 at 07:51:53AM +0100, Michal Piekos wrote:
> stmmac_vlan_restore() unconditionally calls stmmac_vlan_update() when
> NETIF_F_VLAN_FEATURES is set. On platforms where priv->hw->vlan (or
> ->update_vlan_hash) is not provided, stmmac_update_vlan_hash() returns
> -EINVAL via stmmac_do_void_callback(), resulting in a spurious
> "Failed to restore VLANs" error even when no VLAN filtering is in use.
> 
> Remove the unneeded comment.
> 
> Tested on Orange Pi Zero 3.
> 
> Fixes: bd7ad51253a7 ("net: stmmac: Fix VLAN HW state restore")
> Signed-off-by: Michal Piekos <michal.piekos@mmpsystems.pl>
> ---
> This patch fixes a noisy "Failed to restore VLANs" message on platforms
> where stmmac VLAN hash ops are not implemented.
> stmmac_vlan_restore() calls stmmac_vlan_update() without checking for
> VLAN hash ops presence which results in -EINVAL. 
> ---
> Changes in v3:
> - Remove the offending comment
> - Restore the original check for NETIF_F_VLAN_FEATURES
> - Link to v2: https://lore.kernel.org/r/20260321-vlan-restore-error-v2-1-45cf56a5223d@mmpsystems.pl
> 
> Changes in v2:
> - Replace check for hash ops with check for HW FILTER flags
> - Link to v1: https://lore.kernel.org/r/20260314-vlan-restore-error-v1-1-4fc6c3e2115f@mmpsystems.pl
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 6827c99bde8c..0f3e5ac05faa 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -6861,19 +6861,13 @@ static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vi
>  
>  static int stmmac_vlan_restore(struct stmmac_priv *priv)
>  {
> -	int ret;
> -
>  	if (!(priv->dev->features & NETIF_F_VLAN_FEATURES))
>  		return 0;
>  
>  	if (priv->hw->num_vlan)
>  		stmmac_restore_hw_vlan_rx_fltr(priv, priv->dev, priv->hw);
>  
> -	ret = stmmac_vlan_update(priv, priv->num_double_vlans);
> -	if (ret)
> -		netdev_err(priv->dev, "Failed to restore VLANs\n");
> -
> -	return ret;
> +	return stmmac_vlan_update(priv, priv->num_double_vlans);
>  }

Yes, but as both Andrew and myself have pointed out, no one checks
the return value of stmmac_vlan_restore(), so why does it return
int?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

