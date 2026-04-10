Return-Path: <netdev+bounces-277302-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGNKG5W32GnnhAgAu9opvQ
	(envelope-from <netdev+bounces-277302-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 10:40:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1046E3D43E6
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 10:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 67F0F30065D0
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B1A3ACEE1;
	Fri, 10 Apr 2026 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rqmqyPCM"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29EB306B1B
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 08:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775810405; cv=none; b=h+JZ9raMUi/rOsg9kKxd66Kg0UDylVvaVHPN25SzhHYRD6qTxH/c2Fr3564YpLJcYBIYuplfjnJvLlH+gk1hjwCtPNHPuP9R69nC0m4BuZonufK2ABCSi9DLP3P9BZx6w8yU6fEc3qqmw5kFoJhFG8fUNGBttYp38/yPm6oPdYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775810405; c=relaxed/simple;
	bh=TiLiBT6KTnhYXWpLCgTB1gPsKon+lMJReIv7vPRLxIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9Funev6gwWPVXWW/MTda65jsSmdR+B1Xed2EPBILZbXK8H893V/d6cDULHoPrTlVavVrN4LfGH7CwI8dOl4wptqtETjp1Dbf3A1GP+Im7vB264ws27H2reTsn+8yIEjo9FZn67DiQmdfw18QdRIIPsHJwMM9NWYnDkMKuANkbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rqmqyPCM; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZdOnR/1mCgonR7f2wP3H5JqrF/rCMapSujGWUMtD9/A=; b=rqmqyPCMlvW3KvDYDz3/ETNIAh
	G+ESQPCwbBnKWQSJh+ewTI/voRE6d3Ofr1iTuT3bDkAk27P35fRCtsFZbsndaH/5R0K66REmgJSa9
	6DVG3w9ciTeMT7N2D8gBgu388hIIZw6pNykZbUBWSDiL7IR0aL2hPrX8lB4FFeNyxkZ34crCfawWq
	ET2uU1utHtMx1ISS5KHV4cXaCRdUmtsF7xMSq6W4rlj8YdqvT2Z4amTnf9HBxDn9tiMn2tvOV0lU9
	fP2Wv8AVO7k6NoEkFKJOMMsTBV69KWgM7sywkLGQu709m6YCrVMKL6osnzUr1As2obFMhYf3OddEf
	Nyrg83EA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45482)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wB7P7-000000004e2-341K;
	Fri, 10 Apr 2026 09:39:53 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wB7P4-000000005UF-3z5f;
	Fri, 10 Apr 2026 09:39:50 +0100
Date: Fri, 10 Apr 2026 09:39:50 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Chen-Yu Tsai <wens@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH RFC net-next 02/10] net: stmmac: rename dev_id to userver
Message-ID: <adi3Vks-N0a83ylE@shell.armlinux.org.uk>
References: <adYfPBHsXxQUsMyr@shell.armlinux.org.uk>
 <E1wAPBR-0000000F7ju-1fD9@rmk-PC.armlinux.org.uk>
 <CAMdnO-+TK65AxjTsDd017Mhop+VC3Xf8jtfaTXYpE6wBNZOt4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMdnO-+TK65AxjTsDd017Mhop+VC3Xf8jtfaTXYpE6wBNZOt4g@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277302-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,armlinux.org.uk:url,shell.armlinux.org.uk:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1046E3D43E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 04:07:42PM -0700, Jitendra Vegiraju wrote:
> Hi Russell,
> 
> On Wed, Apr 8, 2026 at 2:27 AM Russell King (Oracle)
> <rmk+kernel@armlinux.org.uk> wrote:
> >
> > The Synopsys Databook and several implementation TRMs identify bits
> > 15:8 of the version register in dwmac v3.xx and v4.xx as "userver".
> > We even print its value with "User ID". Rather than using "dev_id",
> > use "userver" instead.
> >
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/hwif.c | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> > index 3774af66db48..830ff816ab4f 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> > @@ -15,7 +15,7 @@
> >
> >  struct stmmac_version {
> >         u8 snpsver;
> > -       u8 dev_id;
> > +       u8 userver;
> >  };
> From the XGMAC databook that I have access to bits(15:8) identify the
> DEVID field of MAC_version register.
> The userver field is from bits(23:16) of the same register. This is a
> customer defined field (configured with coreConsultant).
> Currently stmmac doesn't care about bits(23:16).

Thanks for the additional information.

I don't have any XGMAC documentation, but this indicates that it differs
between XGMAC and previous cores - GMAC and GMAC4 cores, 15:8 are
documented as userver, and 31:16 are marked as reserved.

Note that the dev_info() also prints 15:8 as "User ID" not "Device ID".

To confirm, is the XGMAC version register at offset 0x20 ? Later GMAC
cores moved it to 0x110.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

