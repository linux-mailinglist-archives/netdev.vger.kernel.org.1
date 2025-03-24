Return-Path: <netdev+bounces-177215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5835DA6E4AB
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 21:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A6F03ACD33
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 20:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EEE1E3761;
	Mon, 24 Mar 2025 20:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N01p2f8g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AF21DE2DB
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 20:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742849406; cv=none; b=TgZdEL2yMmobq7hdAfwDDytP19B9rBOkx190VeJZc8F/84qt3l6V7lDuYqNO/ga/rBMEDpRhj02HV6IiGU/S14BJ1taIKSBsWoGMaBCgHSa/u19c7+ImF3JPn4XnP5BY+KuOjwjY9DJ4pbKIeAhwAbTJuS3rdUun0wagKexni2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742849406; c=relaxed/simple;
	bh=suFtJW/on6fChnthGDeTGhYQaK+TtDShm+FGPVQ9V7I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JoyiQVGAZSybZUEOM8fJFnNnHqynTzyW47xS6zCg05TYXTozuUTsSFlICG/fWEwQF0rl/mHb3bRZkrhHHBHTtvNkhLx/tbLxLirzy2CGUCw6marxenvWo5/S1GWhsZkm7QTXLGvtD5KokqWWUlOArUl6NT0tX/0Kt5ns+3YB1ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N01p2f8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B980C4CEE4;
	Mon, 24 Mar 2025 20:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742849406;
	bh=suFtJW/on6fChnthGDeTGhYQaK+TtDShm+FGPVQ9V7I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N01p2f8gkALi1bDfmbEkFrYMg8PU00sHj4Do5EqkXYaJzoReBuenTetz7orIeEjAp
	 hO0IBk1Qm/JZrRwy11OM9LkFMJwh9kCkCHFSXByumC7ZPYfpaKJENoGm6SvnUuJjIJ
	 VqXFNhkRhWUNPG44Lvwg3oceHqVxG3uiYy5uF8diOvti+nGJLfLKZ+HXSwn6Zw4U3L
	 4TpJdkRQOn2X+Hpi+opmGUenqJby/WoqZVOUYfppn/LVgei1gXmeWsUnKDX/fDhwI6
	 gZ0Y/WdVXoWUULR+1bHjLOJaMjbApqav5CdH8ZK/1tcaVkPLqb1dU2ZkfS19sIWi+m
	 e3b2ARVfzrJDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1A5380664D;
	Mon, 24 Mar 2025 20:50:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] net: phylink: Remove unused function pointer from
 phylink structure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174284944225.4167801.6955287752589570922.git-patchwork-notify@kernel.org>
Date: Mon, 24 Mar 2025 20:50:42 +0000
References: <174240634772.1745174.5690351737682751849.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: <174240634772.1745174.5690351737682751849.stgit@ahduyck-xeon-server.home.arpa>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Mar 2025 10:46:25 -0700 you wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> From what I can tell the get_fixed_state pointer in the phylink structure
> hasn't been used since commit <5c05c1dbb177> ("net: phylink, dsa: eliminate
> phylink_fixed_state_cb()") . Since I can't find any users for it we might
> as well just drop the pointer.
> 
> [...]

Here is the summary with links:
  - [net-next] net: phylink: Remove unused function pointer from phylink structure
    https://git.kernel.org/netdev/net-next/c/c3ad9d9e7da8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



