Return-Path: <netdev+bounces-114542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8089C942DB7
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 14:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37A201F24ADC
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 12:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E71F1AD9F7;
	Wed, 31 Jul 2024 12:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="n+2GGOnk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994C818DF93;
	Wed, 31 Jul 2024 12:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722427570; cv=none; b=lQPeWmsLNr/ZG5CbwZF0+IVeDhpmR5zKH4jZ8IJs4XTithDO4E6xuhtRlbDlxR8Zl/HEfQiMiikyoGB3zWf6DNyvP1x+toEXXcWTnESq+uVchzqmGtMp8SAPNrsPStDMGFHnzE9narfOlzn0hrUzrahWRDqa4c7BuBOTdvSD5vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722427570; c=relaxed/simple;
	bh=RNZ3IvyX1i92tpfi5Trda90cdkAUv1uZ6qOGkkeYXJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eD4eN/YpW4hwOQk5evCPsWThY1CzmeQuvAAUVmm/rUbXUwizna7LfyohxrGz5dZSPexAmQm4M8cV44T9YPCVL3N62N1TweNZH3+eUo7ergEZBXbDjPq8nIOpK/7je271pjDgCTmnEIHMOPMopdl4+z/HeHFCNXfV2PRyDO6UzT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=n+2GGOnk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fSBP5u6GwjarXtcQKdmAz2q4jrRtLZRcoSxlqmBUqUA=; b=n+2GGOnkE1esI+gQhbtSD0Dy5g
	0BhLWZayxrdF4WhD+aBmcktD+CaVB/BqkSrntncHzopL6gEXRAl78U7FLK4bfYNweMNESQcwpYqMR
	H81wGI5M3/vn+fzhsOn3izBBFe2I3xZecAWCPlGodUdqsW3FPL9malMs02ws5l5iN5JA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sZ85d-003faD-Tt; Wed, 31 Jul 2024 14:05:57 +0200
Date: Wed, 31 Jul 2024 14:05:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, michal.simek@amd.com, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	git@amd.com
Subject: Re: [PATCH net-next v2 2/4] net: axienet: add missing blank line
 after declaration
Message-ID: <c678a552-dd37-4db5-92d3-8e32033902ee@lunn.ch>
References: <1722417367-4113948-1-git-send-email-radhey.shyam.pandey@amd.com>
 <1722417367-4113948-3-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1722417367-4113948-3-git-send-email-radhey.shyam.pandey@amd.com>

On Wed, Jul 31, 2024 at 02:46:05PM +0530, Radhey Shyam Pandey wrote:
> Add missing blank line after declaration. Fixes below
> checkpatch warnings.
> 
> WARNING: Missing a blank line after declarations
> +       struct sockaddr *addr = p;
> +       axienet_set_mac_address(ndev, addr->sa_data);
> 
> WARNING: Missing a blank line after declarations
> +       struct axienet_local *lp = netdev_priv(ndev);
> +       disable_irq(lp->tx_irq);
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

