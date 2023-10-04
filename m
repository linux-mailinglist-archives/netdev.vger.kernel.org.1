Return-Path: <netdev+bounces-38025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 782AF7B8719
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 20:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 7CC14B2084C
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 18:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825ED1D549;
	Wed,  4 Oct 2023 18:00:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F761C2AB;
	Wed,  4 Oct 2023 18:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCD15C433C7;
	Wed,  4 Oct 2023 18:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696442428;
	bh=yY3S66xRmuC0GgpwkV5hIXIhJWyD1ynLJX7G6on5lF8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MzB3YECAPjuavQIKSKGrwjLSYt2VkqdYSeocnJZGd0KN26Yc6VzLJ7Nr/onYw66pA
	 c+byxTTYWJmzWwrRH/VsPGDqwk1bbk7qgvZl4H+46Ju6N72h1VLin93+7x7kbOxg3R
	 VlclfhVv5wshpeZuZGvvILRwws3r6aPN6ZXP+kSH6kJDalwdoiBE76gIGCp+sBXHSH
	 613HEOemtE4J91O/iNNw5GvUbpjcL4cEnsq5F/UKpwQ0qPRP2ag9SgaW9xWnxkI08v
	 MrESba9nlueJIiJb/q0/wvprxHIrXtrdZvNSR3zlIg6Sx68Jgr/DYtZdcorHIPtwiS
	 fj5Ii+/OVI9Hg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91C1BC595D2;
	Wed,  4 Oct 2023 18:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] dt-bindings: net: fec: Add imx8dxl description
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169644242859.14307.7824312183665858153.git-patchwork-notify@kernel.org>
Date: Wed, 04 Oct 2023 18:00:28 +0000
References: <20230926111017.320409-1-festevam@gmail.com>
In-Reply-To: <20230926111017.320409-1-festevam@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: kuba@kernel.org, wei.fang@nxp.com, shenwei.wang@nxp.com,
 xiaoning.wang@nxp.com, linux-imx@nxp.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, shawnguo@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org, festevam@denx.de,
 conor.dooley@microchip.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 Sep 2023 08:10:17 -0300 you wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> The imx8dl FEC has the same programming model as the one on the imx8qxp.
> 
> Add the imx8dl compatible string.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> [...]

Here is the summary with links:
  - [v2,net-next] dt-bindings: net: fec: Add imx8dxl description
    https://git.kernel.org/netdev/net-next/c/ca6f5c2f94aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



