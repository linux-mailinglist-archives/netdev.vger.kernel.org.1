Return-Path: <netdev+bounces-259771-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TSbjIQjOmGlDMwMAu9opvQ
	(envelope-from <netdev+bounces-259771-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 22:11:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD76116AEC6
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 22:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1CA53013A4C
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 21:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F7730BBA0;
	Fri, 20 Feb 2026 21:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YXx4eOTh"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31722D9EE2;
	Fri, 20 Feb 2026 21:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771621889; cv=none; b=lfC3wPWhq88HvUp6zNpOO1DMZoApOIeVUzlN7s4glbWI684/3QWX8pbod79DnwZfPbledohwKvkuhRCcxxbZnG/PJsHIsM7HyVLTTII4OkFGC8wsK4rPt38Os7LPwgwYd+qb4np5h1t+Hz/dgFbsrcrA68loBJo0H0Hpfa6367o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771621889; c=relaxed/simple;
	bh=evLW7JQrD/ut2K4N5p0AtBBdKmbxw+ljn+dClTOZmsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfSV9vOdkn6nmcu2QT3Hb5TSAU03Q2NZuoiSF9TeepdrmsI/sTnnPBd7a53I4CX+lkEhm2tR4Q1avmE/DeisobDB4gJoYuF1zcVz0XtcUk2kEPoob5uVfzQ2ZStgfQZfQ/KX2KQyG56mPO+Ciw6S4s0ueHR9vJhiYisLLBb1qi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=YXx4eOTh; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=V9cfnUenjEM8RpG6rqNZ27f6Y0gJI/F8pqB9eHHbkgc=; b=YXx4eOTh96Zh2xxGPeTHM+rhAN
	jv+uUjTBoWs6m+/K6j5YO9hDDKeuFhQ7a/7VhltQJ8jfiBnPyDJI0z0Bc8UE+pv/lvnQn2FUuwOYv
	Qua9dRq0H7V8E5FLXIjzyK1R04R7WSLAAuPA9pKgQpkM+5ylAkFvhWN9BT6AL0YwuhBNDMiXDDyYG
	VpUTUUqOnJgQyZ5zJavRF0sAlsiTxPPXHHLg0krX5nF6LIUX7rPCPyb3U450AY84SpndldzJKsUQe
	CzWxoqLe3sMteagLDRw0DhI0dRj2X90ONqhVD2RQsilJE8pvdU3CD3mRABgdrJxUsUmAJqfx+9xYe
	vNqS8Nnw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37828)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vtXmC-000000002Al-2ZVZ;
	Fri, 20 Feb 2026 21:11:04 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vtXm7-000000004ej-2a1a;
	Fri, 20 Feb 2026 21:10:59 +0000
Date: Fri, 20 Feb 2026 21:10:59 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	o.rempel@pengutronix.de,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: phy: micrel: Add support for lan9645x
 internal phy
Message-ID: <aZjN48iisYaJ4xeg@shell.armlinux.org.uk>
References: <20260130-phy_micrel_add_support_for_lan9645x_internal_phy-v2-1-202ac31cf9c4@microchip.com>
 <92ba22ee64b2670448295b44d663d8ae7e8fe9c4.camel@microchip.com>
 <641d92a2-93fb-4ffe-89d8-77bf10edecf8@gmail.com>
 <1b14f42944d21fff1cb45132fe6dc9e5c18289a1.camel@microchip.com>
 <00f03a3f-fc12-4875-b4b5-7470e7f0452d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00f03a3f-fc12-4875-b4b5-7470e7f0452d@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-259771-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.955];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: BD76116AEC6
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 09:50:44PM +0100, Heiner Kallweit wrote:
> No, BMCR_RESET usually doesn't reset configuration registers. That's why the
> function is called genphy_*soft*_reset. In case your PHY behaves different,
> which configuration registers does it change?

I don't think your statement is correct.

Looking at AR8035 for example, the WoL interrupt enable is doumented as
being cleared on soft reset. Smart Speed configuration also gets reset.

802.3 22.2.4.1.1 states that setting 0.15 results in the status and
control registers shall be set to their default states.

So, we should not assume that setting 0.15 will retain configuration in
the PHY - at least phylib should not assume that a call to
genphy_soft_reset will not clear the configuration registers. If we
have code in phylib that makes that assumption, phylib is buggy to
802.3.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

