Return-Path: <netdev+bounces-24713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE007715F6
	for <lists+netdev@lfdr.de>; Sun,  6 Aug 2023 17:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9CA281221
	for <lists+netdev@lfdr.de>; Sun,  6 Aug 2023 15:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F365674;
	Sun,  6 Aug 2023 15:50:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1368953BE
	for <netdev@vger.kernel.org>; Sun,  6 Aug 2023 15:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79643C433CA;
	Sun,  6 Aug 2023 15:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691337021;
	bh=Dj25FJRu+BhueqRxSs43Wx8BQP7RV7dLy+wTKzGsTtE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rYWjLdGd3aW8uPWZtNn1p2qZn8Tv2FXsIx0/SZEp9YzNguE+pwTL87uC3qfN9r9Jt
	 lZ72VuyYzkuUaZk9ohmRQ2G2ghJwTg87I/ogHkitOYw2DRyHNS9jiqWcUSO+J1jZnb
	 44QMTrBpWuzNtTGqmvfoENf/K4an7hKqVf8SeikUubi9+Hmw7Ccj8fwGNqrZhkgV22
	 r2naX6x6BXrzwGte46F44REKRxQczhTNhG0yt9gCom2Qz0GW3wXLBblqD0/BulzTsh
	 Qk7xq1L+oVtqUFpiXfQyvGfWdaav5v1swlJ7gZJWRY4TIAExInE5eHKhBRbTX4UKTQ
	 w3fyGcPY7ITTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 586F1C395F3;
	Sun,  6 Aug 2023 15:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ionic: Add missing err handling for queue reconfig
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169133702135.8913.12946430660133159216.git-patchwork-notify@kernel.org>
Date: Sun, 06 Aug 2023 15:50:21 +0000
References: <20230804205622.73306-1-shannon.nelson@amd.com>
In-Reply-To: <20230804205622.73306-1-shannon.nelson@amd.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 brett.creeley@amd.com, drivers@pensando.io, nitya.sunkad@amd.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 4 Aug 2023 13:56:22 -0700 you wrote:
> From: Nitya Sunkad <nitya.sunkad@amd.com>
> 
> ionic_start_queues_reconfig returns an error code if txrx_init fails.
> Handle this error code in the relevant places.
> 
> This fixes a corner case where the device could get left in a detached
> state if the CMB reconfig fails and the attempt to clean up the mess
> also fails. Note that calling netif_device_attach when the netdev is
> already attached does not lead to unexpected behavior.
> 
> [...]

Here is the summary with links:
  - [net] ionic: Add missing err handling for queue reconfig
    https://git.kernel.org/netdev/net/c/52417a95ff2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



