Return-Path: <netdev+bounces-264393-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFqHGS6DqWkd9gAAu9opvQ
	(envelope-from <netdev+bounces-264393-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 14:20:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B502128C7
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 14:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 352B43015E32
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 13:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0794225A34;
	Thu,  5 Mar 2026 13:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Z7PFjdGz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A77221D96;
	Thu,  5 Mar 2026 13:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772716602; cv=none; b=PaFvWTXYbBLL+WCsJfkC7w9Cpaq5EO/BN1e+5oiEP6VjVHv3oi+K9Y0nVE/OTXDqodJMxiVOPNa5tkgrIRtIj/ltbo+kWwIK0KrdinNeIrS8thbxmaF/c/tWLlAgpc4/uj1brjVLNn5BGO7N0N720mNmRolGUZAIHqmnRZPFplc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772716602; c=relaxed/simple;
	bh=w/FlqKndC4YlkrRLz8Z0pjavoQTgik4NWBlf8NDImG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWEsksM90sDu2Dg51fqgTLQOb883iRCt08fKeoXenMrYAOcWyO51n6YlXtXfZmAOt1N8XJIiDxkNRrVpZJl/uXgwZ21ckeul1/2X9oLh7u2+BVwSSfTYcw7iLDAGOtmCrWTfGJfUGMa9CtvhjgACwTslmULBujWRA0s6SUS8dIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Z7PFjdGz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=12ucEdAFXfC6E20WpVMMZDujwQClNo1zj9TEZw+WEZQ=; b=Z7
	PFjdGzuNOxxgbi7rXc+QGGG1TooRwb7XHvOaOXpw/tlJOv5pAlEHE2vg3AYFGI6cK4gtTWDmL9vwV
	nr6rLbxAy3vyUsp42wOSZxCl6aUVnPdzotD8P/pf3Bk2t2+fzfVA9Mlnpw35GsxeCvAA9HXCd3cAi
	HRL5I4pGs2tstA8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vy8Yl-00AJih-0P; Thu, 05 Mar 2026 14:16:11 +0100
Date: Thu, 5 Mar 2026 14:16:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"taoren@meta.com" <taoren@meta.com>
Subject: Re: [PATCH net-next v6 5/5] ARM: dts: aspeed: ast2600-evb: Configure
 RGMII delay for MAC
Message-ID: <70ed84fd-ac9d-4157-ad20-36deec0c5f82@lunn.ch>
References: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>
 <20260302-rgmii_delay_2600-v6-5-68319a4c4110@aspeedtech.com>
 <d38f54b2-4a99-4a54-8403-e4f4a9704386@lunn.ch>
 <SEYPR06MB5134AE0B0042E05E8E58A5239D7DA@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SEYPR06MB5134AE0B0042E05E8E58A5239D7DA@SEYPR06MB5134.apcprd06.prod.outlook.com>
X-Rspamd-Queue-Id: B8B502128C7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264393-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.0:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,aspeedtech.com:email]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 05:05:03AM +0000, Jacky Chou wrote:
> Hi Andrew,
> 
> Thank you for yor reply.
> 
> > On Mon, Mar 02, 2026 at 06:24:32PM +0800, Jacky Chou wrote:
> > > This change sets the rx-internal-delay-ps and tx-internal-delay-ps
> > > properties to control the RGMII signal delay.
> > > The phy-mode for MAC0–MAC3 is updated to "rgmii-id" to enable TX/RX
> > > internal delay on the PHY and disable the corresponding delay on the
> > > MAC.
> > >
> > > Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> > > ---
> > >  arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts | 20
> > > ++++++++++++++++----
> > >  1 file changed, 16 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
> > > b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
> > > index 3f2ca9da0be2..a2a1c1dbb830 100644
> > > --- a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
> > > +++ b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
> > > @@ -123,42 +123,54 @@ ethphy3: ethernet-phy@0 {
> > >  &mac0 {
> > >  	status = "okay";
> > >
> > > -	phy-mode = "rgmii-rxid";
> > > +	phy-mode = "rgmii-id";
> > >  	phy-handle = <&ethphy0>;
> > >
> > >  	pinctrl-names = "default";
> > >  	pinctrl-0 = <&pinctrl_rgmii1_default>;
> > > +
> > > +	rx-internal-delay-ps = <0>;
> > > +	tx-internal-delay-ps = <0>;
> > 
> > In the binding, you said these default to 0. So you don't need them.
> > 
> > It is also odd that rgmii-rxid becomes rmgii-id, yet both delays are 0?
> > 
> > What was the bootloader doing? This is worth a comment in the commit
> > messages.
> > 
> 
> Before this patch, aspeed-ast2600-evb.dts is an existed old dts in mainline kernel.
> In this series, ftgmac100 for AST2600 will configure the MAC RGMII internal delay
> via SCU register, so this patch is changing this dts as a NEW dts for driver to configure
> RGMII delay from the properties of MAC nodes.
> 
> Old dts: generally, leak tx/rx-internal-delay-ps -> Calculate the RGMII delay that is configured
> from bootloader and decide whether keep the original value
> 
> New dts: In AST2600, we expect the MAC node includes the rx/tx-internal-delay-ns properties
> and the driver directly uses these properties to configure RGMII delay.

You did not answer my question...

> It is also odd that rgmii-rxid becomes rmgii-id, yet both delays are 0?

I could understand "rgmii" becoming "rgmii-id" with both delays being
0. But that is not what you have here. It is starting as
"rgmii-rxid". So the PHY is being asked to insert the RX delay, but
not the TX delay. Where is the TX delay coming from?

I assume the MAC? Has the bootloader configured the MAC to insert the
TX delay? But look at all the board vendors who have been submitting
DT patches, and i've been rejecting them. They all seem to use rgmii,
not rgmii-rxid.

Why is this different to all the other boards? This is what i would
like to see in the commit message, an explanation of this oddness.

> We hope this series can keep the old dts works fine

Hope is not sufficient. Backwards compatibility is required. You need
to convince the reviewer the code changes are backwards
compatible. You can use the commit messages and comments in the code
to explain how backwards compatibility is maintained, while adding
this new functionality.

And once you have convinced me, i will probably ask you to post the
changes to the BMC mailing list, and ask for a few board vendors to
test the patches with old DT blobs, current DT blobs and updated DT
blobs.

And this is why i think fixing the issue in the bootloader is
better. It is much easier to convince a reviewer the changes are
backwards compatible.

	Andrew

