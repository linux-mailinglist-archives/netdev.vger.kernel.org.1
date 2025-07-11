Return-Path: <netdev+bounces-206274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F60FB026FA
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 00:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09E5A7A2928
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 22:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B46C221577;
	Fri, 11 Jul 2025 22:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oammKmnS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FBE1A3145;
	Fri, 11 Jul 2025 22:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752273367; cv=none; b=CZ99Xn5Fcz4Q6unKUNuKDsF10FqeGYa+chr4sIBxQznlL1wVGnsksSvWHThLiflrah5W5ygCkpcdhXDFyKlFeUXvacN+UgAchLO7pSk//ws9xGkmJjqa7B73gVn1UQN1sLqmbgm90RNshq6c8YETOXy6uEn5s+7R2xa5fQczjws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752273367; c=relaxed/simple;
	bh=fPuN7bMxMIlYV+akOgL0LIxUTW9fVzboNK3uUmkR9ds=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E6dts3zpEct8Ipx6aEambr296TJKomSC0zwAG9Qt5j8JxNX8M9FJ+2TldJ/ZFhv8J8gsgDDGF5gII/mcLEX0df48kvDi3g5dFOljkkEfS0y0NuNk0x6X02da/IGKPmaYC1c+raEXzKC/FR1mKiZxElBsjst+EE7EPlFXWpNGt88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oammKmnS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B78EC4CEED;
	Fri, 11 Jul 2025 22:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752273366;
	bh=fPuN7bMxMIlYV+akOgL0LIxUTW9fVzboNK3uUmkR9ds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oammKmnS2iiKAY93qyhdnxhehQL9CGe+x45IKKjIc0lmxXLUTZYo+roTQFLfCQ/+j
	 hQC8S6GFNpSjawF7p2QXPtNpeBKIcuhtf9FBtxGX4Ap2BFIhX81fn9ocoTXciiEpea
	 VRec3dPXd7ytJ/sES/ECzI0JRaVnb50QIJRHI8/ojPq4VAGsg67gxGRFfFyctdUVAU
	 n15qcQPzAunLRVhuGyN+/HTjHD/OwJGVh6S41pMgdrRh3BMxfYdCoeCTNMXlSKHIDE
	 qYtfxNeYCVbXC9ob9Dvvoex1AaIk+P4ZEQW6/HkA2Ra5HQ1wQBF3cYhYZt6BAfpROz
	 y1awjQIqbUm2g==
Date: Fri, 11 Jul 2025 15:36:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>,
 lst@pengutronix.de
Subject: Re: [PATCH net-next v4 0/4] net: selftest: improve test string
 formatting and checksum handling
Message-ID: <20250711153605.4c13b166@kernel.org>
In-Reply-To: <20250711-copper-dragonfly-of-realization-f92247-mkl@pengutronix.de>
References: <20250515083100.2653102-1-o.rempel@pengutronix.de>
	<20250516184510.2b84fab4@kernel.org>
	<aFU9o5F4RG3QVygb@pengutronix.de>
	<20250621064600.035b83b3@kernel.org>
	<aFk-Za778Bk38Dxn@pengutronix.de>
	<20250623101920.69d5c731@kernel.org>
	<aFphGj_57XnwyhW1@pengutronix.de>
	<20250624090953.1b6d28e6@kernel.org>
	<20250711-copper-dragonfly-of-realization-f92247-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 10:42:52 +0200 Marc Kleine-Budde wrote:
> Is passing packets with known bad checksums to the networking stack with
> CHECKSUM_NONE, so that the checksum is recalculated in software a
> potential DoS vector?

I'm not aware of it being a DoS vector. We're talking about a basic
arithmetic sum here, not a CRC or anything math-intensive. So if we
assume the CPU is fast enough to copy this data via the socket API
to user space it is definitely fast enough to add it up and drop 
a packet.

