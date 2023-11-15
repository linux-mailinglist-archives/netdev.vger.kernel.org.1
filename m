Return-Path: <netdev+bounces-47938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F21F7EC046
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 11:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D3931C208E4
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 10:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D400C8CB;
	Wed, 15 Nov 2023 10:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubhayJt0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D68C154;
	Wed, 15 Nov 2023 10:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84D08C433CA;
	Wed, 15 Nov 2023 10:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700043024;
	bh=5EKsaaeZ2NZlV9vedIL3RGNcKNbNRNd75vpTZq+IGMw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ubhayJt0yAMaZM9Nws+v1O3a0jF1lmrQEFjlAMiN/VwpleUvXt0uGTgWvY64ZMwVb
	 tlKC4WHY5fmIkuJIbiYga/2W3VisWNnAkGwcVFpjNBGLZ4cA3jhcJuYQ0oC39ZyMl1
	 EZSL8nNxdZ0KPeHKOfa+3kG7eUFHEsh03s3j36QFRYB5pQ3EGq4eZ+EoQTYS1gM1GX
	 KC/RfzX5uJ1oUt9m/TSye7CElIiitKNzZAzuQ0zfrZuSqlW1O1g3Dy5H09QoY2c/J0
	 EncxAiMBwm8hD8FH7jeMhcgRQVe60QgesNmBkA7xOvZs/tEMN9B9n/aJaJB5szDGjB
	 idlI6I+w/OigA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6529BE1F676;
	Wed, 15 Nov 2023 10:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] dt-bindings: net: ethernet-controller: Fix formatting error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170004302440.28811.17377618977130844267.git-patchwork-notify@kernel.org>
Date: Wed, 15 Nov 2023 10:10:24 +0000
References: <20231113164412.945365-1-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20231113164412.945365-1-niklas.soderlund+renesas@ragnatech.se>
To: =?utf-8?q?Niklas_S=C3=B6derlund_=3Cniklas=2Esoderlund+renesas=40ragnatech=2E?=@codeaurora.org,
	=?utf-8?q?se=3E?=@codeaurora.org
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 prasanna.vengateshan@microchip.com, devicetree@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 13 Nov 2023 17:44:12 +0100 you wrote:
> When moving the *-internal-delay-ps properties to only apply for RGMII
> interface modes there where a typo in the text formatting.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> ---
>  .../devicetree/bindings/net/ethernet-controller.yaml          | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - dt-bindings: net: ethernet-controller: Fix formatting error
    https://git.kernel.org/netdev/net/c/efc0c8363bc6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



