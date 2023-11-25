Return-Path: <netdev+bounces-51066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2687F8DF2
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 20:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C992811DE
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 19:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE302F858;
	Sat, 25 Nov 2023 19:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/NHj3rK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C712F84C
	for <netdev@vger.kernel.org>; Sat, 25 Nov 2023 19:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE80CC433C7;
	Sat, 25 Nov 2023 19:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700940624;
	bh=JlGtXIH2oJivmUcRKwJy0+zOVoxY6xY/tqJo4EdreNs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V/NHj3rKeO1vCewBmcZIKxZ3kdK14NgCCraOFgiUGuyg63nH0T2tx5+iaeEk1IXMR
	 me2YLCwNwKVg6r4UmSlzMa9uWyDR1RkKCjXef4ndx4tFbgE43GezkaPzfhVLylyZbi
	 hE3WqplMnIY1mbxQ/HeJsRTm+TQwRQvu5YgXlXla8ISgnextvw5EkMiajBCh/9/gCa
	 WGle81DhXCLuxO/3V2r2CUIOFdS5uXyishgfJR1SQ2f5c34BHcfrAqGD4pJV5HuDIS
	 iA2ihMqcvfVKzU8dHZH3qCy6W9tUfA1oX7XmgI0PI5WIiwr9FSdgy7gloxbne1fCtJ
	 ThcvLzAfOe04Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 93D1BEAA95E;
	Sat, 25 Nov 2023 19:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mlxsw: pci: Fix missing error checking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170094062460.30456.13518563848698555135.git-patchwork-notify@kernel.org>
Date: Sat, 25 Nov 2023 19:30:24 +0000
References: <b5a455a64f774adc18dfe2eec7a54413e0cfb2e2.1700740705.git.petrm@nvidia.com>
In-Reply-To: <b5a455a64f774adc18dfe2eec7a54413e0cfb2e2.1700740705.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 horms@kernel.org, mlxsw@nvidia.com, scan-admin@coverity.com, jiri@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 23 Nov 2023 13:01:35 +0100 you wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> I accidentally removed the error checking after issuing the reset.
> Restore it.
> 
> Fixes: f257c73e5356 ("mlxsw: pci: Add support for new reset flow")
> Reported-by: Coverity Scan <scan-admin@coverity.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next] mlxsw: pci: Fix missing error checking
    https://git.kernel.org/netdev/net-next/c/9f1f6111fd5d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



