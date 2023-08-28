Return-Path: <netdev+bounces-30979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7079D78A575
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 08:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3109D280DB7
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 06:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45309A2C;
	Mon, 28 Aug 2023 06:00:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4AEEA3
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 06:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34FF3C43391;
	Mon, 28 Aug 2023 06:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693202423;
	bh=M8CVt/akAcg3m+yLAHAXXHxbfvJpt0JVg7QP00pVJTM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HNSERr3rpLPz8SnhG4G5/mQksghoqgKRCteSDqF4pTSuRYBvrPjXNdAE2dfqJKSmi
	 lyPscdCBcOXxjrB8VztbF7q1CbYYDSo5LvaVT17Ds1DmieucSkD66SkIlm65N2O6bQ
	 4HBCpU07mj6RqgcdcHW3+6eo7+hjcNzzL2ODMBUBtK8ansKcO6oUnC7VkLKoVaYwgH
	 lf6zKsjEK+2Py3/KUsRTdwlaKREhd3b3cJg0F31OPiMvlYdjlhgUCq0usYS2/4dVoB
	 RGGmr+hs4oeWLxVVaDVft74yumhzQl04LhTdG1L/Yud9KPIIbkycNAWxotA/YqV0Ay
	 FZwcEirU0WvDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1EE35C3959E;
	Mon, 28 Aug 2023 06:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] dt-bindings: net: xilinx_gmii2rgmii: Convert to
 json schema
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169320242312.13305.11528710657423623934.git-patchwork-notify@kernel.org>
Date: Mon, 28 Aug 2023 06:00:23 +0000
References: <20230824114456.12243-1-harini.katakam@amd.com>
In-Reply-To: <20230824114456.12243-1-harini.katakam@amd.com>
To: Harini Katakam <harini.katakam@amd.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 harinikatakamlinux@gmail.com, michal.simek@amd.com,
 radhey.shyam.pandey@amd.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 24 Aug 2023 17:14:56 +0530 you wrote:
> From: Pranavi Somisetty <pranavi.somisetty@amd.com>
> 
> Convert the Xilinx GMII to RGMII Converter device tree binding
> documentation to json schema.
> This converter is usually used as gem <---> gmii2rgmii <---> external phy
> and, it's phy-handle should point to the phandle of the external phy.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] dt-bindings: net: xilinx_gmii2rgmii: Convert to json schema
    https://git.kernel.org/netdev/net-next/c/c639a708a0b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



