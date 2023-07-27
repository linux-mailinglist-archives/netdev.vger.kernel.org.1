Return-Path: <netdev+bounces-21699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A01764513
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 06:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36ADE281FD5
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 04:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8AB1FBE;
	Thu, 27 Jul 2023 04:50:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCBE1C3F
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 04:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA0A5C433CA;
	Thu, 27 Jul 2023 04:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690433419;
	bh=A8g5S1Nua2BRqzftlNe+ucpQ4lBpqepcn/KYo+LnZ+0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c7uJPXxRw4qdxh5oeAYbrpiIylsrNrj+zwuYExkPVVDAughy7CBvC6Y7Jw2bAxlL3
	 bmWCrhqPA26jiGlVe1fAuHZ6UHB4l7EhsX/siqn18XFMG9E43OLhCuFiYK+a9u/IVb
	 jpEnC9Ep/caMkWOCyCsJMbSKxh9dxe2WuoFHO9qY9R0fBnbvPQ3kSCIC08Yla6JbcO
	 aB0C6EKAxnZw5EEIeVA+/Ms/cQjlP+xruhbAFRNTPNeoYPS+Sv4dXelLIgl8M22knp
	 +BmEleDQDxTBi7XvzuV3Oq8MPQxVSig9EOPB8Hvm7hbICI4P8/WM6xkfMvsI0Uwrb8
	 itC6T/mtXuJgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0118C59A4C;
	Thu, 27 Jul 2023 04:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dt-bindings: net: qca,ar803x: add missing
 unevaluatedProperties for each regulator
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169043341971.19452.6017745582935502470.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jul 2023 04:50:19 +0000
References: <20230725123711.149230-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230725123711.149230-1-krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 f.fainelli@gmail.com, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Jul 2023 14:37:11 +0200 you wrote:
> Each regulator node, which references common regulator.yaml schema,
> should disallow additional or unevaluated properties.  Otherwise
> mistakes in properties will go unnoticed.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/net/qca,ar803x.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [net-next] dt-bindings: net: qca,ar803x: add missing unevaluatedProperties for each regulator
    https://git.kernel.org/netdev/net-next/c/c1b0b6118b48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



