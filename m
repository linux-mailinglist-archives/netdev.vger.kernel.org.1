Return-Path: <netdev+bounces-20088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C7A75D8E3
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 04:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F991C2187C
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 02:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF466FC0;
	Sat, 22 Jul 2023 02:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98BA6AA8
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 02:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C078C43391;
	Sat, 22 Jul 2023 02:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689991821;
	bh=9rC1uB5sevHpclbiTmTUvDyuCYqUc45dLhqAinY3Lss=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W+b6DI0VgccZkOE9buuTPd27B9IejkYvLbqBWN6Yeq1zjVO2tgYgZXWDch6qEG//9
	 oLiNVM+zGo/FwbRd2DhspyZP9ZV74QCaJQPDm/4Z9F3IuYtF/UQuHG9tJTDpJ7vj/T
	 oWzsj/zJ1C5uBKuzMjczGnQ61IlCqolWuV8VEws5IfhuaEO0UffXmlqlI9LX/Ms5G4
	 lBEDcQRRTDj+sWP4nWp87Xs1AllDMO2zuKxktgbvTzoLPwaL+vvrs+p+cTyr5G28Ca
	 Nf9jVFX0ikZ/wc+fF5qEsHq/S7r/NqLOOHi+gZKFRlAx/vDwSP18s9oQyQiGVJCqvC
	 H6TEmVm9cAGFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4D7EFC595C2;
	Sat, 22 Jul 2023 02:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net-next] genetlink: add explicit ordering break check for
 split ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168999182131.11383.14101333137393850077.git-patchwork-notify@kernel.org>
Date: Sat, 22 Jul 2023 02:10:21 +0000
References: <20230720111354.562242-1-jiri@resnulli.us>
In-Reply-To: <20230720111354.562242-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, jacob.e.keller@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Jul 2023 13:13:54 +0200 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Currently, if cmd in the split ops array is of lower value than the
> previous one, genl_validate_ops() continues to do the checks as if
> the values are equal. This may result in non-obvious WARN_ON() hit in
> these check.
> 
> [...]

Here is the summary with links:
  - [net-next] genetlink: add explicit ordering break check for split ops
    https://git.kernel.org/netdev/net-next/c/5766946ea511

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



