Return-Path: <netdev+bounces-49885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1697F3B83
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 02:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 386B3B21505
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 01:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A5D5386;
	Wed, 22 Nov 2023 01:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKFkl7Md"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE4C4426
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 01:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 294B7C433C9;
	Wed, 22 Nov 2023 01:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700617823;
	bh=ytwSLqGynDoxV3L8iE9r2IClifLUP14wvoD8499FKVQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lKFkl7MdEVR7qGp1syXYGejcOz6XMvPmUT2MAP6Nw+Jno0b4llFUGUrwv0HFcLZ+8
	 k1wRmybSeLl4j90Xwnb0R8+ZyZfNFHFHrzvA+zPuuDpPtYDQ9+axWl48ZJz2lPEvxq
	 lX6KP1y4wa5ASs+aMtTsN+aSjE17vshV6lPQEfy/HJjaZumoVrbYoTZ20KjPsaxZZk
	 Mw1GIlm8j8B0ZDILW+PY9novEg73+Tg1hwbR/7ODIC4rJD78uXTv4FvAhVS+BoiLwF
	 EZBwYmVF/8nwyBB2qc345+A5524P0W2lniy8aRoVJkdZEil2zyEx+bhP+PO66yXBsJ
	 OYzpMme4QBRsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0DFCCC595D0;
	Wed, 22 Nov 2023 01:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] dpll: Fix potential msg memleak when genlmsg_put_reply
 failed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170061782305.9000.12246694056316498356.git-patchwork-notify@kernel.org>
Date: Wed, 22 Nov 2023 01:50:23 +0000
References: <20231121013709.73323-1-gehao@kylinos.cn>
In-Reply-To: <20231121013709.73323-1-gehao@kylinos.cn>
To: Hao Ge <gehao@kylinos.cn>
Cc: vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com,
 jiri@resnulli.us, michal.michalik@intel.com, davem@davemloft.net,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Nov 2023 09:37:09 +0800 you wrote:
> We should clean the skb resource if genlmsg_put_reply failed.
> 
> Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> ---
> v1 -> v2: change title due to add some similar fix for some similar cases
> 
> [...]

Here is the summary with links:
  - [v2] dpll: Fix potential msg memleak when genlmsg_put_reply failed
    https://git.kernel.org/netdev/net/c/b6fe6f03716d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



