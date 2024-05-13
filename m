Return-Path: <netdev+bounces-96064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 411F58C42D0
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 16:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C89C528104D
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 14:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD4515380B;
	Mon, 13 May 2024 14:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bU9Fuy/G"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4E950279;
	Mon, 13 May 2024 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715609113; cv=none; b=JPcnDMbrESKSHwmPEYlfsv/MtlmCsszB+D8tVMyOquC0QgBxkNkyWfYfr5Eru/usEWzEZfbsH+IG2TI9dC4UZAQmxonJ2yd9BmjGflgoqqsHa2uLS5xp7G0bsv6YaNiplfEPKqHiqJRRj7ZS8HCL3svytSoMXjS4sEDCU2FYJQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715609113; c=relaxed/simple;
	bh=qwjQ4fg1WT6WfdujCf5cSA6FPKSOt1LSqitx8MP9bKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+fx/QI71yjlwFDIlR7mHg8z/V23D4nQ5tdyKd4CL49uWgntrapB+3akWSY7I5dVfpEx60H7jv3yEjoHg4jVuaSsAQZf0oLSsdzOiFPl9EcQa1DCDXGkb4v7PC10vZ1yFpmAunVuunkPA7wcPfR7Y/B5aPUjSOcTHYlNFAj1bz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bU9Fuy/G; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aEGhKcPHh9CD0ui7RPmRSg76vE/Dq4xMw3NyWOINtCw=; b=bU9Fuy/GeuRaJHGhTQLB4qpvcH
	cvKBaa7/AIOhMZOvKgrCuI7WM2kyUuohkdWAAioU75+Di2yG1zJqB+yt7VX3xeTWWj9qshuEPYoT+
	V659BFgGI0LN137cGAl1WQNS/MkbeyQsllBOu4jWpxq5EcPeTbO1bRNIU7jlSY/h+xDg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s6WIQ-00FJKx-7h; Mon, 13 May 2024 16:04:54 +0200
Date: Mon, 13 May 2024 16:04:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"Parthiban.Veerasooran@microchip.com" <Parthiban.Veerasooran@microchip.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>,
	"anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"Horatiu.Vultur@microchip.com" <Horatiu.Vultur@microchip.com>,
	"ruanjinjie@huawei.com" <ruanjinjie@huawei.com>,
	"Steen.Hegelund@microchip.com" <Steen.Hegelund@microchip.com>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	"UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
	"Thorsten.Kummermehr@microchip.com" <Thorsten.Kummermehr@microchip.com>,
	Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>,
	"Nicolas.Ferre@microchip.com" <Nicolas.Ferre@microchip.com>,
	"benjamin.bigler@bernformulastudent.ch" <benjamin.bigler@bernformulastudent.ch>
Subject: Re: [PATCH net-next v4 05/12] net: ethernet: oa_tc6: implement error
 interrupts unmasking
Message-ID: <81170ef6-2b16-4d7f-85b1-4c3fecdc8853@lunn.ch>
References: <874654d4-3c52-4b0e-944a-dc5822f54a5d@lunn.ch>
 <ZjKJ93uPjSgoMOM7@builder>
 <b7c7aad7-3e93-4c57-82e9-cb3f9e7adf64@microchip.com>
 <ZjNorUP-sEyMCTG0@builder>
 <ae801fb9-09e0-49a3-a928-8975fe25a893@microchip.com>
 <fd5d0d2a-7562-4fb1-b552-6a11d024da2f@lunn.ch>
 <BY5PR02MB678683EADBC47A29A4F545A59D1C2@BY5PR02MB6786.namprd02.prod.outlook.com>
 <ZkG2Kb_1YsD8T1BF@minibuilder>
 <708d29de-b54a-40a4-8879-67f6e246f851@lunn.ch>
 <ZkIakC6ixYpRMiUV@minibuilder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkIakC6ixYpRMiUV@minibuilder>

> Good input. I'll add some instrumentation/stats for how many jiffies
> have elapsed between releases of the worker thread and for the irq
> handler. I can probably find a gpio to toggle as well if it's really
> tight timings.

What might be more interesting is the interrupt status registers. Is
there a bit always set which the driver is not clearly correctly?

You can try printing the values. But that might upset the timing so
you cannot reproduce the issue.

If the printk() does upset the timing, what i have done before is
allocate an array of u32 values. Write the interrupt status into it,
looping around when you get to the end of the array. And then use
debugfs_create_u32_array() to export the array in /sys/kernel/debugfs.
Trigger the problem and then look at the values.

> > Is this your dual device board? Do you have both devices on the same
> > SPI bus? Do they share interrupt lines?
> > 
> 
> It's on the dual device board, the macphys are using separate spi buses,
> one chip shares the bus with another spi device, but the other is the
> only tenant on the bus.
> 
> No device shares an irq line.

I was just wondering how your setup differs so you can trigger the
issue, but others have not been able to reproduce it. It might be
another clue as to what is going on. I don't think you need to do
anything with respect to this, its just information to keep in mind.

	Andrew

