Return-Path: <netdev+bounces-88311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E99A8A6A4D
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 14:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B0821C21295
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 12:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1831DFEF;
	Tue, 16 Apr 2024 12:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="b00vZ9g7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A50683CCD;
	Tue, 16 Apr 2024 12:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269323; cv=none; b=oyPJlUNO8qOdF+QCKfgxrdzwkCpwc89Qm+Srth57gi4vW+nr81MG1WdFPzNRTQUlQRw1jnwGQ3Fix6ZDQxT4AtIGyDvenw5HARye/QvsK+L+rtcCv4A7qm+05K1M8tbE/aCauWemw+OgSJZ6lu3us3BNBAOGhPDnLSABesWl7Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269323; c=relaxed/simple;
	bh=JPUAg8CKdAIwgdoZNkQeMsiJ4zY6KVT0YCL6rtRwpTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jn1MsZyP2z5wYAD/QFSB6g9KZ/eygWfKyMKxDVofBvsua296hQwh+k3NC4+beJiUWr8YndbAL7AOx6C7sYHkwsY/BpAn24reRtXDauwCQqzZh++MM/R8nbsxkGwGOhTR4gblL+5AzaeceyrCKvZZRC9VnSjtQZ5+DwSbJAdI7vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=b00vZ9g7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FS9J2Fip8TfYkPZ+m/CmO8+R1mu1fbpLQrM1HAAlF2o=; b=b00vZ9g7YvlqFvkMK/6ur5FRpO
	mXezNz5Rvi1bQ0+3+hCCImuGH/999eEkaAwdxJqAG+6UDYwed9P8W1MziW/9+0UbkAqj3bUNHW1Ee
	rNiUBpcIFfQPrVZ18+UPJbpEBt5GnLgMbgsUp0cVNAeqfQRcLg2Wt7UytCR5PFWVIvCk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rwhc0-00D8Fc-7N; Tue, 16 Apr 2024 14:08:32 +0200
Date: Tue, 16 Apr 2024 14:08:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Trevor Gross <tmgross@umich.edu>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH net-next v1 4/4] net: phy: add Applied Micro QT2025 PHY
 driver
Message-ID: <0aa87df5-a2b8-45b8-a483-37eee86739bc@lunn.ch>
References: <20240415104701.4772-1-fujita.tomonori@gmail.com>
 <20240415104701.4772-5-fujita.tomonori@gmail.com>
 <CALNs47v+35RX4+ibHrcZgrJEJ52RqWRQUBa=_Aky_6gk1ika4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALNs47v+35RX4+ibHrcZgrJEJ52RqWRQUBa=_Aky_6gk1ika4w@mail.gmail.com>

> > +        let mut a = MDIO_MMD_PCS;
> > +        for (i, val) in fw.data().iter().enumerate() {
> > +            if i == 0x4000 {
> > +                a = MDIO_MMD_PHYXS;
> > +                j = 0x8000;
> > +            }
> 
> Looks like firmware is split between PCS and PHYXS at 0x4000, but like
> Greg said you should probably explain where this comes from.
> 
> > +            dev.c45_write(a, j, (*val).into())?;
> 
> I think this is writing one byte at a time, to answer Andrew's
> question. Can you write a `u16::from_le_bytes(...)` to alternating
> addresses instead? This would be pretty easy by doing
> `fw.data().chunks(2)`.

That probably does not work, given my understanding of what is going
on. A C45 register is a u16.

The data sheet says:

  The 24kB of program memory space is accessible by
  MDIO. The first 16kB of memory is located in the
  address range 3.8000h - 3.BFFFh. The next 8kB of
  memory is located at 4.8000h - 4.9FFFh.

0x3bfff-0x3800 = 0x0x3fff = 16K.

So there are 16K u16 registers mapped onto 16K bytes of SRAM. So each
register holds one byte. Trying to write two bytes every other
register is not something which the datasheet talks about. So i doubt
it will work. Which is shame, because it would double the download
speed.

	Andrew

