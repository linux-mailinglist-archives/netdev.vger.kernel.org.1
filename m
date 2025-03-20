Return-Path: <netdev+bounces-176597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C1BA6AFC8
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 22:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9153D189D065
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 21:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B1A20C477;
	Thu, 20 Mar 2025 21:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dXuit9Ku"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F69BE6C;
	Thu, 20 Mar 2025 21:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742505847; cv=none; b=mfbH2TZVwui+AJzkR/5rV7FlRcUiBkwTuq6EFWSmfvx0zJ3trTLNPH8rA4eN1SrLyCjOfmnP221IwOtKf8xPsVSrqDokVhDVGbK9qOMD+jHfzidMf4dfbbU4asnIs50z5wj9G4FDdS2EB3pZhDGnZyHUpXFztDEWjfhwzRebJ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742505847; c=relaxed/simple;
	bh=WNNFXb5qqPBSMUEeyAEErC3JoChpdRD3LCm1OZY3c7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XN6snLsdAJb+/Vu3zXEdTk5XLDLVIqT06zyt1H+/BG7OmaGibFwmIvMFqgyeUA6CdWQt8/HKsehoAEl3llMthcLx4JouKXZ92CF5jDbi1U447IKrcvWUaWQKlKfottPCyCrNECNPYaQMtx8rZ5XbFWmEwJ2m5IS7OuDRCCUYuvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dXuit9Ku; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YlKOI1W/bc+9wVXeJXLrkLcgvNxryli1d2V8y+irOuE=; b=dXuit9Kuo/Z4tsOYMHnNstvC39
	3lzFpmEAMwLedVEbrMPWzca8ZKwwOm3pR43pji+1UtAgkdResjYyLslNyihrccAFdD4fBslPVX84c
	0T0IoRU1bblAbZhC6AD9Re1wmrnarFl/czdm+uMzOD0GtpCKrV2wFjRnFeA48+fQS0uM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tvNMr-006W5f-Da; Thu, 20 Mar 2025 22:23:57 +0100
Date: Thu, 20 Mar 2025 22:23:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: hfdevel@gmx.net
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 5/7] net: tn40xx: create swnode for mdio and
 aqr105 phy and add to mdiobus
Message-ID: <7d7a7499-f8cf-4e35-9692-78c9037b35c4@lunn.ch>
References: <20250318-tn9510-v3a-v6-0-808a9089d24b@gmx.net>
 <20250318-tn9510-v3a-v6-5-808a9089d24b@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-tn9510-v3a-v6-5-808a9089d24b@gmx.net>

> +void tn40_swnodes_cleanup(struct tn40_priv *priv)
> +{
> +	/* cleanup of swnodes is only needed for AQR105-based cards */
> +	if (priv->pdev->device == 0x4025) {

Maybe replace this magic number with a #define?

      Andrew

