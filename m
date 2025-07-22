Return-Path: <netdev+bounces-208946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A970B0DA84
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 15:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDDED6C1647
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 13:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D279E2E498E;
	Tue, 22 Jul 2025 13:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CK/UivTF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD942BF012;
	Tue, 22 Jul 2025 13:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753189702; cv=none; b=QPjChvYtBjMh+Gsm543yDvu/zf+Qfef75RPJQ/wOkS22cPpruXHwFDfsaTekbLa8OQ2gkkpObmwenkn5nl5SdCxQHjmCjh18B52dzkA8dhvMlxmVIxjbfIZwrGqh9DIRYkV5xaDLKW1qET3bfXBX2u7YTABtuuSapal5SBkF/14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753189702; c=relaxed/simple;
	bh=rW011RMtxUqp0qnKK+maMtp2pVKFsfv65GVLZ/xLwDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLalqCLyQgmofPGTzq0F8isv3Jp6UDN8qiX8LF02VqEnhMx0o2/BIWpIRxloWX6U2tOerxxdE9w5qDsIzY/ZsIPY+g5jrPsc5A/MxLPG4wtHROjPa0RC0ON7tsgYio7M3nJFwtBy8aJuiaUCebdEj0masaqmjNHS3zMJb9+ul5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CK/UivTF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UWGTmGLtd4NHFnVVE7+znEH5Rhr4DSV2eI2eMrF8eyM=; b=CK/UivTFhmsOt1EoPc9SGtKbdN
	bI8wwawl4M0xmLe/rFhEsrlC9Zrz8J69iuHiY3layoQW087QJdWXG578whOsH7uJ3HwbaSeTiu9h8
	OOge0x+6AW0/8b2qvD6u4rZIuYUTtcuCatfveN/W5rWxf05nqWDHyffi4cV1ZjfGwe88=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ueCj2-002SuQ-SD; Tue, 22 Jul 2025 15:08:08 +0200
Date: Tue, 22 Jul 2025 15:08:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	o.rempel@pengutronix.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: micrel: Add support for lan8842
Message-ID: <0d0b56bd-6a8e-4179-955d-bc0e2a933b20@lunn.ch>
References: <20250721071405.1859491-1-horatiu.vultur@microchip.com>
 <4dd62a56-517a-4011-8a13-95f6c9ad2198@lunn.ch>
 <20250722060954.ecaxrk7vq5ibuy55@DEN-DL-M31836.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722060954.ecaxrk7vq5ibuy55@DEN-DL-M31836.microchip.com>

> Yes, I will use PHY_ID_MATCH_MODEL().
> I was thinking to start with 2 cleanup patches, one to use
> PHY_ID_MATCH_MODEL in the driver and one to introduce
> lanphy_modify_page_reg and put it to use.
> Do you have other suggestions?

I did not look at the driver too closely. There might be other
cleanups you can do, but those two make sense in the context of what
you are doing.

	Andrew

