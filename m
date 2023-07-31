Return-Path: <netdev+bounces-22963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CA776A357
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 23:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B8D281513
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 21:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B3D1E51F;
	Mon, 31 Jul 2023 21:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC561E508
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 21:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92C3DC433D9;
	Mon, 31 Jul 2023 21:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690840222;
	bh=x9PcK620o3Zzuv3B5CDGPiuKOCsyD5bfN04/wXzLiig=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dj6CV6SOapIGYfK032JrpqCoMjTjRNNyzX1Necig0+hmee7Cw7lBTDYn2jDZBaTT9
	 qXQBEkvW/+JV08cREQz+M35XKJ7MRbZUeiFQ0iYp6pb8lWZy5vd2I2dMUJ4+vtY3+b
	 w0pKkzeBevBDqzq4Uvp//l/4fesoqTyU5WXzzK8PEAQcs3qKnKLd60Tcvmf8ekFEDU
	 +MLq4OhCpLOiC7cAHIJNZeQLsQZyauSNF65yj7uMGJnF+txBp9CxkHI/+AP+L3SmM9
	 LUlFfgvpefEmpEf+0aLMw/Sg0qP4cbwQ1Rmq1jkgnziLgJv7CvQl2ImVHI1n1b22/n
	 PdktmxmUiJ1gw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78CC3C691D8;
	Mon, 31 Jul 2023 21:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: bcmgenet: Remove TX ring full logging
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169084022248.13504.15633874443409502466.git-patchwork-notify@kernel.org>
Date: Mon, 31 Jul 2023 21:50:22 +0000
References: <20230728183945.760531-1-florian.fainelli@broadcom.com>
In-Reply-To: <20230728183945.760531-1-florian.fainelli@broadcom.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Jul 2023 11:39:45 -0700 you wrote:
> There is no need to spam the kernel log with such an indication, remove
> this message.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/genet/bcmgenet.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Here is the summary with links:
  - [net-next] net: bcmgenet: Remove TX ring full logging
    https://git.kernel.org/netdev/net-next/c/df41fa677d9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



