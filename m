Return-Path: <netdev+bounces-47888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB3F7EBC66
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 04:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C9FF28126F
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 03:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BB680C;
	Wed, 15 Nov 2023 03:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VD5rkWDj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6B5801
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 03:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68E86C433CA;
	Wed, 15 Nov 2023 03:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700020223;
	bh=7f1IBddzYAwzEVP6KQYyZ8VTGi67vxdjPTEJySW1TIM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VD5rkWDjk91pY8UvSwHxsI19OVzsqsaa6OgEjOVzgw8xNi67sMsmpTQHje+oaP8SX
	 o2KCRY1XDpjac7Do1rezgwu0782Z6ahjsY29QLW7ZRzFXq+DUEwuwx9WSUEanlQj4O
	 imJ3kHV8cjcR+VVAiuYsFj4J4Zk3cfDt9cBwxdUMdoSXnEHTrwZ70z0iqW1UwS0Vpr
	 W/nDyLfnJI1eMcsFQaA3vDqmQC9bCNRxKiyx9gq9uFn25BmC1IDeS1SeIX1jIURgU8
	 3fUC9c+AKx7yy8dne2xhyo0nwA6xVQePGEzYEothP/yAGr02CXd3SoQ3CjymoGP9IX
	 6+vQCv9aqxnTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4D172E1F671;
	Wed, 15 Nov 2023 03:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: tag_rtl4_a: Use existing ETH_P_REALTEK
 constant
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170002022331.9438.484108479461103553.git-patchwork-notify@kernel.org>
Date: Wed, 15 Nov 2023 03:50:23 +0000
References: <20231113165030.2440083-1-florian.fainelli@broadcom.com>
In-Reply-To: <20231113165030.2440083-1-florian.fainelli@broadcom.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Nov 2023 08:50:30 -0800 you wrote:
> No functional change, uses the existing ETH_P_REALTEK constant already
> defined in if_ether.h.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  net/dsa/tag_rtl4_a.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [net-next] net: dsa: tag_rtl4_a: Use existing ETH_P_REALTEK constant
    https://git.kernel.org/netdev/net-next/c/8fedaaca4071

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



