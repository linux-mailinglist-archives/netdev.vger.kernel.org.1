Return-Path: <netdev+bounces-45646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C947DEC32
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 06:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 826EE281A35
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 05:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7594B1FB4;
	Thu,  2 Nov 2023 05:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5exa0iQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A501FA7
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 05:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BAB1BC433CA;
	Thu,  2 Nov 2023 05:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698902424;
	bh=p72ZJpQH4fj5igLMUDdC8ykQB9sao0fAt04Lzxcjm8M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g5exa0iQDZ+LBvxyqKbO1es46o6oy4giVdwvn3PjvEf8vhAXQtzz+WHuLWO6UgzCY
	 CzVhHg9BgzpZvgZ2gp3X9mO6DD1Jk9yi6JU2Ppf3Cj2G1YUpO5CnKjoN2fFmfk6S5t
	 3iC0g7gQBxkF5YQIlTqPOEpWis0Fb6wA5rdIdIrREaayLUvL7g7Cm3AOd+VL5lxgWd
	 VfVzbe3dG6D6gpxmw/u9w77lKH41ilyHc8ZMP6W3VbaPX8XMVpPnk32xJIrBWP4vzm
	 zUgP6Q0Gst2VwFb2bxHgDJsKXyKNi/nzDcMmT8dI/1qmcRqLfkTLRvfK5yYq3G6Djf
	 ICwJk4Q8/jGQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 97917E00091;
	Thu,  2 Nov 2023 05:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net] netlink: specs: devlink: add forgotten port function caps
 enum values
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169890242461.25325.6115706587318020271.git-patchwork-notify@kernel.org>
Date: Thu, 02 Nov 2023 05:20:24 +0000
References: <20231030161750.110420-1-jiri@resnulli.us>
In-Reply-To: <20231030161750.110420-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, jacob.e.keller@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Oct 2023 17:17:50 +0100 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Add two enum values that the blamed commit omitted.
> 
> Fixes: f2f9dd164db0 ("netlink: specs: devlink: add the remaining command to generate complete split_ops")
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net] netlink: specs: devlink: add forgotten port function caps enum values
    https://git.kernel.org/netdev/net/c/05f0431bb90f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



