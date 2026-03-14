Return-Path: <netdev+bounces-267688-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL2aLocltWnVwwAAu9opvQ
	(envelope-from <netdev+bounces-267688-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 10:08:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4EA28C48A
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 10:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 598093040AB4
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 09:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D2A314A6B;
	Sat, 14 Mar 2026 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CVjeTl5l"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D2130170F;
	Sat, 14 Mar 2026 09:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773479178; cv=none; b=nA1WFYWO9fqXM0RYcBPrntFVA6N2Au+rIFFEUlZy+MujAFMqW3d2Kx5zBP4oGh1DQNmqlw9wXew9KU32G41mptft2skzA+5yv9UJJJMyN8m64e0WX1/LEFnQ6lPIQnb/Lni7/5PHQzXwrv7ikoNxEHo8krHCAfuD0QfQjbrh1FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773479178; c=relaxed/simple;
	bh=QdR4k2ftYM+FzozJExw6VdKV0B5HUFfyuR43EeKZ26k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvW7tTIrh5xb+ARLnN2rlE5dGEfwQJTCtYtic1W3Vs674fXhPE9xptxxSyC1FPBGweOwkHlGXOsr95xIU0EiSOOVoH78/KaURuvPomu6NuzYsh3jxGGVFHZs5CQcpt/BdpYSbUX7Jxclk2ROePfQJ8CJnNbwjehc5oSvfcIL2bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CVjeTl5l; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XDHPMvvelJ2Cr8JQOMK4y8zlX+CoeMjJj597Pacfiqc=; b=CVjeTl5lsBzj08RYWflxLr2KVH
	bX0l/VwUAC9hKb+4vICTdrttfBP+sNjvSlPz0tV5AZ6t1BdMBsLP8Jf9yKDLaMePUM7xKoedOaDFL
	bx/9IUvP/qbEQ5cBtP2C40LfTEoIRwYzJlKXpPFgEv7kKi239Gnm0nk4RV/X6g37jt2DFOZeiOuJK
	lGI9g2ieVtAd31zKvwwwFFbL2dkqBNQldSOc1oGle2DvXGjv+OaaMU8V7y2cjhj3fGSLxCe5/MO1y
	DtL2oXPouRqgMKp2JoHM6nN7MQ5a2l0dEZrHFo1qZLVT8Ix7+Y3kGRoTfc42+2hvozLosmF50Smsp
	M7TmoiMQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41936)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w1Kwm-000000001xR-01Hj;
	Sat, 14 Mar 2026 09:06:12 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w1Kwj-000000000f7-0P6b;
	Sat, 14 Mar 2026 09:06:09 +0000
Date: Sat, 14 Mar 2026 09:06:08 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Charles Perry <charles.perry@microchip.com>, netdev@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: macb: set default_an_inband to true for
 SGMII
Message-ID: <abUlANami1hWAfgf@shell.armlinux.org.uk>
References: <20260313142140.4040647-1-charles.perry@microchip.com>
 <20260313190631.382df727@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313190631.382df727@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267688-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.878];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E4EA28C48A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 07:06:31PM -0700, Jakub Kicinski wrote:
> On Fri, 13 Mar 2026 07:21:39 -0700 Charles Perry wrote:
> > Most platforms using GEM in SGMII mode use in-band autonegotiation
> > because it is on by default in GEM's 1G PCS and is always on since
> > commit e276e5e40e92 ("net: macb: Disable PCS auto-negotiation for SGMII
> > fixed-link mode"). Leave it on if possible using the "default_an_inband"
> > flag of "struct phylink_config" so that platforms that lack in-band
> > autonegotiation configurability at the PHY do not break with commit
> > 1338cfef1ff1 ("net: macb: fix SGMII with inband aneg disabled") which
> > will turn off in-band autoneg for non hot pluggable PHYs.
> > 
> > Once the majority of the PHY drivers that support SGMII have the
> > ->config_inband() callback, this commit could be reverted so that non  
> > hot pluggable PHY use outband negotiation with macb, like its the case
> > for other MACs.
> 
> I'm assuming this needs a respin now to account for the erronously
> merged patch?

It can be merged as well as the vitesse patch.

The problem with the vitesse patch is it _would_ break for MACs that
use phylink and always enable SGMII inband against phylink's
instruction as the vitesse PHY comes up with SGMII inband enabled.
Do we know of any MACs that are like that... well yes. There's at
least one, the thorn of a driver, the poor implementation, known as
stmmac. However, that wasn't the only one - the patch which caused
this regression shows that macb also ignored phylink's wishes.

Are there others? We don't know. This makes the vitesse patch
potentially unsafe and potentially being reverted if problems are
found during 7.1-rc.

So, I think having both patches in gives to best approach for now -
at least if the vitesse patch gets reverted, macb won't regress.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

