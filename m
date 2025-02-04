Return-Path: <netdev+bounces-162629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2702A276DA
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 17:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 596D63A3C3E
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 16:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A56215193;
	Tue,  4 Feb 2025 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="T8RZoHTK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F124821516C
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 16:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738685552; cv=none; b=Fr1eKgSPH4QAr/xPwWxPst3drjqRfs6V5Vha3HeiHcTSeGC0A2J+zh4dOhMcHZT2/pECh1b66qC+7YiTTMBsYEd0HVGeB7AoiRbTzInEv3u261ccpTIBzWiEiy4ggi8UL30wAoLAleNkDwHwT02bXf9pE1LkpMblz9ixLjkKEls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738685552; c=relaxed/simple;
	bh=NQU5eTalLyYg0E5JLiN73MpknYGriHwHaasvTN1bIHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZ/r7TnDRbrkWyXyympeFGEBm8P2wfhtKyCZghtaHtoaHcPtPTpNWJ316CFQoMmzJuxZLXqhh/iMDSENY2O9AT5oV87yanzvKDinRFa5GR/a2dD1PDwzPg9ncZwbItC00+ZSby5Fw8uKVuvkgyk1WJqI3yZhmM9EIVO2XgtJuQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=T8RZoHTK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1Vr9Urwy0jhhIAsRCwqnVo40qMeyxf9w/KrPP+e9/eA=; b=T8RZoHTKEpXhchFQMtfb3VfQBz
	fWgOcmL07CU9S8XcD2actZz0bQtR8yvRo9B+FMf8rA5PcFOKLYvTe8BZgMWWRT/eEZJslgKYqLUzG
	Jp5zNhjjQBEX2xxempUQ6ccwmcB7Nzwn0U79BAsfb5zbVLeitPmx5SkF9jle3rd+jnjM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tfLXC-00Au3E-AD; Tue, 04 Feb 2025 17:12:22 +0100
Date: Tue, 4 Feb 2025 17:12:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
	horms@kernel.org
Subject: Re: [PATCH net 2/2] MAINTAINERS: add a sample ethtool section entry
Message-ID: <271b2d3b-6d46-437a-8fdb-f5d811943cb5@lunn.ch>
References: <20250202021155.1019222-1-kuba@kernel.org>
 <20250202021155.1019222-2-kuba@kernel.org>
 <8ef9275a-b5f9-45e2-a99c-096fb3213ed8@redhat.com>
 <20250204073759.536531d3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204073759.536531d3@kernel.org>

On Tue, Feb 04, 2025 at 07:37:59AM -0800, Jakub Kicinski wrote:
> On Tue, 4 Feb 2025 10:26:40 +0100 Paolo Abeni wrote:
> > On 2/2/25 3:11 AM, Jakub Kicinski wrote:
> > > This patch is a nop from process perspective, since Andrew already
> > > is a maintainer and reviews all this code. Let's focus on discussing
> > > merits of the "section entries" in abstract?  
> > 
> > Should the keyword be a little more generic, i.e. just 'cable_test'?
> > AFAICS the current one doesn't catch the device drivers,
> > 
> > I agree encouraging more driver API reviewer would be great, but I
> > personally have a slight preference to add/maintain entries only they
> > actually affect the process.
> 
> You're right, I was going after the op name. Seems like a good default
> keyword. But it appears that there are two layers of ops, one called
> start_cable_test and the next cable_test_start, so this isn't catching
> actual drivers.

https://elixir.bootlin.com/linux/v6.13.1/source/include/linux/phy.h#L1080

The op in the driver structure is cable_test_start. There is also
cable_test_tdr_start but so far only Marvell hardware supports raw TDR
data. At the moment, cable_test_start does not produce any false
positives anywhere else in the kernel.

	Andrew

