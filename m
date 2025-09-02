Return-Path: <netdev+bounces-219131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EA8B40090
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBB347B3E70
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 12:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F392DEA6B;
	Tue,  2 Sep 2025 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zMjI/CMs"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB27B2FDC25;
	Tue,  2 Sep 2025 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756816226; cv=none; b=fJcXTrSFQZR4JKWxo/nwhqh0Xn2/lLLWPTGlRPQyL0a+S0jRcN846BwF8br6RaRMZF10U5w+fQ19AYsgRW7suIGuHyeUy1eh/+gxxLQmg4Xr+adH45Xv9gdgg84q98SgAAo6RGWmWDBvaUygIuTus5WzxOdZt9948hd8RRRRPzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756816226; c=relaxed/simple;
	bh=czukquVg7XF9DJNYEyglglLki1nDEidWaPA+xQuQ6EA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIPsHn9+4YNDN8OOfdkBcBe3K+8KuY0d34dxeYdTO+Y+4e7uMCQptiYBbSvs7+9dZ/WeIq87BZAvqmQ2TvXYeoavJmX7zJagD47EtNiNX2Y149PSqrnZD6Mtz6Mu3Doe9wm+wuLl56SZP1PqaPEcnQ0FdqhJMhLCioCwGDQWG3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zMjI/CMs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NMP/CTl2ylNMD3ybJrgMRzD8EiCJt79eet20qgFJRWo=; b=zMjI/CMsKOG9X3LXK1NdFAd+7Q
	wk66xQtu77dJTWA3aIlbuqshCxn2FCQ2PL4FhdfNQW6v/L2+mpPB3Q927olX1qhWnncsc+0F0z+uV
	KGRcNp9okqD6bztwTdjtw5MK+UDET1NWa5S1UZliMtIPVOdnGpKwkZExmoh+nvdVLU9M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1utQ9T-006sqn-TD; Tue, 02 Sep 2025 14:30:19 +0200
Date: Tue, 2 Sep 2025 14:30:19 +0200
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
Message-ID: <8fa4504e-e486-41d0-9140-b24187626850@lunn.ch>
References: <20250829124843.881786-1-jchng@maxlinear.com>
 <20250829124843.881786-3-jchng@maxlinear.com>
 <65771930-d023-49e1-87a7-e8c231e20014@lunn.ch>
 <PH7PR19MB56360AF7B6FCB1AAD0B27120B407A@PH7PR19MB5636.namprd19.prod.outlook.com>
 <398ad4b1-1bd3-4adc-8bda-5cc8f1b99716@lunn.ch>
 <PH7PR19MB56366632D5609B0B51FE8939B406A@PH7PR19MB5636.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR19MB56366632D5609B0B51FE8939B406A@PH7PR19MB5636.namprd19.prod.outlook.com>

> Hi Andrew,
> 
> Thank you for your valuable feedback.
> 
> The switch core hardware block is part of the MaxLinear Lightning
> Mountain (LGM) SoC, which integrates Ethernet XGMACs for connectivity
> with external PHY devices via PCS. 
> At initialization, we configure the switch core ports to enable only
> Layer 2 frame forwarding between the CPU (Host Interface) port and the
> Ethernet ports.

So there is a dedicated port for the CPU. That is one valuable piece
of information for this decision.

> L2/FDB learning and forwarding will not be enabled for any port.
> The CPU port facilitates packet transfers between the Ethernet ports
> and the CPU within the SoC using DMA. All forwarding and routing
> logic is handled in the Linux network stack. 
> 
> LGM SoC also has a separate HW offload engine for packet routing and
> bridging per flow.  This is not within the scope of this patch series.
> 
> > Are there any public available block diagrams of this device?
> 
> We will  update the documentation accordingly in the upcoming version.
> Please find the packet flow at a high level below:
> Rx: 
> PHY -> Switch Core XGMAC -> Host Interface Port -> DMA Rx -> CPU 
> Tx:
> CPU -> DMA Tx -> Host Interface Port -> Switch Core XGMAC -> PHY
> 
> > How does the host direct a frame out a specific port of the switch?
> 
> In the TX direction, there is a predefined mapping between the Ethernet
> interface and the corresponding destination switch port. 
> The Ethernet driver communicates this mapping to the DMA driver, 
> which then embeds it into the DMA descriptor as sideband information.

So, there are not DMA channels per port. The CPU has a collection of
DMA channels, it can pick any, and just needs to set a field in the
DMA descriptor to indicate the egress port.

> This ensures that the data is forwarded correctly through the switch fabric
> 
> > How does the host know which port a frame came in on?
> 
> On the RX side, the source switch port  is mapped to a specific DMA Rx
> channel. The DMA Rx descriptor also carries the ingress port as
> sideband information.
> Either of these methods can be used to determine the source switch port.

So here you do have a fixed mapping of port to DMA channel, but you
don't actually need it.

So this sounds a bit like the Qualcomm IPQESS device.

https://lists.infradead.org/pipermail/linux-arm-kernel/2022-May/743213.html

This never got merged, but it was going the direction of a DSA driver.
However, you could also do a pure switchdev driver.

The advantage of a DSA driver would be a lot of infrastructure you can
just use, where as a pure switchdev driver will require you to
reinvent a few wheels. So a DSA driver would be smaller, simpler, less
bugs.

	Andrew


