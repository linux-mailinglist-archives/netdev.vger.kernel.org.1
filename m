Return-Path: <netdev+bounces-24699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD16F7713DE
	for <lists+netdev@lfdr.de>; Sun,  6 Aug 2023 09:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C954C1C20962
	for <lists+netdev@lfdr.de>; Sun,  6 Aug 2023 07:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C9B1FAF;
	Sun,  6 Aug 2023 07:40:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ABB23B3
	for <netdev@vger.kernel.org>; Sun,  6 Aug 2023 07:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F659C433C9;
	Sun,  6 Aug 2023 07:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691307622;
	bh=i9plfC/05H8gvp/5XulnZa1CX+BdMG6qJk3MrAMZFKM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DHiqX59aB/hk5DUBsZY04DfV05V72naDyLv19j3Z+w4Vs7PkNloPgJD0IEp3wdTtP
	 TgHHkIxTi9MtSVvf4bHDQCR8l5hL5YJCY1rNayWHHfH2mUZHA7V1EeSKkca7eOtPKL
	 I4wSsLdLcum7vOipcl2tistdi0qjVwrVDmSiE4U5Hl+bRdVs8vEBwsUjkeS6kX0XVq
	 Y8UFrF72QVzOdEzl/UqiXsseeTSSmfn3z3C57pOLN2lW1LTiGWZc+qioiUBrWq4AyU
	 TpQzOcdPcEVD9mBtScyxI+AmxBMgYrwNWP6Fq79CmYowBO0paplxgE8tdoH7EwLATy
	 Yv3KctHJgGKjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2CBD2C595C3;
	Sun,  6 Aug 2023 07:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] Add QPL mode for DQO descriptor format
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169130762217.9536.6358439352294485363.git-patchwork-notify@kernel.org>
Date: Sun, 06 Aug 2023 07:40:22 +0000
References: <20230804213444.2792473-1-rushilg@google.com>
In-Reply-To: <20230804213444.2792473-1-rushilg@google.com>
To: Rushil Gupta <rushilg@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 willemb@google.com, edumazet@google.com, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  4 Aug 2023 21:34:40 +0000 you wrote:
> GVE supports QPL ("queue-page-list") mode where
> all data is communicated through a set of pre-registered
> pages. Adding this mode to DQO.
> 
> Rushil Gupta (4):
>   gve: Control path for DQO-QPL
>   gve: Tx path for DQO-QPL
>   gve: RX path for DQO-QPL
>   gve: update gve.rst
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] gve: Control path for DQO-QPL
    https://git.kernel.org/netdev/net-next/c/66ce8e6b49df
  - [net-next,v2,2/4] gve: Tx path for DQO-QPL
    https://git.kernel.org/netdev/net-next/c/a6fb8d5a8b69
  - [net-next,v2,3/4] gve: RX path for DQO-QPL
    https://git.kernel.org/netdev/net-next/c/e7075ab4fb6b
  - [net-next,v2,4/4] gve: update gve.rst
    https://git.kernel.org/netdev/net-next/c/5a3f8d123107

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



