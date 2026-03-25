Return-Path: <netdev+bounces-271585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJzAHPjzw2lZvAQAu9opvQ
	(envelope-from <netdev+bounces-271585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:40:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DDE326E93
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 49E59308668C
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 14:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF263E274F;
	Wed, 25 Mar 2026 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UDjn2G4M"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6943DD506
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 14:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774449449; cv=none; b=ir72Px1t9In139hr9Pd48q5Mai6dK9Zh+bJqgmd0h1P6Fhf1f8qHfuatvxcCxv+SeDOJA/wVJYZQzUSDBAoe935TA9zLEqBJK6GYwdXodxJfL6jN6Z79pf019WEKvJsj25yMRPIWecUGjokBBGmLDwhuSU10IMZhgza+2jNjpNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774449449; c=relaxed/simple;
	bh=ujhOZwbSzzOOvYmG+TOGPe3QUIrHOcld3yL6AWCpPJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNRN5CCvXmkoKenpNPOCV7sYvuduTQWwQZmxSKaD0Gd54LVT8D/zYYWmsCRgn+wOehoa8It9oFTbQyAdXzzCaSTar1KekJ++0shZaeAMCHVpjPEd5ARfz35AfEtFjzSE3f9yiVxMqh/C/7AUGeXMEYgwfJObs29o6Cw28jPyEu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=UDjn2G4M; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YTPjRKoJrKkPqSHoXxV1KY7bysIh/k+vDLIycJCoKm0=; b=UDjn2G4MWnqTw/9saQeG4R2X4w
	Q8wZPPKWwoYTc1cImSIed6YLreqhjOx0qDfayXXTxW9wndzSNNOwO5bGQmrnwtFfyIY5p3SryzsT1
	6ylGJ1gEW0LTva74Vg7c4ky9NaGEqEcMsHqZ0M9NoYYc62IiNCm2c3ccxrvFfMjPot+IUdLcvSsu8
	+kBXMkJ9DV827D3oKKYZMB8y5+9fSeRpiO3OwM6lCRj5egOvlbiwOUxVFEy5kf4hgEFzxHxxabtYW
	eDH5MqZVhcaGsX1c4klBvmiOgAeDpZcX+lP6GvRuUtHt5sjFqj7Tm2wIx1kNOOYGtRiY+Uo+h+gQX
	tWEkeopQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37058)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w5PMF-000000003W9-43fF;
	Wed, 25 Mar 2026 14:37:20 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w5PMC-0000000066Z-1aVs;
	Wed, 25 Mar 2026 14:37:16 +0000
Date: Wed, 25 Mar 2026 14:37:16 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCH] ptp: ocp: fix resource freeing order
Message-ID: <acPzHPYF8y2Vh1DT@shell.armlinux.org.uk>
References: <20260325120510.34481-1-vadim.fedorenko@linux.dev>
 <20260325122005.jvis4ydmogfkrxl7@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325122005.jvis4ydmogfkrxl7@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,lunn.ch,davemloft.net,redhat.com,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271585-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.960];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email,shell.armlinux.org.uk:mid,armlinux.org.uk:url]
X-Rspamd-Queue-Id: 14DDE326E93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 02:20:05PM +0200, Vladimir Oltean wrote:
> On Wed, Mar 25, 2026 at 12:05:10PM +0000, Vadim Fedorenko wrote:
> > Commit a60fc3294a37 ("ptp: rework ptp_clock_unregister() to disable
> > events") added a call to ptp_disable_all_events() which changes the
> > configuration of pins if they support EXTTS events. In ptp_ocp_detach()
> > pins resources are freed before ptp_clock_unregister() and it leads to
> > use-after-free during driver removal. Fix it by changing the order of
> > free/unregister calls.
> > 
> > Fixes: a60fc3294a37 ("ptp: rework ptp_clock_unregister() to disable events")
> > Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> > ---
> >  drivers/ptp/ptp_ocp.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> > index d88ab2f86b1b..16fd4804fc6a 100644
> > --- a/drivers/ptp/ptp_ocp.c
> > +++ b/drivers/ptp/ptp_ocp.c
> > @@ -4558,6 +4558,9 @@ ptp_ocp_detach(struct ptp_ocp *bp)
> >  	ptp_ocp_detach_sysfs(bp);
> >  	ptp_ocp_attr_group_del(bp);
> >  	timer_delete_sync(&bp->watchdog);
> > +	if (bp->ptp)
> > +		ptp_clock_unregister(bp->ptp);
> > +	kfree(bp->ptp_info.pin_config);
> >  	ptp_ocp_unregister_ext(bp->ts0);
> >  	ptp_ocp_unregister_ext(bp->ts1);
> >  	ptp_ocp_unregister_ext(bp->ts2);
> > @@ -4575,9 +4578,6 @@ ptp_ocp_detach(struct ptp_ocp *bp)
> >  		clk_hw_unregister_fixed_rate(bp->i2c_clk);
> >  	if (bp->n_irqs)
> >  		pci_free_irq_vectors(bp->pdev);
> > -	if (bp->ptp)
> > -		ptp_clock_unregister(bp->ptp);
> > -	kfree(bp->ptp_info.pin_config);
> >  	device_unregister(&bp->dev);
> >  }
> >  
> > -- 
> > 2.47.3
> >
> 
> The code wasn't safe even before the patch, since user space could have
> emitted a PTP ioctl that passed into the driver in between the
> ptp_ocp_unregister_ext() calls and the subsequent ptp_clock_unregister()
> call. It's just that the patch you blame made it more obvious.

Indeed.

We've been talking about "setup, then publish interfaces, unpublish
interfaces, tear down" for decades. I remember it coming up at the
Ottawa Linux Symposiums in the early 2000s when the driver model was
in its infancy. Yet, here we are in 2026, and the same problem
persists. :(

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

