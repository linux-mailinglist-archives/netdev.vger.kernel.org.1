Return-Path: <netdev+bounces-100611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F192C8FB512
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 209D61C215C8
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 14:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F75139851;
	Tue,  4 Jun 2024 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YzBkYqjj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385C16FD5;
	Tue,  4 Jun 2024 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510837; cv=none; b=geBN+/N6rpsrqTZwE+jwL95wFRryB1ACfYWyQ+q/Tq5V+G4W5ln3yQ1cAyWcLwXm+2jFqoBjT95WqQRA+hvJYeR6GGumCtqQj9TykkwZDYooERW4CfuNu7Aws69XYTDY5iTr+2zEhYdg5yylZ0UGie/LJbE8DQZ+FMdQIBCmz9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510837; c=relaxed/simple;
	bh=hyfXcuem/Nx4Op0XAHFvKe86UOgEtUMRJg7GLXNd5ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtC5bDJaOqF+QcS8LlUVJ+J76bAfsMU6vWXVSWs+MgRM2x0CyDD94wMg333LYeWoyzt97TWZkJpjVOWf2ncaa/ldhNjq0hnjGvZWZDoUqFM8Q1bS5tO/0w3DaoAM4lV3Cz3hNxn7t9kbd2H307tpkAZdvBNBZU0R5LELavWBXZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YzBkYqjj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZqoH/7o92IP6GbQabg4mgf4qXmnCbH58Lc5e8Elymo4=; b=YzBkYqjjzAF9K+AtaSkj1lU01W
	8xuw46nPy3p0M2vCYix6G48cBajHpq9NsvC49rPbGE/Gmi+aTM83XdXRE7dV/jj/aXfgwnligF23I
	yQXgG+dhG2x39lQQqLVYkNskNmoUtD0J2GETqFgawJKQ+Pta8afODHy+bc8/5tgFopNI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sEV1M-00GoUr-3R; Tue, 04 Jun 2024 16:20:16 +0200
Date: Tue, 4 Jun 2024 16:20:16 +0200
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
Message-ID: <287322d3-d3ee-4de6-9189-97067bc4835c@lunn.ch>
References: <20240518124234.2671651-1-s-vadapalli@ti.com>
 <20240518124234.2671651-2-s-vadapalli@ti.com>
 <642c8217-49fe-4c54-8d62-9550202c02c9@lunn.ch>
 <6e520ad0-0f9b-4fee-87fe-44477b01912b@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e520ad0-0f9b-4fee-87fe-44477b01912b@ti.com>

On Sun, Jun 02, 2024 at 09:36:05AM +0530, Siddharth Vadapalli wrote:
> On Sun, May 19, 2024 at 05:31:16PM +0200, Andrew Lunn wrote:
> 
> Andrew,
> 
> I have spent time going through your feedback, trying to understand your
> suggestions. This email is the complete reply corresponding to my earlier
> reply at:
> https://lore.kernel.org/r/0b0c1b07-756e-439e-bfc5-53824fd2a61c@ti.com/
> which was simply meant to serve as an acknowledgement that I have seen
> your email.
> 
> > On Sat, May 18, 2024 at 06:12:07PM +0530, Siddharth Vadapalli wrote:
> > > The CPSW Proxy Client driver interfaces with Ethernet Switch Firmware on
> > > a remote core to enable Ethernet functionality for applications running
> > > on Linux. The Ethernet Switch Firmware (EthFw) is in control of the CPSW
> > > Ethernet Switch on the SoC and acts as the Server, offering services to
> > > Clients running on various cores.
> > 
> > I'm not sure we as a community what this architecture. We want Linux
> > to be driving the hardware, not firmware. So expect linux to be
> > running the server.
> 
> Due to the use-case requirements, Linux cannot be the server. Some of
> the requirements are:
> 1. Fast startup and configuration of CPSW independent of Linux and Other
> OS running on any of the cores on the SoC. The configuration of CPSW has
> to be performed in parallel while the Bootloader starts Linux.
> 2. CPSW has to be functional and configurable even when Linux has been
> suspended. One of the non-Linux Clients happens to be the AUTOSAR Client
> which continues exchanging network data via CPSW even when Linux has
> been suspended. So the server has to be functional even then, in order
> to cater to the AUTOSAR Client's requests to configure CPSW. CPSW's
> configuration is not static in the sense that it gets programmed and
> will no longer be modified. Therefore the server has to be functional at
> all times to update CPSW's configuration based on the demands of any of
> the Clients.
> 
> For more details about the Ethernet Switch Firmware (EthFw) and the set
> of Clients running on remote cores, please refer:
> https://software-dl.ti.com/jacinto7/esd/processor-sdk-rtos-jacinto7/09_02_00_05/exports/docs/ethfw/docs/user_guide/ethfw_c_ug_top.html#ethfw_remote_clients

Thanks for the links etc.

I also admit, i did replied too soon, and should of read more of the
patches.

In Linux, we have two models with respect to switches.

1) They are external. Linux does not interact with them, other than
sending them packets, and receiving packets from them. The switch
might have some management interface, SNMP, HTTP, etc, but it is not
linuxs job to manage the switch. Linux just has its NIC connected to
the port of switch using a cable. This is the model used for a very
long time.

2) The Linux kernel is controlling the switch, configuration is
performed from userspace using iproute2. Switchdev is used internally
to interface between the linux network stack and the switch
driver. Depending on implementation, linux can either directly write
switch registers, or it can perform an RPC to firmware running on the
switch. But this is an implementation detail, Linux is in control of
all the ports, all the routing/switching, IGMP snooping, STP, PTP,
etc.

Could what Linux sees of this hardware fit into the first model? Linux
just sees a bunch of NICs connected to a switch? The switch is remote,
linux has no control over it. Linux acts purely as a client for low
level protocols like PTP, IGMP snooping, etc. It has no knowledge of
other ports of the switch, there up/down state, what STP is doing in
the switch, how PTP is forwarding packets from the upstream port to
the downstream ports. Linux has no idea and no access to the address
lookup engines in the switch. The switch is colocated in the same
silicon, but all linux has is some ports connected to the switch,
nothing more?

What is interesting is Realteks current driver work for there
automotive system. There CPU has one MAC which is connected to the
internal switch. But they have a similar setup, Linux is not
controlling the switch, some other firmware is. They have PTP, IGMP
snooping, STP etc running in firmware. Linux just has a NIC connected
to the switch as an end system.

If you do want to add a third model, where Linux has some insight into
the switch, you need to coordinate with other vendors in the
automotive world, and come up with a model which everybody can
use. What i don't want is a TI model, followed by a Realtek model,
followed by a vendor XYZ model. So if you need more than what the
first model above provides, you will need to get a consortium of
vendors together to design a new model a few vendors agree on.

	Andrew

