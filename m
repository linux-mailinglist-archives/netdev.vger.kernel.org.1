Return-Path: <netdev+bounces-165890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943AEA33A81
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 10:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 626813AA022
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 08:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C24020CCE3;
	Thu, 13 Feb 2025 08:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzxvSXAg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1E120C480;
	Thu, 13 Feb 2025 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437187; cv=none; b=auekLtVq7KHEr+aggSwwqfnRmy9Qlc//4NP7As3dp4RpITA03M+6WyY9mHNU6acDdyFPCzGokKoatm0MzCeaWts0wPGwJaCzRPUTiYfBXHtT8BWc9Owkn/vG97AMNASoGFMz/hTwr1c/9qr//E8pRKl9WQdZBSeDPzFdUQMijtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437187; c=relaxed/simple;
	bh=HtS9SMt+0MPO7eISiOD7sGZONSitaIQg3tVcG7gVoH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOgcGpDwJ1CdYp4gfLWyJqlHtOBPK5VXKbavgpw5QJYMRzcY3h5r85htDJMCCCkb9FNcqABGx7mL/l1vkv7t6QqmfBXD76aA6bzgRrQlpZc9z2DXNzoC1wxewGocj3+V6+6WByHbz482Cf4yGxtd7KyKfOorSgMayz9FUoSdE6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzxvSXAg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6283C4CEE2;
	Thu, 13 Feb 2025 08:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739437186;
	bh=HtS9SMt+0MPO7eISiOD7sGZONSitaIQg3tVcG7gVoH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PzxvSXAg1ue2/+iuo1Xs+759D/A1NmSuaCCLotOOa0xh+7UJLGIK5PPKCIzQII+ra
	 4LyExYHm5c+g9+m6KROUOfXV+sw7wx57EfU3LaMHQXXxi8nqbPeZF695e4nqmIaDEk
	 fu8JL/euV8YMuISDiPJ4FfLrmmBrg7l79NkTTt5VsSh51QkP4yr18JUDvHsQZEs7uH
	 ADit+sj+ZFG+0EgHURmu5oDswtIesoDUaTdDZn0U+xQNYQFrfVx0F3V+k0s50erb6X
	 sorUyCpNHL6Bm/009CD/98x9VfWWlWZ1D0eZjUUbo46MHeQBfkARhikgREn56FLl6X
	 v0V/xK6SZrgRQ==
Date: Thu, 13 Feb 2025 09:59:42 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 10/10] arm64: dts: st: add stm32mp215f-dk board support
Message-ID: <20250213-unyielding-accelerated-moose-9faba6@krzk-bin>
References: <20250210-b4-stm32mp2_new_dts-v1-0-e8ef1e666c5e@foss.st.com>
 <20250210-b4-stm32mp2_new_dts-v1-10-e8ef1e666c5e@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250210-b4-stm32mp2_new_dts-v1-10-e8ef1e666c5e@foss.st.com>

On Mon, Feb 10, 2025 at 04:21:04PM +0100, Amelie Delaunay wrote:
> Add STM32MP215F Discovery Kit board support. It embeds a STM32MP235FAN SoC,
> with 2GB of LPDDR4, 1*USB2 peripheral bus powered typeC, 1*ETH, wifi/BT
> combo, LCD 18bit connector, CSI camera connector, ...
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
>  arch/arm64/boot/dts/st/Makefile           |  1 +
>  arch/arm64/boot/dts/st/stm32mp215f-dk.dts | 49 +++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


