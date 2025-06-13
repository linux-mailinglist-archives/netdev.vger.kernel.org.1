Return-Path: <netdev+bounces-197554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FB8AD9268
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 18:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454C93A6F8A
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 16:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F53B20DD63;
	Fri, 13 Jun 2025 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5s9Y9Td"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EA220D4E4
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749830429; cv=none; b=f5SwfpmfGCF/72ZVQEjD5Cc6w1z8mC/6wBW/BipP++ZwVRWGpB26JCmyHLEWYQVXDs58y5Ug1Cs8XxoFPVrp9kYN1bhcHXYZKgbP6R3/DZN92GW5tc4Y0KjGGMDnlV7I+G1YjF78YWhx3FJFOQpwsMYtyeMhbZSEaLqRN0+nPng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749830429; c=relaxed/simple;
	bh=l3w1lSo+OAAyb3QIEHku9EwZd0sMjd3vwGQUbMpR1o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLAzJU1mnpG3jWa0umik7uWkexyfnoPvLjYX9XGpuDw4n+D7lutshT0aPclFsDNYvbP43eg58vMq2bgZ8Z22I36VnFrIugkCcwMwbpjTrdIha2+mxulrK9qwrEswkWc4LBgU+wx7TI0n01YU+e3lN3mVpLvQQNZWkC8+SVJS2IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5s9Y9Td; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C88C4CEF0;
	Fri, 13 Jun 2025 16:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749830428;
	bh=l3w1lSo+OAAyb3QIEHku9EwZd0sMjd3vwGQUbMpR1o0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h5s9Y9Tdu7NNwOOL3buDiAeh0q67Tdf4TqUKXVWo+qOZhbVjNpaNP1P/MpYh6o2Io
	 qocyGi6n4jCGUDtqMWJlB03ZrR1ldQd11QWew8ouLIpTbAO7pkb98tQEfJ8W1wWv2K
	 XvS4LNnMmmqd1+rmZMAPC2qjCHpbOXvGCGpgo9cW3YDFT4BCh/AYsawln6zokQcjUy
	 aCEZIQjxpRNojpBZM3cin7hvKTyqAYMs9BRAynzP+V5H0O1PUpkWSgEeGYd/piDCC/
	 kLTmpZ+6FubCTUkKC28iJJPCkzzM+s02ao4b5+GIhg06kRioMVlTkcqBwNrl6YiZqF
	 NIlHuyK9nExwQ==
Date: Fri, 13 Jun 2025 19:00:24 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
	linux@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net,
	pabeni@redhat.com, kuba@kernel.org, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [net-next PATCH 0/6] Add support for 25G, 50G, and 100G to fbnic
Message-ID: <20250613160024.GC436744@unreal>
References: <174956639588.2686723.10994827055234129182.stgit@ahduyck-xeon-server.home.arpa>
 <20250612094234.GA436744@unreal>
 <daa8bb61-5b6c-49ab-8961-dc17ef2829bf@lunn.ch>
 <20250612173145.GB436744@unreal>
 <52be06d0-ad45-4e8c-9893-628ba8cebccb@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52be06d0-ad45-4e8c-9893-628ba8cebccb@lunn.ch>

On Thu, Jun 12, 2025 at 08:29:07PM +0200, Andrew Lunn wrote:
> > > > when the fbnic was proposed for merge, the overall agreement was that
> > > > this driver is ok as long as no-core changes will be required for this
> > > > driver to work and now, year later, such changes are proposed here.
> > > 
> > > I would say these are natural extensions to support additional speeds
> > > in the 'core'. We always said fbnic would be pushing the edges of the
> > > linux core support for SFP, because all other vendors in this space
> > > reinvent the wheel and hide it away in firmware. fbnic is different
> > > and Linux is actually driving the hardware.
> 
> > How exactly they can hide speed declarations in the FW and still support it?
>  
> You obviously did not spend time to look at the code and understand
> what it is doing. This is used to map the EEPROM contents of the SFP
> to how the PCS etc should be configured. So far, this has only been
> used for speeds up to 10Gbps. This code is mostly used by SoCs, and at
> the moment most SoCs inbuilt interfaces top out at 10G. fbnic is
> pushing this core code to higher speeds.
> 
> You can easily hide speed declarations in firmware and still support
> it because we are not talking about the ethtool API here. This is a
> lower level. A FW driven device will have its own code for parsing the
> SFP EEPROM and configuring the PCS etc, without needing anything from
> Linux.

Excellent, like you said, no one needs this code except fbnic, which is
exactly as was agreed - no core in/out API changes special for fbnic.

> 
> > In addition, it is unclear what the last sentence means. FBNIC has FW like
> > any other device.
> 
> From what i have seen, it has a small amount of firmware. 

Initial claim was no-FW, now we are talking about "small amount".
There is no fbnic devices in the market, FW is not open-source to
justify the last claim.

> However, Linux is actually controlling most of the hardware.

Even this claim contradicts their own press releases:
https://www.marvell.com/company/newsroom/marvell-delivers-custom-ethernet-network-interface-controller-solution-at-ocp.html

"Complete firmware control with access to all hardware internals enabling the ability
to deliver innovative customized capabilities and reduce mean time to resolve potential
issues."

Thanks

