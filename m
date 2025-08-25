Return-Path: <netdev+bounces-216697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F9AB34F8E
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 01:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 621267B0957
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 23:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550EE2C0F95;
	Mon, 25 Aug 2025 23:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCWYb5a+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CFD2C033C;
	Mon, 25 Aug 2025 23:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756163402; cv=none; b=uKHG46IJZNq+gR4KaxOiUNDbrDlUWfCTMafGNIPrPUUITQzj9nUbhGm2us9nTIG8vr97cUR8m1SNemT5/vOwBtdgetzYnhUvbWP1a/CA7d427PnhcSOVmG8uVDOX74ULGd1ZSwSikRs4zq5AKaPNFhMxlvZloIqSWZHNTVU5smQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756163402; c=relaxed/simple;
	bh=tzXq4twNoex0WercRwFPA3AFqoDMKErjDAjo9XOfCh8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ko5cyu+xgtjFxrVVNQuvBX81iRiWnrUmyLs506IvUY1DvAlR1nLU7Gsfxk4CogAxx+rIPFXfLfWonIh6a4Wf/1qQJJ+m8g2/oRx52uhHJMhdXAs/Wl6ihVqXtJQWFtTy1bHTIOLtNv2NdWHdxG42wToxqm3XuC1TJ77VX7jljcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCWYb5a+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFE2C4CEED;
	Mon, 25 Aug 2025 23:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756163401;
	bh=tzXq4twNoex0WercRwFPA3AFqoDMKErjDAjo9XOfCh8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vCWYb5a+m6HPjw3SQWqnkit4NoKO+144n2Pg2Ivdjq6oaT7evYlrvyqbvFH7oANw+
	 mNtITivMaHMpsytWrbuj9kfHof3hmztgH/z/Et0yucNn8AupPA9R4pbzjF1caj3+zu
	 xRS05/gKXcvJOTocIvOOjeMet+TaVojV9ZVnT+LFj+bZgCPec1dXG2rnwuuFuitw/h
	 GoG9a3fFunrAK83gUk0qv0suVamCXpOH3acdP5LLYbkH7NH0N4cv+t45UlowNJ1UZQ
	 6itPRII68w7/GlwBSREbahq8DRtSO+f0er2QltU2SytFmGfMuNbNcHSeycQgKHYdsh
	 3447uLnrSYtpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFD0383BF70;
	Mon, 25 Aug 2025 23:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] dt-bindings: net: litex,liteeth: Correct example
 indentation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175616340924.3590689.9893533056849831270.git-patchwork-notify@kernel.org>
Date: Mon, 25 Aug 2025 23:10:09 +0000
References: <20250821083038.46274-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250821083038.46274-3-krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
 gsomlo@gmail.com, joel@jms.id.au, Steen.Hegelund@microchip.com,
 daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
 lars.povlsen@microchip.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 Aug 2025 10:30:39 +0200 you wrote:
> DTS example in the bindings should be indented with 2- or 4-spaces, so
> correct a mixture of different styles to keep consistent 4-spaces.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/net/litex,liteeth.yaml         | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [1/2] dt-bindings: net: litex,liteeth: Correct example indentation
    https://git.kernel.org/netdev/net-next/c/bc2741b032f8
  - [2/2] dt-bindings: net: Drop vim style annotation
    https://git.kernel.org/netdev/net-next/c/7f052126ff38

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



