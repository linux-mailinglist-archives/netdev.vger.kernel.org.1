Return-Path: <netdev+bounces-42662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D967CFBD9
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 16:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF8DD1C20AAB
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 14:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC3C29CF1;
	Thu, 19 Oct 2023 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LN7bcQlo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848B727477
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 14:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE809C433CA;
	Thu, 19 Oct 2023 14:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697724023;
	bh=Yhhd5hstpiKA5zab59qWTAeixMj5SDXdrSZuH8krMxU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LN7bcQloPz4da+FRGYfkx/g3A65uhMEa5F3gqZuacuZijbs+PziV7O7Rtbkc2k4AZ
	 czYMps0+tzOsx064G0kApeXdmMXYOCz2xphLxGLExeqcnXDRZwC94hsMl5Nlv9HeXU
	 xCQiqEhfIqvuOBBu7lF3svFqPt5b2y+9w2a7CqkjVyZGwKa596UvJ8V6TtX0QeC5/T
	 1TZF4dtmg+cXys7g8EEIJEMBlNTrfVyT5eSF+vrmolSWFBeMmuvGvmlWdIi1E51vA7
	 KhOFO4b4XFTmMWhQ/RF9T7n6XQSNv1ohJT+skf/DhHmBcecT6okWR2Kow7GxOOVVvl
	 nYK89xLV62jtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 953A3C595CE;
	Thu, 19 Oct 2023 14:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/5] net: fix bugs in device netns-move and rename
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169772402360.10372.10410205821512863982.git-patchwork-notify@kernel.org>
Date: Thu, 19 Oct 2023 14:00:23 +0000
References: <20231018013817.2391509-1-kuba@kernel.org>
In-Reply-To: <20231018013817.2391509-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us, przemyslaw.kitszel@intel.com,
 daniel@iogearbox.net

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 17 Oct 2023 18:38:12 -0700 you wrote:
> Daniel reported issues with the uevents generated during netdev
> namespace move, if the netdev is getting renamed at the same time.
> 
> While the issue that he actually cares about is not fixed here,
> there is a bunch of seemingly obvious other bugs in this code.
> Fix the purely networking bugs while the discussion around
> the uevent fix is still ongoing.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/5] net: fix ifname in netlink ntf during netns move
    https://git.kernel.org/netdev/net/c/311cca40661f
  - [net,v2,2/5] net: check for altname conflicts when changing netdev's netns
    https://git.kernel.org/netdev/net/c/7663d522099e
  - [net,v2,3/5] net: avoid UAF on deleted altname
    https://git.kernel.org/netdev/net/c/1a83f4a7c156
  - [net,v2,4/5] net: move altnames together with the netdevice
    https://git.kernel.org/netdev/net/c/8e15aee62161
  - [net,v2,5/5] selftests: net: add very basic test for netdev names and namespaces
    https://git.kernel.org/netdev/net/c/3920431d98a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



