Return-Path: <netdev+bounces-211049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C32AAB164D2
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 18:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2EC188D676
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 16:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E840A2DC358;
	Wed, 30 Jul 2025 16:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5Hurjpjl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021A319007D
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753893386; cv=none; b=BbGOfGWrdL0nyH9FRdkx2Wf3m4/tDq/xLYgGAr6pccqz5WNcvCMFnqHbW2R8BA0tmnEPIvNKkXMEWcg+yShejxsu8O3TsB1+Vwl62fgPVaznF27YHKNY+wLqMJEYdp0UOdjwo0r9dFNAtOSxoznsdFRu09nRTsU5WzzxIEb6f3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753893386; c=relaxed/simple;
	bh=+kG3EjPP4yusabObSwvJ6Q19DV6QQIO2naL5dcdZ9xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7lwe3DbsYYaZQRZqu3CwLWLxAtXTBIhZDjJfvtUTBs7AeEhWwpiln7RtJE7EJ7xp5WOI1J5/SXPK1grvOxlbrAJG3gvgq21cf7aYdVlFs/99GYHIH3P6Vz4XiwViuSNpQED4DbExviQnhTIoCHblP6BJuzbXQhOoKyg0vDCw+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5Hurjpjl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AiyTE7hDe9EeXlJ/W7WjJt4fzpoS/m9yM+nOnIGfHfI=; b=5Hurjpjl0uVTfQYqrPPAVh10u4
	4+Nv1+HpInZc+0Uegkm4kcTD8i6E7Ni2PQAZ2xvBAWGM1BZgZu8+Hr/bAmeTo6VTFwcBgVUveTDkX
	aF/BjOaPiUQIctMXNftjC0W/60+EObMi831xHfJeN0I28iPe9LmY2aFHPx9fUB2LO9qM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uh9mw-003IU6-Ru; Wed, 30 Jul 2025 18:36:22 +0200
Date: Wed, 30 Jul 2025 18:36:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: _ <j9@nchip.com>
Cc: netdev@vger.kernel.org
Subject: Re: NETDEV WATCHDOG + transmit queue timed out
Message-ID: <40f61816-8e0e-40ac-87ef-b7058778d056@lunn.ch>
References: <ce1dba69-b759-485c-bc3b-5558306735bc@nchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce1dba69-b759-485c-bc3b-5558306735bc@nchip.com>

On Tue, Jul 29, 2025 at 07:18:32PM -0400, _ wrote:
> Hi
> 
> When I try to use network interface end0 on kernel version 6.14 for Rockchip
> RK3588 SoC, I get this in dmesg:
> 
> "rk_gmac-dwmac fe1c0000.ethernet end0: NETDEV WATCHDOG: CPU: 1: transmit
> queue 1 timed out 5408 ms"
> 
> dmesg:
> rk_gmac-dwmac fe1c0000.ethernet end0: Link is Up - 10Mbps/Half - flow
> control off
> rk_gmac-dwmac fe1c0000.ethernet end0: NETDEV WATCHDOG: CPU: 2: transmit
> queue 1 timed out 5388 ms
> rk_gmac-dwmac fe1c0000.ethernet end0: Reset adapter.
> rk_gmac-dwmac fe1c0000.ethernet end0: Timeout accessing MAC_VLAN_Tag_Filter
> rk_gmac-dwmac fe1c0000.ethernet end0: failed to kill vid 0081/0
> rk_gmac-dwmac fe1c0000.ethernet end0: Register MEM_TYPE_PAGE_POOL RxQ-0
> rk_gmac-dwmac fe1c0000.ethernet end0: Register MEM_TYPE_PAGE_POOL RxQ-1
> rk_gmac-dwmac fe1c0000.ethernet end0: PHY [stmmac-0:01] driver [RTL8211F
> Gigabit Ethernet] (irq=POLL)
> dwmac4: Master AXI performs any burst length
> rk_gmac-dwmac fe1c0000.ethernet end0: No Safety Features support found
> rk_gmac-dwmac fe1c0000.ethernet end0: IEEE 1588-2008 Advanced Timestamp
> supported
> rk_gmac-dwmac fe1c0000.ethernet end0: registered PTP clock
> rk_gmac-dwmac fe1c0000.ethernet end0: configuring for phy/rgmii link mode
> 8021q: adding VLAN 0 to HW filter on device end0
> rk_gmac-dwmac fe1c0000.ethernet end0: Link is Up - 10Mbps/Half - flow
> control off

10Mbps/Half is valid, but it is a bit unusual this decade, when most
networks are now 1G full duplex. What is your link partner, and do you
expect this slow a link?

	Andrew


