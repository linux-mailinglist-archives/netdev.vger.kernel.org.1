Return-Path: <netdev+bounces-55846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E0880C789
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 12:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0561C20F9C
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 11:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5656A2D63F;
	Mon, 11 Dec 2023 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7OuLJth"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383DC2D63B
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 11:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA7B4C433C7;
	Mon, 11 Dec 2023 11:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702292424;
	bh=xkNQtQTncTLP7qrTyZ7IR97TQKmcj3ea5oZ1x3tHOTI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I7OuLJthzPr8Wl7aDJgwE2LMNYTdOTJ26GLqcCymsAQXd/dBK5utiIkexlHYebMfb
	 /qfG543gZWhCmqSOx457g1cJdwo5X3M/+2Sx+Q+9pm/oP5BwwDo4RO2DIb2WFxqlSE
	 vU0TIf8JMEoIGy6CiiED2GxgVc1kb2fLk2GKvzyVJgMS60tE2XsXwOsMZ9XAr+H8ZG
	 74NkHtNQE4zpURQJ7G/qIpxevo+9d0BrNzSvEQza/yoQTXtoF+dSyYFEHWsx4NiP75
	 UKB0fVzBSmHV/imJ9OLo4OmtGDs2iuQEtxUGqal+qEL64W+ETX06tdUG80vz5pPY+z
	 zx8KdxngRZhhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A5EFFDFC906;
	Mon, 11 Dec 2023 11:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] Revert "net: rtnetlink: remove local list in
 __linkwatch_run_queue()"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170229242467.25377.6078665511222930199.git-patchwork-notify@kernel.org>
Date: Mon, 11 Dec 2023 11:00:24 +0000
References: <20231208105214.42304677dc64.I9be9486d2fa97a396d0c73e455d5cab5f376b837@changeid>
In-Reply-To: <20231208105214.42304677dc64.I9be9486d2fa97a396d0c73e455d5cab5f376b837@changeid>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, m.szyprowski@samsung.com, johannes.berg@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  8 Dec 2023 10:52:15 +0100 you wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> This reverts commit b8dbbbc535a9 ("net: rtnetlink: remove local list
> in __linkwatch_run_queue()"). It's evidently broken when there's a
> non-urgent work that gets added back, and then the loop can never
> finish.
> 
> [...]

Here is the summary with links:
  - [net-next] Revert "net: rtnetlink: remove local list in __linkwatch_run_queue()"
    https://git.kernel.org/netdev/net-next/c/9a64d4c93eee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



