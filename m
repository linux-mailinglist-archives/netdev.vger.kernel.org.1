Return-Path: <netdev+bounces-155837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0842A04048
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2231A162233
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 13:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768D51EF09E;
	Tue,  7 Jan 2025 13:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="28g6Q39n"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517C5208AD
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 13:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736255023; cv=none; b=vFshLnuuXRCeuDXRod5MYqAcIXf7/LPhDIb8VLq69+sCt4e7oQJ4tX5lQlyHhrrjA3X/tIfLG8Arc/KnewDbKiCSLpkpnTNqYy/jDdYUAbktEsqh/3aiufMwJWrqNP583LTFky5UT24qworlbLVeiULhBQV8/gCJIBatoXjnTQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736255023; c=relaxed/simple;
	bh=5bmRP58fuFjd3Ap9F6MN3DbmK9cY4daIT0JRVraCfYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6qi2Vu8XtL/AEZP3oaw7C2Ri2R8dMx8b9Mgt6ls7oylXp+6g/bxLcvulvtruc1aEPqCpfZuM+24h40EVClstrMxkusyP3S1qDM+QYaexpkHGoAP4SmriqB9o3/Gr+sSEOiArZ24AUSzzjAf8b0FDV9yp2o34coJ5aiDRtuRArs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=28g6Q39n; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7VhI3bOds4hN/H58RDrhXxqMj97xAGiFOE73e5UGswk=; b=28g6Q39nJrL0VhgPrav/Rnb1OR
	8URpxnVzrCWdPCODhjg5795qPNVtT7aWhyIGDeaqIe2HH8+FI6aF1rny78p0Mk+31zpzO64qfknK+
	lTWuyDqxSR0fuMS8yz2Jy82JDAFb1jhNJ5QJ7QqFxE71PRd+vrbfEatsQ5l1NAz7fMgk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tV9F1-002ESr-CO; Tue, 07 Jan 2025 14:03:27 +0100
Date: Tue, 7 Jan 2025 14:03:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>, Simon Horman <horms@kernel.org>,
	Woojung Huh <Woojung.Huh@microchip.com>,
	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
	Tim Harvey <tharvey@gateworks.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2 2/2] net: dsa: microchip: remove
 MICREL_NO_EEE workaround
Message-ID: <7742385d-3aea-4128-a04c-d86b263689cc@lunn.ch>
References: <79f347c6-ac14-475a-8c93-f1a4efc3e15b@gmail.com>
 <329108a3-12d6-4ce4-9b28-b59f107120ba@gmail.com>
 <Z3za4bKAJWh3HO9u@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3za4bKAJWh3HO9u@pengutronix.de>

> I have two problems with current patch set:
> - dropped documentation, not all switches are officially broken, so
>   keeping it documented is important.
> - not all KSZ9xxx based switches are officially broken. All 3 port
>   switches are not broken but still match against the KSZ9477 PHY
>   driver:
>   KSZ8563_CHIP_ID - 0x00221631
>   KSZ9563_CHIP_ID - 0x00221631
>   KSZ9893_CHIP_ID - 0x00221631

When you say "not broken", do you mean there is text in the errata
which says they do really, truly, work, or there is simply no errata
which says they are broken? Do you have these 3 ports switches and
have tested them?

It seems odd to me that the 3 port version should work. Why is it
special?

	Andrew


