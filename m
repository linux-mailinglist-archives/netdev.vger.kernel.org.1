Return-Path: <netdev+bounces-33063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684EF79C9F5
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 10:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989FE1C20CE7
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 08:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29C4946F;
	Tue, 12 Sep 2023 08:30:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A4F1798B
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 08:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 960EAC433CA;
	Tue, 12 Sep 2023 08:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694507430;
	bh=s2uBgeRSuYe5cJdnSbgRNcVkNm/cSXAA6GCrs5EOgts=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=riyxw6UVa0dZ+CFqIsmyv4qYDkyaXlzlHw7U0rUzAkUW38l92CCw256LbzZrYEGaM
	 AoomPN9Waic+Td+3NEiPIYwXGz54dT5Bvp6G13/FzqgBxHGOrxttCKBSVqTNy0ehU9
	 peaP2roDGO4keZnbKvH2bKL9+BPRczCvrs0rsvoUZzhfkte4oecMII4hTqWv6ajUSs
	 QYdAns7dxQwRYpRz8acRvu+X5De5H7IQdvAgkCbPDDiTBUU6pIexnUuJ1YzZMAZJIz
	 3QHWM8tAxoXGgaHUwMj9LYer30HXUkCMpdI5BGvk8PRDHJ+xPGLCj5ozdYY2VYm4Qv
	 iuN9hTUNvPNwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 768A2E1C282;
	Tue, 12 Sep 2023 08:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] Add support for ICSSG on AM64x EVM
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169450743048.32515.14715213630725008702.git-patchwork-notify@kernel.org>
Date: Tue, 12 Sep 2023 08:30:30 +0000
References: <20230911054308.2163076-1-danishanwar@ti.com>
In-Reply-To: <20230911054308.2163076-1-danishanwar@ti.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: andrew@lunn.ch, rogerq@ti.com, conor+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net, vigneshr@ti.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, srk@ti.com, r-gunasekaran@ti.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 11 Sep 2023 11:13:06 +0530 you wrote:
> This series adds support for ICSSG driver on AM64x EVM.
> 
> First patch of the series adds compatible for AM64x EVM in icssg-prueth
> dt binding. Second patch adds support for AM64x compatible in the ICSSG
> driver.
> 
> This series addresses comments on [v1] (which was posted as RFC).
> This series is based on the latest net-next/main. This series has no
> dependency.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] dt-bindings: net: Add compatible for AM64x in ICSSG
    https://git.kernel.org/netdev/net-next/c/0caab0a46d06
  - [net-next,v2,2/2] net: ti: icssg-prueth: Add AM64x icssg support
    https://git.kernel.org/netdev/net-next/c/b256e13378a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



