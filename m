Return-Path: <netdev+bounces-239129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF43CC645FA
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 14:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E083B20A5
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 13:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D121132721C;
	Mon, 17 Nov 2025 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bT3xSquk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8BB3328F2
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763386214; cv=none; b=Ep8DSjBmtqmLRFbdE+VcwHtotlIkJSO+n+UYjQUfTMsc5zwO1TMoUVP2qFKnDU8pSHoPACQvvLcXh9j5vujAMHuyuMPTXEqYx3MeeDqijLwyi1/HYEGsJJuHYBRH7hdxSn8iFMYJo5GNzVyAKuIGYICGdlxpWtnCWKevvpzGj7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763386214; c=relaxed/simple;
	bh=2V7NVpfc1s1+Myu0JVYwtYQSDehoPIgapU89P9C9+xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2mky7IlPt1mJw0+d5TZ6EMbm53wvhOVZCUegt7M7+zc7qCZdclDfxidBKY3jyoKThmWi9vhXEJFPw07Hkaor+eWbeH0ffP2mRUfmqz42dpowg20EYGlONVxunOiJ5Ppe/3Cs8x7AUVQnB/RIXVma2YGvzWXmqT0jx9pENf7IJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bT3xSquk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tpLNnsnm0koe6mSAB3y4t2c36dTPYWXi2fRTKGqLquE=; b=bT3xSqukPvpjBwq4LiLabs0cJb
	pglOTlFTFxebEvuGlIs7rVeIv1AiFgN3LW+OGABPvpV9a1cA183BO1i07R2N6UgxprOv/hpuFrWBL
	1xFi8p7N7uzSgtRozeEX5rML9dh7YQeP1N5uLIEGkXe8Plar3I0FQ4Tq3inZjaQmH04g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vKzIw-00EF9Z-TX; Mon, 17 Nov 2025 14:30:02 +0100
Date: Mon, 17 Nov 2025 14:30:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: linus.walleij@linaro.org, olteanv@gmail.com, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org,
	alok.a.tiwarilinux@gmail.com
Subject: Re: [PATCH net-next] net: dsa: ks8995: Fix incorrect OF match table
 name
Message-ID: <c9ab8606-66a9-47d7-ad98-7ad0a3e5810e@lunn.ch>
References: <20251117095356.2099772-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117095356.2099772-1-alok.a.tiwari@oracle.com>

On Mon, Nov 17, 2025 at 01:53:50AM -0800, Alok Tiwari wrote:
> The driver declares an OF match table named ks8895_spi_of_match, even
> though it describes compatible strings for the KS8995 and related Micrel
> switches. This is a leftover typo, the correct name should match the
> chip family handled by this driver ks8995, and also match the variable
> used in spi_driver.of_match_table.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

