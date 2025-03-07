Return-Path: <netdev+bounces-172804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66655A561D2
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 08:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A91B1894240
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 07:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE8C1A5BBA;
	Fri,  7 Mar 2025 07:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHXnY75k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF06C1A3171;
	Fri,  7 Mar 2025 07:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741332593; cv=none; b=Dcewxi8mTEZkqSZC3np9yJsD2rUTrgc/Zj0kAdH5oUZctQ6M1dAL8iybLBS0I+6pSdC3T48RUFXRZj7zlHS1OE2sJ3S2Yl9S66zZBIEXwuL9QqmYVgBdJnwV1iDO8g3X90d5E6t/cWAwOKqFLXSnverF3ZIXXPXXqDmvj0zLxns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741332593; c=relaxed/simple;
	bh=9IM2Zi16jhQTEhlsjN0XpLrMG/R/xIXyk6ZdOXdSFl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAXQLhO1N5ydzPg1Oo+oLn5KGwHwrNZHZCM/CAWgHxlQOHoc0DtI0B7o7O2pGTgmcuJmPkauqIzlvf16QhxrDcPpKJvncp65W72Z+G2KIsaD9basuO5kK6O6KvEUhhYnPZYlWQqCGm5dMQC2oJaK9q8e8cMdn2me4i+yiPHoWfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHXnY75k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C70C4CED1;
	Fri,  7 Mar 2025 07:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741332593;
	bh=9IM2Zi16jhQTEhlsjN0XpLrMG/R/xIXyk6ZdOXdSFl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lHXnY75kTGL+ySabRaVU4JEh0F1XwB17J6xFxYfo3CM1sjc1J+V/AYcH3M+kf3T1K
	 VjM1Zk3gAU0zIvhzYNvYayA/EOUTH3C9BrPrZpWSBG7Y+HKFg2QKDrmkhzfSSEbUR3
	 cdRtWpocD9vf9zl5tNgY9FZjFplxMUAkYMT1IplwAiFKkZIMV8nZGrwielBu8qmoNv
	 8vYLGhKh5EvYvH/mD/5kTTeZ8TGkwTpOY/LAk9gQpQq5plXrQiHX2mvf4khhmGOqZm
	 sS6sFyrFPlJUb+lkbje5aklcglsY5sCZOBGI7LiH525K7ZaPjPJbEOQHal+T47nUi2
	 cuYtbsZvEUamg==
Date: Fri, 7 Mar 2025 08:29:49 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Guangjie Song <guangjie.song@mediatek.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Richard Cochran <richardcochran@gmail.com>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH 21/26] clk: mediatek: Add MT8196 ovl0 clock support
Message-ID: <20250307-godlike-quizzical-mayfly-dec36e@krzk-bin>
References: <20250307032942.10447-1-guangjie.song@mediatek.com>
 <20250307032942.10447-22-guangjie.song@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250307032942.10447-22-guangjie.song@mediatek.com>

On Fri, Mar 07, 2025 at 11:27:17AM +0800, Guangjie Song wrote:
> +
> +static struct platform_driver clk_mt8196_ovl0_drv = {
> +	.probe = mtk_clk_pdev_probe,
> +	.remove = mtk_clk_pdev_remove,
> +	.driver = {
> +		.name = "clk-mt8196-ovl0",
> +	},
> +	.id_table = clk_mt8196_ovl0_id_table,
> +};
> +
> +module_platform_driver(clk_mt8196_ovl0_drv);
> +MODULE_LICENSE("GPL");

You have warnings here about missing description. Build your code with
W=1.

Best regards,
Krzysztof


