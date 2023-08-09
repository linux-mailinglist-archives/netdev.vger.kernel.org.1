Return-Path: <netdev+bounces-26028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FDD776985
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 22:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCEC61C21384
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 20:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDAC24535;
	Wed,  9 Aug 2023 20:10:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF8D24518
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 20:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7CB4C433CB;
	Wed,  9 Aug 2023 20:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691611825;
	bh=NEzD99rKAXPxXkTZaKZLGUYXzY4pfffxfApe0PNrruQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tXF5Ttf9IHacpMOPeUPEgeppMW7740EpBKl3PmihUHCnBK7xRaNySr4LJhQA8QEwd
	 QjroJ1UJiYJe+xv2ZCV0UzYKmeaQbM+Givi1LCg4VDL3NsZN/2Lz8d2aummM9VZJOc
	 RwO+U5lEU1Kk7pTWD4MVXH8OwXT/80N03+Boo8aZS1B2Hbz8SArZJRTBxkmx/fIV4l
	 Z1Fc6QgGCI3blrxCjXf7EhcvIpJajoF4se42o3tBPRdNvgWbPWSn8FMzL0+rgRtAWr
	 o0mhZ0Glzk178TWi9jZDlnOpP3kdWM8WWJE4gqfoYgV1Iiy16ZXVi18F3ZIYoPl+/p
	 RCySzUPFCt1Ew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A10BFC64459;
	Wed,  9 Aug 2023 20:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net-next] ynl-gen-c.py: avoid rendering empty validate field
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169161182565.10541.4727321039825877570.git-patchwork-notify@kernel.org>
Date: Wed, 09 Aug 2023 20:10:25 +0000
References: <20230808090344.1368874-1-jiri@resnulli.us>
In-Reply-To: <20230808090344.1368874-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Aug 2023 11:03:44 +0200 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> When dont-validate flags are filtered out for do/dump op, the list may
> be empty. In that case, avoid rendering the validate field.
> 
> Fixes: fa8ba3502ade ("ynl-gen-c.py: render netlink policies static for split ops")
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next] ynl-gen-c.py: avoid rendering empty validate field
    https://git.kernel.org/netdev/net-next/c/2c0e9f3806c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



