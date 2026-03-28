Return-Path: <netdev+bounces-272752-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKbCEKWOx2k0ZAUAu9opvQ
	(envelope-from <netdev+bounces-272752-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 09:17:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E58C34DCA5
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 09:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC250302BA7C
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 08:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79B426158C;
	Sat, 28 Mar 2026 08:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mmpsystems.pl header.i=@mmpsystems.pl header.b="t6UKIqEK"
X-Original-To: netdev@vger.kernel.org
Received: from s106b.cyber-folks.pl (s106b.cyber-folks.pl [195.78.66.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8F22376FD;
	Sat, 28 Mar 2026 08:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.78.66.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774685856; cv=none; b=Qbj/EGpWmk1//WazTk5IvJI5qaYu41WyPKGsK1nDwTgf1TJCSDfhEqZS5GDuRooo1w4ovtmjtyEmTjNjfCKAjRCP2LGxi+s/vn5xPe2uclsSwkJDoQ0dbW1caOd1c9IXQpKdTjJyp3qTY1F2giNgF6B1MGlgNIFVNYpsZqV2vf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774685856; c=relaxed/simple;
	bh=ZDHz9uPP8pqI/sNXlxqRQs9YEhFvQM4pMG0G0GmIMJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nunvRkcdkBC0r/NHQBqHt2CKHBnewW1fTr8+NUfym8trKFHSkt3bnRqiGMoV81/0yq6kT57qVE7P8hKGXWs3NhXEFGFl1gEz910xkjUA/1h4eN+VNgijr97kALLsbXesfrjAzaCAWT/Ml3lO+vMCWD1JmpxT8YgOiUwafBLTdPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mmpsystems.pl; spf=pass smtp.mailfrom=mmpsystems.pl; dkim=pass (2048-bit key) header.d=mmpsystems.pl header.i=@mmpsystems.pl header.b=t6UKIqEK; arc=none smtp.client-ip=195.78.66.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mmpsystems.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mmpsystems.pl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mmpsystems.pl; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ejJZ2msrybPfriDsCgcnWyd7Z8ZISOT5WUkjT8Zg0gg=; b=t6UKIqEKEe0xdQ4e6+tsd6DeSR
	NBT4of6c00PndbkeLeMSBHo8y5rTdNHleSCIjDcpvUdqjLggks7OJEh95Hj6onI1lPuXAPo1p6fO2
	ftDKcVenb368/7W2sN6mhs6yDFil5eeg39VWit8dkXUBGqRjhohyP+FMmVJtzaB+OfbPAjFeVfuCT
	mpvhndZjApCMqhnhiX80x3gD9yLW4/cZTCRejqcpl1JBy87uV8tuIfPR6YsgW/zBdMWy63YjMEXY+
	JnqkuKQIExZlygJ1nYyiwHB4og6EGP3zr6VTsmb13kImgTqe0LafJnsmGyejL8DthLmgiiGft/8Wd
	Jop/neCQ==;
Received: from user-5-173-16-20.play-internet.pl ([5.173.16.20] helo=localhost)
	by s106.cyber-folks.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <michal.piekos@mmpsystems.pl>)
	id 1w6OrK-00000001FqP-2Oxh;
	Sat, 28 Mar 2026 09:17:30 +0100
Date: Sat, 28 Mar 2026 09:17:23 +0100
From: Michal Piekos <michal.piekos@mmpsystems.pl>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: stmmac: skip VLAN restore when VLAN hash ops are
 missing
Message-ID: <d3nc2eqhedz6ygstu76cgj2dghkoiod5dnamdwqpvoe3vajndq@ewqtagfgkfzd>
References: <20260328-vlan-restore-error-v3-1-df47a039c6f6@mmpsystems.pl>
 <aceIeFWGAZwr1njk@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aceIeFWGAZwr1njk@shell.armlinux.org.uk>
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
	TAGGED_FROM(0.00)[bounces-272752-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mmpsystems.pl:-];
	NEURAL_HAM(-0.00)[-0.565];
	FROM_NEQ_ENVFROM(0.00)[michal.piekos@mmpsystems.pl,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,renesas.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mmpsystems.pl:email]
X-Rspamd-Queue-Id: 9E58C34DCA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 28, 2026 at 07:51:20AM +0000, Russell King (Oracle) wrote:
> On Sat, Mar 28, 2026 at 07:51:53AM +0100, Michal Piekos wrote:
> > stmmac_vlan_restore() unconditionally calls stmmac_vlan_update() when
> > NETIF_F_VLAN_FEATURES is set. On platforms where priv->hw->vlan (or
> > ->update_vlan_hash) is not provided, stmmac_update_vlan_hash() returns
> > -EINVAL via stmmac_do_void_callback(), resulting in a spurious
> > "Failed to restore VLANs" error even when no VLAN filtering is in use.
> > 
> > Remove the unneeded comment.
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
> > Changes in v3:
> > - Remove the offending comment
> > - Restore the original check for NETIF_F_VLAN_FEATURES
> > - Link to v2: https://lore.kernel.org/r/20260321-vlan-restore-error-v2-1-45cf56a5223d@mmpsystems.pl
> > 
> > Changes in v2:
> > - Replace check for hash ops with check for HW FILTER flags
> > - Link to v1: https://lore.kernel.org/r/20260314-vlan-restore-error-v1-1-4fc6c3e2115f@mmpsystems.pl
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 6827c99bde8c..0f3e5ac05faa 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -6861,19 +6861,13 @@ static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vi
> >  
> >  static int stmmac_vlan_restore(struct stmmac_priv *priv)
> >  {
> > -	int ret;
> > -
> >  	if (!(priv->dev->features & NETIF_F_VLAN_FEATURES))
> >  		return 0;
> >  
> >  	if (priv->hw->num_vlan)
> >  		stmmac_restore_hw_vlan_rx_fltr(priv, priv->dev, priv->hw);
> >  
> > -	ret = stmmac_vlan_update(priv, priv->num_double_vlans);
> > -	if (ret)
> > -		netdev_err(priv->dev, "Failed to restore VLANs\n");
> > -
> > -	return ret;
> > +	return stmmac_vlan_update(priv, priv->num_double_vlans);
> >  }
> 
> Yes, but as both Andrew and myself have pointed out, no one checks
> the return value of stmmac_vlan_restore(), so why does it return
> int?

Was too quick with the patch. Will spin another version.

Michal
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

