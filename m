Return-Path: <netdev+bounces-44627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 596D47D8D3E
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 04:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01CD62821CB
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 02:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71CB17FA;
	Fri, 27 Oct 2023 02:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVpMAxZX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9810264A
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 02:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22916C433C9;
	Fri, 27 Oct 2023 02:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698375026;
	bh=tLnXA2R6GfJy1EXpnDpnoBR20BAG7VD+eqkBI9a8/pw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jVpMAxZXGK0d7z2hBwVvOMUxkX5RNAD+V+H10axk/I0LvHFh60JMynnNPjdxIdvZR
	 iK3yH44mw6kY8wnqPOPMZDU64BwORCclLEvv1F1LuyLZUi7bdGkTzlcT6KqldkOsEb
	 ZB/sKDlRWTpc3+LTG28Fw9jy9/vR7mJgg+3n7EeZVB0PFRKHRpvDoZAQfNqlWHp/aB
	 /8hzRFu05jL/0Cfrn0+SQwcSzwJmIFdy0p+1uy+AFdSt/AwqOeyP+P67XKYs3g/ZxJ
	 x5iKOTTBhF0IvUw4qPTeKeT8BwpSWSo6IlX1r22gYx8Q7lJvs/3Vp4WBD+3dFLdPeS
	 5aJA3znWfLHEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01E8FC39563;
	Fri, 27 Oct 2023 02:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netlink: specs: support conditional operations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169837502600.8979.17357547047663375407.git-patchwork-notify@kernel.org>
Date: Fri, 27 Oct 2023 02:50:26 +0000
References: <20231025162253.133159-1-kuba@kernel.org>
In-Reply-To: <20231025162253.133159-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Oct 2023 09:22:53 -0700 you wrote:
> Page pool code is compiled conditionally, but the operations
> are part of the shared netlink family. We can handle this
> by reporting empty list of pools or -EOPNOTSUPP / -ENOSYS
> but the cleanest way seems to be removing the ops completely
> at compilation time. That way user can see that the page
> pool ops are not present using genetlink introspection.
> Same way they'd check if the kernel is "new enough" to
> support the ops.
> 
> [...]

Here is the summary with links:
  - [net-next] netlink: specs: support conditional operations
    https://git.kernel.org/netdev/net-next/c/bc30bb88ff31

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



