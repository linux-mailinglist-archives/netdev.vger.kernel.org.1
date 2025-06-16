Return-Path: <netdev+bounces-198075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29505ADB2AA
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA4C169622
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 13:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EE52BF01D;
	Mon, 16 Jun 2025 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XRBiCJoj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F5D2BF013
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082221; cv=none; b=AAgdpvxN3VBqre+hiye4WHxYLokYDWwj/w1vtD5W2WRfY3jyJAEFXJIOv+udtUWeDy5IdpZ9QY0Ea1PSF1D95MlyUL7u+rD/eq5o7AdqUjnUUX5d3CmCiA9PvhoE9eAgubaj0wIhAr3veYuGzfFEVbVJpxRGN2f81eRvQgfokQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082221; c=relaxed/simple;
	bh=ePLLGTjagrMaKhHNlali1+zIKwjZDsmxY7qJr7h+2v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgG+ceq7U+UP69xUtJveO15S3hznzRTJg2HNHRXKNW679rp+yUqhP3jsX2UvXjZ79CukjKuQrl5JjsfbohUc4I0irBhjaXZQGYa+MpVstHLA4pwdYI2BMCadGvsn11wI84P5gcjyqPKirlslsSnRw5OjgekOaobBOzfHqXcfQSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XRBiCJoj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=I8uikXhV15Q5egAKseXehuXCgd2/OVS4d4R+xSSyUB4=; b=XRBiCJoj0m/h2GD0ooSqWOR7xg
	sOuaYETqGk62avj7jvQZG5LMoweoWI0EQvR7qFPa7B29bCbj24ONn8kLZsXDFg5stGHdTRUu5uRTw
	chi5aSY1WMQb1XzBqcZNtU2WxwhT0dkvNJArTPkvBWiLXVRUtPIIyw17+FzuXn6fQZok=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uRAKM-00G381-F0; Mon, 16 Jun 2025 15:56:46 +0200
Date: Mon, 16 Jun 2025 15:56:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/3] net: stmmac: rk: fix code formmating issue
Message-ID: <48479e17-146a-4f82-a0a5-406a5949134e@lunn.ch>
References: <aE_u8mCkUXEWTzJe@shell.armlinux.org.uk>
 <E1uR6sZ-004Ktt-9y@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uR6sZ-004Ktt-9y@rmk-PC.armlinux.org.uk>

On Mon, Jun 16, 2025 at 11:15:51AM +0100, Russell King (Oracle) wrote:
> Fix a code formatting issue introduced in the previous series, no
> space after , before "int".
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

