Return-Path: <netdev+bounces-182505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4756DA88EF2
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 00:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECFB53AFC51
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 22:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C5A1B0F3C;
	Mon, 14 Apr 2025 22:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OuSa7Yw4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A94188733;
	Mon, 14 Apr 2025 22:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744669130; cv=none; b=Zz+AfQsRN2MxfAPGDNLbnSST9+tvjZfdD0aNJf3yyLBOCSbfvXAhdtwXZKpeWYXVFBHoAzXAaNqcxwbSDW8iprvhawalhR3KigtJUy1JSrFWEyqxQRylfq2oqJnQCDOY7cSkBcFOmJjEdrxSI+Kv1d/Vji0H3gq3FLXiaPtuwF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744669130; c=relaxed/simple;
	bh=/Zb1XV2bYof6BzTOqn3Nl2/4vBAP/XCy2fGjFlKM2c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QyR4I2N7NZej5Bir0AAuXkSuQvG6BxSHWaff2J6p67ad212ezF7Lmc2mKZ3IPNaVgleHRa4hhnHAfhl/RLeKcrWfhAxCooHzmrwJ5mKv2cihZPLl2BbH3K5938UzpGVsJBpKp3PCPnuxDQM5eh3TSVBvd+66qrobNMEyyA/I4Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OuSa7Yw4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NzdrtjgDo4uBW10GHqjcnuFCyc2xfj83QuuvTGF5XJU=; b=OuSa7Yw4IXAtwTCvgAdSHneXg0
	HtcripUjUS+d5ejgsf0yQkIvBpMvaH7ELC/DoLd7qyUEQvRM1q+KcDelHuHIh4QLsL8sHumUJyYCw
	weMvEblTpEgIvCFVgfeJVRsWkUL+5o1BFZrENgXUNa+n2V9YqYuzxxJkQPg8JrygAAS4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u4S8M-009Hvy-Lv; Tue, 15 Apr 2025 00:18:30 +0200
Date: Tue, 15 Apr 2025 00:18:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Nelson, Shannon" <shannon.nelson@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, brett.creeley@amd.com
Subject: Re: [PATCH net-next 2/3] ionic: support ethtool
 get_module_eeprom_by_page
Message-ID: <891f1b66-0b49-41ce-bb00-5345ef9afb5c@lunn.ch>
References: <20250411182140.63158-1-shannon.nelson@amd.com>
 <20250411182140.63158-3-shannon.nelson@amd.com>
 <ed497741-9fcc-44fc-850d-5c018f2ef90e@lunn.ch>
 <a32f6b8a-860b-4452-87f0-04e0d289d473@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a32f6b8a-860b-4452-87f0-04e0d289d473@amd.com>

> > > +static int ionic_get_module_eeprom_by_page(struct net_device *netdev,
> > > +                                        const struct ethtool_module_eeprom *page_data,
> > > +                                        struct netlink_ext_ack *extack)

> > > +     switch (page_data->page) {
> > > +     case 0:
> > > +             src = &idev->port_info->status.xcvr.sprom[page_data->offset];
> > > +             break;
> > > +     case 1:
> > > +             src = &idev->port_info->sprom_page1[page_data->offset - 128];
> > > +             break;
> > > +     case 2:
> > > +             src = &idev->port_info->sprom_page2[page_data->offset - 128];
> > > +             break;
> > > +     default:
> > > +             return -EINVAL;
> > 
> > It is a valid page, your firmware just does not support it. EOPNOSUPP.
> 
> I can see the argument for this, but EINVAL seems to me to match the
> out-of-bounds case from ionic_get_module_eprom(), as well as what other
> drivers are reporting for an unsupported address.  It seems to me that
> passing EOPNOSUPP back to the user is telling them that they can't get
> eeprom data at all, not that they asked for the wrong page.

I would disagree with at. Look at the ethtool usage:

ethtool -m|--dump-module-eeprom|--module-info devname [raw on|off]
          [hex on|off] [offset N] [length N] [page N] [bank N] [i2c N]

You can ask for any page. The only validation that can be done is,
does the page number fit within the page selection register. And that
is a u8. So any value < 256 is valid for page.  Some pages are
currently defined, some pages are reserved, and pages 128-255 are for
vendor specific functions.

The limitation here is your firmware, you don't support what the
specification allows. So EOPNOTSUPP for a page you don't supports
would give an indication of this.

ethtool's pretty print should handle -EOPNOTSUPP. It knows some netdev
have limits, and don't give full access to the module data. I would
not be too surprised to find ethtool actually interprets EINVAL for a
valid page to be fatal, but i've not checked. EOPNOTSUPP should just
stop it pretty printing that section of the module.

	Andrew

