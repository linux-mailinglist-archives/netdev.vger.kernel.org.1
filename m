Return-Path: <netdev+bounces-272753-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMfAHFGQx2nFZAUAu9opvQ
	(envelope-from <netdev+bounces-272753-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 09:24:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC13934DCFB
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 09:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B1B8302D523
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 08:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EB8374726;
	Sat, 28 Mar 2026 08:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zeXZhzLg"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE722C21DD
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 08:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774686286; cv=none; b=RIjTeo8ALGudzGDsclIllpeHgwE+fvhSHnHLGyOfQle3HCVSVe4bg5uTwcv8KspDbIsIcycU8n0GWWs1pgNlenx210nDfYGztLLjaOkKDMJJTz3dgCqDDdbMwRI3zJGs+7Jo+01rrtIzAeDtSuq1EgYkxqu8V1FXvgAUBjAcGN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774686286; c=relaxed/simple;
	bh=8sXpWwGlFLojnG830vpU87C4ieuymSRA1ExHCOv6aDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhvcC/nU5UAZWgTF0mp0cshNd9Vk4nrldRaDbI6VxIcFIpOq/SNmN86OTIer5pnxlOWuWVdE7oBYMSuuYsKxiXIbErKX8J1/mN39QUXGiqHvXj7X8A8lr6+zbK0faLXINbkFs7ZOmtN6nAKETa/q0ErBchUfoHJlVbc2peSlyMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zeXZhzLg; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dBGUIi2ACXBs5dBa+ZwVmMxZ7q4HBlEgRbUeEupBh9U=; b=zeXZhzLgUiuIiTK8dL2wHfYuQ4
	twJPvaZEpu/cCswIQPutnepzFsLq/3cT2sqneczANqSdaUDxO5BFOnB/I3hzp9oNxr4MaknA4Zlfb
	dtWGiOscalNfC8nNPuMZAjjQ0eyPEFGHd9JEf5R0ots+a6iC6NgO8ItOb2glUMYkMImzwsMfwBrz8
	ufb/8adgE1SGKZzcG7g0+ePe66kPFxRCipXUr+arTfB5b/x/wl/uoWAbshn5t8m6aTW1O26/kkGc+
	YzyJMdLESbM1u3d1qt9sDv5eXys6OufyDAxI1xRX7XSqibcdRcPWOFCiOR5Hr0/QJm+9dT8LHqMOt
	/5lhlXFA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60066)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w6OyF-0000000073T-0W0n;
	Sat, 28 Mar 2026 08:24:39 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w6OyD-000000000WK-1f02;
	Sat, 28 Mar 2026 08:24:37 +0000
Date: Sat, 28 Mar 2026 08:24:37 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/2] net: stmmac: simplify GSO/TSO test in
 stmmac_xmit()
Message-ID: <aceQRSc5o4D-HHmq@shell.armlinux.org.uk>
References: <acZQaDeCoib5S5UA@shell.armlinux.org.uk>
 <E1w63fl-0000000E3Vb-3JkY@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1w63fl-0000000E3Vb-3JkY@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272753-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.624];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,armlinux.org.uk:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC13934DCFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 09:40:09AM +0000, Russell King (Oracle) wrote:
> The test in stmmac_xmit() to see whether we should pass the skbuff to
> stmmac_tso_xmit() is more complex than it needs to be. This test can
> be simplified by storing the mask of GSO types that we will pass, and
> setting it according to the enabled features.
> 
> Note that "tso" is a mis-nomer since commit b776620651a1 ("net:
> stmmac: Implement UDP Segmentation Offload"). Also note that this
> commit controls both via the TSO feature. We preserve this behaviour
> in this commit.
> 
> Also, this commit unconditionally accessed skb_shinfo(skb)->gso_type
> for all frames, even when skb_is_gso() was false. This access is
> eliminated.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

AI review of this patch regurgitates Jakub's point that was discussed.

> @@ -3700,7 +3700,7 @@ static int stmmac_hw_setup(struct net_device *dev)
>  	stmmac_set_rings_length(priv);
>  
>  	/* Enable TSO */
> -	if (priv->tso) {
> +	if (priv->gso_enabled_types) {
>  		for (chan = 0; chan < tx_cnt; chan++) {
>  			struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[chan];
>  

...

> @@ -7828,7 +7834,7 @@ static int __stmmac_dvr_probe(struct device *device,
>  		ndev->hw_features |= NETIF_F_TSO | NETIF_F_TSO6;
>  		if (priv->plat->core_type == DWMAC_CORE_GMAC4)
>  			ndev->hw_features |= NETIF_F_GSO_UDP_L4;
> -		priv->tso = true;
> +		stmmac_set_gso_types(priv, true);

Clearly, the issue it is regurgitating has been there for a long time
and isn't a new issue introduced by this patch.

AI needs to stop doing this, because it is encouraging multiple changes
in a single patch, which is against the normal kernel process.

As already pointed out, there are multiple issues with stmmac TSO
support, particularly with glue drivers that enable TSO on some
queues/channels and not others, since netdev core TSO support is
global across all channels.

So, won't the AI response in this patch - it's just another pre-
existing issue that needs fixing in a separate patch.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

