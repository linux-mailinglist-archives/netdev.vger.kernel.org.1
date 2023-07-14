Return-Path: <netdev+bounces-17774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48ADD75304B
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 06:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 783891C214F0
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 04:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3A44C7E;
	Fri, 14 Jul 2023 04:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE61C4A11
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 04:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7AF9C433CD;
	Fri, 14 Jul 2023 04:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689307223;
	bh=H6q8GGtigSzHfq199hDMNy6QpWmmankoTwo1WwYWSio=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PzNehzpb3511+Hp6ltXeTF86CxM/NjlTDwglGB8PJCa+RDyX8xuzE6mKQIbnovM60
	 RbPR+rCELZHgAy1sBTcsEzvErfO0NxDoXSbg2KkuX2rWZefORcccjMkqVpsDQ2Tj54
	 Bc5rbFsa8P9+Mw4/j9aSD0jAMsiA1Xrz4JR984A+0ew1eqGldLSgxbt8+16h+3L5+F
	 WHVRwqEbWeSdBuKH3bAOLcvxkO26JhxZtINDBO5SwNkgPwSGUM66YlrBbwGxpXNx06
	 y5NADnUmq8zaH7G1umy3qv4LLtf3kkbXs4pqIj+PRkKwEpV4LqOI9i6W0LIy7hLSUj
	 8uPdDzxHtvlew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B8E7E4D006;
	Fri, 14 Jul 2023 04:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] nfp: prevent dropped counter increment during probe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168930722356.11211.11149919204687825257.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jul 2023 04:00:23 +0000
References: <20230712123551.13858-1-louis.peens@corigine.com>
In-Reply-To: <20230712123551.13858-1-louis.peens@corigine.com>
To: Louis Peens <louis.peens@corigine.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 simon.horman@corigine.com, ziyang.chen@corigine.com, netdev@vger.kernel.org,
 oss-drivers@corigine.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Jul 2023 14:35:51 +0200 you wrote:
> From: Ziyang Chen <ziyang.chen@corigine.com>
> 
> The dev_rx_discards counter will increment by one when an interface is
> toggled up and down. The main reason is that the driver first sends a
> `NFP_NET_CFG_CTRL_ENABLE` configuration packet to the NIC to perform port
> initialisation when an interface is set up. But there is a race between
> physical link up and free list queue initialization which may lead to the
> configuration packet being discarded.
> 
> [...]

Here is the summary with links:
  - [net-next] nfp: prevent dropped counter increment during probe
    https://git.kernel.org/netdev/net-next/c/bec9ce34075e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



