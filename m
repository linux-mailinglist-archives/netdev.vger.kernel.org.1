Return-Path: <netdev+bounces-195302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 423C4ACF5AA
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 19:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B91381889DA9
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 17:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA3F27817C;
	Thu,  5 Jun 2025 17:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEP6ipiA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172CA1DFF8;
	Thu,  5 Jun 2025 17:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749145723; cv=none; b=EDOLR2fmlRdJ6iLPUgDfSZ1otJtydFG8sX9rsJ1+rNlD6ZxLMNEcRhMESA8WG2fdvQEV5y0Saw7UB0C038CE4yIZYFJ7pwmrhCw80tCe7k6Du2OWZl79VhIJYYB5pvPrlOpka0Fs4WV7Aw1t/fSWrmZ+7IRVjQN2HmJhQ7AQhf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749145723; c=relaxed/simple;
	bh=z1alDu+OK3mBs+MEaKTan/LvOGCnBM4jHemIdBWdMAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jv//PQDvHKZ/2yoHrFJLBMvKoSuo1L4qAxsBmq+DdeIIBJnoMk3cLrzzmOXNw+n50KFHncnZF4nDYFrqmflnMnnHgePOEjXKUFnV/TYedD2gEbNouUAf6U31BNn4zlz6nbDe7HOMhvvRt1Uu8+Jk7bF8O+4dfwjY6LEAYWTLzRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEP6ipiA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D5EC4CEE7;
	Thu,  5 Jun 2025 17:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749145721;
	bh=z1alDu+OK3mBs+MEaKTan/LvOGCnBM4jHemIdBWdMAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TEP6ipiAz3j1xYP3Shehu4INZBk+myzfSOoUlgWD/HkZ7bkyqPlHr60ZJb8pmQHxM
	 j6W2OADxRZN6HjdhthesXZA9OdZwMh//sSoG/1oR978hCvmxrnerimNwoEmjdOZ5ul
	 qIjRpe4hp4ds6Hle+xyGwbLkGOGN1YDKnXg4YQrD94GAtVy3lltaaQQNS9R9wEFLvs
	 1SmFsS9e/w33yl72x5GNG5gPuY7GQ+ZKmX/Bl28a1FlUODrYHEs5YsC3Qfda3u8yiu
	 8NCJi0Es2RRZX2rB9jcl/p+8AMOos8Zg3s5I/D19dqOhjLSLhTf3nMC9G5Jd9O1I/F
	 KIbOb/GZI/V9w==
Date: Thu, 5 Jun 2025 12:48:39 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Raghav Sharma <raghav.s@samsung.com>
Cc: richardcochran@gmail.com, s.nawrocki@samsung.com,
	alim.akhtar@samsung.com, netdev@vger.kernel.org,
	karthik.sun@samsung.com, dev.tailor@samsung.com,
	linux-clk@vger.kernel.org, shin.son@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, sboyd@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	krzk@kernel.org, chandan.vn@samsung.com, sunyeal.hong@samsung.com,
	mturquette@baylibre.com, conor+dt@kernel.org, cw00.choi@samsung.com
Subject: Re: [PATCH v3 2/4] dt-bindings: clock: exynosautov920: add hsi2
 clock definitions
Message-ID: <174914571742.2925706.2735159055400329437.robh@kernel.org>
References: <20250529112640.1646740-1-raghav.s@samsung.com>
 <CGME20250529111711epcas5p48afd16e6f771a18e3b287b07edd83c22@epcas5p4.samsung.com>
 <20250529112640.1646740-3-raghav.s@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529112640.1646740-3-raghav.s@samsung.com>


On Thu, 29 May 2025 16:56:38 +0530, Raghav Sharma wrote:
> Add device tree clock binding definitions for CMU_HSI2
> 
> Signed-off-by: Raghav Sharma <raghav.s@samsung.com>
> ---
>  .../clock/samsung,exynosautov920-clock.yaml   | 29 +++++++++++++++++--
>  .../clock/samsung,exynosautov920.h            |  9 ++++++
>  2 files changed, 36 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


