Return-Path: <netdev+bounces-227193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C903DBA9E9E
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 18:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87FFC16C3AB
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 16:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECE230B528;
	Mon, 29 Sep 2025 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTGSnDNp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD9429BDA5
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161616; cv=none; b=k0u9M1CegPqgjxM+Ncn0Ah9r66OLkGwvvifipK1SzIIIjDyaanNrC6jU4pAUjKQcBWRu4pQF21IO/BlLdeyykrEvZ4mM2O3mi7oXIn0sZay+dvCjeuOLXUghgsflYzwwQxzx5tDG1Eyycu6Cygk+RnvHoyx2uc83gZMIQqJ0Xz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161616; c=relaxed/simple;
	bh=n8HcGTjFAw9Tg93vp/GYmMp3q3khdqkWE9Ufn56waKM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QkOUIilqr7wA9QxDPcuPvrYQpiu/VjODEZqPpXD+yKiRoEvnDjLT0idYQaxkKoRlKX4ZS1tUm3t3aOBWWixcVLetM30RETUoarSs62AkaDJs4zugw4BGDa/ZWbOPC6yopHP6678XuGzyaodfNOVzwmgVJHB6syEsWC/sb/C1tvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTGSnDNp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF97C4CEF7;
	Mon, 29 Sep 2025 16:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759161616;
	bh=n8HcGTjFAw9Tg93vp/GYmMp3q3khdqkWE9Ufn56waKM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UTGSnDNp4PEi6UXISIrsbgLsIsPRs99voYdD+Bwtd5sl75eoI3jLa13cQ75Rx4Q+w
	 nr8xXduHsI8c3xUsCtQOcl4Z5KcREQG7drCpE64gdSsidYx5IITunvztxyXM+GvpOq
	 K3Yk8eRJ6Uw66Q5MvtLOm+zeXeamst/LlQCYxmCbe5W9CmuSgQi9+1PVjLZm9HnPbS
	 bj6G1Vom+RbBB6wihLwsrJNqJenXAMLwicrkdCcqwRu6E4kUcnSyDxSnwQLTzG3Jja
	 jLwZED6FVvo7ECZu8XdOT75JAEDEiRvxko7Mw4L2wqlW8jK5Sj1xGVYjxTG5aEvXOo
	 wHgk8BUeqU3Sg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D6539D0C1A;
	Mon, 29 Sep 2025 16:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND] ip/bond: add broadcast_neighbor support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175916161001.1625635.7660570882744679889.git-patchwork-notify@kernel.org>
Date: Mon, 29 Sep 2025 16:00:10 +0000
References: <20250923083953.16363-1-tonghao@bamaicloud.com>
In-Reply-To: <20250923083953.16363-1-tonghao@bamaicloud.com>
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@gmail.com,
 liuhangbin@gmail.com

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Tue, 23 Sep 2025 16:39:53 +0800 you wrote:
> This option has no effect in modes other than 802.3ad mode.
> When this option enabled, the bond device will broadcast ARP/ND
> packets to all active slaves.
> 
> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
> Cc: Stephen Hemminger <stephen@networkplumber.org>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Hangbin Liu <liuhangbin@gmail.com>
> 
> [...]

Here is the summary with links:
  - [RESEND] ip/bond: add broadcast_neighbor support
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=1f7924938884

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



