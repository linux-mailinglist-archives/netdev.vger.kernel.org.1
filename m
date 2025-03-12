Return-Path: <netdev+bounces-174245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C49EA5DF92
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 15:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE4C171277
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 14:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B9124BC07;
	Wed, 12 Mar 2025 14:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sAbZoGCA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0259F24500F;
	Wed, 12 Mar 2025 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741791544; cv=none; b=jzqUS2U3KDqI4yKp48HZxWnB7HkkwFyWunQ0kqApAlQ8NZrALPvAqMJkjHRJLF/Fl65M8iJrO7+LstAGKTgaMrl67yHLvFANaRi14MBNTepZJCRpJXDC6As8yHxxbkxUVc2dUCkaiuwvc5R3dbbsQzhb1QJn6VzAsoXiVv1EOeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741791544; c=relaxed/simple;
	bh=rqtsorVxeT/UcYbtW74hOajsi/kKskf3UdlHs8QdsIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPcEu7Y4M2bEMpJrRRnQWGcO6wEmgLWuSy9wCBo0c684N/WLmsfFVWF1d2v09TU+u9tLJuykcf+E/38p4Nyc9mb2QJK1svlJH5hRD2YatbHVLTbObQ2TlAbTQ6BJx9JkHEpD38SDvfCf1CMRqGKGW4jWx4ylw5PxixjQRXiT9Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sAbZoGCA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+T/w2/VBo7X+S3ivNqnFFzhypZQMklkKS536n+tlnR0=; b=sAbZoGCAsXA1U0VGKX4h7NMH5y
	BxIMWJFCCoxUos0ItYNQvQh2ZgR13vyahlJ7AkASJFxCxweNjM6Vlb/PKwrv7PnN+mrWvoEkhkcYR
	ZMgmm/SBTTilJ4p4gHbDFHA4IunP+alIVPwJUYSs1BFdr7f81QijJv+8S39IOGD1l5O4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tsNXp-004hII-20; Wed, 12 Mar 2025 15:58:53 +0100
Date: Wed, 12 Mar 2025 15:58:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
Cc: Russell King <linux@armlinux.org.uk>,
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
Message-ID: <34ed11e7-b287-45c6-8ff4-4a5506b79d17@lunn.ch>
References: <20250312095411.1392379-1-suraj.gupta2@amd.com>
 <20250312095411.1392379-3-suraj.gupta2@amd.com>
 <ad1e81b5-1596-4d94-a0fa-1828d667b7a2@lunn.ch>
 <Z9GWokRDzEYwJmBz@shell.armlinux.org.uk>
 <BL3PR12MB6571795DA783FD05189AD74BC9D02@BL3PR12MB6571.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL3PR12MB6571795DA783FD05189AD74BC9D02@BL3PR12MB6571.namprd12.prod.outlook.com>

> > On Wed, Mar 12, 2025 at 02:25:27PM +0100, Andrew Lunn wrote:
> > > > +   /* AXI 1G/2.5G ethernet IP has following synthesis options:
> > > > +    * 1) SGMII/1000base-X only.
> > > > +    * 2) 2500base-X only.
> > > > +    * 3) Dynamically switching between (1) and (2), and is not
> > > > +    * implemented in driver.
> > > > +    */

> - Keeping previous discussion short, identification of (3) depends
> on how user implements switching logic in FPGA (external GT or RTL
> logic). AXI 1G/2.5G IP provides only static speed selections and
> there is no standard register to communicate that to software.

So if anybody has synthesised it as 3) this change will break their
system?

	Andrew

