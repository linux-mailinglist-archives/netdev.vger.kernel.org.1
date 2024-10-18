Return-Path: <netdev+bounces-137071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E30B29A443A
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 18:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2841F235D8
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 16:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85C12038B9;
	Fri, 18 Oct 2024 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QFSVkek/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E821520E312;
	Fri, 18 Oct 2024 16:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729270780; cv=none; b=T87oErQgj+SLgUJbXZORlTaw7OExDdXqaadGhF032l3yBYJuNG+E+GaFDNblzRsu33N5vR6fw9V/DGiZZy1nLMqF7XdrBBFU/ZF5msxZ2YUf2UJbCXgP1o67RPl8RySeA/PFRhBAf2Yh+8TCOqlvqv17IUZmBvO0BsH5ULslMyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729270780; c=relaxed/simple;
	bh=KhC2eUomm4G/0uWZ0BTZUA4LIQbrt3cZY0iK9/gIXeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfededystchVdCrrxi21i8SVMXnafwmpduxJ9Wezt2SJ3WyXpvVmSmERMczdBXtkDEoWHbP3tY7ZGIyn6UNJKG7lAfVF+aumDULX0z7NoyMUhKxknL3SMBSPPR7SDm4o4xZDVnbQR93fGt+YHWCBTSYxG4E2CC9xMe+HHmH+aS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QFSVkek/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uaT3G6vBHHY2C2lq2x0O3457k17SuI2+GsVm0BVYviw=; b=QFSVkek/L6Gbg75YKelgPY4MKO
	cHOB4Xf0IuLmLa41cb9wlFEiuD3Bmoak723HgtwMiqNoDgzWJaKmvbug3sW+e4co6+gFL59k0iIQg
	ld0nASZqsYSNeWxESGCNngxqOUnwtBvk5EgNGuDcdBPxPV7HU3qtuto4D8SUS+S2qchA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t1qK2-00AYFn-Fb; Fri, 18 Oct 2024 18:59:30 +0200
Date: Fri, 18 Oct 2024 18:59:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Furong Xu <0x1207@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
Subject: Re: [PATCH net-next v2 7/8] net: stmmac: xgmac: Complete FPE support
Message-ID: <a9eefb9a-8ab7-4131-a9f0-cae2bb0a126f@lunn.ch>
References: <cover.1729233020.git.0x1207@gmail.com>
 <1776606b2eda8430077551ca117b035f987b5b70.1729233020.git.0x1207@gmail.com>
 <20241018091321.gfsdx7qzl4yoixgb@skbuf>
 <20241018180023.000045d8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018180023.000045d8@gmail.com>

> In fact, I can drop the stmmac_fpe_ops at all, avoid the antipattern of
> calling a function pointer for good.
> Since this is a new module, we can try something new ;)

This sounds like a self change-request.

So:

pw-bot: cr

    Andrew

