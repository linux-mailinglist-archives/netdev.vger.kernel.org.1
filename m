Return-Path: <netdev+bounces-215703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDAFB2FEDB
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 078E2B006F6
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD99274B34;
	Thu, 21 Aug 2025 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BiARebMo"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E218A20E6;
	Thu, 21 Aug 2025 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755790558; cv=none; b=iw4Ft+3huBEU7c/3MiFPUJuNNtWogDad2c30WpoocaPq6j0bDlz2rVY9y33XdcDlc3R+5C0hA0i7UGWG6ybnM5dDFMSsTUsETQIw64LbyObr4K7uWNBBdgZykGi0Dka9Ntpj7/oOmGzpP4eamjWdjo2TDeyGuSaIm3tagug5OSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755790558; c=relaxed/simple;
	bh=td56PTEpZ1mg4CIJlNkSc4T2AMSz0KTd2tuX5U2g0is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irS3jfrrwFDAUKfE7U+FG/IVS8582zb+yiQxNGNPu2xUtFnIFEyeVYY69IFDIplcYmsrt1rSWGbbEz0NP1QOSvspbNbXZJZYctpEN9U1O6q8Q1UIaa++gxT5eXeSoLKIiLygzD5BsJGt5ueY4V2Q6dMEj+q8LBtl15lJucnoBuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BiARebMo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6xsxG03JNmvC6eJU0SQIi8DQjG9PZNKQMY+Mtw3NEPY=; b=BiARebMoPEt9DgTUA6GRf89fg4
	24BMngjfsKAFMS29H6P+frfSn8cNaM9ZfhfcIWPgthWEhswJLyGUbsWw04DX1djQ4wHYKaXzBAXu7
	W5b7GsCOmAuBwa2NW7vcCUyQLiKHaJ8CYqVzRx9p/oVljb3EIJ2pvo7JQDJWQEOSt04A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1up7KJ-005TEY-3H; Thu, 21 Aug 2025 17:35:43 +0200
Date: Thu, 21 Aug 2025 17:35:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>, linux-kernel@vger.kernel.org,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Robert Marko <robimarko@gmail.com>,
	=?utf-8?B?UGF3ZcWC?= Owoc <frut3k7@gmail.com>,
	Sean Anderson <sean.anderson@seco.com>,
	Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH net-next 01/15] net: phy: aquantia: rename AQR412 to
 AQR412C and add real AQR412
Message-ID: <162ae90f-d233-4415-ba98-d4292be41c21@lunn.ch>
References: <20250821152022.1065237-1-vladimir.oltean@nxp.com>
 <20250821152022.1065237-2-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821152022.1065237-2-vladimir.oltean@nxp.com>

On Thu, Aug 21, 2025 at 06:20:08PM +0300, Vladimir Oltean wrote:
> I have noticed from schematics and firmware images that the PHY for
> which I've previously added support in commit 973fbe68df39 ("net: phy:
> aquantia: add AQR112 and AQR412 PHY IDs") is actually an AQR412C, not
> AQR412.
> 
> These are actually PHYs from the same generation, and Marvell documents
> them as differing only in the size of the FCCSP package: 19x19 mm for
> the AQR412, vs 14x12mm for the Compact AQR412C.
> 
> I don't think there is any point in backporting this to stable kernels,
> since the PHYs are identical in capabilities, and no functional
> difference is expected regardless of how the PHY is identified.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

