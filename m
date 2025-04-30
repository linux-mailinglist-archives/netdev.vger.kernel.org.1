Return-Path: <netdev+bounces-187084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2844AA4DCC
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 15:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9628E9A527E
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 13:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9D325D900;
	Wed, 30 Apr 2025 13:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0xrVQCvI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF2C20F091;
	Wed, 30 Apr 2025 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746020845; cv=none; b=Z5xtUpTuI7hgvtFVPGxWoUxybJZox9p6VKxdnQt5pmz62TLb+h7SQfxvOIFvo4ZhyDWz6LdfnY+N2CLy5X22P/GA35Mc8DuZ43hX6XAeS+iekY+zLt1NazdKM5fXpzZuIx4aTkMAZHhZYgeBn3J9G/kyxygMKL5wDlgdwbdqIlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746020845; c=relaxed/simple;
	bh=FsCRdVD6+Q7Y1vZkwNGydmeVIIhlnlqXmK44Sf4zTjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quh7sXn3whCrXthMrz0pHIrLEb1tWXeHPuCwV+zret1zhe6LJKXNHJ5zVG/zE9ZkEdYml2pdrwBl1uJli82yQk+koGpQ3iddvtZNQddbiyDWptzH6O9phcnLR/R3+JXzne+2FQnc1qvHxWiW2h4xUTOm37G2rpnc6ttNmoLJ0tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0xrVQCvI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=F9FMcXK4PAR2cWTej1wVtS5qTZ8jEdfVUkLV+HimljQ=; b=0xrVQCvIXYBzzDHjoITezM57mp
	piPnHwNixGOB77FnKEeJ3azy/+OloJzon83vOHGiDV0lX091p9rM4zjvMZJNISCkP+J8j4hcu1Aaw
	cOz2JQFYVPtae1ZAoA10dUNax5Q5Tq+jUvYJi8EB0BrfJNEZ2vpSD2GX3J1Jv678+gsU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uA7mM-00BDng-7s; Wed, 30 Apr 2025 15:47:14 +0200
Date: Wed, 30 Apr 2025 15:47:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net V2 3/4] net: vertexcom: mse102x: Add range check for
 CMD_RTS
Message-ID: <858fc027-4a5c-4d41-b532-1e93e73d1abe@lunn.ch>
References: <20250430133043.7722-1-wahrenst@gmx.net>
 <20250430133043.7722-4-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430133043.7722-4-wahrenst@gmx.net>

On Wed, Apr 30, 2025 at 03:30:42PM +0200, Stefan Wahren wrote:
> Since there is no protection in the SPI protocol against electrical
> interferences, the driver shouldn't blindly trust the length payload
> of CMD_RTS. So introduce a bounds check for incoming frames.
> 
> Fixes: 2f207cbf0dd4 ("net: vertexcom: Add MSE102x SPI support")
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

