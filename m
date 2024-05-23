Return-Path: <netdev+bounces-97779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3048CD26E
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 14:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECCCE1C21049
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 12:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945D2149C56;
	Thu, 23 May 2024 12:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CvHkio7O"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3CE149017;
	Thu, 23 May 2024 12:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716468196; cv=none; b=q8xA7UELZyLpgzzFWl7lsYZBSs2R8RUDzs3T5eVTkT5XkkfcAJ9GXh4ZMVh4JQrXc7L+shfeWNdUVFsCYNlREDYXoQX6UHH9mrSUB0YHxBLDnTuPSHBwPOj7g/L5nKxwEyqAlWK141TXJrlWmnYeDpWXqBSdDriKFvKxkLxSwYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716468196; c=relaxed/simple;
	bh=XYhesPrIe+ub1SdQr2xl3FCi7rcAAsmL9Ma1RciSGTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpozwHXMotWInZW8LGCRxVM7eH9kL3f0B9UlmVScvxhSnqyyMFOExfymYx/dG3gJeNkNRetameCY36seZQNxAHxgLW0adIAKMMB7EAVkGDk7XhKH69mc6Xnzl8sa3WCC1+nZNbLbP7cxlK7lslU+vAGr5jj4ZFOrYSYosOzy5mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CvHkio7O; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=u5xqnRII9t7YYXMuJNUmdTWOeMBfSd5MQF3lTq705uI=; b=CvHkio7OCvRzUdpLmwyhVj4QMY
	LtoR9hvr7JZ42pcvFz7dA/LAjqXjDDvoZehfM6TPKZFXxTaPDvrZj793Jb73sst8vlfBQzU/xyMju
	E9PD5quPEPQLLxgcD/Ug5PTEx5H+HOUe/vYyRMgdnjTTQcagntmimL7z9dueblOC3t0c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sA7mf-00FtJG-MP; Thu, 23 May 2024 14:43:01 +0200
Date: Thu, 23 May 2024 14:43:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban.Veerasooran@microchip.com
Cc: steve.glendinning@shawell.net, UNGLinuxDriver@microchip.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: smsc95xx: configure external LEDs function for
 EVB-LAN8670-USB
Message-ID: <5853e477-be38-40b3-8efe-93f20c57e6fd@lunn.ch>
References: <20240522140817.409936-1-Parthiban.Veerasooran@microchip.com>
 <9c19e0a1-b65c-416a-833c-1a4c3b63fa2f@lunn.ch>
 <f41c1acd-642a-4449-a03c-1ba699bd8441@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f41c1acd-642a-4449-a03c-1ba699bd8441@microchip.com>

On Thu, May 23, 2024 at 08:51:54AM +0000, Parthiban.Veerasooran@microchip.com wrote:
> Hi Andrew,
> 
> On 22/05/24 10:14 pm, Andrew Lunn wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Wed, May 22, 2024 at 07:38:17PM +0530, Parthiban Veerasooran wrote:
> >> By default, LAN9500A configures the external LEDs to the below function.
> >> nSPD_LED -> Speed Indicator
> >> nLNKA_LED -> Link and Activity Indicator
> >> nFDX_LED -> Full Duplex Link Indicator
> >>
> >> But, EVB-LAN8670-USB uses the below external LEDs function which can be
> >> enabled by writing 1 to the LED Select (LED_SEL) bit in the LAN9500A.
> >> nSPD_LED -> Speed Indicator
> >> nLNKA_LED -> Link Indicator
> >> nFDX_LED -> Activity Indicator
> > 
> > What else can the LEDs indicate?
> There is no other indications.

O.K. So it is probably not worth going the direction of using the
netde LED infrastructure to allow the use to configure the LED.

> >> +     /* Set LED Select (LED_SEL) bit for the external LED pins functionality
> >> +      * in the Microchip's EVB-LAN8670-USB 10BASE-T1S Ethernet device which
> > 
> > Is this a function of the USB dongle? Or a function of the PHY?
> It is the function of USB dongle.

So an OEM designing a dongle could make the LEDs do different things?

You are solving the problem only for your reference design, and OEMs
are going to have to solve the same problem for their own design?

This is why i'm asking is it a function of the PHY or the board. If it
is the PHY, we could have one generic solution for everybody using
that PHY.

	Andrew

