Return-Path: <netdev+bounces-102997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EA6905EA2
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 00:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C28BB1F221D1
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 22:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405EE12BEBB;
	Wed, 12 Jun 2024 22:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0dbDj2M2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF44321360;
	Wed, 12 Jun 2024 22:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718232021; cv=none; b=cjDkcaVes8ikDowcMxM47oV+Ie7LA7P4/NcXYSwo79geqWQpBlmgzCtezkjFf0yVmqS3U5oSIS8ihTifAHftySL4xr7xkhL+supQW8E6CNLmPI+fVkWNXUclqm++gdLNidgZgoppY9Kf9oI96cGwpSzon0r9DucmgBfNZmgHRPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718232021; c=relaxed/simple;
	bh=rYC+czHxcKQYzM+1xUOS8jIq0Bj1p1M06sPe50hUMaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhsjxSlxpQIYUMs0rAu2mr1k9/s6flL8rIODDmaHxk6FMVR+XzjWyuW5Gfrv3tKv9gbMbyINESxVNQg3yZDxC+xznioYPrdiH3mYetrcbw7SzcpfdCIiA5qzjcfOowKUsCxGi0cQC1pgCJFV10xFwPUOqdr+ABniNMRlQpSGyHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0dbDj2M2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MsPOlnETfMLsWfJG4LxUIQ4Q97ttuBHiEzDMtNO+4XY=; b=0dbDj2M2GnzRqlZohCLFCXyshs
	kz6a08uiUUtFwsKJ4S2VRwr9OPhKpDPxdNxpKu0COUfbC6HjPduXU3Goo3+kZiPcnNdQMdWB7BLlE
	EAxKVaItgAYvOeTYb8i+SDEJVqxHe+Mw8S1cz5I4tSlQ3jUSgEeEK9rAcHztCh/FLPGc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sHWdQ-00HVWQ-4G; Thu, 13 Jun 2024 00:40:04 +0200
Date: Thu, 13 Jun 2024 00:40:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, corbet@lwn.net, rogerq@kernel.org,
	danishanwar@ti.com, vladimir.oltean@nxp.com, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, vigneshr@ti.com,
	misael.lopez@ti.com, srk@ti.com
Subject: Re: [RFC PATCH net-next 01/28] docs: networking: ti: add driver doc
 for CPSW Proxy Client
Message-ID: <1a966d5f-9eca-4d6d-812b-98ac17579cd7@lunn.ch>
References: <20240518124234.2671651-1-s-vadapalli@ti.com>
 <20240518124234.2671651-2-s-vadapalli@ti.com>
 <642c8217-49fe-4c54-8d62-9550202c02c9@lunn.ch>
 <6e520ad0-0f9b-4fee-87fe-44477b01912b@ti.com>
 <287322d3-d3ee-4de6-9189-97067bc4835c@lunn.ch>
 <3586d2d1-1f03-47b0-94c0-258e48525a9d@ti.com>
 <b5d9f1ff-0b0f-4c97-9d1c-4ba4468ce6e3@lunn.ch>
 <77267e15-b986-4b54-9e12-fb9536432ac2@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77267e15-b986-4b54-9e12-fb9536432ac2@ti.com>

> The DMA Channels provide a path to/from CPSW's Host Port for each Host.
> 
> Please refer to the following illustration corresponding to the data
> movement from each of the Hosts to the CPSW's Host Port via the ALE and
> then out of the MAC Ports:
> 
>            -------      ---------            ---------   CONTROL-PATH
>            |Linux|      |AUTOSAR|            | EthFW | -------------
>            -------      ---------            ---------             |
>             |   |         |   |               |    |               |
> DATA       TX   RX       TX   RX              TX   RX              |
> PATH =>     |   |         |   |               |    |               |
> (DMA)       |   |         |   |               |    |               |
> 	    |   |         |   |               |    |               |
> 	    \   \         \   \               /    /               |
> 	     \   \         \   \             /    /                |
> 	      \   \         \   \           /    /                 |
> 	       \   \         \   \         /    /                  |
> 	        \   \         \   \       /    /                   |
>                 ===============================                    |
>                ||        CPSW HOST PORT       ||                   V
>                 ===============================             -----------
> 			     	|                           |CPSW     |
> 			     TX + RX                        |CONTROL  |
> 			     	|                           |REGISTERS|
> 			     	|                           -----------
> 			     	|
>                        ===================
> 		      ||ALE & SWITCH CORE||
>                        ===================
>                         /  |      |    \
> 		       /   |      |     \
> 		      /    |      |      \
> 		    TX+RX  |       \      -------
> 		    /      |        \            \
> 		   /     TX+RX     TX+RX        TX+RX
>                   /        |          \            \
>         ==========    ==========    ==========    ==========
>        |MAC Port 1|  |MAC Port 2|  |MAC Port 3|  |MAC Port 4|
>         ==========    ==========    ==========    ==========


So, in summary, you have one host port, and on top of that a number of
virtual ports. Because of limitations in the ALE, those virtual ports
don't work in the same way as real ports, replication is not possible,
nor learning for individual virtual ports. The typical 1990 solution
to that would be to flood packets to all hosts, and let them filter
out the packets they are not interested in. 1990 Ethernet was a shared
medium, you expect to see packets for other hosts. But the hardware
also cannot do that.

So you have to program the classify to augment the ALE, and the
classifier is the one that decides which virtual port a packet goes
out. But the classifier does not perform learning. You need additional
mechanisms to program that classifier.

> Host which has registered with that MAC Address "M". This is handled by
> EthFw. EthFw doesn't/cannot snoop on all traffic on the Host Port, since
> it doesn't lie in between the Host Port and the other Hosts. Rather, it
> is quite similar to a Host itself since it also has dedicated TX/RX DMA
> Channels to exchange traffic with CPSW.

I did not say snoop. I said trap. There is a difference. Snoop would
be it sees the packet, as it going by. Trap means it actually gets
passed the packet, and it needs to deal with it, decide the outgoing
port.

So i would trap all broadcast and multicast from the virtual ports to
the EthFW. Let the EthFw deal with that traffic, perform learning, and
programming the classifier, and flood it out user ports for broadcast,
or unicast out specific ports for multicast where IGMP snooping
indicates it should go.

> Since that is not supported, all
> Broadcast/Multicast traffic directed to the Host Port from the Switch Core
> is by default placed on the RX DMA Flow corresponding to EthFw. EthFw then
> creates copies of these in software and shares them with each Host via
> Shared Memory for example.

Why shared memory? EthFw needs to be able to direct packets out
specific virtual ports otherwise it cannot do {R}STP, PTP, IGMP
snooping etc. So it should just pass the packet back to the CPSW,
which will hairpin the packet, hit the classifier, and then send it
out the correct virtual port to the correct host.

> Yes, the Shared Memory path is intended for the low-bandwidth
> Broadcast/Multicast traffic from EthFw while the DMA path is dedicated
> for high-bandwidth Unicast traffic. The current series implements the
> DMA path while the other series you have referred to implements the
> Shared Memory path. Both of them together enable the desired functionality.

So i think we are agreed a new model is not needed. Linux is just a
host connected to a managed switch. Linux has no roll in managing that
switch, and has no idea about the ports of that switch. It is just an
end system, running end system software.

You need a 'MAC' driver in Linux, so Linux sees just a normal network
interface. And it must see a single MAC driver, so if you really do
need to use shared memory in parallel to DMA, you will need to combine
that into one driver.

     Andrew

