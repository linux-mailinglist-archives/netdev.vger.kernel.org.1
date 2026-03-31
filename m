Return-Path: <netdev+bounces-273639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Hk7CjXPy2mILwYAu9opvQ
	(envelope-from <netdev+bounces-273639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 15:42:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 400C136A69A
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 15:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77C483025732
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 13:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD242F39CE;
	Tue, 31 Mar 2026 13:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kdEZvqlE"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B97723958D;
	Tue, 31 Mar 2026 13:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774964302; cv=none; b=Ys2BhaqI7e58wnVx+1v2vy4vexgOFEuipvlaZnl1liUynJf3wzYp20m+8qbyziYRS/IrU2/9S4IXAfCop7pBfSDyhzPh6ZmWFoMgZoXna46aG8rb+yINMZi5vmpmJ7p1K7oT0XJ6hbbv7xGMU+QKZzRfaOST3Vuc4a26k5MqxE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774964302; c=relaxed/simple;
	bh=fM0kCdNQKvtQ3Sw8jKAxEzWo5iK4fm4bQbsosa1F5lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iT2WYBXnPdd3vBzKJix4V1DfdyOdmlilwsCzP3rW6h9auzHphXpbzsKFyQrtjhYqWnXNrREDdEuuXLzo87VBXM7VUKMxnBt/0NeVZfXAmvxOXRPj7KivUWPo4sU9n/R0oQ0uWLmjIMybRv0WcEeTfR8SlXhXJ/7GcdY0NPe5cos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=kdEZvqlE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8SfiYxYPsCmBQN0cjhyBPejDkbLaM0G7dokSuXlFabI=; b=kdEZvqlEYcPTes5uvkczlOSatZ
	WGsTV9x/GXoHkkrCfMbDf32NEDxsB3QV6WKqzQKMycmJUeMY0wkbgiYhD2koL+oOvCLpMXHckXDTd
	Dt6Aj53q+wkqNzd9B/WaFoIgQDCgrXNym8IPYf63FcWYQRyZEnMtzKZhZJGxcfFeeaGT8jZrRGfPl
	8Ro7CImCYu2MIOm8IhxbtVAGDWTMDlGvc8a/03Z74R2gfb89ULYIgFzIny40xkwvHyndSTlIpq7W1
	IXi9988wv+CzCYVK/4Oz/lSobHoR1XqLVB3J2M/vkGV4RzE/3/hPLCuVwdeVCv2lMi/cw7PjjCicH
	aSL4EtMw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51508)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w7ZIG-000000001tK-3bYE;
	Tue, 31 Mar 2026 14:38:09 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w7ZIA-000000003lU-3Zkg;
	Tue, 31 Mar 2026 14:38:02 +0100
Date: Tue, 31 Mar 2026 14:38:02 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jan Hoffmann <jan@3e8.eu>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Markus Stockhausen <markus.stockhausen@gmx.de>,
	Damien Dejean <dam.dejean@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: phy: realtek: support MDI swapping for
 RTL8226-CG
Message-ID: <acvOOnuc709EhdSo@shell.armlinux.org.uk>
References: <20260327202001.413280-1-jan@3e8.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327202001.413280-1-jan@3e8.eu>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273639-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,makrotopia.org,gmx.de,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.656];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 400C136A69A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 08:32:28PM +0100, Jan Hoffmann wrote:
> +static int rtl8226_config_init(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = rtl8226_config_mdi_order(phydev);
> +	if (ret)
> +		return ret;

As I've been pointing out in other patches, putting this "defaulting"
here is not a good idea - this path gets called when the PHY is attached
to the netdev and also when the PHY is being resumed - which will wipe
out the user's configuration just because their system suspended.

I don't think that gives the user a good experience.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

