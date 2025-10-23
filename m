Return-Path: <netdev+bounces-232072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27392C00960
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 12:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60B333A412E
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 10:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717ED30ACF0;
	Thu, 23 Oct 2025 10:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Pf30+2tg"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7054B2D12EA;
	Thu, 23 Oct 2025 10:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761216872; cv=none; b=ti6k1wRnyt5V2TRye0q42QEgqi+kXOtgyGRDlu9GGEEcHH5F3XbIGdqdJd+P/5dDhpMB2SmqViENLIWGMaU0p6NmgDSEFDBz9SVr2mQSuluKv/YiD8vCHUf+dlSBkoDJxoG4abCKE0LoUI4Sgr//eeS7Qvt9eoZBbIN1ygitAJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761216872; c=relaxed/simple;
	bh=ZFnvfm+yWoOd7Q01/nDjdXk5cVbJUlrMR12+19gWEe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsDYSlVerjP2oymia+oB5QJZyJBkBrisTUqHUsNeKTdkr5Ub4S6Ofur8c957SqxTKZBwV1qK3L6KNppONsTeRsSln4d8C7i+pdGWI7Kxcj4X1iNd1mHbeIMjqvY5llrU5hX96grr1xmyTDXlCF3g8XNPyQPGhcBMTo0DC07lwe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Pf30+2tg; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=P5H/X2O6VAth3+1IJiZ1jVADDRZOBh553gExnuinE6g=; b=Pf30+2tgWHWff05MLYY0zw/0+w
	abhcaYZwkQ0qPJr4E85uSPGBRk37p6qmfNoCVIxrBYfZCf8tOmpPEQJbblRJoZOCPOLObmbV/wvPO
	uoVUr+lEphTXs9FQ9lp7Ty3ukn6EbY+cuU9CjUwYcdbXM9lcSfZCHvb7pS1TaajOqUYOdcmb+bYnz
	23KRqaGwo77hReiEZUy5NBKDJvqtwSIfQ1zPJk1uwJSjCpWFbhzIpKvfPO7VnLWUwHPzkGWDIPQmA
	lfcHw/CMNhIUXbIa7hewF4ETVeKLDIjTMnFGgcBAxt0qt06glhbgO9iD1tDuu+Dd8dPEB+vOLzwXm
	PevYaXlA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45430)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vBsxV-000000006Cw-1WVS;
	Thu, 23 Oct 2025 11:54:17 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vBsxQ-000000001cU-0p2n;
	Thu, 23 Oct 2025 11:54:12 +0100
Date: Thu, 23 Oct 2025 11:54:12 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Rohan G Thomas <rohan.g.thomas@intel.com>,
	"Ng, Boon Khai" <boon.khai.ng@altera.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3 1/3] net: stmmac: vlan: Disable 802.1AD tag
 insertion offload
Message-ID: <aPoJVOUe-ASx1GmV@shell.armlinux.org.uk>
References: <20251017-qbv-fixes-v3-0-d3a42e32646a@altera.com>
 <20251017-qbv-fixes-v3-1-d3a42e32646a@altera.com>
 <aPI5pBXnh5X7OXtG@shell.armlinux.org.uk>
 <e45a8124-ace8-40bf-b55f-56dc8fbe6987@altera.com>
 <1abbcd93-6144-440c-90d9-439d0f18383b@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1abbcd93-6144-440c-90d9-439d0f18383b@altera.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Oct 23, 2025 at 09:01:20AM +0530, G Thomas, Rohan wrote:
> Hi Russell,
> 
> On 10/18/2025 7:26 AM, G Thomas, Rohan wrote:
> > Hi Russell,
> > 
> > On 10/17/2025 6:12 PM, Russell King (Oracle) wrote:
> > > On Fri, Oct 17, 2025 at 02:11:19PM +0800, Rohan G Thomas via B4 Relay wrote:
> > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > index 650d75b73e0b0ecd02d35dd5d6a8742d45188c47..dedaaef3208bfadc105961029f79d0d26c3289d8 100644
> > > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > @@ -4089,18 +4089,11 @@ static int stmmac_release(struct net_device *dev)
> > > >    static bool stmmac_vlan_insert(struct stmmac_priv *priv, struct sk_buff *skb,
> > > >    			       struct stmmac_tx_queue *tx_q)
> > > >    {
> > > > -	u16 tag = 0x0, inner_tag = 0x0;
> > > > -	u32 inner_type = 0x0;
> > > > +	u16 tag = 0x0;
> > > >    	struct dma_desc *p;
> > > 
> > > #include <stdnetdevcodeformat.h> - Please maintain reverse christmas-
> > > tree order.
> > 
> > Thanks for pointing this out. I'll fix the declaration order in the next
> > revision.
> > 
> > > 
> > > I haven't yet referred to the databook, so there may be more comments
> > > coming next week.
> > > 
> > 
> > Sure! Will wait for your feedback before sending the next revision.
> 
> Just checking in — have you had a chance to review the patch further? Or
> would it be okay for me to go ahead and send the next revision for
> review?

I've checked my version of the databook, and the core version that has
VLINS/DVLAN and my databook doesn't cover this. So I'm afraid I can't
review further.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

