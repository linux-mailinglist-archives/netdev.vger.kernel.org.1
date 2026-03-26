Return-Path: <netdev+bounces-271985-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gElrGykXxWnr6QQAu9opvQ
	(envelope-from <netdev+bounces-271985-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:23:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C007A334658
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C04763008206
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB5B346E5E;
	Thu, 26 Mar 2026 11:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mmpsystems.pl header.i=@mmpsystems.pl header.b="xW/QOBAp"
X-Original-To: netdev@vger.kernel.org
Received: from s106b.cyber-folks.pl (s106b.cyber-folks.pl [195.78.66.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9175E34E768;
	Thu, 26 Mar 2026 11:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.78.66.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774523741; cv=none; b=TzuAGeFEav7rWTf3B/sBf0W1ewQYLPFH1IioPIuaVKxAws90B6URPYB5yRjhwpPd8/99woI57rL9etfj0utHT4xHCAFw66l8c3gC5gdZ0JH7BzSE7ET08VXKn2sZGHyuccu0zW+pbTmF7cvhd85lQp0+abZAzrU0KzGEmNtdtgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774523741; c=relaxed/simple;
	bh=mR/kvvFFzm3z7f5VgS/15AS/3++gtgDHcsLPFvzWnHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svalUnrYADUjV/OKkUeYY0kgszXKcHuZSccmTsEs7JLAOXK9fNAadTRPAJfxTmceQqwhRoLkoLVviNkm0nXcgCOvQKJDr5H8rmjvj8IG20vSiTu+yLIUwUiGGwsH3uHG2WS+dcpVro1cUB4SseraWrJedvCAD12UxFQxqPwk0Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mmpsystems.pl; spf=pass smtp.mailfrom=mmpsystems.pl; dkim=pass (2048-bit key) header.d=mmpsystems.pl header.i=@mmpsystems.pl header.b=xW/QOBAp; arc=none smtp.client-ip=195.78.66.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mmpsystems.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mmpsystems.pl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mmpsystems.pl; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DH6OZbGLz6JBjk1mkEJ81mLvO4rTm1UWMB27HtaTvcM=; b=xW/QOBApGKxhjAHWxrKhsO4paW
	xK89CYlamTAn1AP6eLV9cfTVNJI/ewzZy4wSLYyakacZky5MH/QjCd+aKaHQx3a/Z/96yfR2syCNf
	P7Cx+SApeqNc8KkuiEUlIqS+R3iXol9E9BdXOjbht4BGl5zgx7C4J+ncxsMCrBjxcgmQxVoIMCy8O
	bmV29jQB6/srewPeRNWQ2iusgKWNQnulKaLN4O6Qqy6Jipt82HSlULinu1fjin3ig1Bef4/90SKCV
	Vuy5IGxBRdNgfYPJr7LNDBpXhCL7zIPubChZXshfZ9GXodTgobhevtupjsvNn+LWl+JYpjAcoyUPY
	P37m3+bQ==;
Received: from user-5-173-16-20.play-internet.pl ([5.173.16.20] helo=localhost)
	by s106.cyber-folks.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <michal.piekos@mmpsystems.pl>)
	id 1w5igY-00000000ajn-1kSH;
	Thu, 26 Mar 2026 12:15:34 +0100
Date: Thu, 26 Mar 2026 12:14:44 +0100
From: Michal Piekos <michal.piekos@mmpsystems.pl>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] net: stmmac: skip VLAN restore when VLAN hash ops are
 missing
Message-ID: <lhlghwdoe6o7eecxpgbnv3e5nb7n2snk6jd6fn4wbolbqwjax4@czydhov4pv4s>
References: <20260321-vlan-restore-error-v2-1-45cf56a5223d@mmpsystems.pl>
 <abb1c779-b306-42f8-b2b1-aa56bfcebe1b@bootlin.com>
 <TY7P301MB198407F8C0280B991334304ED356A@TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY7P301MB198407F8C0280B991334304ED356A@TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM>
X-Authenticated-Id: michal.piekos@mmpsystems.pl
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[mmpsystems.pl:s=x];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[mmpsystems.pl : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271985-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[bootlin.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michal.piekos@mmpsystems.pl,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mmpsystems.pl:-];
	NEURAL_HAM(-0.00)[-0.960];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mmpsystems.pl:email]
X-Rspamd-Queue-Id: C007A334658
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 08:07:33AM +0000, Ovidiu Panait wrote:
> Hi,
> 
> > 
> > Hi,
> > 
> > On 21/03/2026 06:38, Michal Piekos wrote:
> > > stmmac_vlan_restore() unconditionally calls stmmac_vlan_update() when
> > > NETIF_F_VLAN_FEATURES is set. On platforms where priv->hw->vlan (or
> > > ->update_vlan_hash) is not provided, stmmac_update_vlan_hash() returns
> > > -EINVAL via stmmac_do_void_callback(), resulting in a spurious
> > > "Failed to restore VLANs" error even when no VLAN filtering is in use.
> > >
> > > Check presence of VLAN HW FILTER flags before stmmac_vlan_update().
> > >
> > > Tested on Orange Pi Zero 3.
> > >
> > > Fixes: bd7ad51253a7 ("net: stmmac: Fix VLAN HW state restore")
> > > Signed-off-by: Michal Piekos <michal.piekos@mmpsystems.pl>
> > > ---
> > > This patch fixes a noisy "Failed to restore VLANs" message on platforms
> > > where stmmac VLAN hash ops are not implemented.
> > > stmmac_vlan_restore() calls stmmac_vlan_update() without checking for
> > > VLAN hash ops presence which results in -EINVAL.
> > 
> > I've been seeing the same message on socfpga. My two cents on that is
> > that this error messages doesn't bring anything to the table anyways.
> > 
> > As Russell explains, it's either triggered when the vlan op isn't
> > implemented (the stmmac callback macro stuff turns that into a -EINVAL),
> > or when some capabilities arent present. All in all, it's always stuff
> > that users can't really do anything about, as it's HW limitations, I
> > think we can simply discard this message.
> > 
> > Also, nothing actually checks what stmmac_vlan_restore() returns, so we
> > might as well return void ?
> > 
> 
> I think this is the best solution until the VLAN capabilities handling is
> cleaned up.
> 
> Michal, please let me know if you will be handling this in v3 or I should
> send a fix for it.
> 

I will provide the fix for it latest during the weekend.

Michal

> Thanks,
> Ovidiu
> 
> > Maxime
> > 
> > > ---
> > > Changes in v2:
> > > - Replace check for hash ops with check for HW FILTER flags
> > > - Link to v1: https://lore.kernel.org/r/20260314-vlan-restore-error-v1-
> > 1-4fc6c3e2115f@mmpsystems.pl
> > > ---
> > >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > index 6827c99bde8c..cfc0ce9cec9c 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > @@ -6863,7 +6863,8 @@ static int stmmac_vlan_restore(struct stmmac_priv
> > *priv)
> > >  {
> > >  	int ret;
> > >
> > > -	if (!(priv->dev->features & NETIF_F_VLAN_FEATURES))
> > > +	if (!(priv->dev->features &
> > > +	      (NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_VLAN_STAG_FILTER)))
> > >  		return 0;
> > >
> > >  	if (priv->hw->num_vlan)
> > >
> > > ---
> > > base-commit: 42bddab0563fe67882b2722620a66dd98c8dbf33
> > > change-id: 20260314-vlan-restore-error-f8b3a1c7f50a
> > >
> > > Best regards,
> 

