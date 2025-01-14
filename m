Return-Path: <netdev+bounces-157963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D152AA0FF33
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 04:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12C401887DA9
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 03:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D85230D05;
	Tue, 14 Jan 2025 03:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bW/jK1p0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E94232364
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 03:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736825422; cv=none; b=SsY9zu9oRAhmRScQWzngHb0ajeikNoBRvoq7AHitNhEjbuzP9aaZBb0M1m5+TDB3MPxTxzmadToJW8GWWP1XQQkdEV5JE1l0l0UUHBe5G6tGm+RCK4MFnMVtke2PIjiUPX7X8L53RA0O85YeRIOx5rV4wymD/kwAhG84ek1bmmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736825422; c=relaxed/simple;
	bh=v/+++aP20zI6aAQMz+EKz1CUD1VuyPRCtkFAjJMEcGw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uPXGG69MOR4V3DDZuQKSZwx8k8V92e0vHsNmqaJGVT8QKMDNORIym0OeF8+Dj1bhhHh29QJ394OI6KyYkmWxGIJOBz463G+213ugwwkkktOCTz/mJcl7dnNQBBO4j+GmvZ6/MXO/HrpYet/SVLChnhj5kKvWA/MIuHzgPzkgsdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bW/jK1p0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20E0C4CEDF;
	Tue, 14 Jan 2025 03:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736825421;
	bh=v/+++aP20zI6aAQMz+EKz1CUD1VuyPRCtkFAjJMEcGw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bW/jK1p0zS5Hxzak8zIKC+T906bfp2HSJccDJBDJXUSyG99KLrkSnikd8lTf9jIRJ
	 ASQn0sLi4XtHgMPxH1bOgijYV+ix4SHmMIxmw3aD29LOX7Iwj+CvpRW1cZPuuLyPqK
	 zo/Vt2SqA8GxqqAkPYQQDcFhC4/A6JhBBjILXcA4uECemzgBCqONsESJ9KEq83phyY
	 r1fmUTEFJ9RWXHPDgU/GuF3JNEVKbq9u6Rlu07yySwq4UI9g0KBAg43Mkppsr9yVjX
	 SDEfHA21RUp6h0ZvXJ6phamPd3JX6fiFqxB4TmpT8Bv/R1xF8faWcAAZ6gqyUZTY+L
	 82wLFLH3Spm7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEE7380AA5F;
	Tue, 14 Jan 2025 03:30:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V2 00/15] mlx5 HW-Managed Flow Steering in FS core
 level
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173682544448.3721274.12313658958828112956.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jan 2025 03:30:44 +0000
References: <20250109160546.1733647-1-tariqt@nvidia.com>
In-Reply-To: <20250109160546.1733647-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com, mbloch@nvidia.com,
 moshe@nvidia.com, kliteyn@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 9 Jan 2025 18:05:31 +0200 you wrote:
> Hi,
> 
> This patchset by Moshe follows Yevgeny's patchsets [1][2] on subject
> "HW-Managed Flow Steering in mlx5 driver". As introduced there in HW
> managed Flow Steering mode (HWS) the driver is configuring steering
> rules directly to the HW using WQs with a special new type of WQE (Work
> Queue Element). This way we can reach higher rule insertion/deletion
> rate with much lower CPU utilization compared to SW Managed Flow
> Steering (SWS).
> 
> [...]

Here is the summary with links:
  - [net-next,V2,01/15] net/mlx5: fs, add HWS root namespace functions
    https://git.kernel.org/netdev/net-next/c/cbfdefc44194
  - [net-next,V2,02/15] net/mlx5: fs, add HWS flow table API functions
    https://git.kernel.org/netdev/net-next/c/0f3ecf5c57d8
  - [net-next,V2,03/15] net/mlx5: fs, add HWS flow group API functions
    https://git.kernel.org/netdev/net-next/c/4160405f6c4d
  - [net-next,V2,04/15] net/mlx5: fs, add HWS actions pool
    https://git.kernel.org/netdev/net-next/c/c7e62a788a98
  - [net-next,V2,05/15] net/mlx5: fs, add HWS packet reformat API function
    https://git.kernel.org/netdev/net-next/c/aecd9d1020e3
  - [net-next,V2,06/15] net/mlx5: fs, add HWS modify header API function
    https://git.kernel.org/netdev/net-next/c/b36315ca69cb
  - [net-next,V2,07/15] net/mlx5: fs, manage flow counters HWS action sharing by refcount
    https://git.kernel.org/netdev/net-next/c/b581f4266928
  - [net-next,V2,08/15] net/mlx5: fs, add dest table cache
    https://git.kernel.org/netdev/net-next/c/3fd62e943aeb
  - [net-next,V2,09/15] net/mlx5: fs, add HWS fte API functions
    https://git.kernel.org/netdev/net-next/c/2ec6786ad0a6
  - [net-next,V2,10/15] net/mlx5: fs, add support for dest vport HWS action
    https://git.kernel.org/netdev/net-next/c/8e2e08a6d1e0
  - [net-next,V2,11/15] net/mlx5: fs, set create match definer to not supported by HWS
    https://git.kernel.org/netdev/net-next/c/866e50321256
  - [net-next,V2,12/15] net/mlx5: fs, add HWS get capabilities
    https://git.kernel.org/netdev/net-next/c/c09cf80ed299
  - [net-next,V2,13/15] net/mlx5: fs, add HWS to steering mode options
    https://git.kernel.org/netdev/net-next/c/9fc43b5e3933
  - [net-next,V2,14/15] net/mlx5: HWS, update flow - remove the use of dual RTCs
    https://git.kernel.org/netdev/net-next/c/ab6912ff6558
  - [net-next,V2,15/15] net/mlx5: HWS, update flow - support through bigger action RTC
    https://git.kernel.org/netdev/net-next/c/3fc44ca44d7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



