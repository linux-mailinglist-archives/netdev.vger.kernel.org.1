Return-Path: <netdev+bounces-257915-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGFkMG6giWlU/wQAu9opvQ
	(envelope-from <netdev+bounces-257915-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 09:53:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4086010D3B6
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 09:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9ECA83004906
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 08:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E89A3164DC;
	Mon,  9 Feb 2026 08:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fcDG5xkb"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94CD30C34E;
	Mon,  9 Feb 2026 08:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770627180; cv=none; b=bEeALhXrUP/efeufYrOe+UEPXMwULcNbyg7mUIgfh2cPa5S4yt7FgmByTo2ma6B7UhD0O+9L6R4OTQKrl9buVvKPTVNyXWDvfbhBbuA5klPfM1Wp8nAybQyiaW7Li+BwekBryPepNpaPrDLIUTbh/VZnIUXoHK+Ad2bNsHWqA1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770627180; c=relaxed/simple;
	bh=GMJibrj/+0+UKaNGzJAq19b/nSB9Ce27Y3Sp9qXK7aY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWyJLTV7QQQFlrkhOERD6zn7YU3G5NPRIXsIDsKgPLmUNpBhboE62+V1KzN8hvr9IJrdoY8uF32joXV4sLCU2jX6IUiYIxyJ6FbWSdD5MAMUUZM10fa5t4lzsHY0ac8ZYj7rJt856ZBAfONZryPTPbPJjb7bCYjHRlyma7EWlIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fcDG5xkb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=a6jC0h1P4AimHECTj91dAMJUplx9nyACNal2IJFRayA=; b=fcDG5xkbNSfLio/ORJQorF8cX7
	cKWkAZZgBL5R59C1srzyAKxJezC4tYS1KDmZLso8BghHAbVgODx3hsXsTkwD6TxxWTHm5ysIm/8/u
	p6j2DXS2CGWHGyW96j/UdgJBeVlnZAFjmSj8d0A7B/Att9ebd+2LKUzsgPlUdssECZ5T3Q44FG/nu
	SKZSLHgvaDS6APxE1lUNJQmdVYW/Ttgotz3nponNbxV/NaNYjddk5ID8cOTNEk2Sv5Zc46ZaIltkb
	7Mnq6sm2dZoE/PQR/14shG3y8LRXCQj9PiXIKLNP7K3enqiM5qfN8zfORRIohnW1NMHRQZnoZ4hST
	D7yOxYxg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57142)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vpN0e-000000001NA-46iH;
	Mon, 09 Feb 2026 08:52:45 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vpN0X-000000001eo-3B6l;
	Mon, 09 Feb 2026 08:52:37 +0000
Date: Mon, 9 Feb 2026 08:52:37 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jie Zhang <jzhang918@gmail.com>
Cc: netdev@vger.kernel.org, jie.zhang@analog.com, horms@kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: stmmac: fix oops when split header is enabled
Message-ID: <aYmgVS3c7PFC6mfz@shell.armlinux.org.uk>
References: <20260206195643.11333-1-jie.zhang@analog.com>
 <aYZPUx2WrIkPmvIU@shell.armlinux.org.uk>
 <aYlXVIqHfdOfcAAl@P5510>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYlXVIqHfdOfcAAl@P5510>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257915-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,analog.com,kernel.org,intel.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,foss.st.com,bootlin.com,nxp.com,synopsys.com,st-md-mailman.stormreply.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4086010D3B6
X-Rspamd-Action: no action

On Sun, Feb 08, 2026 at 10:41:08PM -0500, Jie Zhang wrote:
> Thanks. This is a new version of the patch I sent last year. I tested
> the original version again the net tree. But I forgot to test the new
> version again. I just test it now on the latest net tree with other
> patches for our board. But Ethernet stops working. I'm trying to figure
> out what causes this new issue. After that I will send out a new version
> of this patch.

You're not listed in MAINTAINERS, so you wouldn't have been Cc'd on the
various patches I've submitted for stmmac, and so wouldn't have had the
opportunity to test them and highlight any issues.

Please consider adding a MAINTAINERS entry so you can be aware of
patches as they are posted.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

