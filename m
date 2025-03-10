Return-Path: <netdev+bounces-173459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EDFA5907C
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 10:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 971E616C253
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 09:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65999225412;
	Mon, 10 Mar 2025 09:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owiKa/n9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D1E2253EC;
	Mon, 10 Mar 2025 09:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600638; cv=none; b=a8A/3cDL6CHD9dAgJVB1dqZ57zb+MuEwOUsAW+ZWpyksW3fhca+l6ejGoP7tX7NL1MrLBUzMFAxWkda+aE0oSDOYMZrNH5XdWIIxnrJhrJW2JeAohiDVPH2RWBxpXHR6E7D41d9Ma5yJrEuEvgukiOqjnwmXIOQoHcR0FJ76xhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600638; c=relaxed/simple;
	bh=XM35sEGq9rPsxDvrLDp2hhBJWfUNe2voFFy34EJh/FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EF/LB/SZxbCA4eFiW7OpMNr3QixooCfUu3JY4MegNNpfU0wNmf8QtyRmqLwhtJiO+LbgA20ZC1BiyDfvyCnTq8GlcFDxeAD4nzZT8RtWaqbBbGm48YFOxcFwZrV6RTVsudtSMEC3ngzknwTQcPAz8N8UDM69LvFPToY/mVQn+J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owiKa/n9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129E6C4CEE5;
	Mon, 10 Mar 2025 09:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741600637;
	bh=XM35sEGq9rPsxDvrLDp2hhBJWfUNe2voFFy34EJh/FY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=owiKa/n9XL5IGC0X+K77PmWU9Iy3QL46VKZQNfTyuKKjVkYTh4V67hkN0CGG/ufq3
	 l+hj4A9QQ1oiivy3+ugmqsoZOsDZJXtSS98fzgW/7z5pbPrSzaBesxfLa6K7AtQLrr
	 Zi6BqymX4ILWFQt5MQKhT/NDAfWCwlqspOxOAtRNle8SyLRZcyHI0ptjQcJJkJanji
	 opsHtDAc4APfc5zMnshG46lasStgvLFz61O/jJkBR9UkOHCndcPajaJ4HWMNcNWepH
	 r44S8UqmpxOVY6cEKaw2FnsiDfE6kzoJJmHvoMdougllrjrpmxKDSMKN0NDPHH36Oj
	 d+Z33dXyG+9Rg==
Date: Mon, 10 Mar 2025 10:57:13 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Wu <david.wu@rock-chips.com>, netdev@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: net: rockchip-dwmac: Require
 rockchip,grf and rockchip,php-grf
Message-ID: <20250310-striped-perfect-sambar-bdcb3e@krzk-bin>
References: <20250308213720.2517944-1-jonas@kwiboo.se>
 <20250308213720.2517944-2-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250308213720.2517944-2-jonas@kwiboo.se>

On Sat, Mar 08, 2025 at 09:37:13PM +0000, Jonas Karlman wrote:
> All Rockchip GMAC variants typically write to GRF regs to control e.g.
> interface mode, speed and MAC rx/tx delay. Newer SoCs such as RK3562,
> RK3576 and RK3588 use a mix of GRF and peripheral GRF regs.
> 
> Prior to the commit b331b8ef86f0 ("dt-bindings: net: convert
> rockchip-dwmac to json-schema") the property rockchip,grf was listed
> under "Required properties". During the conversion this was lost and
> rockchip,grf has since then incorrectly been treated as optional and
> not as required.
> 
> Similarly, when rockchip,php-grf was added to the schema in the
> commit a2b77831427c ("dt-bindings: net: rockchip-dwmac: add rk3588 gmac
> compatible") it also incorrectly has been treated as optional for all
> GMAC variants, when it should have been required for RK3588, and later
> also for RK3576.
> 
> Update this binding to require rockchip,grf and rockchip,php-grf to
> properly reflect that GRF (and peripheral GRF for RK3576/RK3588) is
> required to control part of GMAC.
> 
> This should not introduce any breakage as all Rockchip GMAC nodes have
> been added together with a rockchip,grf phandle (and rockchip,php-grf
> where required) in their initial commit.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


