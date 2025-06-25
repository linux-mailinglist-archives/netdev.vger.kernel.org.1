Return-Path: <netdev+bounces-201314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E1CAE8F5D
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 22:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65F7D1C2649E
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 20:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6066E26159D;
	Wed, 25 Jun 2025 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iL/rNrXO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3820D1DE3B5;
	Wed, 25 Jun 2025 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750882880; cv=none; b=S2KtMyB3q6xjXBe4VXpEQ+zNao3CI3ylCl9de0ot4e3TsuPjlHcWaUdReoWhJHlLL+MDsDqzNa8E+DyNIsqdvtjwYkwOucQgzYYlIs8alyf9HvKfnTyyTbpk32iALPXov/MoypE7bhF6A8qU8wH7/jiuhDGCkRDKr70fuKLmSGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750882880; c=relaxed/simple;
	bh=Qhy65bNDD2Cm+pL3IZhUWPZBKCfxrDQnhAq7vRn8LxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hL1yAxJm1g1idgJj8DD6p+aij1fPzi0BkdgUKtoZVK7GnaeeNH2BniJ+5I183Xod/R2BVCIVtBLkZ8OsQcRnTK4KXQRU1eWktTA3sRkkRyY25xv5T4v8bxrdb2x0+M0zOan/X6bys6+uAPEsUiu0o06TfEgmWNpYDBIPURDzK00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iL/rNrXO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF0FC4CEEA;
	Wed, 25 Jun 2025 20:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750882878;
	bh=Qhy65bNDD2Cm+pL3IZhUWPZBKCfxrDQnhAq7vRn8LxQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iL/rNrXOKOGUP0A3SUGxdwoUEoA+teDqfAA/OjHGGQ9ixO+L/kr3iC04J8m6pFqPc
	 aqjgjrGCV/hgDE5c1i9JBeiYZAG9jFxYRP7Z4x9jL7p8oHSVnRbdRL+L+P0979/bfR
	 xToHNBG1ogbdvT3QIOuKNQD2BIQchVpkR5QLmQPVyCVTEtU9BAYY5uhzgjP9E4h2Og
	 49CXkmlixrJP3W6qyfQWQYhu/uDnypgHD2qfSeUyFtbtD5/YrX3frCRYVVeKJ0wEjp
	 VeWZy8sVLZx0nIQ0vYCaOrym2989ffkQlanJ6iejHDwMiYFthxQAaRm3q+oaSe9of2
	 da/v07j/RpaVQ==
Date: Wed, 25 Jun 2025 13:21:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v4 0/4] net: selftest: improve test string
 formatting and checksum handling
Message-ID: <20250625132117.1b3264e8@kernel.org>
In-Reply-To: <aFuEHpbjGILWich1@pengutronix.de>
References: <20250515083100.2653102-1-o.rempel@pengutronix.de>
	<20250516184510.2b84fab4@kernel.org>
	<aFU9o5F4RG3QVygb@pengutronix.de>
	<20250621064600.035b83b3@kernel.org>
	<aFk-Za778Bk38Dxn@pengutronix.de>
	<20250623101920.69d5c731@kernel.org>
	<aFphGj_57XnwyhW1@pengutronix.de>
	<20250624090953.1b6d28e6@kernel.org>
	<aFuEHpbjGILWich1@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Jun 2025 07:07:42 +0200 Oleksij Rempel wrote:
> Hm... at least part of this behavior can be verified with self-tests:
> 
> - Send a TCP packet with an intentionally incorrect checksum,
>   ensuring its state is CHECKSUM_NONE so the transmit path doesn't change it.
> - Test if we receive this packet back via the PHY loopback.
>    - If received: The test checks the ip_summed status of the
>      received packet.
>       - A status of CHECKSUM_NONE indicates the hardware correctly passed
>         the packet up without validating it.

_NONE or _COMPLETE are both fine in this case.

>       - A status of CHECKSUM_UNNECESSARY indicates a failure, as the hardware
>         or driver incorrectly marked a bad checksum as good.
>    - If not received (after a timeout): The test then checks the device's
>      error statistics.
>       - If the rx_errors counter has incremented
>       - If the counter has not incremented, the packet was lost for an unknown
>         reason, and the test fails.
> 
> What do you think?

Sounds like a good idea! Not sure if I'd bother with the rx_error
handling. Hopefully the drivers can be configured to pass the packet
thru.

