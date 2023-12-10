Return-Path: <netdev+bounces-55642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D17F580BC93
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 19:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69CD4B20816
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 18:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065721A597;
	Sun, 10 Dec 2023 18:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2TNZaNa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F97182BD
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 18:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F2BFC433C8;
	Sun, 10 Dec 2023 18:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702234223;
	bh=r81y3LPrVfor8l0bPVhIMjaxMbB/s8W5wUO/t5r4/Vk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q2TNZaNaGdFUxUq2B8VXArbmn1RvVgiE3BgfhK+yshz16MH+0kWcMAygV4RXmI8Ga
	 hiu6g8H125eGuWd2M9OqECAyzzy9Hgd9L+zykXW6TZkX+pyZl9WrJ4p8xwo9m3TlNU
	 Z5/lWH2/UgQLebAt5oMSkEGnm6kjbesA3i5vtySD3N6EdKcWqCl9n6XxIWiOvcRdB6
	 YAPSLGDiVCIwakwU9jphWeDZW1dx9F0c38i27+4vJO/Ntga/V2rC36LUWSetrh6jK4
	 /z53nteUZx9U5wmLMGR7jkSZLh2mMjBpnygpNH8o0vkCDnENJ39Z3MQ5Wds0MJ6eA4
	 IBErnv66tl1dQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25423DD4F1D;
	Sun, 10 Dec 2023 18:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: fec: correct queue selection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170223422314.23610.8672879447453941206.git-patchwork-notify@kernel.org>
Date: Sun, 10 Dec 2023 18:50:23 +0000
References: <20231207083801.233704-1-wei.fang@nxp.com>
In-Reply-To: <20231207083801.233704-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
 netdev@vger.kernel.org, radu-andrei.bulie@nxp.com,
 linux-kernel@vger.kernel.org, linux-imx@nxp.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  7 Dec 2023 16:38:01 +0800 you wrote:
> From: Radu Bulie <radu-andrei.bulie@nxp.com>
> 
> The old implementation extracted VLAN TCI info from the payload
> before the VLAN tag has been pushed in the payload.
> 
> Another problem was that the VLAN TCI was extracted even if the
> packet did not have VLAN protocol header.
> 
> [...]

Here is the summary with links:
  - [net] net: fec: correct queue selection
    https://git.kernel.org/netdev/net/c/9fc95fe95c3e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



