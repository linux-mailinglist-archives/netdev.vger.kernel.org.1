Return-Path: <netdev+bounces-99217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B36228D4247
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 02:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F6AEB22480
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 00:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445052579;
	Thu, 30 May 2024 00:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2Q8HJdE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1277A1FDD;
	Thu, 30 May 2024 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717028432; cv=none; b=iOvHcbgWgC76zF2HcA0RTJ78sht5LVfkpTr9Hq9BW5fjdfNVUmA9CGwO/ybhXFGPOFny2EfdetSI9tbt9CMH3XwolPsbb3ryC1U3ZruEES+nemQoLSiHRAvNq6QtVHoFBJzT8EqJGEB3efk+XFx5vnGVmc1OguCGEF+lCV9e1nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717028432; c=relaxed/simple;
	bh=n7hlT0uhmy6M3F0Ua2czUZF1UCn0/L9iLZtHkVv9GLE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EUZqqf1QrUju1XUDB6U27GF2gSDOjkiWQWxge/7ewKAMzXI57huEG7us5DB82eyN2nT6aGWEJBxnFShLZF8RqFjZt5X7P95DP3jPsoTIdbFVgdtLc1VUXkAOqw6exG2OEYBIWFUcnhMJx8dBi3mfAhmewKH+9NxBiFduTKn9zvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2Q8HJdE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88850C32786;
	Thu, 30 May 2024 00:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717028431;
	bh=n7hlT0uhmy6M3F0Ua2czUZF1UCn0/L9iLZtHkVv9GLE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A2Q8HJdEZzwUCKf1uEU/iKgSUu8KmfyajlUv0gsTWzXMD3fPlLS7f3glu3Y1m2NZI
	 NOeLoeqXb+YeN5W7Qkj85+3ukRcqlt5JrhYAgOHMMZwskk3yjD9mZ0EZJSQddevdjn
	 kAwttHzZv/CCWZVa4OQQ2Afvp4sce3eyxLJ/X3cNzlcKhn96rwOXcdD81cY733mst+
	 mLt/x8zcvBSXsvg9J+xs3Xu1NF+hhf4fJZXDrTLDYZ6/PpBI0gORUr7WecVDpOA6nz
	 DYD57Wg1qJXyidMNjKG95kYuwVHO9Q3SO56pAL17rZi3y4vTFCCipa524Bm8a0VEa7
	 ATJ0Vevm06lIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7534FCF21E0;
	Thu, 30 May 2024 00:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] dt-bindings: net: rockchip-dwmac: Fix rockchip,rk3308-gmac
 compatible
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171702843147.13917.16610885650179845184.git-patchwork-notify@kernel.org>
Date: Thu, 30 May 2024 00:20:31 +0000
References: <20240528093751.3690231-1-jonas@kwiboo.se>
In-Reply-To: <20240528093751.3690231-1-jonas@kwiboo.se>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 alexandre.torgue@foss.st.com, peppe.cavallaro@st.com, joabreu@synopsys.com,
 t.schramm@manjaro.org, linux-rockchip@lists.infradead.org, heiko@sntech.de,
 krzysztof.kozlowski@linaro.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 May 2024 09:37:48 +0000 you wrote:
> Schema validation using rockchip,rk3308-gmac compatible fails with:
> 
>   ethernet@ff4e0000: compatible: ['rockchip,rk3308-gmac'] does not contain items matching the given schema
>         from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>   ethernet@ff4e0000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode',
>                      'reg', 'reset-names', 'resets', 'snps,reset-active-low', 'snps,reset-delays-us',
>                      'snps,reset-gpio' were unexpected)
>         from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
> 
> [...]

Here is the summary with links:
  - [v2] dt-bindings: net: rockchip-dwmac: Fix rockchip,rk3308-gmac compatible
    https://git.kernel.org/netdev/net-next/c/544a74c32bcc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



