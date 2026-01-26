Return-Path: <netdev+bounces-253504-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OzXOM98d2m9hgEAu9opvQ
	(envelope-from <netdev+bounces-253504-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 15:40:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 476DC89A20
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 15:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E237F3000A76
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 14:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2A923EAB3;
	Mon, 26 Jan 2026 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vqhWKydR"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFB42367D5
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769438071; cv=none; b=t2uWAg5KAhkS7ehTXl9WKQNOb8yEtmmXB0An6UN6mL4KIBtNTqeZoqCDo5tmZZauo7XTARu+Nx/lWpEMD6kRQOgDId6XXlzwRGxWx9J9qy5V+apTHUzENq9rN1RFAYaTa4llRgVCzYcLwc2ArLPfedCTmhPFtZ6vfB02G1wo6Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769438071; c=relaxed/simple;
	bh=UjtkVx2Z1lJZLLj7lxMaC/XSXQbLe9j+CbUcre5VYJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlzTV3Jk4hJOyBnNPYyryGMVZv4BbbnzVV9BlJ2aE7rBsMHhURV4VMh+G8U+HSFbV2yKUTcB+klcVLtDhzGhkdu8X0Ub2myguCl0GbCxd+tcWj5wQ8HOu8AtvAey4fDSsJ/qbL7uLl0DzGJgqZGZxuRIC35EwyF+LJ1Mk5o4IiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vqhWKydR; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VKl2m6va+k/i4PnbhNmJevuXFQu5TbTyIVHNC2U/pqs=; b=vqhWKydRpU++6I0VMWU4R8u+ry
	c3/S/6h0xAtwKEUGK2zwOFafNmYy2EG6Y+rGlmhQt9ChS9Co6DJvurXoHAc1wwxGcNS2nQ/IfpHdm
	u7fw1yAj5+AXRQ9HVuRwxjohpXz3AyQ/CMBektS3EYr07D9u4Z25TzrFtJR9QfHihh/baiCZGoSAO
	FrQU8SbO7lL4bctk42PY1j+21N7huUE9CsbzZdFgTqg/M2+qjOLAU5Ek1OBQEunz1pUvxvu3AaChh
	efyVu/+8tnO0WCFIbHGG0DRqX6ypfKk7NsiXuTkKhcnV5FaPwZIruGlJKVkNsHbYbajEWmyXS4Jgp
	DJnaq+Tw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58188)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vkNfY-000000004xP-0oMi;
	Mon, 26 Jan 2026 14:34:20 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vkNfV-0000000050u-3BFU;
	Mon, 26 Jan 2026 14:34:17 +0000
Date: Mon, 26 Jan 2026 14:34:17 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 06/22] net: stmmac: rk: add SoC specific
 ->init() method
Message-ID: <aXd7aSk7KIxlQd5z@shell.armlinux.org.uk>
References: <aXdTi4ViCkhhXvFI@shell.armlinux.org.uk>
 <E1vkL28-00000005usi-30YC@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vkL28-00000005usi-30YC@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253504-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:url,armlinux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 476DC89A20
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 11:45:28AM +0000, Russell King (Oracle) wrote:
> Add a SoC specific init method.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

I see the AI review has identified that this patch has an issue, whereas
in the previous review, it was fine with this patch. I can't imagine what
it's problem with this patch is, and there's no way to find out for
about 9 hours (more like 19 hours for me because of the timezone) as the
AI reviews are not accessible until then. Makes me wonder whether it's
worth continuing to submit patches to netdev anymore.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

