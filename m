Return-Path: <netdev+bounces-170918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5356A4AA42
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 11:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 606A11899912
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 10:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FCC1CAA9A;
	Sat,  1 Mar 2025 10:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Trg6HRP+"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB781E49F
	for <netdev@vger.kernel.org>; Sat,  1 Mar 2025 10:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740825672; cv=none; b=ivBuUgIKDBMcthlEJcIECOHjuWuew+AQGwHHcSU3OQq9iqaEhwwlz6/nZrSxdNMNnykhRCR5lZ/hiVkWlmehdYNsQ7ywurUyri8kk5Lr3MGNWb7Q90lia5NzQx/XW737vG1lKsI/BfDVNnapjEi9spSCTTaXEBMKz7EjANb8St8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740825672; c=relaxed/simple;
	bh=axVvbg4f/XMx1VP+EM7fdMEfAM+ZiieklFFpiJyau4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHAYIhk1hK6+1IOn6FBCTIjhAYwaSv6zlRLkg59hR08/entkQvsLJBk3iCT1Z7ISUKQ0dCo6LFyIScv9xXUzwTAjJxxkFGUBW0Sxc0C10k2Yc0U6bmkifASWvTJj42tPvJRDiC/kV9GmxviI73G1VrZHHCpITyMneo7qrxjT3UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Trg6HRP+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QKFTGOehFL46cXtqRQ3+zESpMtlY+tcTv0ubD9/y+6c=; b=Trg6HRP+asyq/AhpYZp8PCMXpU
	P6abXB8fdAww95sHxSBpb5iQc4xNvsDF+eXQem4a8WkSlrTIbdhyEwdrMysAeEtyFqRUSEz4ZR3vi
	yD0DvM9rNFapfCXBN7jLreOG5PYzRnlXJC8gfTOtFSdupK05xbq8KZ22Wr/MhZPWn/AUSoO366CFN
	yJuVOpmy5su9V5IQ1tYmV0I4MyCBh6cfO6sIPC416v5tIxspDhfOm7cnSdYodr8EjTB4xqH4q8ZrR
	RDsEzhyYqP7sdaJ5pALxzYeTDuAoOImADIRsz27+kz0n3/m2Wf1Iv7XdIrW/p4ACSnh0GnovZpLV+
	v2mi/eBw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60874)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1toKHI-00045Z-0i;
	Sat, 01 Mar 2025 10:41:04 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1toKHF-0001ia-23;
	Sat, 01 Mar 2025 10:41:01 +0000
Date: Sat, 1 Mar 2025 10:41:01 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>, netdev <netdev@vger.kernel.org>
Subject: Re: [QUERY] : STMMAC Clocks
Message-ID: <Z8LkPQ-w_jyXriFp@shell.armlinux.org.uk>
References: <CA+V-a8u04AskomiOqBKLkTzq3uJnFas6sitF6wbNi=md6DtZbw@mail.gmail.com>
 <84b9c6b7-46b1-444f-b8db-d1f6d4fc5d1c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84b9c6b7-46b1-444f-b8db-d1f6d4fc5d1c@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Mar 01, 2025 at 12:38:04AM +0100, Andrew Lunn wrote:
> On Fri, Feb 28, 2025 at 09:51:15PM +0000, Lad, Prabhakar wrote:
> > Hi All,
> > 
> > I am bit confused related clocks naming in with respect to STMMAC driver,
> > 
> > We have the below clocks in the binding doc:
> > - stmmaceth
> > - pclk
> > - ptp_ref
> > 
> > But there isn't any description for this. Based on this patch [0]
> > which isn't in mainline we have,
> > - stmmaceth - system clock
> > - pclk - CSR clock
> > - ptp_ref - PTP reference clock.
> > 
> > [0] https://patches.linaro.org/project/netdev/patch/20210208135609.7685-23-Sergey.Semin@baikalelectronics.ru/
> > 
> > Can somebody please clarify on the above as I am planning to add a
> > platform which supports the below clocks:
> > - CSR clock
> > - AXI system clock
> > - Tx & Tx-180
> > - Rx & Rx-180
> 
> Please take a look at the recent patches to stmmac for clock handling,
> in particular the clocks used for RGMII
> 
> For the meaning of the clocks, you need to look at the vendors binding
> document. Vendors tend to call the clocks whatever they want, rather
> than have one consistent naming between vendors. The IP might be
> licensed, but each vendor integrates it differently, inventing their
> own clock names. It might of helped if Synopsis had requested in there
> databook what each clock was called, so there was some consistency,
> but this does not appear to of happened.

Part of the problem is that vendors can place clock muxes and gates
and divisors around the Synopsys block, where some muxes/divisors can
be controlled by signals output by the Synopsys block (and thus are
hidden from software). This is especially true of the pair of clk_tx_i
and pair of clk_rx_i clocks.

Thus, the clocks that are visible may be functionally different from
the Synopsys defined clocks.

However, I think that we should push to standardise on the Synopsys
named clock names where they exist (essentially optional) and then
allow platform specific clocks where they're buried out of view in
the way I describe above.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

