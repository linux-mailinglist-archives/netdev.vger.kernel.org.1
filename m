Return-Path: <netdev+bounces-254747-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHlGGRw+e2mNCgIAu9opvQ
	(envelope-from <netdev+bounces-254747-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:01:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3805AF517
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 987EA301CFB4
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86023816F1;
	Thu, 29 Jan 2026 10:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Gm7ef+Pi"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE8F33BBB4;
	Thu, 29 Jan 2026 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769684144; cv=none; b=Y4iuHN9hZVAjaaRIOXiHbXfH08BiIbZNLN2bTbeHEga1wzOrYRvOuC/9r0ZnTnoCuPqpRgqMPw+KP+XV813ZhzizKAUZw1jSaHX7Ok0QmeT6IG6Xz7Ddr0zDnjDtMxAXtytqZTEKL62d5dfYa7NEt0EYn4cmb76Yyo48rAvmItA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769684144; c=relaxed/simple;
	bh=/+hfH01HdJGxMr0GEzw+vMVh+JcYcOhmSVnmoG4kr3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2CSu6tbkgmiGx02I66yftIGvSVR7rnsTBjLbfpGbdI0gnY2G581guFE2nhwdAojsRKZaKhE6souyU1oC3x5Wz3LSCP4zfLuG1yXdxkxWtGiXMyr0cDghjbJl0abDyOsIuJTlIlZPNJ9VGYgEOSQkzdKy4Q4yCT+oR0Q23YMq9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Gm7ef+Pi; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jefi+XwQ73nwaagx0CNNNGtK/XfXgCjuzxBF6exADZo=; b=Gm7ef+PiXrMGgKIZ406JoUii9L
	JuJdizsok1yO9T05Eej4iMkHOccC2XgpGvQy9YCNNt6C9d1OUn1MrpPZBp91or4kH/cRo5bQcAkoR
	BUFhk2PUQ6buihb7HN+tfcw645poUjg+14qhY4mLQ4WKZDfE9BNyeqad6gmywrAShWWXRxNf5zAde
	LSMTluyGsz8balx5M62wwt4ooEYBSXEKgw2YJRzcPnvShjLxAGn5Lj8r/xUKrT+mM7GfHNYVrjU2V
	Yp6lOXi5uc8rcN6fG1+B5j2liAttfO18/QxhgzcCUQ7fbIEWYo84HkkZ2AQX+BO79Pb4U5fhoG5Ro
	RHFWH3mA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56930)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vlPgL-000000008R1-47Sl;
	Thu, 29 Jan 2026 10:55:26 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vlPgJ-000000007ti-3PkK;
	Thu, 29 Jan 2026 10:55:23 +0000
Date: Thu, 29 Jan 2026 10:55:23 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
	Andrew Lunn <andrew@lunn.ch>, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"open list:FREESCALE IMX / MXC FEC DRIVER" <imx@lists.linux.dev>,
	"open list:FREESCALE IMX / MXC FEC DRIVER" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] net: phy: integrate reset-after-clock quirk into
 phy_init_hw
Message-ID: <aXs8m8UodO4griTY@shell.armlinux.org.uk>
References: <20260128094644.302313-1-michael@amarulasolutions.com>
 <13d1018c-d9aa-4838-8bb3-35c509cd3e35@lunn.ch>
 <CAOf5uwm30=AVhqm67yz8Y5TkX9FWdxizTevCGSeaQuJS0KqtNA@mail.gmail.com>
 <aXoV-U-yqcDJj2vk@shell.armlinux.org.uk>
 <20260128202634.gqevi76o6wnf5xno@pengutronix.de>
 <aXqJ_TtdBnkvEZ_i@shell.armlinux.org.uk>
 <20260129104123.zir4rtgeiu5qv3i7@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129104123.zir4rtgeiu5qv3i7@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254747-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[amarulasolutions.com,lunn.ch,nxp.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lists.linux.dev,vger.kernel.org];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: E3805AF517
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 11:41:23AM +0100, Marco Felsch wrote:
> As said, I don't see a problem with the LAN8710. But while checking the
> Linux source code, I saw commit
> 57ec5a8735dc5dccd1ee68afdb1114956a3fce0d which re-introduced the reset
> handling :-/

So now we get to the bottom of it. This is a regression, right? The
addition of that patch has caused previously working boards to stop
working, correct?

That means it needs to be reverted.

We also need to get out of our heads the idea that LAN8710A is somehow
special in needing this. It isn't. Thus, there should be no special
flags to "work around" this "problem".

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

