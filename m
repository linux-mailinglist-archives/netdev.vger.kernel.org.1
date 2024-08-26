Return-Path: <netdev+bounces-121752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 846F395E637
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 03:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22133B20C5D
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 01:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4553F7E6;
	Mon, 26 Aug 2024 01:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sn7E+38/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841CF635
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 01:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724635253; cv=none; b=ulQy+0ZYxZ7mAatZYzTmQWv8FI7S/rcyzSfXwONYBy3Nf9+H8teUiOfKd1Or67UiIpV0tOFsa5XNK2k02GyBQlH+dnfTidvUw8FBALj1cPyXP3UUMnZejK/R5hIXWqxveL4bAbGE60ruM8E8pI2W+X0UkSaBA15VEkC3dZVGYPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724635253; c=relaxed/simple;
	bh=UO0SUXMMuZ93dFCryf69uucorHab5bJPVZpYZb8eCA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXV6bxepjJgyf4VGH879pLqF9W8rR9SnoT5hiHtJe96AK9hklhl0tn/aUq2sVQF31EEXAX4T4YIFe5Qm/TtRBVojHQgBDDu5WUowYax+mz7OPAXde2nl+os7k7ZWnyTahd25N1TXL3cZUqdyGfFA5kgQwyMQTCXCiYyjpAdZ5Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sn7E+38/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6qSmSYaGt/xB4obm0dEsS5EQV0s0GiG18pIOsNletNc=; b=sn7E+38/FLde6JZhWRQc3vn+yH
	bPVDRImSegY2ySKegxk3xtBs2KCr8F7UfELdBQ82ocmQd86D34BZ7jX7bUSL5DdZlOusUjTu/5gHZ
	PxcWqAxyfxja/zX+TT/rJ9EdW5ELLwSQnoKzt4Pq2Ku1qppcwFEqDHLewPr+Lv6wGAp0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1siOPY-005f86-G0; Mon, 26 Aug 2024 03:20:48 +0200
Date: Mon, 26 Aug 2024 03:20:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hans-Frieder Vogt <hfdevel@gmx.net>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH net-next 0/2] net: phy: aquantia: enable firmware loading
 for aqr105 on PCIe cards
Message-ID: <d34a992c-e8a1-43b8-9e2e-21bcd154ab87@lunn.ch>
References: <c7c1a3ae-be97-4929-8d89-04c8aa870209@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7c1a3ae-be97-4929-8d89-04c8aa870209@gmx.net>

On Sat, Aug 24, 2024 at 07:33:26PM +0200, Hans-Frieder Vogt wrote:
> This patch series adds support for firmware loading from the filesystem for
> Aquantia PHYs in a non-device-tree environment and activates firmware
> loading
> for the AQR105 PHY.


These patches are not threaded correctly. git format-patch/git
send-email should get that correct, so i wounder what you did to break
it?

	Andrew

