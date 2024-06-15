Return-Path: <netdev+bounces-103765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A9E9095B3
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 04:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AAF9B220F4
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 02:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD1D749A;
	Sat, 15 Jun 2024 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIKpKQpn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8013EAEB
	for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718419231; cv=none; b=fFP91z6jowE8iuKoWdLivqBfP4vQQwFn4Nu24Yj2On++RamX7t/0Dcic4RYzG144UgisanTxCtiG/MRMn0OwwdXZu2MX+w7C5mTqrOVPtOEBUvC6VOVEjvkZXg5eUIgVStZ6Fq0XTCSQKLV66FpOLFxaqNpHOmv3p8dF3446rEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718419231; c=relaxed/simple;
	bh=N7Yu7x6VeFDyiNS4/dPfgjuL7kgC+KPI9P25lM+mXzI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oxp5LroQOMSf9TQOEppac00rPeeKClpqcqa7VBm1HvicrGZXOMQo6ofA46X8LEztbSm4BjxqJtcQth/bveDFSToIqMiqpok7oltwmgqktFLWWZNDsAwfeOUg+ebWn+YI0sJ764LHP8cggMS1b3rBXkcyhCW+B5J8PtNZnfWd5yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIKpKQpn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5120DC32786;
	Sat, 15 Jun 2024 02:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718419231;
	bh=N7Yu7x6VeFDyiNS4/dPfgjuL7kgC+KPI9P25lM+mXzI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AIKpKQpnQUXissXO9DU6GdzJRbUZMy5JWMt6VNrfe16UCfHcIxCrSDeoAJ6vkCMQc
	 uRMmV36vyqUvqhTPh5y0Dqdk20PhmBGYzooA/F6crCnn8hx8jM7FQT0+81L7jYjoE8
	 7hpGtzP0CRrKNsBNZzbH902xEABqFbdRteABvu85/8nvjuuhjxtpm3KOykf0Hgw3vn
	 izaJSHvnlBABkWyS8f/2KtBOXGD/YjhMKHgqYnGSSzTOPG5N9rk02mCaGuavc+EJB5
	 XuIgXdUID5s9DK3XjlYlPiVYx1i1DUZ8kxJbtzr6A1KujL2fGc5KYU3Dux+TSX0iD8
	 8jup3NydRZctw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C810C43612;
	Sat, 15 Jun 2024 02:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] mlxsw: Handle MTU values
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171841923124.25457.9944342013124852100.git-patchwork-notify@kernel.org>
Date: Sat, 15 Jun 2024 02:40:31 +0000
References: <cover.1718275854.git.petrm@nvidia.com>
In-Reply-To: <cover.1718275854.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 amcohen@nvidia.com, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Jun 2024 16:07:53 +0200 you wrote:
> Amit Cohen writes:
> 
> The driver uses two values for maximum MTU, but neither is accurate.
> In addition, the value which is configured to hardware is not calculated
> correctly. Handle these issues and expose accurate values for minimum
> and maximum MTU per netdevice.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] mlxsw: port: Edit maximum MTU value
    https://git.kernel.org/netdev/net-next/c/cae7fd47dfe1
  - [net-next,2/5] mlxsw: Adjust MTU value to hardware check
    https://git.kernel.org/netdev/net-next/c/d361536fc2df
  - [net-next,3/5] mlxsw: spectrum: Set more accurate values for netdevice min/max MTU
    https://git.kernel.org/netdev/net-next/c/753aacfc032d
  - [net-next,4/5] mlxsw: Use the same maximum MTU value throughout the driver
    https://git.kernel.org/netdev/net-next/c/3e7856545d36
  - [net-next,5/5] selftests: forwarding: Add test for minimum and maximum MTU
    https://git.kernel.org/netdev/net-next/c/4be3dcc9bf04

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



