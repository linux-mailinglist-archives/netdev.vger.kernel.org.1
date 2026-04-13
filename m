Return-Path: <netdev+bounces-277966-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MALfIKea3GkxUAkAu9opvQ
	(envelope-from <netdev+bounces-277966-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 09:26:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1133E8328
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 09:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 852FD30058EE
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 07:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEB93932ED;
	Mon, 13 Apr 2026 07:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FAQAssc1"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E93C3932DA;
	Mon, 13 Apr 2026 07:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776065190; cv=none; b=KHTgkzYjLmgDi9jLE/S2jL3ZEugkcw8Lk/EISKxMbbYGN6+z/dgL2kDX05/RaNrdHMGpDKcta1430V77iEDN0S/JJI+HycEwBseGLaBLlw1Pzf+bSezIIeY7deoiCu+kyXZQ5vwTK2oiGeEQ3eTlaMAH9baarV3z/bAD9Nd8qCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776065190; c=relaxed/simple;
	bh=0UZup749flYi8j6vn002fi1Olhf1IFL/QlslisUpTwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbvOfHeILjw/Dk9xB1h01vv072l04cgMlB9w9f5G8O9ucsONQPSTdrjLx+bJ8wsAXzOvTwLPbumDyYdxh9rp2OYBqtrHN3Uq1PaLlwP+Tof8Ljl+zy1LX1bd4Lz6BeQRqJgRPaldT/+WqcC2fJJfRyeM7IvdDBE701B8bKAL9V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FAQAssc1; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wNSkRS98vTD1N1yDX5+Ln00CNvWjycit9ZpJUKlOBuI=; b=FAQAssc1W37ws8pk6Y4/QdsArK
	nUuZ7joUamnaBOr7XODkiDkzMdJUFxpZ0z4OH1Iw+9TCfCA1DP+STwRIltuFlgQqEhd5OZjueLfok
	yRa8pW+UXRMPNLpuMJafSW1OhMqV2Jb3ydaUMuC0CPuI/OsYZWqhdeIIwVoRII2yE8Lu+mI3EbPg0
	diLpDv07ewmLpt7S4dmSqE1I2wRfl10TrciIXS0hJCZr0d1xEEGbXuBNQehKLJq1aXWTNcmKOOxDg
	un/4KU0hj/Fsp3SWHxAW4VA/QSUyE722425Yz3zHIUtceXlolhCG+quInRt+kn+L77+nMG+KfeTDP
	7ikeqJoA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44652)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wCBgY-000000007vx-2fju;
	Mon, 13 Apr 2026 08:26:18 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wCBgV-000000008Rl-3tl4;
	Mon, 13 Apr 2026 08:26:15 +0100
Date: Mon, 13 Apr 2026 08:26:15 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: KhaiWenTan <khai.wen.tan@linux.intel.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, maxime.chevallier@bootlin.com,
	ovidiu.panait.rb@renesas.com, vladimir.oltean@nxp.com,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	yoong.siang.song@intel.com, hong.aun.looi@intel.com,
	khai.wen.tan@intel.com
Subject: Re: [PATCH net,v2 1/1] net: stmmac: Update default_an_inband before
 passing value to phylink_config
Message-ID: <adyal1InVw6UFmTY@shell.armlinux.org.uk>
References: <20260413020339.68426-1-khai.wen.tan@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413020339.68426-1-khai.wen.tan@linux.intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277966-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,bootlin.com,renesas.com,nxp.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,intel.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shell.armlinux.org.uk:mid,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,armlinux.org.uk:email,armlinux.org.uk:url]
X-Rspamd-Queue-Id: 2A1133E8328
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 10:03:39AM +0800, KhaiWenTan wrote:
> get_interfaces() will update both the plat->phy_interfaces and
> mdio_bus_data->default_an_inband based on reading a SERDES register. As
> get_interfaces() will be called after default_an_inband had already been
> read, dwmac-intel regressed as a result with incorrect default_an_inband
> value in phylink_config.
> 
> Therefore, we moved the priv->plat->get_interfaces() to be executed first
> before assigning mdio_bus_data->default_an_inband to
> config->default_an_inband to ensure default_an_inband is in correct value.
> 
> Fixes: d3836052fe09 ("net: stmmac: intel: convert speed_mode_2500() to get_interfaces()")
> Signed-off-by: KhaiWenTan <khai.wen.tan@linux.intel.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

I'll note that this will cause a conflict with net-next when that is
eventually merged.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

