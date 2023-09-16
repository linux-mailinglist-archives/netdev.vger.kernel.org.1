Return-Path: <netdev+bounces-34261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1D17A2F51
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 12:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A2EC1C20933
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 10:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F339E134A4;
	Sat, 16 Sep 2023 10:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A80134A1;
	Sat, 16 Sep 2023 10:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48FD8C43391;
	Sat, 16 Sep 2023 10:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694861424;
	bh=QT2lWqyg+MtX/ZEh6qrZXyyEC1jXOKlLGV4I3Csj5p8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Cnw3hPoLHy5+H9pNocaiEkrHbnOrwWT8sE/94QhWxEI/lybZzLLnueZZGttuB6JpF
	 GCGfuLTGtp9B+jeLR56LJQivqDsKaoy2ESOFpOijMbpzsb0bYB/62p0gTGAwgEXCUa
	 scO0Pag6tRymrTZmIq+tywuyN6TCgJnwyA4Bw8pPk8tcfEkN7rgrHrcSKwXH7inf+A
	 sNV/c6JZJsnYZWWPrzYvpXII0Q0MSdilNRDYY9vHkppmBXYaPGb92HUL64qzLT19u6
	 yyydUT6rEkzwdALwNIC4D3Ae31w0SSoatTXmVFmZnHLUecvxBX2NGwP9nwDWiEj5ZC
	 3bXTKBmTRAf0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33AF2E26883;
	Sat, 16 Sep 2023 10:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 0/3] Move Loongson1 MAC arch-code to the driver dir
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169486142420.3496.7382362425660916712.git-patchwork-notify@kernel.org>
Date: Sat, 16 Sep 2023 10:50:24 +0000
References: <20230914114435.481900-1-keguang.zhang@gmail.com>
In-Reply-To: <20230914114435.481900-1-keguang.zhang@gmail.com>
To: Keguang Zhang <keguang.zhang@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, lee@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 tsbogend@alpha.franken.de, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 Sergey.Semin@baikalelectronics.ru

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 14 Sep 2023 19:44:32 +0800 you wrote:
> In order to convert Loongson1 MAC platform devices to the devicetree
> nodes, Loongson1 MAC arch-code should be moved to the driver dir.
> Add dt-binding document and update MAINTAINERS file accordingly.
> 
> In other words, this patchset is a preparation for converting
> Loongson1 platform devices to devicetree.
> 
> [...]

Here is the summary with links:
  - [v5,1/3] dt-bindings: mfd: syscon: Add compatibles for Loongson-1 syscon
    https://git.kernel.org/netdev/net-next/c/7e10088bc4e4
  - [v5,2/3] dt-bindings: net: Add Loongson-1 Ethernet Controller
    https://git.kernel.org/netdev/net-next/c/2af21077fa9f
  - [v5,3/3] net: stmmac: Add glue layer for Loongson-1 SoC
    https://git.kernel.org/netdev/net-next/c/d301c66b35b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



