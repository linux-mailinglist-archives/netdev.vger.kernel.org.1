Return-Path: <netdev+bounces-160096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9942A18202
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 17:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B46518812CA
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 16:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB5C1F03D8;
	Tue, 21 Jan 2025 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sbMgiPgx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A5B3BBF2;
	Tue, 21 Jan 2025 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737477068; cv=none; b=D9T5dZDTaQDLqWkc9m62AU70xod6OErPssdOJBudp++5SN1GHpAo+/PGmJ6MyRaaETWPTAzCXWHIGqbpEd6XK7jgH45L5K74Y7at007WkWrzc4RvxJbOBuXa1VDO7qR7apqgoWA06dRibhJe47FEqLSFaoVPY6dl6qoKWDGejd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737477068; c=relaxed/simple;
	bh=C4J0NuPF47tl45z8cScmZ9d88dwudF/0LWVRm9wcyuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6iHnJlUpes2KqWvbX50icmfWdyAkzFRy02i+EY5NXDAgq9a/YudRbLZPe64bH8NvMSfK/IIHLHL+yVtT0aB8sDU78OJQbZvrND0HEn18UF9NkNmuXgEl3yJHqjtRIx3b5M5urx0jJm9udzlhbCd31KJnd7dK4iO3IM/mr3LLC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sbMgiPgx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=TIBcQIVWAqhDi4MjOluGHd+JW49Qm54tz8wmj3F5SJQ=; b=sb
	MgiPgx7owdHJxvwCMLSnb7/TyFTrsXtM8G5ATnONlWDzsEdY8ty2bG/Xh9w6IXMvSdBEJfXq7akmt
	jehodMRFlSN63Qm1Y2osokh30xsMPfF+qc5882egUx+jyXgUSW1vOkh4csyFIIaLdNzGqfezXFrfq
	jJiBKGJzF8pY7PY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1taH9P-006gn8-Pm; Tue, 21 Jan 2025 17:30:51 +0100
Date: Tue, 21 Jan 2025 17:30:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: Wentao Liang <vulab@iscas.ac.cn>, Jakub Kicinski <kuba@kernel.org>,
	Daniele Palmas <dnlplm@gmail.com>, Breno Leitao <leitao@debian.org>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] net: usb: qmi_wwan: Add error handling for
 usbnet_get_ethernet_addr
Message-ID: <0044ac56-b391-4e2d-8c12-9ad8a14bd625@lunn.ch>
References: <20250120170026.1880-1-vulab@iscas.ac.cn>
 <87y0z52wcj.fsf@miraculix.mork.no>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y0z52wcj.fsf@miraculix.mork.no>

On Mon, Jan 20, 2025 at 07:06:52PM +0100, Bjørn Mork wrote:
> Wentao Liang <vulab@iscas.ac.cn> writes:
> 
> > In qmi_wwan_bind(), usbnet_get_ethernet_addr() is called
> > without error handling, risking unnoticed failures and
> > inconsistent behavior compared to other parts of the code.
> >
> > Fix this issue by adding an error handling for the
> > usbnet_get_ethernet_addr(), improving code robustness.
> >
> > Fixes: 423ce8caab7e ("net: usb: qmi_wwan: New driver for Huawei QMI based WWAN devices")
> > Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> > ---
> >  drivers/net/usb/qmi_wwan.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
> > index e9208a8d2bfa..7aa576bfe76b 100644
> > --- a/drivers/net/usb/qmi_wwan.c
> > +++ b/drivers/net/usb/qmi_wwan.c
> > @@ -779,7 +779,9 @@ static int qmi_wwan_bind(struct usbnet *dev, struct usb_interface *intf)
> >  	/* errors aren't fatal - we can live with the dynamic address */
> >  	if (cdc_ether && cdc_ether->wMaxSegmentSize) {
> >  		dev->hard_mtu = le16_to_cpu(cdc_ether->wMaxSegmentSize);
> > -		usbnet_get_ethernet_addr(dev, cdc_ether->iMACAddress);
> > +		status = usbnet_get_ethernet_addr(dev, cdc_ether->iMACAddress);
> > +		if (status < 0)
> > +			goto err;
> >  	}
> >  
> >  	/* claim data interface and set it up */
> 
> 
> 
> Did you read the comment?
> 
> This intentinonally ignores any errors.  I don't know how to make it
> clear anough for these AI bots to understand.  Any advice there?

The problem is not really the AI bot, but the user of the AI bot. We
often see this problem, and need to teach bot drivers that the bot is
just the start. The bot points out a potential issue, but it needs a
human developer to verify the issue and consider what the real fix is,
which might be, as in this case, a false positive and no fix is
needed.

I don't know how to really fix this issue, other than try to teach the
bot drivers to actually think.

> NAK
> 
> (and why weren't I CCed?  Noticed this by chance only...)

Probably the same issue. The bot driver does not know the processes,
has not run the get_maintainers script. This is again part of the
issue with these sorts of patched, they are often low quality and need
careful review.

	Andrew


