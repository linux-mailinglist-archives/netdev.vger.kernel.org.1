Return-Path: <netdev+bounces-165893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB282A33A8F
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 10:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C57A2163599
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 09:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459AB20C021;
	Thu, 13 Feb 2025 09:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3iWvDyp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1727F201034;
	Thu, 13 Feb 2025 09:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437376; cv=none; b=lih1gvfhWds7dRel/6ins7V47QMuV3pMF26NKoc37Z/+0m2kkcuBPM4GfLT5nibFZuE5ZM07C+3UKYVvsHcK+7sM1wM55hJ0+ZHsbKqYHeXmct8I2o0qXl3mIuFxJgoSk6Qb1j9De1QlRqwUqQvDIzvHickIEnaWCJ+gu6sEEHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437376; c=relaxed/simple;
	bh=qJUGS5aMNlI3ACxeGXL55sT5mPp48KgzgEP7Ar9ldlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUVmumea8QZyMLTK0RfnkypyEzO4QQay1SKt8D8oPMEtBadK41YiuTQprsU2w3yEk373dsat+c6Zye3+BFjHAyWSN0gjkNRez4ervUX5JfV92ib/xJvQdvFwxDFpB4o5hChBxbhjYJWTMxUxWyTYzsMdkQToPK7QVdJSFYjEVvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3iWvDyp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E39C4CED1;
	Thu, 13 Feb 2025 09:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739437375;
	bh=qJUGS5aMNlI3ACxeGXL55sT5mPp48KgzgEP7Ar9ldlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T3iWvDypjZL41SnTlfB9/DhnZgwBi8RYF8WEjUJ5LBFgxYRxWYhblp0osEcb8Gdv9
	 nB/Lpa7WN788G5cy8ooLGj+rxipdcx3BUftPR2DUx/73mV1v12FOKUUSXer4eGJt7d
	 kv0qYZSpVKvdqD0lmfGZHsakRBEspK7XZ8qRK8THDYKTwW0g+up2uhMuwN06UXNs16
	 4XpykJJ5yb4LpWMgBLSJR4n5hO5A3T1dnB7qTu3jwG0YjoaV9STafcatIFkbXnNu9g
	 6h/KfB1GHjjArGzXGeYPWIruSJ7LlgLRXsjsYFVmV6Wg6XJLdkKoSux1AuFM0q1/cE
	 +eXTpQNw0+pWA==
Date: Thu, 13 Feb 2025 10:02:51 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 07/10] arm64: Kconfig: expand STM32 Armv8 SoC with
 STM32MP21 SoCs family
Message-ID: <20250213-polite-spiked-dingo-ce0f3a@krzk-bin>
References: <20250210-b4-stm32mp2_new_dts-v1-0-e8ef1e666c5e@foss.st.com>
 <20250210-b4-stm32mp2_new_dts-v1-7-e8ef1e666c5e@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250210-b4-stm32mp2_new_dts-v1-7-e8ef1e666c5e@foss.st.com>

On Mon, Feb 10, 2025 at 04:21:01PM +0100, Amelie Delaunay wrote:
> Expand config ARCH_STM32 with the new STM32MP21 SoCs family which is
> composed of STM32MP211, STM32MP213 and STM32MP215 SoCs.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
>  arch/arm64/Kconfig.platforms | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 844a39620cfea8bfc031a545d85e33894ef20994..f788dbc09c9eb6f5801758ccf6b0ffe50a96090e 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -325,6 +325,8 @@ config ARCH_STM32
>  			- STM32MP251, STM32MP253, STM32MP255 and STM32MP257.
>  		- STM32MP23:
>  			- STM32MP231, STM32MP233, STM32MP235.
> +		- STM32MP21:

Squash it with previous patch and keep some sort of order.

> +			- STM32MP211, STM32MP213, STM32MP215.
>  
>  config ARCH_SYNQUACER
>  	bool "Socionext SynQuacer SoC Family"
> 
> -- 
> 2.25.1
> 

