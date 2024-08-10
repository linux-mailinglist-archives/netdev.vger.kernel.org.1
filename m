Return-Path: <netdev+bounces-117398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031FF94DC1B
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 11:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36FBE1C2116E
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 09:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DD61514EE;
	Sat, 10 Aug 2024 09:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6UyPYKV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ACE14A4F3;
	Sat, 10 Aug 2024 09:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723283494; cv=none; b=ltvnv8w/gb30c5n5L0MctcNFdKiZfdzOtTdg0ipDSnLouEtTdHWZcD2hSXQ33xckAwa3z82fAYYc4nEyrHlz1P3XKudL2Tw18ACl6iMB0fJRgjmMq9ZCw4RIbWBDYxmCM/zUslJM4ShAFlr6q/cRRYJ6uN5Q4qko77n+JXCbk88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723283494; c=relaxed/simple;
	bh=cTqL5xUWw00ey23oEIyGFCO8ELq1yoTqJ70ikIFg6Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0TIuDXjKzUvHfz9YPa2G9YmNPMV8I519wt920vCrJwRX9DOoMRgHlPYagKR9Ife83DHi4pLuhZVKg5e53Ye2aps6oiDUquvjYez4LUkD9GFtX3x+wZ/rV+y/YnMczTLRolLUSEmTegKvwY7WXLBMY4VHltyBc32UMhtPrhkVoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6UyPYKV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC652C32781;
	Sat, 10 Aug 2024 09:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723283494;
	bh=cTqL5xUWw00ey23oEIyGFCO8ELq1yoTqJ70ikIFg6Q8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n6UyPYKV1YKJai8yOSp7iJnOBvvjmhHbwzQgbbU8upVe1vgsV6nFii27yHIHYy9LB
	 W95vaHHMFmoJbtkBV0ehXYHe/dSuPCccv7SY9bs+sF12KV8vpeTFn24Eob/0gDZlfN
	 yO9f9yx+gyAnR+zQZI/M7vZqioCUBp0jYabFkl51RMIJSouYvTZs5N6TFirfrvb3JH
	 bsJGyekpDbU4s9diRaKrxXzqw+11+SEBzOCUJfyGLjyQXdW4Syq7mryDqKlQYO+OH9
	 pBgce2jyvVXQrOhXIVD1+cangixuX5aeps/SIMqBAfaymYMYw2MsUKkQ+NxakkPRhp
	 E1vCsGs5343Vw==
Date: Sat, 10 Aug 2024 10:51:29 +0100
From: Simon Horman <horms@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2] arm: dts: st: stm32mp151a-prtt1l: Fix QSPI
 configuration
Message-ID: <20240810095129.GH1951@kernel.org>
References: <20240809082146.3496481-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809082146.3496481-1-o.rempel@pengutronix.de>

On Fri, Aug 09, 2024 at 10:21:46AM +0200, Oleksij Rempel wrote:
> Rename 'pins1' to 'pins' in the qspi_bk1_pins_a node to correct the
> subnode name. The incorrect name caused the configuration to be
> applied to the wrong subnode, resulting in QSPI not working properly.
> 
> To avoid this kind of regression, all references to pin configuration
> nodes are now referenced directly using the format &{label/subnode}.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Pass

