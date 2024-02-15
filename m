Return-Path: <netdev+bounces-72061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9A3856621
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 15:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E3DA1C208F0
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 14:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E89131E4A;
	Thu, 15 Feb 2024 14:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="w+cCKPBQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D9769DF0
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 14:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708008022; cv=none; b=WWAVLF97kbczDhOlfdU8pIxi2kb433YWkWdVVyuRoBHJ5ZR4ednfvzG7aH/xTV2mIYX85x/Ci7OGcvcfDJ/uyJSxSrBbfFKipqzmzB9B6fhXryBrEMZ5JbDVHoJLz+k88Y73z/jceDBIrga9vbViOy5ey04vDw/tCpaOnsv4Tvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708008022; c=relaxed/simple;
	bh=5UCzbgOJ8GSriW5YsVBHOLcxyi2eei2ONv7KfwAdGvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYrdpbRvDf1rAC38xxJZuTsMIrur2/dEALCFq3xdD8ZwQSndhgoX/JEk0ahA8PkQE/EVNcAydeqCLfYwc0zr5uRI6K838hg3RZ5qivCcz/S/dYt6rBa+ZIEfI3trkW+aeFHDvF6IlxfoXRA7k/xIHsrX68b/dYzKiJvNDdR58qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=w+cCKPBQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aV681ZwnipXI3hBaV4+kavZrwiD355reAQHnMbp+nfE=; b=w+cCKPBQpkIVeTi6/dYrX2dk+G
	OeJrzUOIEgmyYZqqJf0fdmUEOzyz13WDAg72p6TccHo6zsslZQy/kCraGcg7/1tCrenvmfTG5T3p3
	9NniBY9Ecv67i6kKKkG8mZrGwtX9xpgVraYTcd2n0fLtnajfbpRqBIHoak2i9/nv6vfI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1racuZ-007teR-Ic; Thu, 15 Feb 2024 15:40:27 +0100
Date: Thu, 15 Feb 2024 15:40:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Denis Kirjanov <dkirjanov@suse.de>
Cc: Denis Kirjanov <kirjanov@gmail.com>, mkubecek@suse.cz,
	netdev@vger.kernel.org
Subject: Re: [PATCH ethtool] ethtool: put driver specific code into drivers
 dir
Message-ID: <23bdba44-0a82-428f-b813-3675b2da1984@lunn.ch>
References: <20240214135505.7721-1-dkirjanov@suse.de>
 <2951e395-7982-47bb-a9f6-c732c2affaaf@lunn.ch>
 <f6ae42d5-5fb8-476e-acfa-db192ac8aec9@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6ae42d5-5fb8-476e-acfa-db192ac8aec9@suse.de>

On Thu, Feb 15, 2024 at 04:41:47PM +0300, Denis Kirjanov wrote:
> 
> 
> On 2/14/24 21:12, Andrew Lunn wrote:
> > On Wed, Feb 14, 2024 at 08:55:05AM -0500, Denis Kirjanov wrote:
> >> the patch moves the driver specific code in drivers
> >> directory
> > 
> > It is normal for the commit message to give the answer to the question
> > "Why?".
> 
> "For better code organization the patch moves the driver-specific code into drivers directory"

Is that enough justify the code churn? Are you about to add a lot more
driver code?

> > Also, what is your definition of a driver? I would not really call the
> > sfp parts drivers.
> 
> Sure, I'll put them back in the next version

It is i while since i looked at the insides of ethtool. But if i
remember correctly, the 'drivers' are there to pretty print values
returned by ethtool --register-dump. SFP was just an example, i
suspect there are other files which you moved which are not used by
register-dump as drivers. Hence my question, what is your definition
of driver?

   Andrew

