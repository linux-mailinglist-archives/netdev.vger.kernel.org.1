Return-Path: <netdev+bounces-32924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE3779AB29
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 22:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CF4C2812F4
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 20:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7398515AF4;
	Mon, 11 Sep 2023 20:20:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F040E15AE6
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 20:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DA65C433C8;
	Mon, 11 Sep 2023 20:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694463628;
	bh=X5xlf3ivtp7jN1PQvuP0qrKFqZ41kIddDxu1O9Hi9Jc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GTBzNeGaG/PMEEo5s8v29bc0qgyd+T5rPl4pm5x9/ghcgsd04BMh/nBGMRlUX8ST3
	 XWbaWszYc468OmviyOtacXf0Ta2bTdrsSWifZCxu4HzRl72ErpYIe4+jkxN1PBgF5q
	 f9cK9dhJQfxgaXW81mX7cLG4sl7F9Hy3tDeON7IpmHkxSCscsju5qjrJUFccFFDv2E
	 1zCPxU2HLIM3LXS5qWVq9n4XLcB8ecVphDmIP+gCV74gX+2Rbc+W29UCOUJDFjrKl8
	 vx4SkT+6xKXTVmkoe4qA07oeQz7XOgTnPF0g0cm69EVao67OYt9hIqbyAHPNf3ySbJ
	 Uf0H6p2jKR10w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5FE4EC64459;
	Mon, 11 Sep 2023 20:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 ethtool] rxclass: fix a bug in rmgr when searching for
 empty slot
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169446362838.25976.13688801336520865450.git-patchwork-notify@kernel.org>
Date: Mon, 11 Sep 2023 20:20:28 +0000
References: <20230901065203.125150-1-yinjun.zhang@corigine.com>
In-Reply-To: <20230901065203.125150-1-yinjun.zhang@corigine.com>
To: Yinjun Zhang <yinjun.zhang@corigine.com>
Cc: mkubecek@suse.cz, oss-drivers@corigine.com, netdev@vger.kernel.org,
 alexanderduyck@meta.com, niklas.soderlund@corigine.com

Hello:

This patch was applied to ethtool/ethtool.git (master)
by Michal Kubecek <mkubecek@suse.cz>:

On Fri,  1 Sep 2023 14:52:03 +0800 you wrote:
> When reverse searching the list in rmgr for a free location the last
> slot (first slot searched) in the list needs special care as it might
> not span the full word length. This is done by building a bit-mask
> covering the not-active parts of the last word and using that to judge
> if there is a free location in the last word or not. Once that is known
> searching in the last slot, or to skip it, can be done by the same
> algorithm as for the other slots in the list.
> 
> [...]

Here is the summary with links:
  - [v2,ethtool] rxclass: fix a bug in rmgr when searching for empty slot
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=7fd525f67cf5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



