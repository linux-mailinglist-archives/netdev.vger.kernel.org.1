Return-Path: <netdev+bounces-97138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B86158C952B
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 17:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4480BB21074
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 15:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7791E51D;
	Sun, 19 May 2024 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bVfau57A"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8770D8F58;
	Sun, 19 May 2024 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716132692; cv=none; b=k71L/Kvv6rc3o5w/ParzpYLsBV1yD8iceCsV+TOAexbLFo+ZL8ZlRdNFZT7cS2/mwIAoNzPs82ZKrOz3o32YBbnRd+qx0wjrCN6kKnODqrzly3cLfBdEtHyO7xdRBwsbM0mXqinEp7Na9Yr1X06EwxQABdxBHSden3U1KISWN3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716132692; c=relaxed/simple;
	bh=b0DmkzNrx+W6swleqyCrcm/0earbkc2m1lDm2uGiSdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEbjTsSEMAecocl9lctTHpmB4BdaoEoqTwZ6eTF6rvV23r0Q4e4x3Ak/zuXevDoAYG5OObs3TYF6LxjD3WpLdefxr/dA4cAgI55qVo02LEuBOLvTuDilFc1teoAKm5vvGHA18ZaKsTVOrQZLBHvQESM8dbBLehQaYfCJD8nqXI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bVfau57A; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/Uig9LqJCJCt5xBuEOZx6meohWHgGKYx6kG+ikgkUrc=; b=bVfau57A2yM0QkCXCzyIbH70lU
	XD9S5qffJ2EKIVZKB+IQnYBDClpp8ROTA2x9m9T/MzNG9VT/KHR7YDDhPG5CT9gf4DS1I6NJACqQ+
	9mcshUV/NNxy7G5eXT7oBH06kmucnyZoQgl6lknyC1Uz0vWjV3k9J9ujWlkTcyGd3n4A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s8iVI-00FezC-Ru; Sun, 19 May 2024 17:31:16 +0200
Date: Sun, 19 May 2024 17:31:16 +0200
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
Message-ID: <642c8217-49fe-4c54-8d62-9550202c02c9@lunn.ch>
References: <20240518124234.2671651-1-s-vadapalli@ti.com>
 <20240518124234.2671651-2-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240518124234.2671651-2-s-vadapalli@ti.com>

On Sat, May 18, 2024 at 06:12:07PM +0530, Siddharth Vadapalli wrote:
> The CPSW Proxy Client driver interfaces with Ethernet Switch Firmware on
> a remote core to enable Ethernet functionality for applications running
> on Linux. The Ethernet Switch Firmware (EthFw) is in control of the CPSW
> Ethernet Switch on the SoC and acts as the Server, offering services to
> Clients running on various cores.

I'm not sure we as a community what this architecture. We want Linux
to be driving the hardware, not firmware. So expect linux to be
running the server.

> +The "am65-cpsw-nuss.c" driver in Linux at:
> +drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +provides Ethernet functionality for applications on Linux.
> +It also handles both the control-path and data-path, namely:
> +Control => Configuration of the CPSW Peripheral
> +Data => Configuration of the DMA Channels to transmit/receive data

So nuss is capable of controlling the hardware. nuss has an upper
interface which is switchdev, and a lower interface which somehow acts
on the hardware, maybe invoking RPCs into the firmware?

So it is not too big a step to put the server functionality in Linux,
on top of the nuss driver.

Now take a step backwards. This concept of a switch with different
CPUs attached to it is nothing special.

Some Marvell switches have a Z80 connected to a dedicated port of the
switch. You can run applications on that Z80. Those applications might
be as simple as spanning tree, so you can have a white box 8 port
ethernet switch without needing an external CPU. But there is an SDK,
you could run any sort of application on the Z80.

The microchip LAN996x switch has a Cortex A7 CPU, but also a PCIe
interface. Linux can control the switch via the PCIe interface, but
there could also be applications running on the Cortex.

Look at the Broadcom BCM89586M:
https://docs.broadcom.com/doc/89586M-PB

It is similar to the microchip device, an M7 CPU, and a PCIe
interface. It seems like a Linux host could be controlling the switch
via PCIe, and applications running on the M7.

I expect there are more examples, but you get the idea.

A completely different angle to look at is VF/PF and eswitches. A
server style CPU running virtual machines, a VM getting a VF passed
through to it. This is not something i know much about, so we might
need to pull in some data centre specialists. But we have a different
CPU, a virtual CPU, making use of part of the switch. Its the same
concept really.

My main point is, please start with an abstract view of the problem. A
lot of the solution should be generic, it can be applied to all these
devices. And then there probably needs to be a small part which is
specific to TI devices. It could be parts of the solutions already
exist, e.g. VF/PF have port represents, which might be a useful
concept here as well. Switchdev exists and provides a generic
interface for configuring switches...

	Andrew


