Return-Path: <netdev+bounces-233690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EADDC176B6
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 00:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3D3D400A11
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 23:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33882FF177;
	Tue, 28 Oct 2025 23:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SA1gJowD"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C372D877D
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 23:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761695714; cv=none; b=em18jnG5ACug07/7pwMkyhgzFy0RdF9I1UlCPYQm+DnYGzyo9y/nZpTmkBxfY5EHdvyzwd9/uZUP0WIF58TIIJ9+MzQ/5tEAFwJZldQ3RZgrMfDSekUQLxEuyjvC5rq0riNuNVVt+tBIREEVc2WCyPmswNGFfjG9bc8xcMBFGcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761695714; c=relaxed/simple;
	bh=/p9Eupj41zs8+DrLkO5T23BrbRttox4W6pPz0PP3/+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSb6SM1OFsaaJbDfHe/mWvRi0Isw5T0EfqwzwnlR57WA1KVKam36acgjmQSDm4C2rPhVPl5H31uvLhJ+Kl0NY9tj8f1zOQRFEEAmf1CPghwfw/9rbzb+bGTzy7UW2FOVer2z1cdSBdyeLmb631aAZDforTGSyFCyzBAadLp7kk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=SA1gJowD; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=S1uikCk1PVoFKraVmv1JjdTmyz7aVTR16X64oIcnMf8=; b=SA1gJowDBcLZISZx0Lli/3K9Tr
	tSQGuKix+Lwh74Sfj/czjDbD+PnGWw7ARxxjBvN5rOHI+4H2ewkNHUPFg+WtHUOPGO8x2RJQKdDYC
	pdybl08H/jFyXjVqDIP2uBppNyOHf1z97iYoOnGNAdnArT9qoiDC2f3ScEQv2UjyIDX3HY3CY1ltT
	e94lz91ONXafGZP1BifBuX/mawC8G2o6UlUaEbZaSV4Dfks24zWdHZIaIHgjxy2p8GGXs/IxzxHUP
	j6O+zAU8PPw3K0SAfHx+4P5w2kbpHPxKi9eq9ARmOHYnaZ8Yi9oudR9PZiojyBt6yP0hoyrV6QWBW
	Pv34Ld6Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40576)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vDtWo-000000003f0-3177;
	Tue, 28 Oct 2025 23:55:02 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vDtWk-000000006xk-0Ryn;
	Tue, 28 Oct 2025 23:54:58 +0000
Date: Tue, 28 Oct 2025 23:54:57 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next 0/8] net: stmmac: hwif.c cleanups
Message-ID: <aQFX0cdyCHLHIquB@shell.armlinux.org.uk>
References: <aPt1l6ocBCg4YlyS@shell.armlinux.org.uk>
 <20251028164257.067bdbcd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028164257.067bdbcd@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Oct 28, 2025 at 04:42:57PM -0700, Jakub Kicinski wrote:
> On Fri, 24 Oct 2025 13:48:23 +0100 Russell King (Oracle) wrote:
> > This series cleans up hwif.c:
> > 
> > - move the reading of the version information out of stmmac_hwif_init()
> >   into its own function, stmmac_get_version(), storing the result in a
> >   new struct.
> > 
> > - simplify stmmac_get_version().
> > 
> > - read the version register once, passing it to stmmac_get_id() and
> >   stmmac_get_dev_id().
> > 
> > - move stmmac_get_id() and stmmac_get_dev_id() into
> >   stmmac_get_version()
> > 
> > - define version register fields and use FIELD_GET() to decode
> > 
> > - start tackling the big loop in stmmac_hwif_init() - provide a
> >   function, stmmac_hwif_find(), which looks up the hwif entry, thus
> >   making a much smaller loop, which improves readability of this code.
> > 
> > - change the use of '^' to '!=' when comparing the dev_id, which is
> >   what is really meant here.
> > 
> > - reorganise the test after calling stmmac_hwif_init() so that we
> >   handle the error case in the indented code, and the success case
> >   with no indent, which is the classical arrangement.
> 
> This one needs a respin (patch 6 vs your IRQ masking changes?).

Are you sure? Nothing came up in the re-base, and nothing was reported
in PW.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

