Return-Path: <netdev+bounces-61547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F038243B0
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9EEA1C23FF6
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 14:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78C9224EE;
	Thu,  4 Jan 2024 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="t6tUmIwY"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC25A225A2
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nYZzk/b22yl3Pt07po6VyrQXuT+78XxODTrFH6wAuUE=; b=t6tUmIwY8o9NtK8oFNcPVJR3SH
	/fVxNqpg2TVaIWuJ75xAuJp4x05B/gY1Sa/F/IqgFG1iIqYlivFo8UMQaNhZMk+ZU78JuUNYh1n+6
	QiQ9XeRXUsh4YnJhxJWOxwbUpUaSX7GgAA9eexWvj0WiIkuJegfbVTDY+EHCkALpsmBeoCbA+9ZpA
	AJQx45JRY90Lj18n+TUzxNmej4tx3EXtz8iTwLxD1/duHd+pMFihqGYgIO5/rMBLu9saGRfG7743s
	AqPXQTkHumXihDKzdSnrbLddtFxOO3R6N8ThgGMPbxXVHnXzf+OsPAqUqOfy44VkC691yoFugRnaW
	MPMJABCg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58524)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rLOdE-000081-09;
	Thu, 04 Jan 2024 14:23:36 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rLOdG-0007Uz-C1; Thu, 04 Jan 2024 14:23:38 +0000
Date: Thu, 4 Jan 2024 14:23:38 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sergio Palumbo <palumbo.ser@outlook.it>, netdev@vger.kernel.org
Subject: Re: sfp module DFP-34X-2C2 at 2500
Message-ID: <ZZa/aj7B05mL9rse@shell.armlinux.org.uk>
References: <AS1PR03MB8189F6C1F7DF7907E38198D382672@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <d253b578-8fc4-4e85-9c8f-23bdf15dfa77@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d253b578-8fc4-4e85-9c8f-23bdf15dfa77@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jan 04, 2024 at 03:15:17PM +0100, Andrew Lunn wrote:
> On Thu, Jan 04, 2024 at 02:10:43PM +0100, Sergio Palumbo wrote:
> > diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> > index 2abc155dc5cf8..a14f61bab256f 100644
> > --- a/drivers/net/phy/sfp.c
> > +++ b/drivers/net/phy/sfp.c
> > @@ -495,6 +495,9 @@ static const struct sfp_quirk sfp_quirks[] = {
> >         // 2500MBd NRZ in their EEPROM
> >         SFP_QUIRK_M("Lantech", "8330-262D-E", sfp_quirk_2500basex),
> >  
> > +       // DFP-34X-2C2 GPON ONU supports 2500base-X
> > +       SFP_QUIRK_M("OEM", "DFP-34X-2C2", sfp_quirk_2500basex),
> > +
> >         SFP_QUIRK_M("UBNT", "UF-INSTANT", sfp_quirk_ubnt_uf_instant),
> >  
> >         // Walsun HXSX-ATR[CI]-1 don't identify as copper, and use the
> > 
> 
> Hi Sergio
> 
> Please read:
> 
> https://docs.kernel.org/process/submitting-patches.html
> 
> and
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> 
> There is a formal process you need to go thought when submitting
> patches, which these two documents describe.

Indeed. I assume the original didn't have any commit message, sign-off,
and obviously wasn't Cc'd to the appropriate maintainers...

It is worth noting that:

https://hack-gpon.org/ont-odi-realtek-dfp-34x-2c2/

gives a table of the possible host interface modes, which appears to
includes 2500base-X _with_ AN.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

