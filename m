Return-Path: <netdev+bounces-242859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24768C9570B
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 01:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99B23A21EE
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 00:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48D21FDA;
	Mon,  1 Dec 2025 00:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0RXuOGqp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72A310F1;
	Mon,  1 Dec 2025 00:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764547599; cv=none; b=MmTLs4cnoH2nXh8xcU0uhJCXKSqL8KiHTkYQJ+hDFTLaji1lzX92uGaAaL3LOm8r2swqn+YoaRItAWKSRK04i5ssl5piDIzFrAOkPQmnDOSQk2EcSBIR6iT2ZbSrXzAETGpxBagWD32El2toZLt4kHovAS7datCXx/RbCuxzmCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764547599; c=relaxed/simple;
	bh=NI9teLAjFoPuBFUYANFwFkzTUz0foYqxJz+WhM4MGj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2/KFKZuJEW5u1gIvgnED6iMr9wu6cY6P7ZjPWN+bydIUVz88Tovw3V2aChJ8NrkY0WnvOtict48Gm2J5FZNQ3QK97/sepeYr2IhCY+E8Aeotafm0HpcWlFAVLzQluTSwZY/IoH0AnG47EFNq5xrhgMuRaRGHmaenZqrc1UUyxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0RXuOGqp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wVyLMlsax2BhUE1HQIxnChRCm21thhaGU63AnDvjfMk=; b=0RXuOGqpmyPR0/yGX+kwUTnAzo
	FH8MlYJtuG40oef4Cq1g/k4ebcDYEuD0YEcTWK8r5kWpkxs6XVJisGxn2Bb8AWXT+n9kcVqDphNDL
	cBR3AdHdfdrIl5pBB9IOr0L8bY8lH7WeseWAvuNGdM4gmAbdsGlKzMc0TYmjuAFLUlaA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vPrQr-00FToD-R0; Mon, 01 Dec 2025 01:06:21 +0100
Date: Mon, 1 Dec 2025 01:06:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yeounsu Moon <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dlink: fix several spelling mistakes in
 comments
Message-ID: <2fac78b6-d60b-4d86-8342-3cd097a96037@lunn.ch>
References: <20251130220652.5425-2-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251130220652.5425-2-yyyynoom@gmail.com>

On Mon, Dec 01, 2025 at 07:06:53AM +0900, Yeounsu Moon wrote:
> This patch fixes multiple spelling mistakes in dl2k driver comments:
> 
> - "deivices" -> "devices"
> - "Ttransmit" -> "Transmit"
> - "catastronphic" -> "catastrophic"
> - "Extened" -> "Extended"
> 
> Also fix incorrect unit description: `rx_timeout` uses 640ns increments,
> not 64ns.
> - "64ns" -> "640ns"
> 
> These are comment-only changes and do not affect runtime behavior.
> 
> Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

