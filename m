Return-Path: <netdev+bounces-109912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF1592A41E
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 15:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F8D284FE5
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 13:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC9913AD07;
	Mon,  8 Jul 2024 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rnQRsXHd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3BB13A3FF;
	Mon,  8 Jul 2024 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446801; cv=none; b=qBxagUpdN0CXTXciV9U70OZQ8UJe8CbttKJx3KCagh4ykqm5/hcYEF0DqihQxn5OSpdTs/ZSOafmU5PYBl2hHprECRqCJas1ohW3b74RVKtxLOK+xu59vPx4U/gcPplgNZC48yWG7s46NN6unNd+ZRGtJYA+FjmC+nzwkkWjtSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446801; c=relaxed/simple;
	bh=4gvVWnO+4ewFU4NAR/MX4F+pX/k1QNiJ4MV6c6MS9DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjlVs95jo52C9NJTGW/eGYt8tgh7ad9IaakaJMdtonkn4Xzh5KP5Nvnic9SlC4z+rMXv+tujUjB26BnaQob1GEL4XFQNlOz+wglPZj2tpqOTcPJ6xsCrERWvRFV3n1+9dWCRWq23nscm8/oBYXJtABJ0fRETwF1iPRUu08Smkv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rnQRsXHd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=p2QPqbHIw/JAoYCdkof+USdy7A/iEKc+/fFJ4UJPt/c=; b=rnQRsXHdB7EosNcr0XOiV0hM7S
	kf9NaRiuOMX0H+80+f4/NyaZltvtNpaoX+OfQopSlOZEBTYQ8yPjincmwRnKXwjsFSmXJCLnosMeM
	I9fc7w26QiqzaU7J4rZLt1tkLrItMGFsBJohgwto1F9loU/VaHNccT54FljMNYWKEIUk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sQonl-0022uM-SJ; Mon, 08 Jul 2024 15:53:09 +0200
Date: Mon, 8 Jul 2024 15:53:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Guillaume La Roque <glaroque@baylibre.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	MD Danish Anwar <danishanwar@ti.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ti: icssg-prueth: add missing deps
Message-ID: <1eec9f10-9eda-4f9b-b0f8-28f25a6153ca@lunn.ch>
References: <20240708-net-deps-v1-1-835915199d88@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708-net-deps-v1-1-835915199d88@baylibre.com>

On Mon, Jul 08, 2024 at 03:38:20PM +0200, Guillaume La Roque wrote:
> Add missing dependency on NET_SWITCHDEV.
> 
> Fixes: 5905de14c2a5 ("net: ti: icssg-prueth: Add support for ICSSG switch firmware")
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

