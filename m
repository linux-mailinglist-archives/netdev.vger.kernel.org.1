Return-Path: <netdev+bounces-30476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEA478785D
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 21:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EDC51C20EA8
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 19:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFCD15ACF;
	Thu, 24 Aug 2023 19:10:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CBB1549C
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 19:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40B27C433CA;
	Thu, 24 Aug 2023 19:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692904226;
	bh=zHXeyyb7jd7cv3Gte+HqV5Lpz939RXDcmC00eFUsas0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EAYUWtT0acJTqNT6ps46iX7Z6gdtH/CyduTM/dTchEB4V71G1SDZ1bPOC91vxfBYF
	 P7ISJa/9gNJB8gsQSJLPruPXBq2PtTgtliVyk0Rt9D/uUPkeMHGNMJbY62kO7MlPK2
	 p5Vam5N9yj+GIxrRCDmdWJUilVIyiUD6zOsXcaq/H4vWGPKO+h1theWeQkFqgh7VUz
	 zDsxAWf4whiyyiGM/G57QU3kEWUt/4Wu2raaErlF/0/CoxtOGyfBAU7EyWBEdIQXsY
	 lyMjFPJEK4KwYE4OPE0OukHC/jG2hjFoYtj91lJu+wcvpDD+6dbMvyAvBE+tCfS0QP
	 245ijWOswTxZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25A21E33096;
	Thu, 24 Aug 2023 19:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: use capital "OR" for multiple licenses in
 SPDX
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169290422615.11645.341779346028816587.git-patchwork-notify@kernel.org>
Date: Thu, 24 Aug 2023 19:10:26 +0000
References: <20230823085632.116725-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230823085632.116725-1-krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kurt@linutronix.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Aug 2023 10:56:32 +0200 you wrote:
> Documentation/process/license-rules.rst and checkpatch expect the SPDX
> identifier syntax for multiple licenses to use capital "OR".  Correct it
> to keep consistent format and avoid copy-paste issues.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/net/dsa/b53/b53_serdes.c                   | 2 +-
>  drivers/net/dsa/b53/b53_serdes.h                   | 2 +-
>  drivers/net/dsa/hirschmann/hellcreek.c             | 2 +-
>  drivers/net/dsa/hirschmann/hellcreek.h             | 2 +-
>  include/linux/platform_data/hirschmann-hellcreek.h | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [net-next] net: dsa: use capital "OR" for multiple licenses in SPDX
    https://git.kernel.org/netdev/net-next/c/59da9885767a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



