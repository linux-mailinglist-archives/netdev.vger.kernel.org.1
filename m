Return-Path: <netdev+bounces-144244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 216749C643E
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 23:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2F0282F1F
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 22:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFB8219C9E;
	Tue, 12 Nov 2024 22:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YOZ0HGR+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717C6218335;
	Tue, 12 Nov 2024 22:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731450424; cv=none; b=s9d+eghoEp+pjkXG7YbyLLtTUVKfDYglKxSFLIy0cxNLtrx7Fz6bM/KwOl476InsaLKJsPDGhGM6Ui/TsqChOQX+ZxTWJ/Dom2bMv9joYIDOu7xt6zvjNOsCM3QFYJc5W9DxaVSu4Lo2fpjKKq2YVxNE/Rif2KjWB+shinJ3YGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731450424; c=relaxed/simple;
	bh=QyKjGhc/LiH6qXL92TWk4AycrwmNV4ge/bHG2jksKek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTNlByDsRU0TPGINvS0kEWxVo6Luwll4xNMq3Yw2jOjB3O4p8A4fn1EsC4Hb+9THAXDj6lB+SIXJjvuiAA0kOcyF+RnG5gIn9dcWeYkd+Hau6dHLIQl57ov8tQERT/l1LcyxKKQn6+Qm1aWpdP2rRD3CtRIU089eE6lg4ObZGtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YOZ0HGR+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=s0UdRsicpoVTDAuGsmFohQLpfAXGAQppr0GRBNzIM8I=; b=YOZ0HGR+B3c134eJR92ia9yRie
	lnZHb5Gz9jBAVV21fqjqQzf+Tib2CGKpEj8SzaGgH3obV9TsFbcxAcyyAI8g+pzrMqKDIdafkd7LS
	w4FcJX3sXjRPgEDGXny4bNU5JKPhuqy7TSdaucUkJfx4+1Wj7GFfUC+NEh+8DmCta4FQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tAzLV-00D5bz-Gl; Tue, 12 Nov 2024 23:26:49 +0100
Date: Tue, 12 Nov 2024 23:26:49 +0100
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
Message-ID: <53c8b505-f992-4c2e-b2c0-616152b447c3@lunn.ch>
References: <20241112133724.16057-1-divya.koppera@microchip.com>
 <20241112133724.16057-2-divya.koppera@microchip.com>
 <37bba7bc-0d6f-4655-abd7-b6c86b12193a@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37bba7bc-0d6f-4655-abd7-b6c86b12193a@linux.dev>

> I believe, the current design of mchp_ptp_clock has some issues:
> 
> struct mchp_ptp_clock {
>         struct mii_timestamper     mii_ts;             /*     0    48 */
>         struct phy_device *        phydev;             /*    48     8 */
>         struct sk_buff_head        tx_queue;           /*    56    24 */
>         /* --- cacheline 1 boundary (64 bytes) was 16 bytes ago --- */
>         struct sk_buff_head        rx_queue;           /*    80    24 */
>         struct list_head           rx_ts_list;         /*   104    16 */
>         spinlock_t                 rx_ts_lock          /*   120     4 */
>         int                        hwts_tx_type;       /*   124     4 */
>         /* --- cacheline 2 boundary (128 bytes) --- */
>         enum hwtstamp_rx_filters   rx_filter;          /*   128     4 */
>         int                        layer;              /*   132     4 */
>         int                        version;            /*   136     4 */
> 
>         /* XXX 4 bytes hole, try to pack */
> 
>         struct ptp_clock *         ptp_clock;          /*   144     8 */
>         struct ptp_clock_info      caps;               /*   152   184 */
>         /* --- cacheline 5 boundary (320 bytes) was 16 bytes ago --- */
>         struct mutex               ptp_lock;           /*   336    32 */
>         u16                        port_base_addr;     /*   368     2 */
>         u16                        clk_base_addr;      /*   370     2 */
>         u8                         mmd;                /*   372     1 */
> 
>         /* size: 376, cachelines: 6, members: 16 */
>         /* sum members: 369, holes: 1, sum holes: 4 */
>         /* padding: 3 */
>         /* last cacheline: 56 bytes */
> };
> 
> tx_queue will be splitted across 2 cache lines and will have spinlock on the
> cache line next to `struct sk_buff * next`. That means 2 cachelines
> will have to fetched to have an access to it - may lead to performance
> issues.
> 
> Another issue is that locks in tx_queue and rx_queue, and rx_ts_lock
> share the same cache line which, again, can have performance issues on
> systems which can potentially have several rx/tx queues/irqs.
> 
> It would be great to try to reorder the struct a bit.

Dumb question: How much of this is in the hot patch? If this is only
used for a couple of PTP packets per second, do we care about a couple
of cache misses per second? Or will every single packet the PHY
processes be affected by this?

	Andrew

