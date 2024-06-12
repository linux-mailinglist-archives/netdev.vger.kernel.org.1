Return-Path: <netdev+bounces-102901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC089905603
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 16:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19B21C2136E
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 14:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8E017F396;
	Wed, 12 Jun 2024 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AZS2wXkk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A4117A931;
	Wed, 12 Jun 2024 14:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204373; cv=none; b=ntbQkI8s+m4PDMae7b/omRaoFx2/kMEz1mm4zxa3oPoN2IG474dIlgnXZMCcHvG83naEI0Icxgx7dcZDN6IlUdpPXY/YJ4Jx/kxOtKGRsp1rw4dgWK65C2K2MHq9cbXJ+B1aheJB8REHlbzVjtf+0PIG8bU7O+8t/yV8Zsh7csg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204373; c=relaxed/simple;
	bh=hZe66tmBruqItE6Qo0fdsbLpkz7kntMz0MEsPGhcTs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQVjtECgY4O/3EgKPNcopOhhfu7qy12eCvL62DyqiStBYHNBb+wZI9a0NaW5FpP8LM8emeyiYIqzxewzlw4lO95Mk3BO0O8LP05hJ9zWV/YkU6YIYlTVa1/XSJMOdsTqIpXgz1RQ16CLgg5e40DVvEHB9fkDxRfmt9E+GS4efU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AZS2wXkk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KJPyWglk6TTgeC4SYtEN5iGBVrUcdT9kbqfPN/0Fs6s=; b=AZS2wXkk7HtR1yaV5seNb7ikdk
	y5I08xmnO15BmJnALxV+nd7MNFmLAPJAY/kVDs3plt9aQNCxmj9wbKBPJ8UH187zpeoepQYPA7DVc
	G4kG8rqaOjNiQ+BoOmfzUirUfKfJxI1QFQ0MhMmRN4y7wFmQyuYaWRWmZ05A+r0rTkEI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sHPRR-00HTtj-VE; Wed, 12 Jun 2024 16:59:13 +0200
Date: Wed, 12 Jun 2024 16:59:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yojana Mallik <y-mallik@ti.com>
Cc: schnelle@linux.ibm.com, wsa+renesas@sang-engineering.com,
	diogo.ivo@siemens.com, rdunlap@infradead.org, horms@kernel.org,
	vigneshr@ti.com, rogerq@ti.com, danishanwar@ti.com,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com, rogerq@kernel.org,
	Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH net-next v2 2/3] net: ethernet: ti: Register the RPMsg
 driver as network device
Message-ID: <8b4dc94a-0d59-499f-8f28-d503e91f2b27@lunn.ch>
References: <20240531064006.1223417-1-y-mallik@ti.com>
 <20240531064006.1223417-3-y-mallik@ti.com>
 <4416ada7-399b-4ea0-88b0-32ca432d777b@lunn.ch>
 <2d65aa06-cadd-4462-b8b9-50c9127e6a30@ti.com>
 <f14a554c-555f-4830-8be5-13988ddbf0ba@lunn.ch>
 <b07cfdfe-dce4-484b-b8a8-9d0e49985c60@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b07cfdfe-dce4-484b-b8a8-9d0e49985c60@ti.com>

> The shared memory address space in AM64x board is 2G and u32 data type for
> address works to use this address space. In order to make the driver generic,to
> work with systems that have more than 4G address space, we can change the base
> addr data type to u64 in the virtual driver code and the corresponding
> necessary changes have to be made in the firmware.

You probably need to think about this concept in a more generic
way. You have a block of memory which is physically shared between two
CPUs. Does each have its own MMU involved in accesses this memory? Why
would each see the memory at the same physical address? Why does one
CPU actually know anything about the memory layout of another CPU, and
can tell it how to use its own memory? Do not think about your AM64x
board when answering these questions. Think about an abstract system,
two CPUs with a block of shared memory. Maybe it is even a CPU and a
GPU with shared memory, etc. 

> The shared memory layout is modeled as circular buffer.
> /*      Shared Memory Layout
>  *
>  *	---------------------------	*****************
>  *	|        MAGIC_NUM        |	 icve_shm_head
>  *	|          HEAD           |
>  *	---------------------------	*****************
>  *	|        MAGIC_NUM        |
>  *	|        PKT_1_LEN        |
>  *	|          PKT_1          |
>  *	---------------------------
>  *	|        MAGIC_NUM        |
>  *	|        PKT_2_LEN        |	 icve_shm_buf
>  *	|          PKT_2          |
>  *	---------------------------
>  *	|           .             |
>  *	|           .             |
>  *	---------------------------
>  *	|        MAGIC_NUM        |
>  *	|        PKT_N_LEN        |
>  *	|          PKT_N          |
>  *	---------------------------	****************
>  *	|        MAGIC_NUM        |      icve_shm_tail
>  *	|          TAIL           |
>  *	---------------------------	****************
>  */
> 
> Linux retrieves the following info provided in response by R5 core:
> 
> Tx buffer head address which is stored in port->tx_buffer->head
> 
> Tx buffer buffer's base address which is stored in port->tx_buffer->buf->base_addr
> 
> Tx buffer tail address which is stored in port->tx_buffer->tail
> 
> The number of packets that can be put into Tx buffer which is stored in
> port->icve_tx_max_buffers
> 
> Rx buffer head address which is stored in port->rx_buffer->head
> 
> Rx buffer buffer's base address which is stored in port->rx_buffer->buf->base_addr
> 
> Rx buffer tail address which is stored in port->rx_buffer->tail
> 
> The number of packets that are put into Rx buffer which is stored in
> port->icve_rx_max_buffers

I think most of these should not be pointers, but offsets from the
base of the shared memory. It then does not matter if they are mapped
at different physical addresses on each CPU.

> Linux trusts these addresses sent by the R5 core to send or receive ethernet
> packets. By this way both the CPUs map to the same physical address.

I'm not sure Linux should trust the R5. For a generic implementation,
the trust should be held to a minimum. There needs to be an agreement
about how the shared memory is partitioned, but each end needs to
verify that the memory is in fact valid, that none of the data
structures point outside of the shared memory etc. Otherwise one
system can cause memory corruption on the other, and that sort of bug
is going to be very hard to debug.

	Andrew


