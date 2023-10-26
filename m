Return-Path: <netdev+bounces-44608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0047D8C46
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 01:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA2E82821B4
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 23:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9A53FB3F;
	Thu, 26 Oct 2023 23:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHR1PD8m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5B53C6B2
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 23:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58319C433C7;
	Thu, 26 Oct 2023 23:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698363625;
	bh=R7x6CkCU+Tbnkm7sX4xnBQ7U4p7knsBu7uuqxvZJsSo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KHR1PD8mVM1nA5oCzyfDv/d5Irs2veNWT/mRkMUVIDHaCU9tiUj9rVfgwqibJVOBF
	 J/Lm1NEVetb+OgBH15KipKsg164TMUFS4SV7NDHYjKu2/S/mNFJweJIY493aEytZVO
	 /t77s7hZXkB5e+YZ0wSERJiV69Wavbbb6bNEN7m5TFbL4xv+96BNJcSkdg/nxrvT88
	 xm9NMH/UMYO+Ryw5fldold57TPyJGx7ojxdjGbzjLYh9yjj2ytSJM6nee41Uzjv36H
	 1S7QCBi6su26aD7KWxT7D773Wfvdl1nvu36Sox8W021+hkreTWLSmOcEObTwKUTUNa
	 uy2L1dQvctZ3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3485FC41620;
	Thu, 26 Oct 2023 23:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netlink: make range pointers in policies const
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169836362519.18504.11964226514290552580.git-patchwork-notify@kernel.org>
Date: Thu, 26 Oct 2023 23:40:25 +0000
References: <20231025162204.132528-1-kuba@kernel.org>
In-Reply-To: <20231025162204.132528-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, j.vosburgh@gmail.com, andy@greyhouse.net,
 dsahern@kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, vinicius.gomes@intel.com, johannes@sipsolutions.net,
 razor@blackwall.org, idosch@nvidia.com, linux-wireless@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Oct 2023 09:22:04 -0700 you wrote:
> struct nla_policy is usually constant itself, but unless
> we make the ranges inside constant we won't be able to
> make range structs const. The ranges are not modified
> by the core.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] netlink: make range pointers in policies const
    https://git.kernel.org/netdev/net-next/c/ea23fbd2a8f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



