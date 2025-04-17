Return-Path: <netdev+bounces-183573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E301A91126
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 03:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38E2C443A82
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 01:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6F01494CF;
	Thu, 17 Apr 2025 01:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOnf5wRK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AAE1C6B4
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 01:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744853437; cv=none; b=qEuJZC5eob2VUArpcou5vZqKqUjDNSb39QwbH2emxB35mmD4cY9cF+nMequ/bD2xZ8jW5afjP5G7sCnApYp8jc+od5kcBMbL/QrzvG1Xo3jPJtl/Q/mu1Tw0OXHQELXIhu3Y7py1637ulew03DeZSKsdrRTNsYSNFZ5bXEUcUhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744853437; c=relaxed/simple;
	bh=D+gZmktpp8Lf8RlowWGSGExi853JIK4hMZu7Xr0Q+Qw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PWAdRM+zE8pGS0fzxQowose1hM6p4Ls2dt6RkxaxgtYkS9uqrOT0i1qHlP1NqzNJkCXMrph5cjySK7DwI42fbBKjJXTmyia6E4u0EGi+ZDN1V427aSoZbbeMu6TgBqBYn9rCoGl6yL3RZ93cOvx8bs4umchsVSnBnNrzxIwIkZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOnf5wRK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5270C4CEE2;
	Thu, 17 Apr 2025 01:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744853437;
	bh=D+gZmktpp8Lf8RlowWGSGExi853JIK4hMZu7Xr0Q+Qw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pOnf5wRKaF0LJZ8DmndAL74xoau9SdcUPmnwF2NxhE9E4eT2XW8Bz8jCZ4Z4MfCoh
	 9n7DqaZjGthGVo/GKkSHn5uwcbiWFp8nUZ8FY7QfJdl5Wyrg4zlp7IYzCNzRTQyV4e
	 DWzx1u4+bSzuxta8ryuOlV18pKLINfZ2G9U5tBQ4oXAlrV1eQ0QV+4l/8pyMh1DPyt
	 nySg7906zYpz0aBS5BSrHk7rRHoiN16TSBEK88r13KGUZfBbNDWSYMBlg+Lk78Frw0
	 Xng6WUFq79RP5i1mkUVJ/UkWCQ6eK2Q1VuZ4bl8Ls0xPt5nL+MsyMebdawpd20h5/4
	 U5ik6WfoIJR4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 343543822D5A;
	Thu, 17 Apr 2025 01:31:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] Collection of DSA bug fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174485347474.3557841.17510283891317360037.git-patchwork-notify@kernel.org>
Date: Thu, 17 Apr 2025 01:31:14 +0000
References: <20250414212708.2948164-1-vladimir.oltean@nxp.com>
In-Reply-To: <20250414212708.2948164-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, linux@armlinux.org.uk,
 tobias@waldekranz.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 vivien.didelot@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Apr 2025 00:27:08 +0300 you wrote:
> Prompted by Russell King's 3 DSA bug reports from Friday (linked in
> their respective patches: 1, 2 and 3), I am providing fixes to those, as
> well as flushing the queue with 2 other bug fixes I had.
> 
> 1: fix NULL pointer dereference during mv88e6xxx driver unbind, on old
>    switch models which lack PVT and/or STU. Seen on the ZII dev board
>    rev B.
> 2: fix failure to delete bridge port VLANs on old mv88e6xxx chips which
>    lack STU. Seen on the same board.
> 3: fix WARN_ON() and resource leak in DSA core on driver unbind. Seen on
>    the same board but is a much more widespread issue.
> 4: fix use-after-free during probing of DSA trees with >= 3 switches,
>    if -EPROBE_DEFER exists. In principle issue also exists for the ZII
>    board, I reproduced on Turris MOX.
> 5: fix incorrect use of refcount API in DSA core for those switches
>    which use tag_8021q (felix, sja1105, vsc73xx). Returning an error
>    when attempting to delete a tag_8021q VLAN prints a WARN_ON(), which
>    is harmless but might be problematic with CONFIG_PANIC_ON_OOPS.
> 
> [...]

Here is the summary with links:
  - [net,1/5] net: dsa: mv88e6xxx: avoid unregistering devlink regions which were never registered
    https://git.kernel.org/netdev/net/c/c84f6ce918a9
  - [net,2/5] net: dsa: mv88e6xxx: fix -ENOENT when deleting VLANs and MST is unsupported
    https://git.kernel.org/netdev/net/c/ea08dfc35f83
  - [net,3/5] net: dsa: clean up FDB, MDB, VLAN entries on unbind
    https://git.kernel.org/netdev/net/c/7afb5fb42d49
  - [net,4/5] net: dsa: free routing table on probe failure
    https://git.kernel.org/netdev/net/c/8bf108d7161f
  - [net,5/5] net: dsa: avoid refcount warnings when ds->ops->tag_8021q_vlan_del() fails
    https://git.kernel.org/netdev/net/c/514eff7b0aa1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



