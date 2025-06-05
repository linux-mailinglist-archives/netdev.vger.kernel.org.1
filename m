Return-Path: <netdev+bounces-195301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2629ACF5A7
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 19:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5090A16E069
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 17:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAB22777F1;
	Thu,  5 Jun 2025 17:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdNLQVGQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B964018CC15;
	Thu,  5 Jun 2025 17:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749145679; cv=none; b=QLysqyJwSMu7P/kL70BQvGqpkhzpygfbjaMwtFwaTDu36P40JEu+jzjmr8aHcznGqcOl2nOnD/mtNVR8dsFr8JQXfsI0EIuPDTz9631d3hb5X3O196OZajLSQeVlwZGMTifK2PSpmjd5p2BGJ4g6HvTUX+HZfe+Iq+pEK3GQBsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749145679; c=relaxed/simple;
	bh=Vc58Oa/CYTfhNPPdVaJtGNwwC3wsXvAVKJEocn2OeU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BuWvWXKlwuzH7JPXD9MiPaVJIq3MaFJ4G0jEvid7e7ugGUrDE6jR3kFXQCHkeaV5Q6HpIO0ZFhcq+50CmA2dYv4ZAesoIFckvQm1nCk88bqvozEObcwf7nJkdRX/6td6J5QYEh3SFiOBRuPIznJKNToJe3tRdIbsud7BqFHRwOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdNLQVGQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023D2C4CEE7;
	Thu,  5 Jun 2025 17:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749145679;
	bh=Vc58Oa/CYTfhNPPdVaJtGNwwC3wsXvAVKJEocn2OeU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cdNLQVGQii5rss8ytGr4U6veG6kEPy+GHpnQHAB7z/DI+p9QuSvLtpVzSAUVu5haw
	 aO/DVtIq+UjRJU7RJXJ5E5UyAitURhzC2VKvDoaoiGx3QlocsaJffM9F43lAwG+jP/
	 2hcw+MJUl8xDH1sCc3UVW2Gqoos0yRBs6SSOCaaDJlqRcpwcpvGXejbsavWp0Z4SD7
	 rKOJJ/ZBGe4O7erznqTs9pDGmS2Rug2p8ZbAWRzHtw0rv4U1y+xHZYG1LKcSjE54gZ
	 d2NpZilgXhW8p4neumVVmTyZCoUDGLXILQc8JphXzVdIb/K51AMsGWwc3BwsoggrCQ
	 JbS6x+eZajHBA==
Date: Thu, 5 Jun 2025 12:47:57 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Raghav Sharma <raghav.s@samsung.com>
Cc: krzk@kernel.org, linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, cw00.choi@samsung.com,
	sunyeal.hong@samsung.com, sboyd@kernel.org, s.nawrocki@samsung.com,
	mturquette@baylibre.com, alim.akhtar@samsung.com,
	linux-arm-kernel@lists.infradead.org, shin.son@samsung.com,
	karthik.sun@samsung.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, chandan.vn@samsung.com,
	richardcochran@gmail.com, linux-clk@vger.kernel.org,
	dev.tailor@samsung.com, conor+dt@kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: clock: exynosautov920: sort clock
 definitions
Message-ID: <174914567467.2924605.14306583560925504695.robh@kernel.org>
References: <20250529112640.1646740-1-raghav.s@samsung.com>
 <CGME20250529111708epcas5p232b8bb6b05795b7014d718003daef0cb@epcas5p2.samsung.com>
 <20250529112640.1646740-2-raghav.s@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529112640.1646740-2-raghav.s@samsung.com>


On Thu, 29 May 2025 16:56:37 +0530, Raghav Sharma wrote:
> Sort all the clock compatible strings in alphabetical order
> 
> Signed-off-by: Raghav Sharma <raghav.s@samsung.com>
> ---
>  .../bindings/clock/samsung,exynosautov920-clock.yaml      | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


