Return-Path: <netdev+bounces-111989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D4C9346B4
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 05:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CABF31C2286F
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 03:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F09F2C69B;
	Thu, 18 Jul 2024 03:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uBCAIHLH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC183A1C9;
	Thu, 18 Jul 2024 03:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721273274; cv=none; b=flreLWVY/IbIyZQ9gwYR6AKxzjk5IUmxSWKl58FiUBGNJmAAjC6Yvjx8pzKJYgU27YPtjWccav9kvx2ghZ270qJERRhRFzOB5gGRxveYC9bfA4YJ3cd8/gz/CxpsnWGFnpgFjxbaN98MWsJZgELUGNWJv4ZfYLMstfuiT/+fN+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721273274; c=relaxed/simple;
	bh=eHEXBDVXes3j+b2zzF7l4IGppaODD6pBuy62e5c1l+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehNv/o6Zrl7/+nF+KZaLMMCwYb0/RRo3tzvw6arjCD7hYfJo+BxtYI0HlzRALZ/4iwxXoxhO9Tzngss0y+SnD+2gpbC70/AViaoqBh5laa/VpbKx7p7WkB3LFBmwQvGmjF1sKGQ9oFI3ka1oskTaTb9jdRRvEHMMLS2g5ilW1UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uBCAIHLH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wOrai0BMpdrYPq65MuItW3Znh746Zw3Nq7jGyyHGcNc=; b=uBCAIHLHMXdc1pwpXxmPxJAM1v
	NLnl9/Tqls/Wmv2pIcnwkBvXub4ZaqFONWCuAk2Bw0MJfIMoc79Pz0qPrunjIXVLe5B9heW9jD9xW
	3W0aw8MCS3p+OrwoYC7aVKs1sIPzu+93ylM5d8U0a5ybS97LvMPQ20F7LfLF2il5WIaU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sUHnr-002klu-EZ; Thu, 18 Jul 2024 05:27:35 +0200
Date: Thu, 18 Jul 2024 05:27:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	horms@kernel.org, hkallweit1@gmail.com, richardcochran@gmail.com,
	rdunlap@infradead.org, linux@armlinux.org.uk,
	bryan.whitehead@microchip.com, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next V2 0/4] Add support to PHYLINK for
 LAN743x/PCI11x1x chips
Message-ID: <2d8d38c2-0781-47ff-bff8-aec57d68ef05@lunn.ch>
References: <20240716113349.25527-1-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716113349.25527-1-Raju.Lakkaraju@microchip.com>

On Tue, Jul 16, 2024 at 05:03:45PM +0530, Raju Lakkaraju wrote:
> This is the follow-up patch series of
> https://lkml.iu.edu/hypermail/linux/kernel/2310.2/02078.html
> 
> Divide the PHYLINK adaptation and SFP modifications into two separate patch
> series.

You appear to be missing the PHYLINK maintainer in your Cc: list.

	Andrew

