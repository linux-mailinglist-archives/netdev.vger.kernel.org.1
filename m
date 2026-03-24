Return-Path: <netdev+bounces-270965-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCmgLXxhwmmecAQAu9opvQ
	(envelope-from <netdev+bounces-270965-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:03:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DAB30623A
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 266273037F2D
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06A83D9059;
	Tue, 24 Mar 2026 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="t58YdZem"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4322A19B5A3;
	Tue, 24 Mar 2026 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774346015; cv=none; b=nlPWFIido+xO/H5qbi4Cfz+hypPVH1aWXHT1cIRlR9KeWQo1x+ile58KcL8mqU3X/moJiN3nN3SdpAbXvRr60AlLQR1sumD/SecvwfEwI5nKNJDiwww5cQ4ybRL6lohUeuPLW/3pM2/Lx57HAwVaZN5Ovh+RXL0OXLXrRL6imgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774346015; c=relaxed/simple;
	bh=uEuWKLwlIuAaFC56spYVjrMANVV7jxtcmWXjBl73dbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQII0S2kzdviWPrMRIvuGN9S/Td05mK2dyvmTG5lkbB81P/aUuKoHeszhu6z84BIO9wZL9+LQQjInip0IgyBYx9IRAM4ETkJ7X4plw+Ixkn/OzA5VlL6A9juQvlGq5Bf9ONR85Jz281kGeYLBVArqmC1q3c+6WyeQOzD60EwPKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=t58YdZem; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cB8TFGRfEdVX3qY2fuvGrhl4Xqk2fm3TveNGrNsWCq0=; b=t58YdZemTOa6KNg9wCkCIlj924
	BtVeV7s+7Gmia04+AgJGiBQvWFvbagQR4CEmQ7JbSY5sZ7ETfxNDVzvwykaoVrUWtk5FwqXKzYoy7
	kD37wMf2LXs6Zoy83K28E/i+Fz99vxwQtTWSSK5nBZYJeTuQq8NUTkGqL0GESTbIM+wUONgY0WOhX
	l6kQTLAJ2+soUSXELGweLAPPCPqvjhXguGsr1vrcwFdWi633h5lIfDddh19jrkv8A5+ZpdyDdZuEA
	QPkNyp63gv6XZAWS/oGO5RgoXQpnNt3jdnTPPdokZmSLzAhZULh3HMXBXDxlNjTjo/OW7DKaCqVpG
	u+PMyUEQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41654)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w4yRv-000000001jA-0bjJ;
	Tue, 24 Mar 2026 09:53:23 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w4yRt-000000004yG-1hQP;
	Tue, 24 Mar 2026 09:53:21 +0000
Date: Tue, 24 Mar 2026 09:53:21 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	thomas.petazzoni@bootlin.com,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Rohan G Thomas <rohan.g.thomas@altera.com>,
	Mun Yew Tham <mun.yew.tham@altera.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next 5/5] net: stmmac: dwmac-sofcpga: Drop the struct
 device reference
Message-ID: <acJfEfLzOLYN9qJ_@shell.armlinux.org.uk>
References: <20260324092102.687082-1-maxime.chevallier@bootlin.com>
 <20260324092102.687082-6-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324092102.687082-6-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270965-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,davemloft.net,google.com,redhat.com,gmail.com,foss.st.com,bootlin.com,altera.com,vger.kernel.org,lists.infradead.org,st-md-mailman.stormreply.com];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	NEURAL_HAM(-0.00)[-0.975];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,armlinux.org.uk:email,armlinux.org.uk:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 30DAB30623A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 10:21:00AM +0100, Maxime Chevallier wrote:
> We keep a reference to our the struct device in the socfpga_dwmac priv
> structure, but now it's only ever used to produce logs in the
> .set_phy_mode() ops, that are specific to this driver.
> 
> When we call that ops, we always have a ref to the struct device around,
> so let's pass it to .set_phy_mode(). We can now discard that reference
> from struct socfpga_dwmac.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c   | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> index ae40de2ed8eb..1d7f0a57d288 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> @@ -53,14 +53,14 @@
>  
>  struct socfpga_dwmac;
>  struct socfpga_dwmac_ops {
> -	int (*set_phy_mode)(struct socfpga_dwmac *dwmac_priv);
> +	int (*set_phy_mode)(struct socfpga_dwmac *dwmac_priv,
> +			    struct device *dev);

As you're changing the signature of this method, would it be more
sensible to put "struct device *dev" as the first arg, rather than
swapping the order below:

> @@ -552,7 +553,7 @@ static int socfpga_dwmac_init(struct device *dev, void *bsp_priv)
>  {
>  	struct socfpga_dwmac *dwmac = bsp_priv;
>  
> -	return dwmac->ops->set_phy_mode(dwmac);
> +	return dwmac->ops->set_phy_mode(dwmac, dev);

?

In either case:

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

