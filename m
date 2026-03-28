Return-Path: <netdev+bounces-272763-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GA98EZasx2kFagUAu9opvQ
	(envelope-from <netdev+bounces-272763-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 11:25:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B182234E14C
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 11:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4827A3034327
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 10:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC81387349;
	Sat, 28 Mar 2026 10:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="q6Xo5Ah6"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13727386C0C;
	Sat, 28 Mar 2026 10:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774693521; cv=none; b=SmgdvmFzK4Xc5zYrijwRcuvX8E6LA4gbdzNhWiVxn8Xr9KsTEzkJVpPWBdJkg3q+7vWKrEvk1uDezHw3PrgTv5HvbrTilsv6ACnXE0A9Yk3tj7WH9fktGT5X6N55Vk0beDOM/+uSxk9TxuPcWV9fIekq7SqmyGPANMY76mEv4rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774693521; c=relaxed/simple;
	bh=Wsh2qYytOvwuwza3IaTTqM4VH5pzbA5oDqBtLXjQwQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkdfQznBQPQXWnkok4e5jOhuWGPO+uHGUGl23b/oFItYUM0hyoY9rfBXeaSHwRSrAUFpCsjNXQNRYUfAAwuCWcJdEIXtUzyLyBqzqZLPDFYUIl8dQcSW89dLGV+fJLw5YMoK6J1YaEfnvIYQbdt8eKkcVfvqjHcCDCgipdy6HFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=q6Xo5Ah6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=S6OyOHlz9Wy2vwI6pxqWW/pqak1TG4VrC3axA8pR8go=; b=q6Xo5Ah6GantLv/VpZQ+LXjalJ
	lW+MyIKB+AGAGsIGtZGOEsFpuDHwWEzzlTCHoI2R9zP9A2KDtFiJFtM6qB747z5yykc5VRN7+jiga
	xUIv6tIsIuZQLAREv+FjV+hSJLRr4Hh/+nlnrP7nFAE21BcIQ4J/gk4P0skeBV5z5eX2Nt6Y1sy7B
	/vsaGIP3CW5xRiLOEWb4UpexQV/ZsnGW76QvEg92RLvr5seLSMmG/luTSZYqLVHMDXpqX5bn7z6v2
	nh/6P2P9gcXXz93H3HjghaQWA/p0g3fuh6B9Z3/MdkNnNLezSdlcJ7n72lJQ+ZbBT1jyeKi2/QiI8
	L2Q5TcyA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55356)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w6Qqt-0000000078G-1uzR;
	Sat, 28 Mar 2026 10:25:11 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w6Qqo-000000000ap-3L8h;
	Sat, 28 Mar 2026 10:25:06 +0000
Date: Sat, 28 Mar 2026 10:25:06 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: "Lucien.Jheng" <lucienzx159@gmail.com>, andrew@lunn.ch,
	hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bjorn@mork.no,
	frank-w@public-files.de, daniel@makrotopia.org,
	lucien.jheng@airoha.com
Subject: Re: [PATCH v2] net: phy: air_en8811h: add AN8811HB MCU
 assert/deassert support
Message-ID: <acesgklpv8GlNeVf@shell.armlinux.org.uk>
References: <20260326153518.8387-1-lucienzx159@gmail.com>
 <edeee8e5-0de3-48ea-aeb5-cc705fdcd469@gmail.com>
 <6f42d92b-a26d-49a4-bef7-2227c252eea7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f42d92b-a26d-49a4-bef7-2227c252eea7@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-272763-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,mork.no,public-files.de,makrotopia.org,airoha.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.671];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: B182234E14C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 28, 2026 at 11:21:59AM +0100, Eric Woudstra wrote:
> static int air_pbus_reg_write(struct mdio_device *mdio, u32 pbus_address,
> 			      u32 pbus_data)
> {
> 	int ret;
> 
> 	mutex_lock(&mdio->bus->mdio_lock);

I wonder why we have phy_lock_mdio_bus() but not mdio_bus_lock()...
Should a helper be provided at mdio bus level to complement the PHY
level helper if we're going to have MDIO drivers directly manipulating
the lock?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

