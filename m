Return-Path: <netdev+bounces-282950-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WD8REX+J82md4wEAu9opvQ
	(envelope-from <netdev+bounces-282950-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 18:55:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 871B24A6141
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 18:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45B903012273
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 16:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB83B34750B;
	Thu, 30 Apr 2026 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vzaGZftK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEC13019D6;
	Thu, 30 Apr 2026 16:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777567774; cv=none; b=XyZXbrSsJ4cHRhoUoBWJptPC28fXRI2pJVRnRE0qZOw/5ASzuc6UWbm6Mq3D0Nn8dNT2iktrDSo3Nde+IKWsTuCZoQQpGiIkSF4mXDGWx/ldEdAye3UIyxWXFe1KD5a1ULLq2KqSrfPHPvk1RyWon+9NHa7TyfejTdL7tf/TRqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777567774; c=relaxed/simple;
	bh=rc94khdHXYE6Mq0nAe17Y1EGkpWccVgBj7qAQMIerc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IURrdSciZJ6z82ylqui4l/U9JOWUMBd8kY0JHvPr9Z6cFNsPgqUNtLsCQklbLky6PKgyy1vOeHDL5GWMPGdgEYAnSfbD96YQZa+85UHs4NhrYWCHPOCWhraljUiP9fsMF9b81+Tccb4CQKoa4k1evYosDwPFXPsLLHvaS2S3h0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vzaGZftK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=chRC1YitdRUSoDJcc7gltKwhvPCsDSDtuA6AljdNUME=; b=vzaGZftKGtnAKFFpd3XDXTahpX
	wGjT0XbTTHqXGEZqIw/jT8ikVEKkagbRGl0mZZxf3NZfm/1NdPDNCKiceVi2XRCoUlIdEvunlCwIq
	Rv2ZcebwZZ3af0uUhKRB5Ok7oaV3FbrZo2YA3XcjNds8hQxCzjwlmfpS4968ERwpm8dM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wIUZj-000iG2-Gx; Thu, 30 Apr 2026 18:49:19 +0200
Date: Thu, 30 Apr 2026 18:49:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC Patch net-next] r8169: add phylink support
Message-ID: <d212f15b-8b5d-4125-bd04-35abfb9c0013@lunn.ch>
References: <20260430083244.703-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430083244.703-1-javen_xu@realsil.com.cn>
X-Rspamd-Queue-Id: 871B24A6141
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-282950-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

> And one more question, when the driver initializes RTL8116af,
> r8169_mdio_register() will still be called. So tp->phydev =
> mdiobus_get_phy(new_bus, 0) will still be executed. This feels redundant
> since we are now using phylink. However, if I bypass this assignment,
> it breaks several existing functions which are strongly rely on
> tp->phydev. Is it acceptable to keep this tp->phydev for now, or is
> there a preferred way to handle this problem?

You probably want to do some refactoring, before swapping to phylink.

rtl_link_chg_patch() needs to know the link speed, so looks at
phydev->speed. The rtl_mac_link_up() call gets passed the speed.  So i
would refactor rtl_link_chg_patch() to be passed the speed. And then
when you swap to phylink, and r8169_phylink_handler() disappears you
can call rtl_link_chg_patch() from mac_link_up.

rtl_coalesce_info() i would refactor to put the current speed in tp,
set is when rtl_mac_link_up() is called, and back to -1 when
rtl_mac_link_down is called. This can be another refactor patch, have
r8169_phylink_handler() set the speed.

Same change for r8169_get_tx_lpi_timer_us().

EEE is quite different for phylink, so rtl8169_get_eee() and
rtl8169_set_eee() will change and should not need to reference phydev.
The same is true for rtl8169_get_pauseparam() and
rtl8169_set_pauseparam().

rtl8169_set_link_ksettings() is broken! It should not be touching
phydev members like this. That also mostly disappears with the swap to
phylink.

r8169_apply_firmware() is interesting. Is this putting firmware in the
MAC or the PHY? Or both? If it was only PHY, i would move this into
the PHY driver.

I would try to move the code in r8169_phy_config.c into the PHY
driver. The tricky part is knowing what MAC version is being used.

/* Chip doesn't support pause in jumbo mode */ should be done
differently. We have helpers phy_support_sym_pause() and
phy_support_asym_pause(). A new helper should be added
phy_support_no_pause(). Both advertising and supported should be
cleared. And these should be an else clause for when jumbo is
disabled, and pause can be used again. phylink however does this in a
different way. It might be you need to call phylink_stop() &
phylink_start() and ensure the mac_get_caps() returns the correct
capabilities.

Try to remove as many references to phydev as you can.

I would also suggest lots of small patches when doing this
refactoring. When you break something, it will make it easier to
figure out what broke it.

    Andrew

