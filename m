Return-Path: <netdev+bounces-271064-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHCtMZqPwmn/ewQAu9opvQ
	(envelope-from <netdev+bounces-271064-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:20:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DB29B3093D7
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 28DD13046623
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B003BC680;
	Tue, 24 Mar 2026 13:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JO4krb76"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1420390999;
	Tue, 24 Mar 2026 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774357491; cv=none; b=XR+dCsOJdZRid3Q93snFxQlFShS+rBsDvKuBQeHMr7tTKU0QSnvs1aPPwvHU28LAoVOuOT3rinQPkz5TnQNyASnFnqfXp8TBtrO85egzZQoj63rFwsd37LsUKJJmhwBA7mY58z7ma19N6jTwZbvxyQFosxaHKA7ucFEq1l/B3jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774357491; c=relaxed/simple;
	bh=Sj+d5N6JtCmiB6OYc3c9qCEma5tAXaqtiZ+NbtcW0HI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJ+iWoyLyobzDx0ikQfTB/bWD5PIpRhDVeLYcurxnuWMkR42vVb4oOH6ygAlDVH3slodxBBtiZqTm/hz9hpCMWSGsSBpp//GS+/ocU/UVhTwFHtAZOAK2mcb4kxgIMDDGrzk1fKVNBIGk0WgbBged8eypxj4+Pxynwhlb3aiAPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=JO4krb76; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WN2wTNGMgM5bYbRGfOQZgYj/JyTydD59C5V7z3tIw28=; b=JO4krb767LEVW4/gzQbytGjPP0
	FIMh0JO+ZsFiQqlgXLpEQXy+eQz2g1WGOjXNbzS/NKmGHCMkdlLFXkjvL60PFC3f/G9a6py6A95Gm
	96ru2QzKxJQQS/k6iUDn7Dg3FxM7m8nYjcTRlIb3HuBYR6O3quUUlNs2OW2TrV6WAFJjPQ2+2Q0bT
	mmgDDxr+rwB2aMz/UIIRPsLkxdp5Zpx7UZbRIJm20tcHSeOK7cIbnHJoqGQwKSh2lVbAUpgMCEM/Q
	QUsRNCxtLrGZ/884HjkfwvmSZ7+VurZEZR6m0RiLmmeUrmXRsh8T2Gnvr44ouJMTk87XQFyG67lKP
	1fXJtbMQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38946)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w51Qz-0000000021Z-0snn;
	Tue, 24 Mar 2026 13:04:37 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w51Qw-00000000558-0Eg7;
	Tue, 24 Mar 2026 13:04:34 +0000
Date: Tue, 24 Mar 2026 13:04:33 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Paolo Abeni <pabeni@redhat.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: Michal Piekos <michal.piekos@mmpsystems.pl>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: stmmac: skip VLAN restore when VLAN hash ops are
 missing
Message-ID: <acKL4RoM-zdwj1Ib@shell.armlinux.org.uk>
References: <20260321-vlan-restore-error-v2-1-45cf56a5223d@mmpsystems.pl>
 <5e5706bb-0f04-4bb1-94f4-45083a3c76fd@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e5706bb-0f04-4bb1-94f4-45083a3c76fd@redhat.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271064-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[mmpsystems.pl,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.942];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mmpsystems.pl:email,renesas.com:email,shell.armlinux.org.uk:mid,armlinux.org.uk:url]
X-Rspamd-Queue-Id: DB29B3093D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 01:14:29PM +0100, Paolo Abeni wrote:
> On 3/21/26 6:38 AM, Michal Piekos wrote:
> > stmmac_vlan_restore() unconditionally calls stmmac_vlan_update() when
> > NETIF_F_VLAN_FEATURES is set. On platforms where priv->hw->vlan (or
> > ->update_vlan_hash) is not provided, stmmac_update_vlan_hash() returns
> > -EINVAL via stmmac_do_void_callback(), resulting in a spurious
> > "Failed to restore VLANs" error even when no VLAN filtering is in use.
> > 
> > Check presence of VLAN HW FILTER flags before stmmac_vlan_update().
> > 
> > Tested on Orange Pi Zero 3.
> > 
> > Fixes: bd7ad51253a7 ("net: stmmac: Fix VLAN HW state restore")
> > Signed-off-by: Michal Piekos <michal.piekos@mmpsystems.pl>
> > ---
> > This patch fixes a noisy "Failed to restore VLANs" message on platforms
> > where stmmac VLAN hash ops are not implemented.
> > stmmac_vlan_restore() calls stmmac_vlan_update() without checking for
> > VLAN hash ops presence which results in -EINVAL. 
> > ---
> > Changes in v2:
> > - Replace check for hash ops with check for HW FILTER flags
> > - Link to v1: https://lore.kernel.org/r/20260314-vlan-restore-error-v1-1-4fc6c3e2115f@mmpsystems.pl
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 6827c99bde8c..cfc0ce9cec9c 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -6863,7 +6863,8 @@ static int stmmac_vlan_restore(struct stmmac_priv *priv)
> >  {
> >  	int ret;
> >  
> > -	if (!(priv->dev->features & NETIF_F_VLAN_FEATURES))
> > +	if (!(priv->dev->features &
> > +	      (NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_VLAN_STAG_FILTER)))
> >  		return 0;
> >  
> >  	if (priv->hw->num_vlan)
> Adding Russell.
> 
> It's not obvious to me that with this change the
> restore_hw_vlan_rx_fltr() and vlan_update() callback are still invoked
> in all the relevant driver/features permutation.

I think there's a few questions here.

When CONFIG_VLAN_8021Q is enabled, then we set the filter features
if the vlhash dma capability is set:

        if (priv->dma_cap.vlhash) {
                ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
                ndev->features |= NETIF_F_HW_VLAN_STAG_FILTER;
        }

Only dwmac4 and dwxgmac2 have the ability to set this feature (and
thus be synthesised with the feature enabled.) From what I understand,
when present, these features are permanently enabled (as they're not
set in hw_Features).

However, in stmmac_vlan_update() there is:

        if (!priv->dma_cap.vlhash) {
                if (count > 2) /* VID = 0 always passes filter */
                        return -EOPNOTSUPP;

                pmatch = vid;
                hash = 0;
        }

So, it is clear that the intention is that stmmac_vlan_update() will
be called even when the NETIF_F_HW_VLAN_*TAG_FILTER features are not
present - consider a core that implements the VLAN ops, but has
priv->dma_cap.vlhash false.

It looks like vlan support was added in dwmac v4.0 and later cores
(from the hwif table.) As the vlan ops are NULL before that, the
horrid stmmac_do_void_callback() crud will return -EINVAL (yuck). The
method it calls is a void function, so the only possible return values
are zero if implemented, or -EINVAL if not.

stmmac_vlan_update() itself only ever returns zero if the netif
isn't running, or the above return value. So, an error returned from
stmmac_vlan_update() just means that the driver has no support for
programming the vlan configuration.

Looking at the implementations for the case where vlhash is false,
(where stmmac_update_vlan_hash() will be called with hash=0 and
perfect_match with a vid, vlan_update_hash() still write
to the VLAN_TAG register to configure vlan handling. I haven't
looked up exactly what it does.

The other possibility is dwxgmac2_update_vlan_hash(). This looks
similar.

So, I don't think that the correct solution is to only call this
function when one or more of NETIF_F_HW_VLAN_*TAG_FILTER feature flags
are set - clearly the code is written to handle the case where the
update_vlan_hash method is populated but vlhash is false and these
feature flags are clear.

Now I'm wondering whether the code in the STMMAC_VLAN_TAG_USED block
is correct:

        /* Both mac100 and gmac support receive VLAN tag detection */
        ndev->features |= NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_STAG_RX;
        if (dwmac_is_xmac(priv->plat->core_type)) {
                ndev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX;
                priv->hw->hw_vlan_en = true;
        }
        if (priv->dma_cap.vlhash) {
                ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
                ndev->features |= NETIF_F_HW_VLAN_STAG_FILTER;
        }
        if (priv->dma_cap.vlins)
                ndev->features |= NETIF_F_HW_VLAN_CTAG_TX;

The test for dwmac_is_xmac() matches for dwmac4 and dwxgmac cores. If
this is true, then we will have the vlan ops populated, and it means
that NETIF_F_HW_VLAN_CTAG_RX can be configured by the user rather than
being always-enabled. Is this correct? I'm not sure - I haven't dug
into enough of the documentation for this yet. However, I suggest
that we need to always call stmmac_update_vlan_hash() for these cores.

So, I'm coming to the conclusion that we either need a test for
dwmac_is_xmac() and not the feature flags, or maybe we just get rid
of the "Failed to restore VLANs" error print and make
stmmac_vlan_restore() return void (nothing uses the return value.)

In summary, I'm not sure what the correct approach is - please reach
out to Ovidiu Panait <ovidiu.panait.rb@renesas.com> who recently added
this code, but I'm fairly sure that this solution is incorrect.

Really, Ovidiu Panait should be reviewing this patch as his recent
change introduced the problematical error print.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

