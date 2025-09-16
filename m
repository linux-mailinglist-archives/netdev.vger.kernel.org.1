Return-Path: <netdev+bounces-223530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A52B5967D
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80F981BC6ADB
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB8C1CD1F;
	Tue, 16 Sep 2025 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wos8zgU9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA66A42056
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758026773; cv=none; b=hCVGdhRJtZ7h61agps+P4UQScNtHvYG2eJzapA+bRoZ5I2XXqigxC2h4dA9H3thfmwX5vJm9NEy8rdVTMDZQxYq1UBOjs7/zKfPXbrwE57FicFKhl8xVIpUg7PaytMUv/V+WjnnVfQxFiN3lLV3COL5WsTgnb7SXDv0BrJWJF8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758026773; c=relaxed/simple;
	bh=mAiTmpOJj/QV5eoB+6aEqKY6BzyOAaQlbwsZKevG4Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Os8wrxHgz2dFtozdbQ3YFCVIzybs3XQJD+V4nmbfc9hvzrfHmwkjan2pn1sCsyKGXlVxMACDXeocCTgF57c/vtvNR7Tl+ip4LS5btyZJr5mPneuONif1qgticyI8VFrrpTa/peUG9/7xvw18Hi2+QRyBLZGx5l7tezkuuxT6R80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wos8zgU9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MOlpMG8LerMzAWrwQwyAtbsTUaNEvTOMoXuwenYDIA0=; b=wos8zgU9X2eK2q2r9ubd/OcUBj
	oFcm6Jp3xoLzHJHz2nHqGK2T8ezxoT034Ntlt2zmzQ7LV20D+lZ92kK9PgCTtUldH2gSrZobfUOHV
	zqyOtY9Bwp7HEWSXumbWyf1i66wDpTaKHHKL2attHNFUgZbnT0EmMaeY5P2D9q6ST9Fc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uyV4P-008YvZ-CU; Tue, 16 Sep 2025 14:46:05 +0200
Date: Tue, 16 Sep 2025 14:46:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next 5/5] net: dsa: mv88e6xxx: move
 mv88e6xxx_hwtstamp_work() prototype
Message-ID: <9d3eb839-99be-4d08-96ec-8bee1dec073a@lunn.ch>
References: <aMgPN6W5Js5ZrL5n@shell.armlinux.org.uk>
 <E1uy8uh-00000005cFT-40x8@rmk-PC.armlinux.org.uk>
 <20250916080903.24vbpv7hevhrzl4g@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916080903.24vbpv7hevhrzl4g@skbuf>

> This leaves the shim definition (for when CONFIG_NET_DSA_MV88E6XXX_PTP
> is not defined) in ptp.h. It creates an inconsistency and potential
> problem - the same header should provide all definitions of the same
> function.

How big is the PTP code? We have added a lot of code to this driver
since PTP was added. I suspect the PTP code is now small compared to
the rest of the driver, so does it still make sense to have it
optional? Also once the PTP code gets moved into a library and shared
by the Marvell PHY driver and other Marvell MAC drivers, won't we have
an overall code shrink even when it is enabled in DSA?

Maybe it is time for CONFIG_NET_DSA_MV88E6XXX_PTP to go away?

	Andrew

