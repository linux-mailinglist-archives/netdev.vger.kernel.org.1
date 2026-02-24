Return-Path: <netdev+bounces-260347-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CMtEblCnWkMOAQAu9opvQ
	(envelope-from <netdev+bounces-260347-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 07:18:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D91F41825D2
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 07:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E1B5301A2F2
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 06:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3F42DAFDE;
	Tue, 24 Feb 2026 06:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fhzKRuEC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD8F2D29C8;
	Tue, 24 Feb 2026 06:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771913908; cv=none; b=bWm1OB8jTaQGnBkbeuWWPbp3pDZVXQHGAK7VXVlBh/iXpd1PMmvIc/NglF0LUYEJ42wtK1ee9NQxCKo63d8o2VG4MJ9w0VpqAvvP9QF98tBUrlM79RkFLLHUJTjwZDAZAhPrIFM9F+c4bwIayIAnOSQLx2gkhMFMj5EBD3cTOMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771913908; c=relaxed/simple;
	bh=5so+i5TN5Ymsq487c5z6Ijr+l+6Z2GTD9oU+kbQIeEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+mOlhAC3ZQSNuz/qxYzBt4yf/8F0cBz5uFtoZQXohTUVKgG04WZ/Objb1MHwtWQsrMF5snsjS/gZ5MmT7671TMlMPWjCvut0Gkm0vd8DnWLi/CjBOlwwVtSiEw9ddTm7CKZr5Il4w9DKAFHGs/9BzjmKVloYbSHJDl5tJoCHto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fhzKRuEC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF153C116D0;
	Tue, 24 Feb 2026 06:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771913908;
	bh=5so+i5TN5Ymsq487c5z6Ijr+l+6Z2GTD9oU+kbQIeEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fhzKRuECtoQuaS+tRitj2dpRYazlKfn58FqkpuO9wHfa7Td6kIBUNVg5+7Cq+I1jF
	 NDIZF1JOAU56HcsFFl8rJX/EULTS4FLZtCFxRYP23xw3Qt6J0I0a5nV2mN7cEVlU20
	 Ad2tJ5SgJDSdA+3zmpdcDs8m0j6A1JxHQxS7K7WE=
Date: Mon, 23 Feb 2026 22:18:25 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matt Johnston <matt@codeconstruct.com.au>,
	stable <stable@kernel.org>
Subject: Re: [PATCH net] net: mctp: usb: properly drop the usb interface on
 probe error
Message-ID: <2026022314-retiring-accustom-ca7b@gregkh>
References: <2026022319-turbofan-darkened-206d@gregkh>
 <0fc4daf8261ea1b163c81c5618aba74f248bc3a9.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0fc4daf8261ea1b163c81c5618aba74f248bc3a9.camel@codeconstruct.com.au>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260347-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: D91F41825D2
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 09:50:09AM +0800, Jeremy Kerr wrote:
> Hi Greg,
> 
> On a second look:
> 
> > diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
> > index ef860cfc629f..eef17ae89298 100644
> > --- a/drivers/net/mctp/mctp-usb.c
> > +++ b/drivers/net/mctp/mctp-usb.c
> > @@ -355,6 +355,7 @@ static int mctp_usb_probe(struct usb_interface *intf,
> >         usb_free_urb(dev->tx_urb);
> >         usb_free_urb(dev->rx_urb);
> >         free_netdev(netdev);
> > +       usb_put_dev(dev->usbdev);
> >         return rc;
> >  }
> 
> Should we not do the usb_put_dev() before the free_netdev()?

Why?  The usb_put_dev() doesn't really do anything, except for the fact
that you have to do it because you did a usb_get_dev() earlier.  In
reality, no USB driver needs to call get/put on a usb device at all,
that is a bad pattern I made years ago for no good reason, sorry about
that.

I really should just sweep the tree to fix that up one of these days,
odds are a coccinelle script can do that...

> Given we're in NETREG_UNINITIALIZED state, we're likely to be
> immediately freeing netdev there, which includes the netdev_priv data,
> ie., dev.

That's great, but again, the usb device will still be around as the usb
core ensures that for the lifetime of probe/remove, the device will be
there with a reference.  So there's no real reason to put it anywhere in
this list, other than last as that mirrors when this was grabbed, right?

thanks,

greg k-h

