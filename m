Return-Path: <netdev+bounces-241342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8ADC82EC4
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 01:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3024C34ABDB
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 00:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6493C1C862E;
	Tue, 25 Nov 2025 00:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tIr5G9gl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD21C1531C1;
	Tue, 25 Nov 2025 00:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764030112; cv=none; b=QFMrShPbi5oldPcJhJu3ruMypE5JaeaG7trWd8DZFeszKG+qGBxNrkrouZzXZgANqJ/fCMMzScRAfKliDB6vny9Msqs2x4ol07nP1pdsEVZaJTwyG6x40ZlI73zG+GnSL1NJB+PO79mIjp1b5ZhuWlON9yqWLSdNAkd0Jx8j+Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764030112; c=relaxed/simple;
	bh=8P9sXdGTcyHZs1owxJsoXGiwW5zZFjRw5GHTYrIdTKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQwAPRQGKbFgaCCTzix0uyTmKqZagOBSf+YpNbrMVwY6DWO4GsQGaTzp+CqPA05SHtj0kHulVQZWfZ4l9TmHRs9zkkIUsnLlCUoJo4MrKEMDdEt6vYKqHkBtNo8uSmWkgO9B8g2ey4SZeCFhuEXohKmYu5NOp59DjSZ89nukw8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tIr5G9gl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=J+TANZWcOgQJfDvygww+ASmyXzn+Rs4bLGiVbxMb90k=; b=tIr5G9glL6VbI7ZTorMTvbjU4o
	JDpX5zVtTUXBKeOzKZjxTkHmD6kxO/hzfbsh2AqvZlypONdc4QmZmyqfvR2C7enOt/24ywYaskjoj
	3Bm7mz+GQyT5RRjAUsl2ZPwKSz0v/tkkZB2S6bSdGPgSLbZ974xZrLL82Aw7RHTwlNbs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vNgnn-00ExY1-Kx; Tue, 25 Nov 2025 01:21:03 +0100
Date: Tue, 25 Nov 2025 01:21:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yixun Lan <dlan@gentoo.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: spacemit: Remove broken flow control
 support
Message-ID: <78328381-db8a-4bc9-b520-eb1c687b846f@lunn.ch>
References: <20251124-k1-ethernet-actually-remove-fc-v2-1-5e77ab69b791@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124-k1-ethernet-actually-remove-fc-v2-1-5e77ab69b791@iscas.ac.cn>

On Mon, Nov 24, 2025 at 01:28:27PM +0800, Vivian Wang wrote:
> The current flow control implementation doesn't handle autonegotiation
> and ethtool operations properly. Remove it for now so we don't claim
> support for something that doesn't really work. A better implementation
> will be sent in future patches.
> 
> Fixes: bfec6d7f2001 ("net: spacemit: Add K1 Ethernet MAC")
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
> ---
> Starting at v2 as this is the net-next successor of:

If this is for net-next, and not for backporting to stable, you should
not have a Fixes: tag.

Otherwise it looks O.K.

	Andrew

