Return-Path: <netdev+bounces-55502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C62880B0E7
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 01:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21BA6B20C00
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 00:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B5680B;
	Sat,  9 Dec 2023 00:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjDJVVpy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB9F7F8
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 00:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2B4CC433C8;
	Sat,  9 Dec 2023 00:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702081229;
	bh=uwhp2uSyWgTFzjZ+NMEnoEa8qoPg6161DRIO58bSA08=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hjDJVVpyohd5NVShawyAiheIqULvbLj64JL95oB7WCwZGvma1G9ptwNo+ItVxiPT5
	 cgdSgkg2kFnp9CgMyxbtyo2D/XfcmSjELrvveTs2N8ObGnc0UkkN0q5RCJ+nrQSfTa
	 ZbdfHBpT7tRjVUWAi4TCsAvJ1y0GtiX1S3dQEyRRMDtscqQoaO8YiSnkNig0cL7ANB
	 aYMj94oFucEi7FZ0qykf15XCpKjqwB9lnnBhigK+zl0vMMITe13MzmAHDN4NnDKZl5
	 jR3XHDvXvUfEIITzV8Ii6rSZPzAa2tBm7tO1P/74DMTxIdBEZdSGa6bsfMTuKK4n6N
	 a0phLBRG4GXQQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90421C04DD9;
	Sat,  9 Dec 2023 00:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: sysfs: fix locking in carrier read
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170208122958.21357.6245083794142139410.git-patchwork-notify@kernel.org>
Date: Sat, 09 Dec 2023 00:20:29 +0000
References: <20231206172122.859df6ba937f.I9c80608bcfbab171943ff4942b52dbd5e97fe06e@changeid>
In-Reply-To: <20231206172122.859df6ba937f.I9c80608bcfbab171943ff4942b52dbd5e97fe06e@changeid>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, johannes.berg@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Dec 2023 17:21:23 +0100 you wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> My previous patch added a call to linkwatch_sync_dev(),
> but that of course needs to be called under RTNL, which
> I missed earlier, but now saw RCU warnings from.
> 
> Fix that by acquiring the RTNL in a similar fashion to
> how other files do it here.
> 
> [...]

Here is the summary with links:
  - [net-next] net: sysfs: fix locking in carrier read
    https://git.kernel.org/netdev/net-next/c/bf17b36ccdd5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



