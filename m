Return-Path: <netdev+bounces-174383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A682A5E707
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 23:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AEF87AC746
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 22:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C781EF0A3;
	Wed, 12 Mar 2025 22:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CUJjtxBi"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EB31D5CD4;
	Wed, 12 Mar 2025 22:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741817469; cv=none; b=J77B48AAfpIcEZogHJpvgY4ezUaNTPeuaLpv0ECtqfBN3w5TDBKMw1mPAk65MYS+ezhpAWXb0LZLIHwxrdmgzdU69ekTMNe7j8/WhlO2GEP9jcf0zxol3Q8tmsylxFqVz2mK9kgbcv6asF48FpmZRE9UZiaNferHDhi3e+vxuUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741817469; c=relaxed/simple;
	bh=/1XozE0/vIquYjFMnDWf+X78e+cGMvn6tYV+FrUbuaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Avq8cTF0VdjddMq0dG1hS0M6/klgQzDlgLDYqFNbEs4tPMWdB9rfPy85S1WNdp9rF+0zi2TFKkx48lhk+cbxVOvd7JkhO0PsYh15sPASq59NpVU4M/8v+mK6k4Ni1S5sEHWi9EyZvKSYSbZClhSSZMRcgR2dRZi3t7FE55laVXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CUJjtxBi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IlkU+vvOpVkWxTXBaPN8dTl7vOj74Nbxp/MBIBuSI/E=; b=CUJjtxBinEu+HCHR0pkQ66sNLG
	zBCFxcd/c9xGd/TtgT9ArE8qGMycLVSOHNcBlApCiYDnKvkOQCsVIkMBdTGwlOf/C2zRO2x2s9IxY
	K9O+45c1LO++pQ1hBQB8N9fAAV2RJU0DjPuaz7idRlb5OVKyF8QUy8aJoXjocSFtX8YU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tsUHx-004nYU-QD; Wed, 12 Mar 2025 23:10:57 +0100
Date: Wed, 12 Mar 2025 23:10:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: "Gupta, Suraj" <Suraj.Gupta2@amd.com>,
	"Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"git (AMD-Xilinx)" <git@amd.com>,
	"Katakam, Harini" <harini.katakam@amd.com>
Subject: Re: [PATCH net-next V2 2/2] net: axienet: Add support for 2500base-X
 only configuration.
Message-ID: <186bf47a-04af-4bfb-a6d3-118b844c9ba8@lunn.ch>
References: <20250312095411.1392379-1-suraj.gupta2@amd.com>
 <20250312095411.1392379-3-suraj.gupta2@amd.com>
 <ad1e81b5-1596-4d94-a0fa-1828d667b7a2@lunn.ch>
 <Z9GWokRDzEYwJmBz@shell.armlinux.org.uk>
 <BL3PR12MB6571795DA783FD05189AD74BC9D02@BL3PR12MB6571.namprd12.prod.outlook.com>
 <34ed11e7-b287-45c6-8ff4-4a5506b79d17@lunn.ch>
 <BL3PR12MB6571540090EE54AC9743E17EC9D02@BL3PR12MB6571.namprd12.prod.outlook.com>
 <fd686050-e794-4b2f-bfb8-3a0769abb506@lunn.ch>
 <BL3PR12MB6571959081FC8DDC5D509560C9D02@BL3PR12MB6571.namprd12.prod.outlook.com>
 <Z9HjOAnpNkmZcoeo@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9HjOAnpNkmZcoeo@shell.armlinux.org.uk>

> This is not an approach that works with the Linux kernel, sorry.
> 
> What we have today is a driver that works for people's hardware - and
> we don't know what the capabilities of that hardware is.
> 
> If there's hardware out there today which has XAE_ABILITY_2_5G set, but
> defaults to <=1G mode, this will work with the current driver. However,
> with your patch applied, it stops working because instead of the driver
> indicating MAC_10FD | MAC_100FD | MAC_1000FD, it only indicates
> MAC_2500FD. If this happens, it will regress users setups, and that is
> something we try not to do.
> 
> Saying "someone else needs to add the code for their FPGA logic" misses
> the point - there may not be "someone else" to do that, which means
> the only option is to revert your change if it were merged. That in
> itself can cause its own user regressions because obviously stuff that
> works with this patch stops working.
> 
> This is why we're being cautious, and given your responses, it's not
> making Andrew or myself feel that there's a reasonable approach being
> taken here.
> 
> >From everything you have said, I am getting the feeling that using
> XAE_ABILITY_2_5G to decide which of (1) or (2) is supported is just
> wrong. Given that we're talking about an implementation that has been
> synthesized at 2.5G and can't operate slower, maybe there's some way
> that could be created to specify that in DT?
> 
> e.g. (and I'm sure the DT folk aren't going to like it)...
> 
> 	xlnx,axi-ethernet-X.YY.Z-2.5G
> 
> (where X.YY.Z is the version) for implementations that can _only_ do
> 2.5G, and leave all other implementations only doing 1G and below.
> 
> Or maybe some DT property. Or something else.

Given that AMD has been talking about an FPGA, not silicon, i actually
think it would be best to change the IP to explicitly enumerate how it
has been synthesised. Make use of some register bits which currently
read as 0. Current IP would then remain as 1000BaseX/SGMII,
independent of how they have been synthesised. Newer versions of the
IP will then set the bits if they have been synthesised as 2) or 3),
and the driver can then enable that capability, without breaking
current generation systems. Plus there needs to be big fat warning for
anybody upgrading to the latest version of the IP for bug fixes to
ensure they correctly set the synthesis options because it now
actually matters.

	 Andrew

