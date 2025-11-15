Return-Path: <netdev+bounces-238872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE50C60AAE
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 21:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2FF3A9B0D
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 20:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E33530AAC9;
	Sat, 15 Nov 2025 20:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ng0mue8b"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FDB3093C3;
	Sat, 15 Nov 2025 20:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763238135; cv=none; b=fkz0T2XojKAzd39EaUsBSD3bdnuL1Uqg6MSwIi1vkwTrioIoVYQjRUdaG23NNZ2uStvjXj82+sjXY2+Pf/x5OyjSu7tTqLSPya2bSl0+9RZCZ4+Wf162BADknkQLZ80almX9n396OJq5uI+Tm4SEL4D8/eWKppyxAuRFnxWj72M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763238135; c=relaxed/simple;
	bh=IDqY+BCoTcRpIKKZYMg89/PLmloZZEWFwyU1e0K6GS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKFWzwHXNPTK4htlyhdigCmYx8Ddy8f1tQT2KgCYsbejV6cp4Yw5C8TNC3KXC11H3cxpoI85dqTR6ZEhcO4H2PE1e+cBslXqwnJ6R+rRmEywkYpMrtF4gs0cWfgY649UOHZriWnJghFYTionLSM4zQSYTrHb4e0bXalG79ipr8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ng0mue8b; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=z2fwFa6QVnJuwOffEsHvva2/nbcKBkz0dp/B4EMubRY=; b=Ng0mue8bpuBdK/pxtP5fakYkI4
	i49atV8mpzZT9KCHV4MC66YC6nzdsuI2WDQ2yWGnRbQ8UaqTHzuavYq9me5SXjx29KP8/sPyE+sKU
	iv9rcRSq3QjvKvGGl3cz4X3TZwz7nJVan9ZLjq9+yx+x4+2SBbTunbKX4PmV6VHlUzZU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vKMmP-00E6rv-1y; Sat, 15 Nov 2025 21:21:53 +0100
Date: Sat, 15 Nov 2025 21:21:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, almasrymina@google.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, kernel-team@meta.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
	pabeni@redhat.com, rmk+kernel@armlinux.org.uk
Subject: Re: [PATCH net-next V2] eth: fbnic: Configure RDE settings for pause
 frame
Message-ID: <825c2171-1f35-4ded-b049-edb52323238b@lunn.ch>
References: <20251113232610.1151712-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113232610.1151712-1-mohsin.bashr@gmail.com>

On Thu, Nov 13, 2025 at 03:26:10PM -0800, Mohsin Bashir wrote:
> fbnic supports pause frames. When pause frames are enabled presumably
> user expects lossless operation from the NIC. Make sure we configure
> RDE (Rx DMA Engine) to DROP_NEVER mode to avoid discards due to delays
> in fetching Rx descriptors from the host.
> 
> While at it enable DROP_NEVER when NIC only has a single queue
> configured. In this case the NIC acts as a FIFO so there's no risk
> of head-of-line blocking other queues by making RDE wait. If pause
> is disabled this just moves the packet loss from the DMA engine to
> the Rx buffer.
> 
> Remove redundant call to fbnic_config_drop_mode_rcq(), introduced by
> commit 0cb4c0a13723 ("eth: fbnic: Implement Rx queue
> alloc/start/stop/free"). This call does not add value as
> fbnic_enable_rcq(), which is called immediately afterward, already
> handles this.
> 
> Although we do not support autoneg at this time, preserve tx_pause in
> .mac_link_up instead of fbnic_phylink_get_pauseparam()
> 
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

