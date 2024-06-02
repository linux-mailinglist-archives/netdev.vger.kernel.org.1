Return-Path: <netdev+bounces-100000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 699AB8D76D7
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 17:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03FC01F21120
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 15:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506623BBF4;
	Sun,  2 Jun 2024 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qrwTJ06U"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8BC17736;
	Sun,  2 Jun 2024 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717343148; cv=none; b=R6RcEGKDNUFEATpZlV+iApXBn0CoMBVImNlG+Ri+mv1DjjoRgapXfp+bGGw1jSCnnwU/cZJ9lf/ZvR1Gcuk43WbDfVXaIqoT8ZJv1bwtQri3oivy96OSGO6wTugPyzlo+MIhE8YTCHZdUwzrHOOWjKKIp2vl/7WnCstCsgq4Dsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717343148; c=relaxed/simple;
	bh=LZHz46gZY0Uo9hNwDp7vSBscpdT7ixIYgNYA5g2hde4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4isz4kvxdWt5GELrVOeu92QPJCugFAbiXWZu+vTQmf09NmYaU9GrB1qWiF5NLqK70jZDrZig5raYja3yQ8N6Fkx1TFC8Tb7I/qc+1tRLNZ6OF1x0KHKMzICJBD23f0ewlpR+PnI/VKQeNEssM82OcDJdwAB55hWlrKmrghMZ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qrwTJ06U; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=P0IunT5E4kP03Ju05n5fpl6v0D6JN754xrn2B0poXdM=; b=qrwTJ06UWxG9noO5YDvcSBOtGW
	KHzgAILPHxG9rf1O2+ugBoT+4dlqXjVUo8zS+QF1uln9n8X7tUsb8tMV7CtXLfNcF0RvN5pSYIJgw
	S3pMiySWVjkKPwHxnv6MP9gScyzIlYm1tgmmNwEWeyy/vM00ImWWwA7BhCUbQ1GxAXg0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sDnOj-00GdQu-AP; Sun, 02 Jun 2024 17:45:29 +0200
Date: Sun, 2 Jun 2024 17:45:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yojana Mallik <y-mallik@ti.com>
Cc: schnelle@linux.ibm.com, wsa+renesas@sang-engineering.com,
	diogo.ivo@siemens.com, rdunlap@infradead.org, horms@kernel.org,
	vigneshr@ti.com, rogerq@ti.com, danishanwar@ti.com,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com, rogerq@kernel.org
Subject: Re: [PATCH net-next v2 0/3] Introducing Intercore Virtual Ethernet
 (ICVE) driver
Message-ID: <8f5d2448-bfd7-48a5-be12-fb16cdc4de79@lunn.ch>
References: <20240531064006.1223417-1-y-mallik@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531064006.1223417-1-y-mallik@ti.com>

On Fri, May 31, 2024 at 12:10:03PM +0530, Yojana Mallik wrote:
> virtio-net provides a solution for virtual ethernet interface in a
> virtualized environment.
> 
> There might be a use-case for traffic tunneling between heterogeneous
> processors in a non virtualized environment such as TI's AM64x that has
> Cortex A53 and Cortex R5 where Linux runs on A53 and a flavour of RTOS
> on R5(FreeRTOS) and the ethernet controller is managed by R5 and needs
> to pass some low priority data to A53.
> 
> One solution for such an use case where the ethernet controller does
> not support DMA for Tx/Rx channel, could be a RPMsg based shared memory
> ethernet driver.

virtio-net is very generic and vendor agnostic.

Looking at icve, what is TI specific? Why not define a generic
solution which could be used for any heterogeneous system? We are
seeming more and more such systems, and there is no point everybody
re-inventing the wheel. So what i would like to see is something
similar to driver/tty/rpmsg_tty.c, a driver/net/ethernet/rpmsg_eth.c,
with good documentation of the protocol used, so that others can
implement it. And since you say you have FreeRTOS on the other end,
you could also contribute that side to FreeRTOS as well. A complete
open source solution everybody can use.

	Andrew

