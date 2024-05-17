Return-Path: <netdev+bounces-97034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCF78C8D54
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 22:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051071F23BC5
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 20:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D56433A6;
	Fri, 17 May 2024 20:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="US2jN4iC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB5F14F61;
	Fri, 17 May 2024 20:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715978310; cv=none; b=c342xzxG/sFxIn7fB564todz+YdfceShQYh1xnxvFhHURmgq2IN15TDmjbFQtquX4dBXYIr6kwh1N6k9LAqZ81FBPOIfKgCijXjuldtG4aDa+/dhHi2F8mrnWei2sxub6L50t7Ydy4vGYoi47UX0C03To+S0XeCgQzoOjc1zlI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715978310; c=relaxed/simple;
	bh=jXVxvuA4QzVhcG150evLa4DPe5FRaUxxzqJ1vrqUjXM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UGoxC/4/01srW18hUUsKgmqUrcsB3nn2/UaYvUqUzw77Eodu/L+3gl77D5Q5n9VZu3MyZA1jTrSD0aJfomw3329MGfGRmdIzsird7B8V7H9/QuO6hjwHjfr4miUnPWo3cHXFPj2oplJ03bmSufcgcrSkXA/jTiq4xQaSOF1TnlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=US2jN4iC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B01F8C4AF07;
	Fri, 17 May 2024 20:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715978309;
	bh=jXVxvuA4QzVhcG150evLa4DPe5FRaUxxzqJ1vrqUjXM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=US2jN4iC9DaCYchkJRVpWp0LeTeKNvi+WQYi5HnrY+68uhO8yIZ10aQ4H72wqtwcq
	 RbpDPGyfzoAz5MtUYnJGU365hbpO3iLEcZXA1cYIUTpIjioh49MUjv9HSyTjYQsWyK
	 DPR3LiTYJ0ZiJqcV9BhhZroD9/lfnt6EfHkIc3iYwC4Z1KPsvNRTYqfHqr+6Z3WcQn
	 osPyc4GXGY4fRcQDUa3/LtiJ0RAnvExZGOO0x0up98rGbxwjFJeRDhPlbKMvKT1906
	 RZmM34B2y2O7F1QdWTI2jZNju1Uyx1E8ujThG59U3MefJ2vtzoSTyTdWaHck3wtRAY
	 j3od/WUYgonFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2577C54BB2;
	Fri, 17 May 2024 20:38:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dt-bindings: net: ti: Update maintainers list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171597830966.5541.17091174323354972426.git-patchwork-notify@kernel.org>
Date: Fri, 17 May 2024 20:38:29 +0000
References: <20240516054932.27597-1-r-gunasekaran@ti.com>
In-Reply-To: <20240516054932.27597-1-r-gunasekaran@ti.com>
To: Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, s-vadapalli@ti.com, rogerq@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 May 2024 11:19:32 +0530 you wrote:
> Update the list with the current maintainers of TI's CPSW ethernet
> peripheral.
> 
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> ---
>  Documentation/devicetree/bindings/net/ti,cpsw-switch.yaml        | 1 -
>  Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml | 1 -
>  Documentation/devicetree/bindings/net/ti,k3-am654-cpts.yaml      | 1 -
>  3 files changed, 3 deletions(-)

Here is the summary with links:
  - [net-next] dt-bindings: net: ti: Update maintainers list
    https://git.kernel.org/netdev/net/c/ce08eeb59df0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



