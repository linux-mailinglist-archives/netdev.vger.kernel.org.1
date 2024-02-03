Return-Path: <netdev+bounces-68836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8741A84876E
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 17:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B87B71C22A19
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 16:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF7B5F54D;
	Sat,  3 Feb 2024 16:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0yIYr42e"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BC95F57D
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706977579; cv=none; b=SNmYUcWypgRP9RKijd7EfwinBLVy2SDoFl++qI4wxIFxcTl+kBSM0ZU4Zl+OQxOG9xhqRyXGpJuBUxniWMcARHym7oNt//GuBPDgtu1jm0gVDjyWTUvaNDNcvogqTmq/VDleuU7DJRVsZkbwF0XqAvCjGS35Pt6HhFDvu/nuVdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706977579; c=relaxed/simple;
	bh=hoH6In2hUkMB9nDrCrUtOS3eRwOtHqOcQkr/gdAOVIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1Ply40scLvrsHgbwUABKL/D+Cxri4kIJnKbuNOkDySdQUJ3sKFHzloZevuqOzGImQfBAhcVFZUXmWl01yD16QwcT2m6h4vcF510Zv/+aPiIpWT25skrmZFH4EPg1zSeEGl27T96ZHlgAAU5UttfnFGtAsC777k36PYQmzdLtWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0yIYr42e; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=o73TRuf2/JrOpfNWUc2M3MyeiP38nWpzlxCKdFBIez0=; b=0y
	IYr42epFq9O02Lbn+VF7sodYwQOckQl0BrxXepQrwA0af2risDtbACct0VNIczXnW6YtHecyrqUoN
	NqlwFavdIVIcgbNf8nM9moivR4r2si5iNFQddsJ90CHWVhQSTI1WJGTTEh5nvmVqqhUEKfThAsSNC
	e3v9BsLh0Tq3hqE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rWIqM-006uds-Us; Sat, 03 Feb 2024 17:26:14 +0100
Date: Sat, 3 Feb 2024 17:26:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH net-next 2/2] net: dsa: qca8k: consistently use "ret"
 rather than "err" for error codes
Message-ID: <10ec9fa5-208c-4318-9c8a-11297c7b3aa9@lunn.ch>
References: <20240202163626.2375079-1-vladimir.oltean@nxp.com>
 <20240202163626.2375079-3-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240202163626.2375079-3-vladimir.oltean@nxp.com>

On Fri, Feb 02, 2024 at 06:36:26PM +0200, Vladimir Oltean wrote:
> It was pointed out during the review [1] of commit 68e1010cda79 ("net:
> dsa: qca8k: put MDIO bus OF node on qca8k_mdio_register() failure") that
> the rest of the qca8k driver uses "int ret" rather than "int err".
> 
> Make everything consistent in that regard, not only
> qca8k_mdio_register(), but also qca8k_setup_mdio_bus().
> 
> [1] https://lore.kernel.org/netdev/qyl2w3ownx5q7363kqxib52j5htar4y6pkn7gen27rj45xr4on@pvy5agi6o2te/
> 
> Suggested-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

