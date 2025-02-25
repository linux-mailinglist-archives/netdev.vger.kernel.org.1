Return-Path: <netdev+bounces-169524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FEFA4458F
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 17:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 237D5166683
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 16:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7003189912;
	Tue, 25 Feb 2025 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NU2EeJ8F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E7F17E015;
	Tue, 25 Feb 2025 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499940; cv=none; b=D01MrrJqucRiRhfE4XPEVRviPPB2C2mXYEqNyUEEmZBfXiGprN6OeqPRHprWFMOSs7A63anbVp03UPIJNfLGCgSF+HbJW2NKTkAaGLZ34iOaHOV2Pb4bDxFZK6CIJIl7YLzByCREUOD437f02cfdAM61OvJHfJ07JRbi6vat9yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499940; c=relaxed/simple;
	bh=6TPSx9DDdcDsDZc4Z3MH/7GdfIzQc59GGd56ID/Sx5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOWCQUtXF3Ze3KVqjFuY4n7z/mjJ34pSg6wP8Vh4BZ6ES3qy9Z0K055TB/WGr/R6KjgbJUk9IEhdgS05Yy6rxAa1g+43hyzDDhyczuwkszgSUHd8d5oeZF3Q8uoizeUnv10mwkrbMr5DLuzAeLHBGyu3S6YYSDmQb3TtYgOOh1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NU2EeJ8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7572C4CEDD;
	Tue, 25 Feb 2025 16:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740499940;
	bh=6TPSx9DDdcDsDZc4Z3MH/7GdfIzQc59GGd56ID/Sx5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NU2EeJ8FyzWf7HI2/8kGM+qhJabN/O1VJNuarGCTaaTAf7SR0p+tXbOv0rNLPxQ1P
	 GkqL3qVSbuxuVt9WmUtYt4eLECgRNhSgxMT0XJ/QUI9wAN5TWpY3nPWU8jNdGjfQJ1
	 LEUk04YN6vDTgqNHfkNpZ21fN8T0YcAAhr04EjLYBM4jAXdRaS7W4XTBxCiIxrqv4P
	 57Y+JoPZ9jyr40AvmvoOKNnT4zak99uCOcC7BXyI5g+RhLFg7ZZKkroT5cbSGKYFZx
	 /ZFM9Ce6EOdxSFVina9oQWVocBhDIDX72LveN6lPTQLAoVJoBBHIB2h6yRFVQvtex7
	 lT6g4Vkayq9QA==
Date: Tue, 25 Feb 2025 10:12:18 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Will Deacon <will@kernel.org>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 04/10] dt-bindings: stm32: add STM32MP21 and STM32MP23
 compatibles for syscon
Message-ID: <174049993788.2634473.18262936778020471573.robh@kernel.org>
References: <20250225-b4-stm32mp2_new_dts-v2-0-1a628c1580c7@foss.st.com>
 <20250225-b4-stm32mp2_new_dts-v2-4-1a628c1580c7@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225-b4-stm32mp2_new_dts-v2-4-1a628c1580c7@foss.st.com>


On Tue, 25 Feb 2025 09:54:07 +0100, Amelie Delaunay wrote:
> Add the new syscon compatibles for STM32MP21 syscfg = "st,stm32mp21-syscfg"
> and for STM32MP23 syscfg = "st,stm32mp23-syscfg".
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
>  Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


