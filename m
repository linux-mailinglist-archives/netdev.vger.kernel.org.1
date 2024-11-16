Return-Path: <netdev+bounces-145534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D42659CFC4E
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 03:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E41CB2460F
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 02:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4941EA73;
	Sat, 16 Nov 2024 02:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8sqewTO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1828417D2
	for <netdev@vger.kernel.org>; Sat, 16 Nov 2024 02:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731722422; cv=none; b=IudhmkoBzYtQFdInvT+M/7hsQkyRtiaHuUQmGi8uU8OfsSDMjQWFCey/BWoQKzFM23MHp2R2TSlMkMYUiAdpr0BmJFFN+zIltWKCZ73DAxmDif6s6PTdM1pNu6xFte/Q59Hi6Cn4mvSAqOfrwYeWD+WO6GCS/cYpIKTWnQ0yUrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731722422; c=relaxed/simple;
	bh=g7dmBhMTvJRXH/c1R43GnpAhsCfLG47Sk+FTUuIPD/E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A1819ntEbvHkL4Y43ZuWZGaRc0+q3Xt/n/RuLNG1OTlT22JYcTDC8XDgY7ZFkxn3E5KpR1sBGOOWVG1HQdw7RZa6EyC0SachZ1pvC82UtTQs/bpOAdlEIJ9s3GFpSDj1m5xFaOauZDSOla+O2sqM4M7ozr4+s6yjBG74ALjilms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8sqewTO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC91C4CECF;
	Sat, 16 Nov 2024 02:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731722421;
	bh=g7dmBhMTvJRXH/c1R43GnpAhsCfLG47Sk+FTUuIPD/E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B8sqewTOL5PgbIu8t3P8yIdNqq9m/BZtDwWPsaqN9ov1j7gGbKH2+DTrfPbgMu30n
	 fZVOafjF/twYMP3SUJglCLRs5LeDBHpPPX0cnVHKqkmf4AoR+hHthJErPXbdfFxqvX
	 BOj18p/x28k+9p0R/XAsuO0PJIOi68n/PWgvVhJNL8W0bSHqgo1Nu3IaITd0zEigbq
	 VeUCO3tW5z1UmPhNFMvOGZGjYORiaHKi/i2BVbVhwUzboTrPspy/GITlgJcwJYLnfI
	 1/WWQ1gIVAlncOeM4GbCinm46sxMXKgQHgWezpBlRxALU2EkSVgLckhbP/HwjC6S3w
	 xVjY3iaphMSdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CBD3809A80;
	Sat, 16 Nov 2024 02:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/7] net: ndo_fdb_add/del: Have drivers report
 whether they notified
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173172243225.2797219.9826426655274919043.git-patchwork-notify@kernel.org>
Date: Sat, 16 Nov 2024 02:00:32 +0000
References: <cover.1731589511.git.petrm@nvidia.com>
In-Reply-To: <cover.1731589511.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org,
 idosch@nvidia.com, amcohen@nvidia.com, vladimir.oltean@nxp.com,
 aroulin@nvidia.com, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 Nov 2024 15:09:52 +0100 you wrote:
> Currently when FDB entries are added to or deleted from a VXLAN netdevice,
> the VXLAN driver emits one notification, including the VXLAN-specific
> attributes. The core however always sends a notification as well, a generic
> one. Thus two notifications are unnecessarily sent for these operations. A
> similar situation comes up with bridge driver, which also emits
> notifications on its own.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/7] ndo_fdb_add: Add a parameter to report whether notification was sent
    https://git.kernel.org/netdev/net-next/c/4b42fbc6bd8f
  - [net-next,v4,2/7] ndo_fdb_del: Add a parameter to report whether notification was sent
    https://git.kernel.org/netdev/net-next/c/42575ad5aab9
  - [net-next,v4,3/7] selftests: net: lib: Move logging from forwarding/lib.sh here
    https://git.kernel.org/netdev/net-next/c/b219bcfcc92e
  - [net-next,v4,4/7] selftests: net: lib: Move tests_run from forwarding/lib.sh here
    https://git.kernel.org/netdev/net-next/c/601d9d70a40a
  - [net-next,v4,5/7] selftests: net: lib: Move checks from forwarding/lib.sh here
    https://git.kernel.org/netdev/net-next/c/af76b4431818
  - [net-next,v4,6/7] selftests: net: lib: Add kill_process
    https://git.kernel.org/netdev/net-next/c/46f6569cf075
  - [net-next,v4,7/7] selftests: net: fdb_notify: Add a test for FDB notifications
    https://git.kernel.org/netdev/net-next/c/15880bec9bc3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



