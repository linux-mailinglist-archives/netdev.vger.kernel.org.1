Return-Path: <netdev+bounces-165888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDCFA33A6F
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 09:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DC91160839
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 08:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E8420C477;
	Thu, 13 Feb 2025 08:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViI3lAUR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D2E20B7EB;
	Thu, 13 Feb 2025 08:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437167; cv=none; b=Z2YChnpsqRr7JO1Ejk4miAhugu0fZ++HMKKG8kLxwDOo2eDu18blOtXNwFkCZnBnS/MNWSPlSs4VfauSZfaaxlmdwE8O9+ius/Riewnn+QgkHQIcltMsDLAxGVc49N4fuTBDoF1o8InenifS9j/QOiYbPQLFLHQ5YuTK6JSNsXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437167; c=relaxed/simple;
	bh=r0p8oF2o5KcUkeDQOtykeK1nddAxj6LGqMj0TRgl5jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKUmfKLVmVPJZthzBBeWRGw8THQaruptxmrz2S2jET29uX+8LYlZD9rbY2IrKbKi8ZIzQHbu4vGmIN3yTBgfx09jfh2eumTzc+u5wVdEiJtWj1UsVpaZNHRYmTd13lXdqub9DoxspPE/n/F86s4dx5PrSzB7b/dZG2pi7FfgV/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViI3lAUR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEC9C4CED1;
	Thu, 13 Feb 2025 08:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739437166;
	bh=r0p8oF2o5KcUkeDQOtykeK1nddAxj6LGqMj0TRgl5jA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ViI3lAUREFpp/f9x3sPMkFSynOe0mj3ozQIXsJTK46uIC918sz+sLUgC/vW3fWzfp
	 pwpy6dQFqjqv4ZKwQUucSN6JatWQYeqW6gZ+dxgT6ig0QpsC880dulVf1ubHP09+XF
	 39mF8kkY+f/46pgPWBz1rorbdc8eKFsc58elem+vg9hvK3SlqGhRFxzMqhymxabWaR
	 go5S7LXMaHe8fZdcTknA7fQFMJgryg/y3wnGdwoPHVbZqa+DWmJ4keEvYVrBzmodrY
	 qu9lNlGXInZITWUutbzn/AHu3TfXtBEtXbKVmY1CZ3tU4EKOTs7ZP3OHJ1dBmQ5PQb
	 59BYo9MfinClQ==
Date: Thu, 13 Feb 2025 09:59:22 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 09/10] dt-bindings: stm32: document stm32mp215f-dk board
Message-ID: <20250213-wooden-ibis-of-assurance-2b3622@krzk-bin>
References: <20250210-b4-stm32mp2_new_dts-v1-0-e8ef1e666c5e@foss.st.com>
 <20250210-b4-stm32mp2_new_dts-v1-9-e8ef1e666c5e@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250210-b4-stm32mp2_new_dts-v1-9-e8ef1e666c5e@foss.st.com>

On Mon, Feb 10, 2025 at 04:21:03PM +0100, Amelie Delaunay wrote:
> Add new entry for stm32mp215-dk board.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
>  Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


