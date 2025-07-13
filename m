Return-Path: <netdev+bounces-206444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 147E3B0323F
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 19:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBECC7AAAAD
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 17:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF0A28000A;
	Sun, 13 Jul 2025 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xKNGv00C"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6041237160;
	Sun, 13 Jul 2025 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752426375; cv=none; b=GiH0Ce7u3kW+U1ErRG5c84/h3INa8d4r6hB1ZxfBVU4+i9Kcm7iMs8v/LCmvxXnd+KOErXWnty8ugH9FW/bMJ+RiqM24msvyfh9dzxBC9t6d/BIh7tsbgeANdOUBH2S4wcp1DlVn34/CLXKQ/ZRJ9jyCKy/NP9hI/ditsmrjJgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752426375; c=relaxed/simple;
	bh=8buxFrE/ZovBFdNA8vZzICYoigzm/dgB4JRsAasaV0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sK8b980CzZltU1BBAppS18cF1cskylLbFly2jTWzitd6+RZTItsdinByjzIJecpIL0MGE2tzxMd/e3DUmtMwwwtxiA027O/J+oeMQk6y5Gu7/oZRUFA7911HenlZJueA93WSerBPKG7A5zPNnzp3tHuFJO41J0lGjLUrPIJeS/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xKNGv00C; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=95RPu8t4CUwWlmCFT2jOjTv3HPdU6j+ByKVs/cDz7fg=; b=xKNGv00CQ/QVag8uKte+lwPUiO
	e9XP4VmEPKDgvBcF4XHnqg7+XlJkU8wHSAkWPuMpFQ6T2cuJiIzueZrD79iDs+ts6lAUb2J0nKyxj
	xg9v1cNeOyK1Sa7X0jQBVdZpHubCOXPan8WiDjGW2L2A/RUhBydyHoQsO6qbKttdFF+s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ub09H-001O0A-G9; Sun, 13 Jul 2025 19:05:59 +0200
Date: Sun, 13 Jul 2025 19:05:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: ChunHao Lin <hau@realtek.com>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] r8169: add quirk for RTL8116af SerDes
Message-ID: <9291f271-eafe-4f65-aa08-3c6cb4236f64@lunn.ch>
References: <20250711034412.17937-1-hau@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711034412.17937-1-hau@realtek.com>

On Fri, Jul 11, 2025 at 11:44:12AM +0800, ChunHao Lin wrote:
> RTL8116af is a variation of RTL8168fp. It uses SerDes instead of PHY.
> But SerDes status will not reflect to PHY. So it needs quirk to help
> to reflect SerDes status during PHY read.

Can you give us a few more details. What is on the other end of the
SERDES? An SGMII PHY? An SFP cage? An Ethernet switch chip?

A quick search suggests it is used with an SFP cage. How is the I2C
bus connected? What about GPIOs? Does the RTL8116af itself have GPIOs
and an I2C bus?

	Andrew

