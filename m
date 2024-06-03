Return-Path: <netdev+bounces-100105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E09588D7E0A
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8312832EB
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 09:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5F87F7FB;
	Mon,  3 Jun 2024 09:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="B/GXgkrR"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB277E792;
	Mon,  3 Jun 2024 09:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717405478; cv=none; b=nm78hbIYHCf0A+qCrp9zAYi9Fr1P95WxN53kbc02WXwdAmyzMTkhCKAm12NygQ4JUDEZiItZMXYitZku4WLAuqZKHzqNNhY7DTjlrUPiYuNkjJhaQQXozy8tpqGMmEAIqpi1rHXE+YPU2TXZT4o+rz+Ko6oTZBNsF5PrdCxkXCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717405478; c=relaxed/simple;
	bh=k7Hy66vX/C6sOWjPSgDZazgLPHPy3ibQ3Zr6PMgovpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KePc425jyShjkqFKFb0YmNssI6hliVjmoJcsz4E9IsnIBvK/5d6pajST28Yzl0qkdhx2CZAtNPRznGulAzzGTQUrV8sccLJTc3HOUJ6UjICu4/o5rjZvF4Uvgd5LEIC3xcSrYxlzjABCeSii/fh0PBWd0x/mm4EnR2eR7rACVPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=B/GXgkrR; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PL2tpWgubRP0I1wFdl1ZHWzMi0qsZ0DU3zEaEHooRQY=; b=B/GXgkrRVf4Kx2g9TuilFMzYS2
	U9NTJ5sySISyPgH9X1HT28urmVye+m8mf3bX59ZQDteLTM3jnFc1Kzc+tmlAFyVnmxXtbYs0av3NO
	OmLqHpnPC3byTnIq33a+gZJnip3nRKGZul8W89TBkvBRFJ3JHiAwenoET9L5h8IZwUzENpMQUAMOp
	uZWQu6OKtFlZCvBAv4hF9G3Y3hTj/hTIKsrrPn661EXWRJZ/hIJmtTR9est5xH+53rgZ7RoQL2Dnr
	KDSvpFP9+i3sAVYcUhzW8UeuDOaW9ZGHARWbtggPnAP4+E0DPiweET4f+R95aIdfxnRFa9XdvgzvH
	ZnB0owOQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45002)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sE3bi-0002Tb-2G;
	Mon, 03 Jun 2024 10:03:58 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sE3be-0000IR-OA; Mon, 03 Jun 2024 10:03:54 +0100
Date: Mon, 3 Jun 2024 10:03:54 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Sagar Cheluvegowda <quic_scheluve@quicinc.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Tomer Maimon <tmaimon77@gmail.com>, openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 10/10] net: stmmac: Add DW XPCS specified via
 "pcs-handle" support
Message-ID: <Zl2G+gK8qpBjGpb3@shell.armlinux.org.uk>
References: <20240602143636.5839-1-fancer.lancer@gmail.com>
 <20240602143636.5839-11-fancer.lancer@gmail.com>
 <2lpomvxhmh7bxqhkuexukztwzjfblulobepmnc4g4us7leldgp@o3a3zgnpua2a>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2lpomvxhmh7bxqhkuexukztwzjfblulobepmnc4g4us7leldgp@o3a3zgnpua2a>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jun 03, 2024 at 11:54:22AM +0300, Serge Semin wrote:
> >  	if (priv->plat->pcs_init) {
> >  		ret = priv->plat->pcs_init(priv);
> 
> > +	} else if (fwnode_property_present(devnode, "pcs-handle")) {
> > +		pcsnode = fwnode_find_reference(devnode, "pcs-handle", 0);
> > +		xpcs = xpcs_create_fwnode(pcsnode, mode);
> > +		fwnode_handle_put(pcsnode);
> > +		ret = PTR_ERR_OR_ZERO(xpcs);
> 
> Just figured, we might wish to be a bit more portable in the
> "pcs-handle" property semantics implementation seeing there can be at
> least three different PCS attached:
> DW XPCS
> Lynx PCS
> Renesas RZ/N1 MII
> 
> Any suggestion of how to distinguish the passed handle? Perhaps
> named-property, phandle argument, by the compatible string or the
> node-name?

I can't think of a reasonable solution to this at the moment. One
solution could be pushing this down into the platform code to deal
with as an interim solution, via the new .pcs_init() method.

We could also do that with the current XPCS code, since we know that
only Intel mGBE uses xpcs. This would probably allow us to get rid
of the has_xpcs flag.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

