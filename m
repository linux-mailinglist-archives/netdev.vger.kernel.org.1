Return-Path: <netdev+bounces-70430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BA384EF5C
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 04:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA051C24FB9
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 03:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881EF4C97;
	Fri,  9 Feb 2024 03:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xf5MS4Fh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EAD4C90
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 03:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707448828; cv=none; b=JjE1fkvPiTBenaSciOMviBO9Idxx5SXRvfDdxyzOtp+V6emhIiix1b8diCVYcAct8LwJQQ2INXsTAO3AbjOqWdO+pezmTbz6ceuvxTJPvdsQLzJuvYG3qi7FaFlI7ycjtkSjVzb4A/eEnpzxaW3CudH+2V9gd10oQAja+82VTVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707448828; c=relaxed/simple;
	bh=9H/QdVrb3VsqTS/ConAt5/mR1aYyAsOUWy0/a3xasQc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lTddLqIlZQWCLY5AaFfzUrejEe2RJamg2aU8GVNbxed4AQlXdbgtEGy728qYu6fnUc6CFE2YJ51wRmNM9LDNV73hbBbanM28Pc81o77C2L+MnlvtE4LNpZWf4JCgXP9R7RsZu1z9g3qtJAyM9bLnH6x+WZrF0UdrNXW1k8VKi0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xf5MS4Fh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4C07C433C7;
	Fri,  9 Feb 2024 03:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707448828;
	bh=9H/QdVrb3VsqTS/ConAt5/mR1aYyAsOUWy0/a3xasQc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xf5MS4FhQLNKpwWpBCF5+T8GBye0NOrCtyME9auvOPZnb82nAJiYIxMGVHCVKl3Ub
	 sF7OPcRAZYx6c8Ek7dn6lEbrDo71GIi1VwNVWti5geCyLiuytWJxyPpYK4TROqU40B
	 xgmEC5EpAmjh5vr/G8EIXT81R+QbAFP6YTNSZ9fq80HIxbpu+xmU0yAFqr+h3u3HTj
	 MQZfR+lcUxjyQUsZpmQGey8GU6m6dxOzxMyvmteFVh9bwnkWwMnBrXNTRMx1Ucp/9A
	 xkEHV074FMj/9Z4ZmRazCiWCz9JhK7iGkRBM7BMj3AAAq5jJnFdpB0OYolT6hy+AoU
	 xI9mcbfM1CpLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C73CBC395FD;
	Fri,  9 Feb 2024 03:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3][pull request] Intel Wired LAN Driver Updates
 2024-02-06 (ixgbe)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170744882781.28492.229337638261453378.git-patchwork-notify@kernel.org>
Date: Fri, 09 Feb 2024 03:20:27 +0000
References: <20240206214054.1002919-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240206214054.1002919-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue,  6 Feb 2024 13:40:50 -0800 you wrote:
> This series contains updates to ixgbe driver only.
> 
> Jedrzej continues cleanup work from conversion away from ixgbe_status;
> s32 values are changed to int, various style issues are addressed, and
> some return statements refactored to address some smatch warnings.
> 
> The following are changes since commit 60b4dfcda647f86c62dc7b8219d2bfed19bb2698:
>   Merge branch 'nfc-hci-save-a-few-bytes-of-memory-when-registering-a-nfc_llc-engine'
> and are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 10GbE
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] ixgbe: Convert ret val type from s32 to int
    https://git.kernel.org/netdev/net-next/c/8f76c0f4c3ce
  - [net-next,2/3] ixgbe: Rearrange args to fix reverse Christmas tree
    https://git.kernel.org/netdev/net-next/c/b678b63a2454
  - [net-next,3/3] ixgbe: Clarify the values of the returning status
    https://git.kernel.org/netdev/net-next/c/ef3dd5965047

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



