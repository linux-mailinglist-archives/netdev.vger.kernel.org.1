Return-Path: <netdev+bounces-259314-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PTCFFvGlWmTUgIAu9opvQ
	(envelope-from <netdev+bounces-259314-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 15:02:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32191156F31
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 15:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 537B03003986
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 14:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DD9327202;
	Wed, 18 Feb 2026 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CyTIK6Jl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F7930DED7
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771423315; cv=none; b=f+vSbO9OlPOt6UrAM9l384L29mgBaJTqieJj5r4k+wq0ZLAhcQ6QvqdeB35P8qKT3f/+Sond4LEMLjYe5N4nuKVBLetQm2nHoUB1lz6/4Q385hQFbZX5Kmsn3BngovjsQJpQVVrT9i618wjwKt6uVg9558we4S6n50oERFljIZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771423315; c=relaxed/simple;
	bh=0LfMK+veG6/2bqbxvEgtF3WFbkTIjtAvYqjehEETSA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7lKNNQIIPiFheWSXSXcXYgtnqdYVfBdhP9hOsWGCWiG4kmsIbBbyy7FE8Zg58aPobW2jvq3AzYsNoglYPfpgN0LXWi4wltisFx+ppRAfSSIn5eokaAwtAxwuyQpocGLRwEZYrWdyW5PvKnkT2GnkI25kaEtO/meA07P7ue9gPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CyTIK6Jl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SJahCvOd0XzFSW4MYnoIoXi1KFrQLDHZQFJVqw46QAw=; b=CyTIK6JlD+GHe8KyfidyPULr41
	5pEd2k7WL+DpD5pc+J4XlA7oAcH5y+gVwd+ym5zFyVGUTlq5AvhUoT797DKhyMSvidEg6IKgN7p+K
	Fh4Dq7QzF7lVPmOQB5mrd/kfthlVAv4u4qIR4yKP2lvjxHrCHTsJvIw6Joyubn/1ry/E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vsi7g-007lwc-W7; Wed, 18 Feb 2026 15:01:49 +0100
Date: Wed, 18 Feb 2026 15:01:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oliver Neukum <oneukum@suse.com>
Cc: netdev@vger.kernel.org, hayeswang@realtek.com, bjorn@mork.no,
	o.rempel@pengutronix.de, Oliver Neukum <oneukum@suse.de>
Subject: Re: [RFC net-next 2/3] net: usb: usbnet: switch to dynamic
 allocation of private data
Message-ID: <d72011ec-4c44-438c-8354-10b8493b2fbd@lunn.ch>
References: <20260210151416.42254-1-oneukum@suse.com>
 <20260210151416.42254-3-oneukum@suse.com>
 <8d1bf5ab-f154-4e64-84a2-929d06fb4e6e@lunn.ch>
 <9256ed08-d7c9-491a-be37-afb4d245e4c0@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9256ed08-d7c9-491a-be37-afb4d245e4c0@suse.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[lunn.ch:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259314-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 32191156F31
X-Rspamd-Action: no action

> > > @@ -107,7 +107,7 @@ static void cdc_ncm_get_ethtool_stats(struct net_device *netdev,
> > >   				    u64 *data)
> > >   {
> > >   	struct usbnet *dev = netdev_priv(netdev);
> > > -	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
> > > +	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private;
> > 
> > But it is not clear why changes like this belong on this patch. Can
> > they be moved into another patch with a good commit message?
> 
> I don't think so. dev->private[0] is an unsigned long
> dev->private is unsigned long *
> 
> This driver uses the provided scratchpad to store a pointer.
> If you want me to leave these lines unchanged I'd need to add
> a required_room member of "sizeof(void *)" to the driver_info
> of this driver, which really makes no sense.

I'm not asking for it to be left unchanged. I'm asking, can this
change be done as a different patch? With a commit message which
explains the change.

Adding usbnet_priv() might help here. Look at netdev_priv().

struct net_device has

	u8			priv[] ____cacheline_aligned
				       __counted_by(priv_len);

so it is not that different to what struct usbnet has, just u8 vs
unsigned long.

static inline void *netdev_priv(const struct net_device *dev)
{
	return (void *)dev->priv;
}

usbnet_priv() could do something similar. The initial version would
return the address of the unsigned long [5] as a void *. You can have
one patch which then converts all "simple" users to using
usbnet_priv(). And a second patch, with a good commit message,
converting these dev->private[0]. At this point, you have not actually
changed anything with the memory allocation, you have just added an
access wrapper. You can then change to dynamically allocating the
memory of a requested size, and update the wrapper to suit.

Doing it like this should make it possible to break the change up into
smaller, more obviously correct patches.

> > > @@ -1511,7 +1511,7 @@ static void smsc75xx_unbind(struct usbnet *dev, struct usb_interface *intf)
> > >   		cancel_work_sync(&pdata->set_multicast);
> > >   		netif_dbg(dev, ifdown, dev->net, "free pdata\n");
> > >   		kfree(pdata);
> > > -		memset(dev->private, 0, sizeof(dev->private));
> > > +		memset(dev->private, 0, sizeof(struct smsc75xx_priv *));
> > 
> > These also might need investigating. Why is it necessary to memset
> > this memory? Has the life cycle of the memory changed? Can these be
> > removed? Again, a separate patch, with a good commit message
> > explaining why?
> 
> Well, now I need you to kind of make up your mind.

The assumption is, dev->private as unsigned long [5] is big enough to
hold a struct smsc75xx_priv. This is true before or after the change
to dynamically allocating the memory. So this memset change could
happen before you change to dynamically allocating the memory. So you
could make this an patch, with a commit message something like:

  dev->private will soon change from being a fix sized array to
  dynamically allocated memory of requested size. This means
  sizeof(dev->priv) will no longer work. However, it is known that it
  will always be big enough to contain a struct smsc75xx_priv. So it
  is safe to just memset the size of struct smsc75xx_priv.

A two line patch, with a commit message like this is quick and simple
to review, since it is obviously correct.

	Andrew

