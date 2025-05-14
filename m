Return-Path: <netdev+bounces-190440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A83BBAB6D4E
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CD104A463A
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 13:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5BA27978D;
	Wed, 14 May 2025 13:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wRmzNHp5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C88F19341F
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747230747; cv=none; b=n7ORG6CV+XOU6ZU3uZzhvbBGQxENp8E0BOhjdkpWnadvTuEzY4KQH3iGbXSNmec0y0qHUx2c6ujPSWjHjW8eMNsElCbJt5swC/AiR/scbr3T+nJntz/oNgtzvxhrEGERf60uF9NDS8Sqdwfsxe6JoYI2Ep/hBvvHpAPYMTFxNYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747230747; c=relaxed/simple;
	bh=027HtBkYxb4uDaFocZECbnAGBxh6PAkFNlVURgEkDt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+r1CMuFZ2IkxRh1xa+GkgUir04gfNNWb0LqiVG5Arm6nsDFdWpxiTQ9n9vLNjWNb60mzWHc1kIxe1m3kUis6rA2dj+sTa0SWDe4nXVMS7SePXhVbnNRMzvmuvgvsmKVMh0GiIfCXA/OibcCi2gmyVEXehVGptuqs0ZXvfsx8fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wRmzNHp5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gQZU2fjEGV2XQ/VYw+aktbvR9GpsrIn0f+kbAP4qgtw=; b=wRmzNHp5F4X0ORQAcgYEbAMmiy
	+mo44CQD39o/GtOsFS8iQ3nCC0vC2OoSgnceHk+YyAdA+u5JaXWvON6i5reZp2k2vsZrN1UwKyflV
	gu+j7ExU641T4USVteFOdb2wBQR/ZqTPwBRWRZPu462dgfV/VYLIzy1VT36qw9pwWopA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uFCX0-00CZ80-PH; Wed, 14 May 2025 15:52:22 +0200
Date: Wed, 14 May 2025 15:52:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andreas Muswieck <amuswieck@gmx.de>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: Realtek RTL8125
Message-ID: <5f328f11-c513-4946-9677-561a1af5c6a1@lunn.ch>
References: <bb856c9b-7038-4e1c-ac8b-7fc5af4ca62d@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb856c9b-7038-4e1c-ac8b-7fc5af4ca62d@gmx.de>

On Wed, May 14, 2025 at 03:03:15PM +0200, Andreas Muswieck wrote:
> Hello,
> My new computer has had problems with the LAN chip right from the start. The
> motherboard is an ASUS PRIME X870-P WIFI. It contains a Realtek RTL8125
> chip.
> The Linux distributions Debian bookworm and Linux Mint 21 are not able to
> establish a LAN connection. I have also tried Debian Trixie, no connection.
> Debian bookworm recognises an r8169 with unknown chip XID 668 and
> recommends: contact the maintainer.

MAINTAINERS says:

8169 10/100/1000 GIGABIT ETHERNET DRIVER
M:      Heiner Kallweit <hkallweit1@gmail.com>
M:      nic_swsd@realtek.com
L:      netdev@vger.kernel.org
S:      Maintained
F:      drivers/net/ethernet/realtek/r8169*

Adding Heiner

       Andrew

