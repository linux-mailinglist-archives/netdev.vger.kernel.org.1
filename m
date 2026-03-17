Return-Path: <netdev+bounces-268602-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAlKGyRTuWnYAgIAu9opvQ
	(envelope-from <netdev+bounces-268602-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 14:12:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE30F2AA977
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 14:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83BFB30A4142
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1518A3C343F;
	Tue, 17 Mar 2026 13:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mmpsystems.pl header.i=@mmpsystems.pl header.b="rYLR2K1l"
X-Original-To: netdev@vger.kernel.org
Received: from s106b.cyber-folks.pl (s106b.cyber-folks.pl [195.78.66.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CBC3ACA5A;
	Tue, 17 Mar 2026 13:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.78.66.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752751; cv=none; b=CNTreOuR0f6QxvFc8iJo53dEttJkwe1newoy7qX6fQ05eWBtDe0C4kWdr36ZDG3iyWdaFIG+N0XzOx4UsI6bjtDiH+jQnRWFYSGvK82XFJsVIFBppM43Y4S2u8qBeGVNbl3/8/rXWei8dLroPwCOA1SoGFMowDB8S9jTJtuW2kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752751; c=relaxed/simple;
	bh=XE6Ux2I7E4pXafy0WPNqyk6pN9CCnzgu1uXic9ZHdSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFnItZ48dndj2wXzr1KpEzl8fyQ8MmgCtK6wdjJoRm+KFHgAsrOERl0hwe+T7m+C+ADCdwhAXKTMO7oBWZ6oBorILFG3CllcvwJGwQErHJRYuQxRi66erCc1thZftBKjsjJ/KOrb70pKf8Fbb004gliV2t2TqUitHy1hRmCcNYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mmpsystems.pl; spf=pass smtp.mailfrom=mmpsystems.pl; dkim=pass (2048-bit key) header.d=mmpsystems.pl header.i=@mmpsystems.pl header.b=rYLR2K1l; arc=none smtp.client-ip=195.78.66.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mmpsystems.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mmpsystems.pl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mmpsystems.pl; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1LeDQMyH2RycDF+8KnCGFkEFqzlWBy52GMaL6I3Md0E=; b=rYLR2K1lFK/0FJ4Mnf0QAtzzMB
	rRRY7w1bbN6NLsHAc4gSIgEJ09Sh508RhXb71uy1KVBXSXzf2C0f2SQ6NDhi3vJAsCHFgtmMKALT8
	RSsAzUr7+mMqOy2UoC/wVrNm9Rc2oLbrwn5nlAh/h5ttFMEjNOl06SAvb/u9anwW7VachNIfTOJ/r
	fVaYss9HQy8BiWIxPDumckhnbY+09PvmlNMm8KfbbHc4KHFx72cg+hqrqJyzNuakr40SU5AlrV5Nd
	eBCkxmlPnCwRtox8jd+HBElM1qmILB/yflF/tJwx72kWZOQmIU9y1UrDldLXCl7e9Tkj8AT8szqWO
	qGgGYs0Q==;
Received: from user-5-173-16-20.play-internet.pl ([5.173.16.20] helo=localhost)
	by s106.cyber-folks.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <michal.piekos@mmpsystems.pl>)
	id 1w2U7F-00000000foh-0Rg0;
	Tue, 17 Mar 2026 14:05:45 +0100
Date: Tue, 17 Mar 2026 14:05:00 +0100
From: Michal Piekos <michal.piekos@mmpsystems.pl>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: stmmac: skip VLAN restore when VLAN hash ops are
 missing
Message-ID: <6wr4v36ijdwlh4q6wiwki42qdjwsjoif7l47mu2df6npi42vrx@scd7zbgb4dml>
References: <20260314-vlan-restore-error-v1-1-4fc6c3e2115f@mmpsystems.pl>
 <TY7P301MB1984C5D71A81DFE5E8EC94D4D341A@TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY7P301MB1984C5D71A81DFE5E8EC94D4D341A@TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM>
X-Authenticated-Id: michal.piekos@mmpsystems.pl
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[mmpsystems.pl:s=x];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[mmpsystems.pl : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268602-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michal.piekos@mmpsystems.pl,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mmpsystems.pl:-];
	NEURAL_HAM(-0.00)[-0.724];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mmpsystems.pl:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE30F2AA977
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 12:36:42PM +0000, Ovidiu Panait wrote:
> Hi Michal,
> 
> > stmmac_vlan_restore() unconditionally calls stmmac_vlan_update() when
> > NETIF_F_VLAN_FEATURES is set. On platforms where priv->hw->vlan (or
> > ->update_vlan_hash) is not provided, stmmac_update_vlan_hash() returns
> > -EINVAL via stmmac_do_void_callback(), resulting in a spurious
> > "Failed to restore VLANs" error even when no VLAN filtering is in use.
> > 
> > Check presence of VLAN hash ops before stmmac_vlan_update().
> > 
> > Fixes: bd7ad51253a7 ("net: stmmac: Fix VLAN HW state restore")
> > Signed-off-by: Michal Piekos <michal.piekos@mmpsystems.pl>
> > ---
> > This patch fixes a noisy "Failed to restore VLANs" message on platforms
> > where stmmac VLAN hash ops are not implemented.
> > stmmac_vlan_restore() calls stmmac_vlan_update() without checking for
> > VLAN hash ops presence which results in -EINVAL.
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 6827c99bde8c..bc09439ec00b 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -6869,6 +6869,9 @@ static int stmmac_vlan_restore(struct stmmac_priv
> > *priv)
> >         if (priv->hw->num_vlan)
> >                 stmmac_restore_hw_vlan_rx_fltr(priv, priv->dev, priv->hw);
> > 
> > +       if (!priv->hw->vlan || !priv->hw->vlan->update_vlan_hash)
> > +               return 0;
> > +
> 
> The stmmac_restore_hw_vlan_rx_fltr() call above also goes through the
> priv->hw->vlan pointer, so maybe for consistency, the check for empty
> VLAN ops should be made at the top of the function.
> 
> Another alternative would be to replace the NETIF_F_VLAN_FEATURES check
> at the top of stmmac_vlan_update() function to check if VLAN HW filtering
> is supported instead (NETIF_F_HW_VLAN_CTAG_FILTER and
> NETIF_F_HW_VLAN_STAG_FILTER).
> 
> The restore only deals with the HW filters anyway and the vlan ops are
> always defined in that case (stmmac_vlan_rx_add_vid() and
> stmmac_vlan_rx_kill_vid() rely on this being true as well, as they also
> call stmmac_vlan_update() unconditionally).
> 
> Ovidiu

Thank you for the comment. 
Your suggested solution to check VLAN HW filtering flags is much better.
I'll go for it for v2.

Michal

> 
> >         ret = stmmac_vlan_update(priv, priv->num_double_vlans);
> >         if (ret)
> >                 netdev_err(priv->dev, "Failed to restore VLANs\n");
> > 
> > ---
> > base-commit: 1c9982b4961334c1edb0745a04cabd34bc2de675
> > change-id: 20260314-vlan-restore-error-f8b3a1c7f50a
> > 
> > Best regards,
> > --
> > Michal Piekos <michal.piekos@mmpsystems.pl>
> 

