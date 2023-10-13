Return-Path: <netdev+bounces-40650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6357C8278
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 11:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC2A11C20AC1
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 09:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D9011193;
	Fri, 13 Oct 2023 09:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ay8gvoa1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2CC11192
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 09:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED200C433C9;
	Fri, 13 Oct 2023 09:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697190623;
	bh=8nZNXYCM0kCl/5zssxdd495/7tDEM/Zl1DBgwKO+mmw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ay8gvoa1BD8zDqp7CU3WvJSywdU3nCfwv3EODuYxEKQMDT4DhwdfXgd5Wj+0E8MPu
	 BGyLYTXVqXz3KvyXQ4+DKsMsbd/Dw8I/lGbomatw8RPG7n0ZNb6du7bzbCA04PSMMw
	 qbKuEAlIFDBnHezNUShWEoBb3oQ6fNgKl7/eDeeOsdXwEsnCQ1BOPszLraQ4rHh3jR
	 r14odgm5PHHInsqerLuJMwKn8t6D5xSlCykdRYoFCSW+AvMN+BV6hXcd0VONPE5IJM
	 nGAI6ORdCI7PxpDzpkmPKk7gkGod8ZCcg3BDZglFwkUubNxQZnQcOVdn1LrNqekLQc
	 /gQRqpoO8bfpg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D969BE11F41;
	Fri, 13 Oct 2023 09:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net-next] selftests: netdevsim: use suitable existing dummy
 file for flash test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169719062288.23782.6011707693421892911.git-patchwork-notify@kernel.org>
Date: Fri, 13 Oct 2023 09:50:22 +0000
References: <20231010144400.211191-1-jiri@resnulli.us>
In-Reply-To: <20231010144400.211191-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, shuah@kernel.org, pavan.chebbi@broadcom.com,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 10 Oct 2023 16:44:00 +0200 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> The file name used in flash test was "dummy" because at the time test
> was written, drivers were responsible for file request and as netdevsim
> didn't do that, name was unused. However, the file load request is
> now done in devlink code and therefore the file has to exist.
> Use first random file from /lib/firmware for this purpose.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: netdevsim: use suitable existing dummy file for flash test
    https://git.kernel.org/netdev/net-next/c/6151ff9c7521

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



