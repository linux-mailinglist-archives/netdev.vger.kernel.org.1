Return-Path: <netdev+bounces-200385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B74DAE4C1E
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 19:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C1D3189E691
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 17:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEADE287519;
	Mon, 23 Jun 2025 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="N1MxmY4/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ABF3D3B8;
	Mon, 23 Jun 2025 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750700866; cv=none; b=qE9pgxSqpSXoUOvlS7FTeyRQAiyejlgSP1IEji4J4ezrHUnaFawQ/+3ZL4RPoylh5Xv8Y3MOjA9yvzCjBlycywqV0peMqfZJeDf/K03qxf4cGsZsVl0E/ymwSticNmSkYoP+qvtp4Zl7FoLq9UzWSFEAWdX3FZZCc/7mWfmVUMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750700866; c=relaxed/simple;
	bh=DQA1YjYGt0Bcpov/++EhtCvF+McC1Sn4ATQi0Qk6+xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuWlavuVLLxeZTSLAj51pDetbgKCUqxnMky6j6P5yvlFtwfHgFEuqTIn3RpIz5eKtP2h7IMjWWTFmFn2DdARN96//2lRvPSanTn6mLE1tTWieYQFPaer167UjqVusu2QtNX3yiEPjkUredPNAPXVwJAN++eJzTqdszqWSyguxt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=N1MxmY4/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pgVc16tuszevNFSrJNNjwVYo9zNPjlL0T1AuSx6YM2U=; b=N1MxmY4/gusvuN6lmH308JfacB
	FaCSRbCuTlArCp2GTS/Lo86vvcK4mwTVTPdH0PRVh2vQYfGYebdvENEN2ZwMnrr1Dcy8LTHB30kDl
	nR+x8NlI7NLB8ZnRoN+1GVzhyuPIGWqwPirw6A1opLr7isPEprmgQ7D/Lmgq3UVoI+Ec=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uTlGV-00GiRv-3H; Mon, 23 Jun 2025 19:47:31 +0200
Date: Mon, 23 Jun 2025 19:47:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ryan Wanner <ryan.wanner@microchip.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Expose REFCLK for RMII and enable RMII
Message-ID: <461269ea-4741-4916-b0e0-63e0ce8d9c7e@lunn.ch>
References: <cover.1750346271.git.Ryan.Wanner@microchip.com>
 <4b1f601d-7a65-4252-8f04-62b5a952c001@lunn.ch>
 <0aa6c9a4-4a65-4b55-a180-92c795499384@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0aa6c9a4-4a65-4b55-a180-92c795499384@microchip.com>

> Our SAMA7D65_curiosity board has a connector that allows us to change
> ethernet phys. Since some of the phys we have provide their own REFCLK
> while others do not, this property needs to be added so we are able to
> use all of these.
> 
> I do not have an exact .dts patch for this since our default is MPU
> provides the REFCLK, this property will be used with dt-overlays that
> match each phy that is connected.

We generally don't allow a feature without a user. So please re-submit
this when you submit a DT overlay which can actually use it.

    Andrew

---
pw-bot: cr

