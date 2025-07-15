Return-Path: <netdev+bounces-207212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE7BB0641C
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 18:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95815814FB
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267D11F3BAB;
	Tue, 15 Jul 2025 16:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KYat4eAl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605771C4A24
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 16:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752596156; cv=none; b=p64saOBp4VgaLOz2oeXAKUbWaowoQ96yv5usdOSmoKEyHWy5w0CBbEChp0cgx+lp7OqkZMiIJ/MNssBq2HfdWqPLVAAiArejtdvw0fATE0vFbAD7+dbDx277VlkqkaW9J0YJx+lQ9IEjWx+j1yknHxsrHRR3mPTmTpRQH1iRoYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752596156; c=relaxed/simple;
	bh=RgwoLqirdlXIhxtQhlBF+mmW/bebs9uw4I1PFybSQnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnlrd7ZP/BH/dkGjsvN6A2J+SYGwQbOq376urH0EvvvsJ55Xo4s+ZQbrJhQogcai9IfDOQYGPcrdqBkZTL+TLfabf2ryIMhAXlVf3J+aVfcsJ5cIMmp9syGSOWt4Wc3PXpylTlYeUfev9pB98I2pmqYRC/wBkI7GlIM8nLCD5+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KYat4eAl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uzwmmuXxMSLYErQxvPhYqNc3mWgX/z4RK8xr9fPwMZ0=; b=KYat4eAlB6bPqLaUENRXQW0GV2
	bvnxiGf3NecGkkhnqZJHBy5tImpUgckxHLwrAImKZmbs7eLdHpJVozhx7kNU66ySfhYyC5XgAEsgT
	3TBXXgJrqTs7WZfkHW+oAGKwKFIHwbhRirC37axdedBZKN+kCvsBx61leMlGgNvtIpzk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ubiJr-001bex-Qk; Tue, 15 Jul 2025 18:15:51 +0200
Date: Tue, 15 Jul 2025 18:15:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jack Ping CHNG <jchng@maxlinear.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, fancer.lancer@gmail.com,
	yzhu@maxlinear.com, sureshnagaraj@maxlinear.com
Subject: Re: [PATCH net-next v2] net: pcs: xpcs: Use devm_clk_get_optional
Message-ID: <06ffd971-ce57-4971-be97-2e1c76e791e1@lunn.ch>
References: <20250715021956.3335631-1-jchng@maxlinear.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715021956.3335631-1-jchng@maxlinear.com>

On Tue, Jul 15, 2025 at 10:19:56AM +0800, Jack Ping CHNG wrote:
> Synopsys DesignWare XPCS CSR clock is optional,
> so it is better to use devm_clk_get_optional
> instead of devm_clk_get.
> 
> Signed-off-by: Jack Ping CHNG <jchng@maxlinear.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

