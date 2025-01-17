Return-Path: <netdev+bounces-159128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 158D8A14792
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 02:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CA317A1CA2
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 01:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9839770813;
	Fri, 17 Jan 2025 01:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4dS5kC8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB403BBD8
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 01:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737077409; cv=none; b=psa6BPIamvwwBx1tZIEy4zGd8EuAcSzqrOK41FB19/CvHEGU6Ky0wMoSTsW8ORV/ZcFt7bbE76xoCBwqY0t0WvKVXVR2hgBfmDoRU3dgPAbC0EIvrpcO8w5ZfA196SOTr6lmv5Rb03Kh/aV4BIq6jsEAHuaJak1gPHyY0wW96tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737077409; c=relaxed/simple;
	bh=95kohPlFmiP/xb7qCK5/t+w6CFHo0+QZY9lHj0L7s38=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GdDY2bDD8bQV/l5tCWBmhMZxtsBL7l/QaCxR4jfHdTVJ3ZVjgmr1iTEUQGhfM8qu7uNGGwraEq8kz4Ju7VYTSvcGA51h0XAKJWDXLC6LERKuxZuw8ceKjZBku1lcv7Rz4a44TQ09XONghROLj+RKL8R08tRtXihIBvt76BAPeuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4dS5kC8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4544C4CEDF;
	Fri, 17 Jan 2025 01:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737077408;
	bh=95kohPlFmiP/xb7qCK5/t+w6CFHo0+QZY9lHj0L7s38=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E4dS5kC8NgmCDWZVJZVCsfkXvQD+fyBH76yToE3jMnJFKweH/Ph87nxOyAEdgVCEt
	 C42QDAXBjPZpJ6lDbbGz4OfD5RUwVNh6zlk3QJZip8V89HskmeXkv2ADGF53NjIRgD
	 Q7sfulMWk6uObumgQnPpqGkmW4SBDIdKwbeOGi/8gx2Mz0iVltiSIMFa95HJT34UBs
	 Gouyn6iAerMU4y8usp7Yfkf+yzfL7qs9VVIrUKrTjIz3EccCcghZb2BGxSB1PcLe4z
	 T1sbi0QlrEeWG+bR3h4P+3ScO/W+/7AhY8+TtF5XEA1P1wK3yw4UqqxRnw2b+c39bD
	 KXm2eyIdG4oaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33ED0380AA63;
	Fri, 17 Jan 2025 01:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next 0/3] dev: Covnert dev_change_name() to per-netns
 RTNL.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173707743200.1649676.1452336792645263362.git-patchwork-notify@kernel.org>
Date: Fri, 17 Jan 2025 01:30:32 +0000
References: <20250115095545.52709-1-kuniyu@amazon.com>
In-Reply-To: <20250115095545.52709-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Jan 2025 18:55:42 +0900 you wrote:
> Patch 1 adds a missing netdev_rename_lock in dev_change_name()
> and Patch 2 removes unnecessary devnet_rename_sem there.
> 
> Patch 3 replaces RTNL with rtnl_net_lock() in dev_ifsioc(),
> and now dev_change_name() is always called under per-netns RTNL.
> 
> Given it's close to -rc8 and Patch 1 touches the trivial unlikely
> path, can Patch 1 go into net-next ?  Otherwise I'll post Patch 2 & 3
> separately in the next cycle.
> 
> [...]

Here is the summary with links:
  - [v1,net-next,1/3] dev: Acquire netdev_rename_lock before restoring dev->name in dev_change_name().
    https://git.kernel.org/netdev/net-next/c/e361560a7912
  - [v1,net-next,2/3] dev: Remove devnet_rename_sem.
    https://git.kernel.org/netdev/net-next/c/2f1bb1e2cc00
  - [v1,net-next,3/3] dev: Hold rtnl_net_lock() for dev_ifsioc().
    https://git.kernel.org/netdev/net-next/c/be94cfdb993f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



