Return-Path: <netdev+bounces-127629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 404D8975E66
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 03:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE691B210EA
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 01:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EF71799B;
	Thu, 12 Sep 2024 01:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ft5pEczb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3548F5684;
	Thu, 12 Sep 2024 01:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726103867; cv=none; b=Or6kR/4cbyHAt2sbrN96vvC92lD2b9I9Nt49JrhCuEop/goNNR7wkZUWzhkjKz0I5bmY1ALxWZRKYFtfJE7cJnpToXey6Soh4aE2BrdFuPO/tVloyeXKbvtCXawTA0jEgVa9FzHWFYJ5AuS87XTmsYf5wUMlhsb1JZssKemQKeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726103867; c=relaxed/simple;
	bh=K7lqwu5/HwHabgvhMNiMucTtxvF7EkAn5b8VYSPPiA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elQcqhScnROpo18keCXM+trPk55vO6uBui3fRsxlL01qVmNvwdEbjerrOvALTAw1HbwSIqx0wtJQDqb2DzQ7D7WVeNXIo7SOpWNCg83bd6QWbYRGSRFrbiCIZLFEx95uKXbtAYrTbOKJUcsvaORbY3xZMFcxGrdwcxLOiFiaFOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ft5pEczb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dWE8SDpOBXJhnTjfTGnZ6pwcgWm4AvR5qq6d537BBPM=; b=Ft5pEczbdportTpEeDrznKRqzn
	N40nYyBPtprdjFUsOuhTaagbNLAN/2Ixz57xq5IQG1IOoat2aL71Lko1Owln/xcLCFmPjd+GbdgDs
	gWlVmlnGvvQLFiUu9deAMYrx7KsGKuSXHV9lM6gS0OcPsdWip/FQXAeDpux5mvEULk2s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1soYSh-007GkL-FH; Thu, 12 Sep 2024 03:17:31 +0200
Date: Thu, 12 Sep 2024 03:17:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Divya Koppera <divya.koppera@microchip.com>,
	arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: microchip_t1: Cable Diagnostics for
 lan887x
Message-ID: <e2a7854f-6b36-4582-96af-97f952b6658f@lunn.ch>
References: <20240909114339.3446-1-divya.koppera@microchip.com>
 <20240911155912.1c36cf3c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911155912.1c36cf3c@kernel.org>

On Wed, Sep 11, 2024 at 03:59:12PM -0700, Jakub Kicinski wrote:
> On Mon, 9 Sep 2024 17:13:39 +0530 Divya Koppera wrote:
> > Add support for cable diagnostics in lan887x PHY.
> > Using this we can diagnose connected/open/short wires and
> > also length where cable fault is occurred.
> 
> Hi Andrew, is this one in your review queue by any chance? :)


Sorry, fell through the cracks.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


