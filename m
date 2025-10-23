Return-Path: <netdev+bounces-232074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC2EC00993
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 12:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868873AE2F8
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 10:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3740F2FB966;
	Thu, 23 Oct 2025 10:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ljnUuImE"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8036425A331;
	Thu, 23 Oct 2025 10:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761217179; cv=none; b=beLyNrP/hO3ON7g97SY8/Bq65+aOBoSLc1VtudV1T75t5o1/RDRmsY125kRqbRXSnw+eqIBs4M42QpCnwEF1I8pmPjYjbpZnxaOdkPa5XHPrdmPYzqMd/WWT9+g3kQ9DmLlIgBZydUW2Ct5tzulAKX33N3CEfn1sMgcTUsQoUE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761217179; c=relaxed/simple;
	bh=ZareSfvJu1tD4utOGY4tzaHmqdMXYJKeJkBrPZsTs58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAUs0InA2CuGHTKzSmXWKs/fvfA0qGIFH3DsnQKsbLA7qUYChS9s4zYOnpvDhqvFdIA2creduxLc6iGYd/vMklD4f2s6nhpYbQ7hilPq8Q9ggeMPTbL/BrcHNJAvXb4jYlp3sKd6sDx1aQK35Cnu3hij8IbllLqTVeigEKKGGKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ljnUuImE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cXNqIy91mHPmLyBUYzLy8qeZ7FOKJrKClaIbZivIa/4=; b=ljnUuImE9Pjqxqy0Uz5qYz6n9e
	mGCtjIUZIsd8VeoxBNlc51Frunk5tzXuigWR4oE67G5/H6szRyYTez9MIgvnmQSNh4Mw0eOydkivV
	mD4YugCenid+cFxILBA/x/XzqQa/ZL4mutB4tYA0aeKv9M1Q3dNzphSJD6Sd0Tbl58dUax4bFVDo/
	viI2gysJGHzHvM0rj+FTKe7sYmxNOGmMcpGO0j4gw2+c479jYSr/16oHGCDRG4Cj3fANteVJGbu5z
	RCo/wbUYOg/Lbi7u6XKIkydMPRrDNHOXF9ZuDsZ71qFEW3wnqTcn2u60T8c7lhjC46U1T82xbnjmE
	aJL5ohPw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41112)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vBt2S-000000006EA-3ZEb;
	Thu, 23 Oct 2025 11:59:24 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vBt2P-000000001d1-35L8;
	Thu, 23 Oct 2025 11:59:21 +0100
Date: Thu, 23 Oct 2025 11:59:21 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Rohan G Thomas <rohan.g.thomas@intel.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: Re: [PATCH net v3 2/3] net: stmmac: Consider Tx VLAN offload tag
 length for maxSDU
Message-ID: <aPoKiREmRurn-Mle@shell.armlinux.org.uk>
References: <20251017-qbv-fixes-v3-0-d3a42e32646a@altera.com>
 <20251017-qbv-fixes-v3-2-d3a42e32646a@altera.com>
 <d7bbb7dd-ddc6-43d6-b234-53213bde71bd@altera.com>
 <83ffc316-6711-4ae4-ad10-917f678de331@linux.dev>
 <0d3a8abe-773c-4859-9d6f-d08c118ce610@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d3a8abe-773c-4859-9d6f-d08c118ce610@altera.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Oct 18, 2025 at 07:20:03AM +0530, G Thomas, Rohan wrote:
> Hi Vadim,
> 
> On 10/17/2025 5:51 PM, Vadim Fedorenko wrote:
> > On 17/10/2025 08:36, G Thomas, Rohan wrote:
> > > Hi All,
> > > 
> > > On 10/17/2025 11:41 AM, Rohan G Thomas via B4 Relay wrote:
> > > > +    sdu_len = skb->len;
> > > >       /* Check if VLAN can be inserted by HW */
> > > >       has_vlan = stmmac_vlan_insert(priv, skb, tx_q);
> > > > +    if (has_vlan)
> > > > +        sdu_len += VLAN_HLEN;
> > > > +
> > > > +    if (priv->est && priv->est->enable &&
> > > > +        priv->est->max_sdu[queue] &&
> > > > +        skb->len > priv->est->max_sdu[queue]){
> > > 
> > > I just noticed an issue with the reworked fix after sending the patch.
> > > The condition should be: sdu_len > priv->est->max_sdu[queue]
> > > 
> > > I’ll send a corrected version, and will wait for any additional comments
> > > in the meantime.
> > 
> > Well, even though it's a copy of original code, it would be good to
> > improve some formatting and add a space at the end of if statement to
> > make it look like 'if () {'>
> 
> Thanks for pointing this out. I'll fix the formatting in the next version.

I suggest:

First patch - fix formatting.
Second patch - move the code.

We have a general rule that when code is moved, it should be moved with
no changes - otherwise it makes review much harder.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

