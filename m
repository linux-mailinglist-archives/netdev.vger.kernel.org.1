Return-Path: <netdev+bounces-258784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKkzATIBkmnYpAEAu9opvQ
	(envelope-from <netdev+bounces-258784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 18:24:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D06A13F357
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 18:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1335B301B717
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 17:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B0828C2BF;
	Sun, 15 Feb 2026 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QhVxgtdb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A5617DFE7;
	Sun, 15 Feb 2026 17:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771176237; cv=none; b=S69oWZ/Ce5p9yLgstTqQ+rUTg4jsCThPqRCANmhCL7DCigIZ4ZVUjCUC9fLA0bpJwg6Fep5UbBRoqDx8v1gCsgx/vwc3wl5ZsYmPyiJ/jj6bDeBsPeqfiA2YW2juge5SOUP/bq3vhOeAugEwPrBKpCPmuoZO5ghIlTnSVka1C/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771176237; c=relaxed/simple;
	bh=vP1ld/UOqVDqqOkepRMATLDHctxlJDhy4ZUOtnCeIBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJjTaOtVW3vRt156lC4ZQhfdiWYLDk4NIomHbhcSjHCADojWXHDkcDpxNxkDb6qIQyElztb81g2tOzUO6G9qs/AY3BXud3rqiW/iPdxRqtjHuSpIz1ooRKso7TcDM0CTWI35Jq2Xw0a4YJLz/miaV2wVa5OWcgKS8HkpZqenZrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QhVxgtdb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=eoNlOlC07KIIwed0idbUiLLsgrdMVT4VI9/W83S5z+Q=; b=Qh
	Vxgtdbwk08iCxr1e5jsPMug78NEwUP5TA7LWu64socnTV199GPT/0Jz4NuZ+/OWofYoUs9bvVc179
	gXETC+Lb4dXhu2wldSQLc0fthXnOG1+91t6RxIgkon0pTGRRgyUxi0w9fRWIuYp2yRO8zr7LrDypX
	F/fMFeA4c+51Koo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vrfqJ-007PAt-D1; Sun, 15 Feb 2026 18:23:35 +0100
Date: Sun, 15 Feb 2026 18:23:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Malladi, Meghana" <m-malladi@ti.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	linux@armlinux.org.uk, hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com
Subject: Re: [EXTERNAL] Re: [PATCH net] net: phy: dp83869: Set auto mdix bit
 for forced 100Base-Tx mode
Message-ID: <d296a7f9-c7d3-4450-af75-09855b405890@lunn.ch>
References: <20260211131033.2525617-1-m-malladi@ti.com>
 <0a9d0ec8-09c4-4029-8449-8c8f08c6dca0@lunn.ch>
 <a498b310-29f1-4775-aa65-fda027a3124b@ti.com>
 <5929eafb-6101-4570-beaf-ed08ae109423@bootlin.com>
 <06ff0e10-f412-44f5-932d-f14a0044181e@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06ff0e10-f412-44f5-932d-f14a0044181e@ti.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258784-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[bootlin.com,redhat.com,kernel.org,google.com,davemloft.net,armlinux.org.uk,gmail.com,vger.kernel.org,ti.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 6D06A13F357
X-Rspamd-Action: no action

On Sun, Feb 15, 2026 at 08:15:23PM +0530, Malladi, Meghana wrote:
> Hi Maxime,
> 
> On 2/13/2026 12:10 AM, Maxime Chevallier wrote:
> > Hi Meghana, On 12/02/2026 07: 21, Meghana Malladi wrote: > Hi Andrew, >
> > > On 2/11/26 19: 42, Andrew Lunn wrote: >> On Wed, Feb 11, 2026 at 06: 
> > 40: 32PM +0530, Meghana Malladi wrote: >>> When using DP83869 in force
> > 100Base-Tx
> > ZjQcmQRYFpfptBannerStart
> > This message was sent from outside of Texas Instruments.
> > Do not click links or open attachments unless you recognize the source
> > of this email and know the content is safe.
> > Report Suspicious
> > <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK! uvdqvDfOXMcx4EXE_POD_-6kkowIhAz8zXLHMFm81_iVEIIhL4AZYTCCg5LBLfOFsQIbaQidTlj5ZWaMhdH1sacfSO1-r-L7$>
> > ZjQcmQRYFpfptBannerEnd
> > 
> > Hi Meghana,
> > 
> > On 12/02/2026 07:21, Meghana Malladi wrote:
> > > Hi Andrew,
> > > 
> > > On 2/11/26 19:42, Andrew Lunn wrote:
> > > > On Wed, Feb 11, 2026 at 06:40:32PM +0530, Meghana Malladi wrote:
> > > > > When using DP83869 in force 100Base-Tx mode, the PHY is required
> > > > > to have robust Auto-MDIX feature enabled from register 1Eh.
> > > > > Refer to 7.4.1.2 100BASE-TX section in the TRM [1] for more details.
> > > > 
> > > > What are the results of not enabling this? How would somebody know
> > > > they need this patch?
> > > 
> > > This is the fix for 100M full duplex when auto-neg gets disabled, it
> > > fails to have a link up and this patch fixes it. I will add more
> > > description to the commit message.
> > 
> > I have a board here with a DP83869 + imx93's dwmac, but I couldn't
> > trigger the bug locally. I forced speed, dpx and aneg settings with :
> > 
> > ethtool -s eth0 speed 100 duplex full autoneg off
> > 
> > I did the same on the link partner, but I was still able to get link-up.
> > 
> 
> Your steps so far are correct. But I didn't do the same settings on the link
> partner. With other speeds (10M, 1G) I was seeing a link up without the need
> to force speed on the link partner side. So I was expecting the same with
> 100M as well.

This is not correct. If you turn autoneg off on one link partner, the
other link partner also must be forced, because it should not be able
to perform autoneg. Some PHYs will default to 10/Half when autoneg
fails, but as far as i'm known, that it not part of 802.3.

> > I'm not saying the bug isn't real, I mostly curious about the kind of
> > circumstances that causes this prblem to show-up. Do you have any
> > clarifications on that ?

Given the testing you have done, it seems to need an invalid
configuration?

> Also when I tried the same between DP83869 PHYs of two AM64x (TI DUTs) I
> couldn't see this issue. When I tried between DP83869 PHY and an external
> switch or PC I was able to reproduce this issue.

Did you force the switch to 100Full? Or was autoneg still enabled?

	Andrew

