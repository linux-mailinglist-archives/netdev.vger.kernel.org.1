Return-Path: <netdev+bounces-230991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C1408BF31CB
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 21:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DB184E1EC6
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 19:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6FC149C7B;
	Mon, 20 Oct 2025 19:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="k8EGPIiJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBA91E511
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 19:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987245; cv=none; b=muOnyoxHOaCxu8+PiDr8v2YntqbYnT3ytUQAT6CIQZNwDyP7Ywm8MTSF/qHpCS3TqKqP2jRTcnsGKNtNQUdxDxtm3udLp6a0C9FolF8wLRk3g7IFcTyEc8EOt0FBogr0ow7EOP1GwcqoohVmeLgojbcYV1fnrTKRzjGkLWQTPzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987245; c=relaxed/simple;
	bh=T46cOUrhKXJQE1mdM44GOOUt4ex2pD+b41+QCu0oAPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxC6fBrh77fTDAvPho1UhgRaq+QotfxNwUvTDJRj0YhPSpTT0w/D2MBdDf1o9Lfmn0GmeKjaihMVwLnnOZNe/Hq4RB+TOoX2mLuXRsFTrWu/DeiF8Ssu3B0EizgyOqbgrlJh7vwxDqXWwMSl4dR+ov6BfWxqQifbnkjhObuUU1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=k8EGPIiJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ti2RdeqiKfld0/IuMHMf2VgAItOBM+fx0kuYRyEkRD0=; b=k8EGPIiJJqbbgNzwckxJo+K2PD
	uXfdpyIMWTOP55Kq9zr7bHnQpqXPhkAYn5+vmbeNnJ+0thOLObX5ERqxs6+8tFotM4C109upTig/R
	ToQRxtd1PpGZ6MkRAvwF1MJ6OLsIUwkb3eVnAMJT/1UzrWZybsGT0crcMn5wzyVSaLjg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vAvE0-00BYBR-AV; Mon, 20 Oct 2025 21:07:20 +0200
Date: Mon, 20 Oct 2025 21:07:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, andrew+netdev@lunn.ch,
	Shyam-sundar.S-k@amd.com
Subject: Re: [PATCH net-next v3 2/4] amd-xgbe: add ethtool phy selftest
Message-ID: <9ba51a79-5a0e-42ab-90aa-950673633cda@lunn.ch>
References: <20251020152228.1670070-1-Raju.Rangoju@amd.com>
 <20251020152228.1670070-3-Raju.Rangoju@amd.com>
 <ba2c0a35-eaad-4ae7-a337-b32cdf6323c6@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba2c0a35-eaad-4ae7-a337-b32cdf6323c6@bootlin.com>

On Mon, Oct 20, 2025 at 06:19:55PM +0200, Maxime Chevallier wrote:
> Hi Raju,
> 
> On 20/10/2025 17:22, Raju Rangoju wrote:
> > Adds support for ethtool PHY loopback selftest. It uses
> > genphy_loopback function, which use BMCR loopback bit to
> > enable or disable loopback.
> > 
> > Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> 
> This all looks a lot like the stmmac selftests, hopefully one day
> we can extract that logic into a more generic selftest framework
> for all drivers to use.

https://elixir.bootlin.com/linux/v6.17.3/source/net/core/selftests.c#L441

Sorry, not looked at the patch to see if this is relevant for this
driver. But we do have a generic selftest framework...

	Andrew

