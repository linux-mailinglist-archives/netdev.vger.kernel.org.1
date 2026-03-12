Return-Path: <netdev+bounces-267196-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPFDCwcbs2mDSAAAu9opvQ
	(envelope-from <netdev+bounces-267196-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 20:59:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 996B927864A
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 20:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 304083017FA7
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 19:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A2A3F1661;
	Thu, 12 Mar 2026 19:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="U/xpEQlk"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C703BD65E;
	Thu, 12 Mar 2026 19:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773345530; cv=none; b=lfuS0UuQsreyhOCF9AYCPKxLnnEjA4rscGxnVtgbl44rr3HACDfVHIpUyQaILG6mis0MNdwLjElMpIMjxfIaOGpyvKfkvWUHCV9yQOlmpR6ijFSekFnYhGSo22VRObY1boXEjEjObuwUEmcukSJpxiIKaomObFdFOe+ygkzmjLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773345530; c=relaxed/simple;
	bh=cQtDzB0VK26/gkhZcE2vnXDoKRyVorkL63PuotcbCw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXVJ+QAk1UWxj2iwFIDWEw+elqCRClMsBCRJORphqpxUMXngGtW4dJMton19HsLkf6t/ff4t0h8H+pMQP+hTrGlKNw8VI3i7tweKTJIyw9/P2Ra0E1ql+JjX5AndchK1BzvhTMJ3bBFwvedecSYicYHka1/cHuVqmBuUTXV8OqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=U/xpEQlk; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZgJABhOLNHlITvKzLeWHM0YIe4ZBlXE2o4k163INn4w=; b=U/xpEQlkF3IsNm2lh+nnErN9zq
	epnmshj4pSw5KbQY+Nk1bzb6EFU0WZOGUKYDWVjAfIH95CLIYUAXKzyeopc/kRtP9qTiR72Ggy5jv
	hE25aikp5v07JzsYWFQRpjrhhqX7+JLtNWE8w/aC5bEYWqvtpahShw4sQziqSfLGXxwx9L8IXk995
	/+Ldsakxm9yFMIuJE860sz21xU6ayrlC3odjteHZ8iXykkf76+uJsxJRzCBOnQY4o1bN1OSQ5jws5
	1mcuSZ4CmwDt5l9v4G61yzLn+k5uGpl37TUPOxFYtNz5w6lymS1pWZ/lip5bcCRy921j0+ChuQcbQ
	qbTKrjQQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37520)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w0mBA-000000008In-2Tid;
	Thu, 12 Mar 2026 19:58:44 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w0mB8-000000007T6-0BQG;
	Thu, 12 Mar 2026 19:58:42 +0000
Date: Thu, 12 Mar 2026 19:58:41 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Charles Perry <charles.perry@microchip.com>
Cc: netdev@vger.kernel.org, Conor Dooley <conor@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: macb: set default_an_inband to true for
 SGMII
Message-ID: <abMa8e_2fjRkeOix@shell.armlinux.org.uk>
References: <20260312133856.2911581-1-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312133856.2911581-1-charles.perry@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	TAGGED_FROM(0.00)[bounces-267196-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.954];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 996B927864A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 06:38:55AM -0700, Charles Perry wrote:
> Most platforms using GEM in SGMII mode use in-band autonegotiation
> because it is on by default in GEM's 1G PCS and is always on since
> commit e276e5e40e92 ("net: macb: Disable PCS auto-negotiation for SGMII
> fixed-link mode"). Leave it on if possible using the "default_an_inband"
> flag of "struct phylink_config" so that platforms that lack in-band
> autonegotiation configurability at the PHY do not break with commit
> 1338cfef1ff1 ("net: macb: fix SGMII with inband aneg disabled") which
> will turn off in-band autoneg for non hot pluggable PHYs.
> 
> Once the majority of the PHY drivers that support SGMII have the
> ->config_inband() callback, this commit could be reverted so that non
> hot pluggable PHY use outband negotiation with macb, like its the case
> for other MACs.
> 
> Fixes: 1338cfef1ff1 ("net: macb: fix SGMII with inband aneg disabled")
> Closes: https://lore.kernel.org/r/20260304-nebulizer-rounding-40fbc81a2ba1@spud

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

