Return-Path: <netdev+bounces-102729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B442E9046AD
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 00:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B73FE1C238BF
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 22:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBE61552F5;
	Tue, 11 Jun 2024 22:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="j2383kz4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DA52D611;
	Tue, 11 Jun 2024 22:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718143398; cv=none; b=B9OYPFvjBFgE1hXWhZIPsjmehgUbE90p+kNkI4Y+BKgWMljfxKF0dwgOudMb2cZk42co26T4zbWLMYWgC6yrho5D3arJWyjCz/Wd3qgkvkyPj5IfXCD9fbv3t1W92GycHBHagCMx399AouAfJJVV78Xa9S0HtJ5Pg6FTAoptiVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718143398; c=relaxed/simple;
	bh=3rPUdKbtViSdk09zudZD2AmmmcopXye5JepDpAK3whE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GREQWS4e6dxIcRWFToJk+IEsPrlQhIj/4pqD7FCCVqnr5STrj3Fgknzppu2ZqeR/6A4X5iic9W+ryD6+KzQNJk809pc8nDOOa35B3NExfqNqfKaQu7A5p7fmeFOih3Gvwmi6kOoGvFP32a1BmlfR1q6HU+7WUixjUv7qPKbHqoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=j2383kz4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=C5mPl2mcX1d8g/QBmFMcrKFqEz6OxAEd1x9a71sf7NE=; b=j2383kz4wu5qKoA1zTomzxQj5D
	VFcTwQZ78UCVmOsfWyPtdk50P7UEz6nhKtZxdoG9SNEF7ldl0uomRqKrLM43JmPAcbJ4CCeK8yqew
	h/c2zeRGcuvjGImKkr4N3TpWyJt1aIMlZBxvi5O83fPjb/1h+B41/2mQQQbOD8YCBDX4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sH9a0-00HQgJ-T3; Wed, 12 Jun 2024 00:03:00 +0200
Date: Wed, 12 Jun 2024 00:03:00 +0200
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
Message-ID: <b5d9f1ff-0b0f-4c97-9d1c-4ba4468ce6e3@lunn.ch>
References: <20240518124234.2671651-1-s-vadapalli@ti.com>
 <20240518124234.2671651-2-s-vadapalli@ti.com>
 <642c8217-49fe-4c54-8d62-9550202c02c9@lunn.ch>
 <6e520ad0-0f9b-4fee-87fe-44477b01912b@ti.com>
 <287322d3-d3ee-4de6-9189-97067bc4835c@lunn.ch>
 <3586d2d1-1f03-47b0-94c0-258e48525a9d@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3586d2d1-1f03-47b0-94c0-258e48525a9d@ti.com>

> System Architecture and Implementation Details
> ==============================================
> 
> The CPSW Ethernet Switch has a single Host Port (CPU facing port) through
> which it can receive data from the Host(s) and transmit data to the
> Host(s).

So there is a single host port, but it can support multiple hosts,
each having a subset of the available DMA channels. Maybe it is
explain later, but why call it a _single_ host port? Apart from the
DMA channels, are there other things the hosts are sharing?

> The exchange of data occurs via TX/RX DMA Channels (Hardware
> Queues). These Hardware Queues are a limited resource (8 TX Channels and
> up to 64 RX Flows). If the Operating System on any of the cores is the
> sole user of CPSW then all of these Hardware Queues can be claimed by that
> OS. However, when CPSW has to be shared across the Operating Systems on
> various cores with the aim of enabling Ethernet Functionality for the
> Applications running on different cores, it is necessary to share these
> Hardware Queues in a manner that prevents conflicts. On the control path
> which corresponds to the configuration of CPSW to get it up and running,
> since there is no Integrated Processor within CPSW that can be programmed
> with a startup configuration, either the Operating System or Firmware
> running on one of the cores has to take the responsibility of setting it.
> One option in this case happens to be the Ethernet Switch Firmware (EthFw)
> which is loaded by the Bootloader on a remote core at the same time that
> Linux and other Operating Systems begin booting. EthFw quickly powers on
> and configures CPSW getting the Forwarding Path functional.

At some point, a definition of functional will be needed. How does the
EthFw know what is required? Should Linux care? Can Linux change it?

> Once Linux and
> other Operating Systems on various cores are ready, they can communicate
> with EthFw to obtain details of the Hardware Queues allocated to them to
> exchange data with CPSW.

> With the knowledge of the Hardware Queues that
> have been allocated, Linux can use the DMA APIs to setup these queues
> to exchange data with CPSW.

This might be an important point. You communicate with the CPSW. You
don't communicate transparently through the CPSW to external ports?
There is no mechanism for a host to say, send this packet out port X?
It is the CPSW which decides, based on its address tables? The
destination MAC address decides where a packet goes.

> Setting up the Hardware Queues alone isn't sufficient to exchange data
> with the external network. Consider the following example:
> The ethX interface in userspace which has been created to transmit/receive
> data to/from CPSW has the user-assigned MAC Address of "M". The ping
> command is run with the destination IP of "D". This results in an ARP
> request sent from ethX which is transmitted out of all MAC Ports of CPSW
> since it is a Broadcast request. Assuming that "D" is a valid
> destination IP, the ARP reply is received on one of the MAC Ports which
> is now a Unicast reply with the destination MAC Address of "M". The ALE
> (Address Lookup Engine) in CPSW has learnt that the MAC Address "M"
> corresponds to the Host Port when the ARP request was sent out. So the
> Unicast reply isn't dropped. The challenge however is determining which
> RX DMA Channel (Flow) to send the Unicast reply on. In the case of a
> single Operating System owning all Hardware Queues, sending it on any of
> the RX DMA Channels would have worked. In the current case where the RX
> DMA Channels map to different Hosts (Operating Systems and Applications),
> the mapping between the MAC Address "M" and the RX DMA Channel has to be
> setup to ensure that the correct Host receives the ARP reply. This
> necessitates a method to inform the MAC Address "M" associated with the
> interface ethX to EthFw so that EthFw can setup the MAC Address "M" to
> RX DMA Channel map accordingly.

Why not have EthFW also do learning? The broadcast ARP request tells
you that MAC address M is associated to a TX DMA channel. EthFW should
know the Rx DMA channel which pairs with it, and can program ALE.

That is how a switch works, it learns what MAC address is where, it is
not told.

> At this point, Linux can exchange data with the external network via CPSW,
> but no device on the external network can initiate the communication by
> itself unless it already has the ARP entry for the IP Address of ethX.
> That's because CPSW doesn't support packet replication implying that any
> Broadcast/Multicast packets received on the MAC Ports can only be sent
> on one of the RX DMA Channels.

That sounds broken.

And this is where we need to be very careful. It is hard to build a
generic model when the first device using it is broken. Ethernet
switches have always been able to replicate. Dumb hubs did nothing but
replicate. Address learning, and forwarding out specific ports came
later, but multicast and broadcast was always replicated. IGMP
snooping came later still, which reduced multicast replication.

And your switch cannot do replication....

> So the Broadcast/Multicast packets can
> only be received by one Host. Consider the following example:
> A PC on the network tries to ping the IP Address of ethX. In both of the
> following cases:
> 1. Linux hasn't yet exchanged data with the PC via ethX.
> 2. The MAC Address of ethX has changed.
> the PC sends an ARP request to one of the MAC Ports on CPSW to figure
> out the MAC Address of ethX. Since the ARP request is a Broadcast
> request, it is not possible for CPSW to determine the correct Host,
> since the Broadcast MAC isn't unique to any Host. So CPSW is forced
> to send the Broadcast request to a preconfigured RX DMA Channel which
> in this case happens to be the one mapped to EthFw. Thus, if EthFw
> is aware of the IP Address of ethX, it can generate and send the ARP
> reply containing the MAC Address "M" of ethX that it was informed of.
> With this, the PC can initiate communication with Linux as well.
> 
> Similarly, in the case of Multicast packets, if Linux wishes to receive
> certain Multicast packets, it needs to inform the same to EthFw which
> shall then replicate the Multicast packets it received from CPSW and
> transmit them via alternate means (Shared Memory for example) to Linux.

This all sounds like you are working around broken behaviour, not
something generic.

What i actually think you need to do is hide all the broken
behaviour. Trap all multicast/broadcast to EthFw. It can run a
software bridge, and do learning. It will see the outgoing ARP request
from a host and learn the host MAC address. It can then flood the
packet out the external ports, working around the CSPW brokeness. It
can also program the ALE, so the reply goes straight to the
host. Incoming broadcast and multicast is also trapped to the EthFW
and it can use its software bridge to flood the packet to all the
hosts. It can also perform IGMP snooping, and learn which hosts are
interested in Multicast. 

Your switch then functions as a switch.

And you are then the same as the RealTek and Samsung device. Linux is
just a plain boring host connect to a switch, which somebody else is
managing. No new model needed.

> All data between Linux (Or any Operating System) and EthFw is exchanged
> via the Hardware Mailboxes with the help of the RPMsg framework. Since
> all the resource allocation information comes from EthFw, the
> vendor-specific implementation in the Linux Client is limited to the DMA
> APIs used to setup the Hardware Queues and to transmit/receive data with
> the Ethernet Switch. Therefore, it might be possible to move most of the
> vendor specific implementation to the Switch Configuration Firmware
> (similar to EthFw), to make the Linux Client implementation as generic
> and vendor agnostic as possible. I believe that this series more or less
> does the same, just using custom terminology which can be made generic.

This is actually very similar to what your college is doing:

https://lore.kernel.org/netdev/20240531064006.1223417-1-y-mallik@ti.com/

The only real difference is shared memory vs DMA.

	Andrew

