Return-Path: <netdev+bounces-204654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EDCAFBA23
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 19:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B8931AA6833
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 17:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3737D231837;
	Mon,  7 Jul 2025 17:53:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED411A0728;
	Mon,  7 Jul 2025 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751910780; cv=none; b=XbxX6QhyPkyemClLkOAllcyOE7ZPm7nDOb2JGhXjHdUfG6iG1F3fy8u3eGlxcgHvW4T0E7aKAwwWpOtaI8OtjGpL5l/E8yxK2XAdAVzK3zMcHXnnbN84YX+rMb1OROgB5hy/ov+1j8NQrL3QBbYsCUHV9zla87XMpKkTndSCEeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751910780; c=relaxed/simple;
	bh=AsTcTGqi6Fn5LcdCeig/ngKT0YoLhCTEOGgFgHjH8KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGyOk2m4+04AN8s8EkVbK2/Kvf0f+PiTGHUSXQZtFqw6OU98hNxXkJJuyKKgDI10gNOLbwCK1/dpYTDWUChfOkPjH7H2Hat4n8DGvX9m8VeRfXvgppcBYOwfE2YfMzn9SAEvL3MYW5ISlI7uiuSdZMD8mZwWNhjfC5urO2n8Ejk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id F06482C0163C;
	Mon,  7 Jul 2025 19:52:47 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C17FD423825; Mon,  7 Jul 2025 19:52:47 +0200 (CEST)
Date: Mon, 7 Jul 2025 19:52:47 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	Andre Edich <andre.edich@microchip.com>
Subject: Re: [PATCH net v1 4/4] net: phy: smsc: Disable IRQ support to
 prevent link state corruption
Message-ID: <aGwJbzY9cwtLlBWA@wunner.de>
References: <20250701122146.35579-1-o.rempel@pengutronix.de>
 <20250701122146.35579-5-o.rempel@pengutronix.de>
 <aGPba6fX1bqgVfYC@wunner.de>
 <aGT_3SpVVzJFzT6B@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGT_3SpVVzJFzT6B@pengutronix.de>

On Wed, Jul 02, 2025 at 11:46:05AM +0200, Oleksij Rempel wrote:
> On Tue, Jul 01, 2025 at 02:58:19PM +0200, Lukas Wunner wrote:
> > Without support for interrupt handling, we can't take advantage
> > of the GPIOs on the chip for interrupt generation.  Nor can we
> > properly support runtime PM if no cable is attached.
> 
> Hm... the PHY smsc driver is not using EDPD mode by default if PHY
> interrupts are enabled. Or do you mean other kind of PM?

See commit 2642cc6c3bbe ("net: phy: smsc: Disable Energy Detect
Power-Down in interrupt mode"):

The LAN9514 used on older RasPi boards only supports SUSPEND0,
SUSPEND1, SUSPEND2.  Other incarnations of the LAN95xx family
such as LAN9500A additionally support SUSPEND3.  The smsc95xx.c
driver enables suspend only on SUSPEND3-capable chips.

I was planning to add suspend support for LAN9514 but never got
around to finish it.  Enabling SUSPEND1 if no cable is attached
saves quite a bit of power, so RasPis without a network connection
consume less.

Back in the day I did some tests and noticed that while EDPD
wasn't working at all outside of SUSPEND modes, it did work
at least sometimes to wake up from SUSPEND1.  The driver fiddles
with EDPD settings upon entering suspend.  I concluded that more
testing is necessary to enable EDPD before SUSPEND1 and that's
when I had to put this project aside. :(

Thanks,

Lukas

