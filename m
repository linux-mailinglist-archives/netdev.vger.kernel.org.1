Return-Path: <netdev+bounces-27818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA9C77D5CA
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 00:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33D801C20E2F
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 22:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D8919892;
	Tue, 15 Aug 2023 22:10:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FDD17ACA
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 22:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1E4DC433C9;
	Tue, 15 Aug 2023 22:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692137424;
	bh=PNrJAPsiFzvufWi72j+2bROR9cQ+OYvyOXKcD14jSWo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dHeyICU+hLleDe2/Y3Cu4ULt4aK4tOxf2cCAWagIoIJACd66bXCQA9EZmX7CrGt1H
	 TropFTm6dDF7z8upGbMSsQZ535ykJz7IbQv/EPhpjKfiGLw8tiGsh3KsnCo4zECnv+
	 qi3oA2siDskkN/TDIYhLsq6zU0Vm5HRAdo6Edrt8aQNKoRH1LduElQ9osgRmlltLXz
	 JBiDrQAmsGI7PwthT28byUUYg45HYkVNBhHRFkxZHz8FhvMMB1/7YJ5uCBBN4Wsc9Q
	 2+51xtpvEPzmZ+uSBnNni7cx8J6lK1E/KiSTC22zWjD2JXjbu5tNvFFSsw8qm5GkB5
	 6Le3bQ6Xt9qFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B862BE93B37;
	Tue, 15 Aug 2023 22:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 00/10] genetlink: provide struct genl_info to
 dumps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169213742475.30940.13714880161407370687.git-patchwork-notify@kernel.org>
Date: Tue, 15 Aug 2023 22:10:24 +0000
References: <20230814214723.2924989-1-kuba@kernel.org>
In-Reply-To: <20230814214723.2924989-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us, johannes@sipsolutions.net

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Aug 2023 14:47:13 -0700 you wrote:
> One of the biggest (which is not to say only) annoyances with genetlink
> handling today is that doit and dumpit need some of the same information,
> but it is passed to them in completely different structs.
> 
> The implementations commonly end up writing a _fill() method which
> populates a message and have to pass at least 6 parameters. 3 of which
> are extracted manually from request info.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,01/10] genetlink: push conditional locking into dumpit/done
    https://git.kernel.org/netdev/net-next/c/84817d8c6042
  - [net-next,v3,02/10] genetlink: make genl_info->nlhdr const
    https://git.kernel.org/netdev/net-next/c/fde9bd4a4d41
  - [net-next,v3,03/10] genetlink: remove userhdr from struct genl_info
    https://git.kernel.org/netdev/net-next/c/bffcc6882a1b
  - [net-next,v3,04/10] genetlink: add struct genl_info to struct genl_dumpit_info
    https://git.kernel.org/netdev/net-next/c/9272af109fe6
  - [net-next,v3,05/10] genetlink: use attrs from struct genl_info
    https://git.kernel.org/netdev/net-next/c/7288dd2fd488
  - [net-next,v3,06/10] genetlink: add a family pointer to struct genl_info
    https://git.kernel.org/netdev/net-next/c/5c670a010de4
  - [net-next,v3,07/10] genetlink: add genlmsg_iput() API
    https://git.kernel.org/netdev/net-next/c/5aa51d9f889c
  - [net-next,v3,08/10] netdev-genl: use struct genl_info for reply construction
    https://git.kernel.org/netdev/net-next/c/0e19d3108aea
  - [net-next,v3,09/10] ethtool: netlink: simplify arguments to ethnl_default_parse()
    https://git.kernel.org/netdev/net-next/c/ec0e5b09b834
  - [net-next,v3,10/10] ethtool: netlink: always pass genl_info to .prepare_data
    https://git.kernel.org/netdev/net-next/c/f946270d05c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



