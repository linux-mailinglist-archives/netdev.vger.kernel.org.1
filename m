Return-Path: <netdev+bounces-64516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0821D8357FD
	for <lists+netdev@lfdr.de>; Sun, 21 Jan 2024 22:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2B82B211A6
	for <lists+netdev@lfdr.de>; Sun, 21 Jan 2024 21:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0112A3839A;
	Sun, 21 Jan 2024 21:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2+TO9ZVw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA751E49E
	for <netdev@vger.kernel.org>; Sun, 21 Jan 2024 21:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705874003; cv=none; b=gqPL/TrBTb20E/C90RFEnRoAHa1XaZNIj7CeiJPcM1JXQtYhXgcOk9Q/CHpeyTLmwHTYNZCNGPngBky0TDeiLjd7kINDS+6Lj7ubr1YCdQS6TX8DSLG7ct8rHMc4yY/PwudeNOQiXdrpc0h3ghKwVE3c5ZMNH+MMgo17Jd2o7bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705874003; c=relaxed/simple;
	bh=+MPQBKX2wH1iIcNIu6z07/LM+PD07UATHk2JPtRRNW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUuWrIX6WqULqFJkBLO/cOfGdHwGS6FHghlS5jQSJAwStCGjKZp1tzL61NL8jnLmPGg+cSTRbJ1XZzESGO2yREkjUpdfZN2wsGkDbLS9yfXdOJdOllw36mogyzlnRrSQ6OI+WLrCxkrVw2AdKJQnr2BWQAzB3unCjFu2Wr8EXhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2+TO9ZVw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SGgv4/xisAPYhJzOAV7QLIeOR29GRroUN5tKGW/32mM=; b=2+TO9ZVwmlJA0FmApg/e58MZCL
	oiiUWGdLe62XiAj8wQfEN/JvkTsaSbWoxnRXaUvngH7t8GxZFoFjE2xLfob/gMRmegzSkp+G2oHu1
	KCSEqvetxd28kIPr4t4sr1ea7X/9YPjSIi9Kk8Nife7Ji9tEItGMXP7n7tivDUULq22Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rRfkO-005fmn-5p; Sun, 21 Jan 2024 22:52:56 +0100
Date: Sun, 21 Jan 2024 22:52:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Marc Haber <mh+netdev@zugschlus.de>
Cc: alexandre.torgue@foss.st.com, Jose Abreu <joabreu@synopsys.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jisheng Zhang <jszhang@kernel.org>, netdev@vger.kernel.org
Subject: Re: stmmac on Banana PI CPU stalls since Linux 6.6
Message-ID: <8efb36c2-a696-4de7-b3d7-2238d4ab5ebb@lunn.ch>
References: <Za173PhviYg-1qIn@torres.zugschlus.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za173PhviYg-1qIn@torres.zugschlus.de>

On Sun, Jan 21, 2024 at 09:17:32PM +0100, Marc Haber wrote:
> Hi,
> 
> I am running a bunch of Banana Pis with Debian stable and unstable but
> with a bleeding edge kernel. Since kernel 6.6, especially the test
> system running Debian unstable is plagued by self-detected stalls on
> CPU. The system seems to continue running normally locally but doesn't
> answer on the network any more. Sometimes, after a few hours, things
> heal themselves.
> 
> Here is an example log output:
> [73929.363030] rcu: INFO: rcu_sched self-detected stall on CPU
> [73929.368653] rcu:     1-....: (5249 ticks this GP) idle=d15c/1/0x40000002 softirq=471343/471343 fqs=2625
> [73929.377796] rcu:     (t=5250 jiffies g=851349 q=113 ncpus=2)
> [73929.383205] CPU: 1 PID: 14512 Comm: atop Tainted: G             L     6.6.0-zgbpi-armmp-lpae+ #1
> [73929.383222] Hardware name: Allwinner sun7i (A20) Family
> [73929.383233] PC is at stmmac_get_stats64+0x64/0x20c [stmmac]
> [73929.383363] LR is at dev_get_stats+0x44/0x144
> [73929.383389] pc : [<bf126db0>]    lr : [<c09525e8>]    psr: 200f0013
> [73929.383401] sp : f0c59c78  ip : f0c59df8  fp : c2bb8000
> [73929.383412] r10: 00800001  r9 : c3443dd8  r8 : 00000143
> [73929.383423] r7 : 00000001  r6 : 00000000  r5 : c2bbb000  r4 : 00000001
> [73929.383434] r3 : 0004c891  r2 : c2bbae48  r1 : f0c59d30  r0 : c2bb8000
> [73929.383447] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [73929.383463] Control: 30c5387d  Table: 49b553c0  DAC: a7f66f60
> [73929.383486]  stmmac_get_stats64 [stmmac] from dev_get_stats+0x44/0x144

Hi Marc

https://elixir.bootlin.com/linux/v6.7.1/source/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c#L6949

My _guess_ would be, its stuck in one of the loops which look like:

		do {
			start = u64_stats_fetch_begin(&txq_stats->syncp);
			tx_packets = txq_stats->tx_packets;
			tx_bytes   = txq_stats->tx_bytes;
		} while (u64_stats_fetch_retry(&txq_stats->syncp, start));

Next time you get a backtrace, could you do:

make drivers/net/ethernet/stmicro/stmmac/stmmac_main.lst. You can then
use whatever it is reporting for:

PC is at stmmac_get_stats64+0x64/0x20c [stmmac]

to find where it is in the listing.

Once we know if its the RX or the TX loop, we have a better idea where
to look for an unbalanced u64_stats_update_begin() /
u64_stats_update_end().

> I am running a bisect attempt since before christmas, but since it takes
> up to a day for the issue to show themselves on a "bad" kernel, I'll let
> "good" kernels run for four days until I declare them good. That takes a
> lot of wall clock (or better, wall calendar) time.

You might be able to speed it up with:

while true ; do cat /proc/net/dev > /dev/null ; done

and iperf or similar to generate a lot of traffic.

    Andrew

