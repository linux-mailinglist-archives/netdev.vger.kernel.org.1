Return-Path: <netdev+bounces-250896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8B0D3977C
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 16:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E28663009117
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 15:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CE532B981;
	Sun, 18 Jan 2026 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZZnknsLh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A784D171CD;
	Sun, 18 Jan 2026 15:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768750622; cv=none; b=pv4iSpU17+Hxf4JOvgHNu5CzRsxfpjBEIxTj0a9TQEWHQaBHJCCumyI6eB1gSAHWqG854VVdmFcda7GLQtWToqSNsUvXHK6rpaF0hCC47WEUQ4VDyccZBMkTDmb8wSR7SwlfpKSb4CIDyspikVXIY4uPUqv3Bq3yNHb+VP3ZI+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768750622; c=relaxed/simple;
	bh=gaxj3CKn535S/wDtRnePw1+nvTcn+48j00YVan2u2Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMcmuUMTlkwHLSk0NdX1nNLbJxT48SxHUp93bgwBPhkoY3aMspW2tBauwEkA5ydiVxBh5ScKbJBYT77Z7ESW5Q8jetj7w9mn9MkPCJgpF+NSjPNmvT1Q1xoQie92+oAibhPO51XXqCxpOh+18gEFVabTG8DU6+hQ2DLFoj914z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZZnknsLh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=So2SFmrLbkfjfSoug2RpIoWGuKfEg8N4HkPPp4cAvy0=; b=ZZ
	nknsLhfvHT8KgswvpFRIAB+FwSAJ66/u8kSL88Ko9uN5j+uhQ97HQwARAQXi+sAcKxFolBPnFxdlR
	8bIPf2NkA5pDZMPA2E72H5qIeI9wcAiw63CfFthRmHlaR5bIdxrzHO2sY1urO+RVVPhZD40x6Hay+
	EQsZEozts9S8tsg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vhUpW-003MdL-Q8; Sun, 18 Jan 2026 16:36:42 +0100
Date: Sun, 18 Jan 2026 16:36:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jonas Jelonek <jelonek.jonas@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Subject: Re: [PATCH net-next v5] net: sfp: extend SMBus support
Message-ID: <58e01c87-770a-48b6-9d6f-2cbc6d045a5d@lunn.ch>
References: <20260116113105.244592-1-jelonek.jonas@gmail.com>
 <6a87648c-a1e8-49a2-a201-91108669ab44@bootlin.com>
 <6987689b-35ac-4c15-addb-1c8e54144fa7@gmail.com>
 <5e7c71f6-80dd-408b-a346-888e6febf07a@lunn.ch>
 <fcf7b3f2-eaf3-4da6-ab9a-a83acc9692b0@bootlin.com>
 <fe1bf7b6-d024-447c-a672-e84f4e77f8d7@lunn.ch>
 <91442f3f-0da9-4c52-89ce-2ca0a3188836@gmail.com>
 <aWyxDI6-sKc6BNQE@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aWyxDI6-sKc6BNQE@shell.armlinux.org.uk>

On Sun, Jan 18, 2026 at 10:08:12AM +0000, Russell King (Oracle) wrote:
> On Sun, Jan 18, 2026 at 10:43:12AM +0100, Jonas Jelonek wrote:
> > Looking at the SFP MSA [1], some sentences sound like one could assume
> > byte access is needed at least for SFP. In Section B4, there are statements
> > like:
> > - "The memories are organized as a series of 8-bit data words that can be
> >     addressed individually..."
> > - "...provides sequential or random access to 8 bit parameters..."
> > - "The protocol ... sequentially transmits one or more 8-bit bytes..."
> > 
> > But that may be too vague and I can't judge if that's a valid argument to not
> > care about word-only here.
> 
> There's a whole bunch of documents. You also need to look at SFF-8472.
> This contains the following paragraph:
> 
>  To guarantee coherency of the diagnostic monitoring data, the host is
>  required to retrieve any multi-byte fields from the diagnostic
>  monitoring data structure (e.g. Rx Power MSB - byte 104 in A2h, Rx
>  Power LSB - byte 105 in A2h) by the use of a single two-byte read
>  sequence across the 2-wire interface.
> 
> Hence why we don't allow hwmon when only byte accesses are available.

I would also add, SFP vendors like to ignore the MSA and do random
things. Look at the number of quirks we have for dealing with SFPs
which break what these documents say.

      Andrew

