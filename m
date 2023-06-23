Return-Path: <netdev+bounces-13374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C7A73B5F6
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 13:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 491B31C21021
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 11:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39660230F4;
	Fri, 23 Jun 2023 11:20:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECAA3D6A
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 11:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F0ABC433C9;
	Fri, 23 Jun 2023 11:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687519220;
	bh=HE9jkOtOoyDv0Q75oB+XoqEDHM4V4Xs9EiPT4vC6Om8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RZCSBXHo8Y7px28LcuhKSF2i2zvdLL25rGbmWQw8k4HTrkRgXmtC4mcKyHv6LY1Mi
	 JynCQ3M6h0qgbHSQJl6LWlq9Q0qUT3GZawHLeVzHrJZMFMJxVn93Nci7xLlCW1LHp0
	 VP/zwkclE+Bk0gKZYXKOSSInCAbUg3o2UPGk00m63+8Ah2QVpcVcdzSXODpWBHvgLw
	 vZmp16UN3NLFebnuvDqy7TaRZyJev0mV2jkHp7IyG6fs8Bsz98Mky4fEY9nfLQRQYl
	 61RxxhVDXb1nCgspRFAHJTocJp/I2cReOcO21/FraJfkNH2+ApEyBhkc1Cz2r23TwE
	 FU3n07sFA7/Tg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13A6BC43169;
	Fri, 23 Jun 2023 11:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dt-bindings: net: altr,tse: Fix error in
 "compatible" conditional schema
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168751922007.31575.12644715744862183773.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jun 2023 11:20:20 +0000
References: <20230621231012.3816139-1-robh@kernel.org>
In-Reply-To: <20230621231012.3816139-1-robh@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 21 Jun 2023 17:10:12 -0600 you wrote:
> The conditional if/then schema has an error as the "enum" values have
> "const" in them. Drop the "const".
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/net/altr,tse.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] dt-bindings: net: altr,tse: Fix error in "compatible" conditional schema
    https://git.kernel.org/netdev/net-next/c/faaa5fd30344

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



