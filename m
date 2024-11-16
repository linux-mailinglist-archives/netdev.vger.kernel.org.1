Return-Path: <netdev+bounces-145530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CCC9CFBD0
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 01:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A29061F24687
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 00:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9B0567D;
	Sat, 16 Nov 2024 00:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+o50lig"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A5623BB;
	Sat, 16 Nov 2024 00:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731718134; cv=none; b=WR+/AuTxyoPZdr1u+fca6e6VpTl+I24pNQUKApxAVo8a+//vbrXEn12oO84FTvzzbfSZxWAIFvQ1MTXuCdxKmQwwmMIhPhXwB03OJg2ahTtBFVKwbkjEPSdo5pYn7Eixuf8MxSrCYOgy0d014B2okMQzy7Az6/oH7kqY9tbvC9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731718134; c=relaxed/simple;
	bh=xwCxaAaU5PMEh9QrfIbGIXBcwLTq9pbKPX9NFgBNOIk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0rpYFvAks+SnOymczDefF5QnTDOT2ZI7AJWdv8Po4pnaY2WvMEu3KLPT32H4cCSTmxgtIlU4ehAOisLNB0zkhdD2KP4IOsJ11mEnp650nSLikd87V5rIrmiiuhhutf2WV277iM3QWv8dSgvg61aJDj9V+4BAyYh3mS70sa+vd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+o50lig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D2DC4CECF;
	Sat, 16 Nov 2024 00:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731718133;
	bh=xwCxaAaU5PMEh9QrfIbGIXBcwLTq9pbKPX9NFgBNOIk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o+o50lig8d3faVZznomrszeGLyuqZDkDr3dqten4m5bf7O7ZWmAEmsoqO26alUxVv
	 nZHzpGMvtFaYlAITioz7f4AQ5LLoiYSy07hehKDt4pD1ULKreK1HKxUZcsv0URDR9M
	 lh11vwoQ/fED1lHA0lzsN8hjSEk4QOkJ5B7KWhaPWfnRFAeO2MME9zSvX12dEbs2rL
	 6SL4ILBYyErHNA0CVm2IM0RhUr43g5rVfKh5K+p96MXf2+ycfHiyXECilG87z5Vjyi
	 6aF+Wg8x/rpu3BAqR17TiPbBBcjU3PD4WlMBm01CwEp2hzCTifyU9CT2fW+QOy5Ule
	 xsKLKug76ZcRA==
Date: Fri, 15 Nov 2024 16:48:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Moon Yeounsu <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4] net: dlink: add support for reporting stats
 via `ethtool -S`
Message-ID: <20241115164852.0d46d6de@kernel.org>
In-Reply-To: <20241114151949.233170-2-yyyynoom@gmail.com>
References: <20241114151949.233170-2-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 00:19:48 +0900 Moon Yeounsu wrote:
> -	dev->stats.rx_packets += dr32(FramesRcvOk);
> -	dev->stats.tx_packets += dr32(FramesXmtOk);
> -	dev->stats.rx_bytes += dr32(OctetRcvOk);
> -	dev->stats.tx_bytes += dr32(OctetXmtOk);
> -
> -	dev->stats.multicast = dr32(McstFramesRcvdOk);
> -	dev->stats.collisions += dr32(SingleColFrames)
> -			     +  dr32(MultiColFrames);
> -
> -	/* detailed tx errors */
> -	stat_reg = dr16(FramesAbortXSColls);
> -	dev->stats.tx_aborted_errors += stat_reg;
> -	dev->stats.tx_errors += stat_reg;
> -
> -	stat_reg = dr16(CarrierSenseErrors);
> -	dev->stats.tx_carrier_errors += stat_reg;
> -	dev->stats.tx_errors += stat_reg;

Maybe I'm lost in the macros again, but I dont see where you are
updating dev->stats now. 

Do basic stats still work?

ip -s -s link show
-- 
pw-bot: cr


