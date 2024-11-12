Return-Path: <netdev+bounces-144247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AAE9C64EE
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 00:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59C21F24FFA
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 23:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A461F21A71D;
	Tue, 12 Nov 2024 23:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5O8aS4U7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0C521A6F0;
	Tue, 12 Nov 2024 23:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731453097; cv=none; b=ewg7dFGBDRHOArPY1KvjA/c4y4g/YIlRv/Xx5E6jLdCSQpHbYSN3EnUBEY3hX+Sc4w5CyYkjCI6+Bp76OO4NXFl4ofyy0TTaxarBT21ih6ZVFMS0RDa1wdbtaQAD+hNeplAESVenpi+GU5R+sFzFpNHk7XOT1LmAvU8eangvTP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731453097; c=relaxed/simple;
	bh=xoQEyKpxjqdCp8f4++DVz0fSZHlJ9cbQ2I5eLo0PbLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBm880+AAHZyrJzyem3p4m+6EjUZDzVBM3kMsm3mav+cu2Mki2h73tGmRzWXPVDFzbVTHyQwVcIQghIKPQm1agPg/0cPiqu16/gkxjZu4sdkS0FGGNqll/kxfwK+gPEEzfwJuJjSc0xhbs6xhGobRsXKcSJdereobORSyDThpl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5O8aS4U7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=bgW4WvFiNCkS+lS7QpvW0cGbwOTZMf1uBGkeLoFoEP8=; b=5O
	8aS4U7ga7T3+9HohJGFREvboN9YFxTtvy1KZybgDFXP9k6tY3sqpXJSPnm50fAmeO46vxOGtEFet0
	qGsbgALNRmany4vlzCTJKqQWRT/xjVqDwJltZjjEXiT0DcpZBodgBh5tPcBp82l6SfhSRRyLIt0tJ
	yS+byoRUiTsUzWs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tB02d-00D5wS-Jt; Wed, 13 Nov 2024 00:11:23 +0100
Date: Wed, 13 Nov 2024 00:11:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Divya Koppera <divya.koppera@microchip.com>,
	arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	richardcochran@gmail.com
Subject: Re: [PATCH net-next v3 1/5] net: phy: microchip_ptp : Add header
 file for Microchip ptp library
Message-ID: <7e9e0964-6532-42e6-9005-18715aaac5a6@lunn.ch>
References: <20241112133724.16057-1-divya.koppera@microchip.com>
 <20241112133724.16057-2-divya.koppera@microchip.com>
 <37bba7bc-0d6f-4655-abd7-b6c86b12193a@linux.dev>
 <53c8b505-f992-4c2e-b2c0-616152b447c3@lunn.ch>
 <955cb079-b58d-4c32-8925-74f596312b21@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <955cb079-b58d-4c32-8925-74f596312b21@linux.dev>

On Tue, Nov 12, 2024 at 10:56:19PM +0000, Vadim Fedorenko wrote:
> On 12/11/2024 22:26, Andrew Lunn wrote:
> > > I believe, the current design of mchp_ptp_clock has some issues:
> > > 
> > > struct mchp_ptp_clock {
> > >          struct mii_timestamper     mii_ts;             /*     0    48 */
> > >          struct phy_device *        phydev;             /*    48     8 */
> > >          struct sk_buff_head        tx_queue;           /*    56    24 */
> > >          /* --- cacheline 1 boundary (64 bytes) was 16 bytes ago --- */
> > >          struct sk_buff_head        rx_queue;           /*    80    24 */
> > >          struct list_head           rx_ts_list;         /*   104    16 */
> > >          spinlock_t                 rx_ts_lock          /*   120     4 */
> > >          int                        hwts_tx_type;       /*   124     4 */
> > >          /* --- cacheline 2 boundary (128 bytes) --- */
> > >          enum hwtstamp_rx_filters   rx_filter;          /*   128     4 */
> > >          int                        layer;              /*   132     4 */
> > >          int                        version;            /*   136     4 */
> > > 
> > >          /* XXX 4 bytes hole, try to pack */
> > > 
> > >          struct ptp_clock *         ptp_clock;          /*   144     8 */
> > >          struct ptp_clock_info      caps;               /*   152   184 */
> > >          /* --- cacheline 5 boundary (320 bytes) was 16 bytes ago --- */
> > >          struct mutex               ptp_lock;           /*   336    32 */
> > >          u16                        port_base_addr;     /*   368     2 */
> > >          u16                        clk_base_addr;      /*   370     2 */
> > >          u8                         mmd;                /*   372     1 */
> > > 
> > >          /* size: 376, cachelines: 6, members: 16 */
> > >          /* sum members: 369, holes: 1, sum holes: 4 */
> > >          /* padding: 3 */
> > >          /* last cacheline: 56 bytes */
> > > };
> > > 
> > > tx_queue will be splitted across 2 cache lines and will have spinlock on the
> > > cache line next to `struct sk_buff * next`. That means 2 cachelines
> > > will have to fetched to have an access to it - may lead to performance
> > > issues.
> > > 
> > > Another issue is that locks in tx_queue and rx_queue, and rx_ts_lock
> > > share the same cache line which, again, can have performance issues on
> > > systems which can potentially have several rx/tx queues/irqs.
> > > 
> > > It would be great to try to reorder the struct a bit.
> > 
> > Dumb question: How much of this is in the hot patch? If this is only
> > used for a couple of PTP packets per second, do we care about a couple
> > of cache misses per second? Or will every single packet the PHY
> > processes be affected by this?
> 
> Even with PTP packets timestamped only - imagine someone trying to run
> PTP server part with some proper amount of clients? And it's valid to
> configure more than 1 sync packet per second. It may become quite hot.

I'm just thinking of Donald Knuth:

“The real problem is that programmers have spent far too much time
worrying about efficiency in the wrong places and at the wrong times;
premature optimization is the root of all evil (or at least most of
it) in programming.”

	Andrew

