Return-Path: <netdev+bounces-218752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F223FB3E449
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 15:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 948CE1A843B6
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 13:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140311D88D7;
	Mon,  1 Sep 2025 13:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GqYf8255"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369DD19F11E;
	Mon,  1 Sep 2025 13:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756732277; cv=none; b=H16vlC13o80/r7msYkpEHBAUVIzddurrRjRxk4AWjiJzbj0yJ9LqNRF2u4WCKfk/Epj+TENW2ccvDpOZv6qqbK2k0HCr8ELmCT6N5GNAtaEJdAGgAsqhkmieEtj6YxZ8qc7PjcJAWhvkppFhqmfc271QsewKq3QG3OFuBeG4Fss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756732277; c=relaxed/simple;
	bh=4n93srW3Uf6HaSLH4EuetJft7bKYSG3S1uTAxo7hgIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlT8mz38N25i9VKq8WuSeSBmOZ9p2d2mtZi8zkW/NwITvWh4vCilMR9pXZT2U7quxBV6GZrRjrP/UFeTLUroFEcBEKAwIeCBtbyL57q+OK9E+27a/OXmv/KKD35mAnVm9iM8VPOcb/+H35TmTmuRl1fi1xasV3PVBldc8MAhvqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GqYf8255; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BH4e93OAzG4ly146yOK0V5DZKaGTbR3A6urXJYn+Ico=; b=GqYf8255+GqVO+8+YfbqIsdvZl
	xDv4EwhKN0TrHE2iwb0o1Uuh5ri8PbG76MUuOcu1evyf9kAEfyc7D1VswoPgXaRNTXFz5Z0Xv5G/x
	zAXYRkhsgL5WEuHfz7h6cwzXLiOP5c3TfLe5PupMziMdpOLT8XimV6iF5HbVwu2HRJ2M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ut4JQ-006m2M-7V; Mon, 01 Sep 2025 15:11:08 +0200
Date: Mon, 1 Sep 2025 15:11:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jack Ping Chng <jchng@maxlinear.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Yi xin Zhu <yzhu@maxlinear.com>,
	Suresh Nagaraj <sureshnagaraj@maxlinear.com>
Subject: Re: [PATCH net-next v3 2/2] net: maxlinear: Add support for MxL LGM
 SoC
Message-ID: <398ad4b1-1bd3-4adc-8bda-5cc8f1b99716@lunn.ch>
References: <20250829124843.881786-1-jchng@maxlinear.com>
 <20250829124843.881786-3-jchng@maxlinear.com>
 <65771930-d023-49e1-87a7-e8c231e20014@lunn.ch>
 <PH7PR19MB56360AF7B6FCB1AAD0B27120B407A@PH7PR19MB5636.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR19MB56360AF7B6FCB1AAD0B27120B407A@PH7PR19MB5636.namprd19.prod.outlook.com>

On Mon, Sep 01, 2025 at 09:38:44AM +0000, Jack Ping Chng wrote:
> Hi Andrew,
> 
> On Fri, 29 Aug 2025 22:24:06 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > > +This document describes the Linux driver for the MaxLinear Network Processor
> > > +(NP), a high-performance controller supporting multiple MACs and
> > > +advanced packet processing capabilities.
> > > +
> > > +The MaxLinear Network processor integrates programmable hardware accelerators
> > > +for tasks such as Layer 2, 3, 4 forwarding, flow steering, and traffic shaping.
> > 
> > By L2 and L3, do you mean this device can bridge and route frames
> > between ports? So it is actually a switch?
> 
> Yes, the SoC does support packet acceleration. 
> However, this patch series primarily focuses on the host interface to deliver packets to the CPU, 
> where bridging and routing are handled within the network stack.

Linux has two ways to support a switch. Pure switchdev, or switchdev +
DSA. Which to use depends on the architecture of the device. I would
like to check now, before you get too far, what the hardware
architecture is.

Are there any public available block diagrams of this device?

How does the host direct a frame out a specific port of the switch?
How does the host know which port a frame came in on?

	Andrew

