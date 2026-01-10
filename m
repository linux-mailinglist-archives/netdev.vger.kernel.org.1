Return-Path: <netdev+bounces-248665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 217FDD0CD52
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 03:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C7BC304F17A
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 02:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B609524DCE2;
	Sat, 10 Jan 2026 02:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MowrHAlM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936A3242D7B
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 02:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768011816; cv=none; b=JkHoeJeXPeVkvVJoC/X4KstYEqiCAJmrDxhdwqM2nydpZQf4SGmE96H2rbeuJICabQrO8rOzLEkaoW96eDmq2/0twu3FUlzFwFajcD4aMTDlQzkGcE28qH1MbwX6KT83xzDB/Z52NhfvTqONz0VNpCP3UXx6GnHCXn7xizy+qtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768011816; c=relaxed/simple;
	bh=ZVmDDxg57THTNsbNDkjhBjYX6GMVOuT2a2oOfFIP4rE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R8rYIq+J+EYxiwILpqtxoG+2QGERie287AsOjS1VSSiPcpSRincn3NqEMrAwmEb3mCd5hTKCYJKJjSpTmyhB7g2v6+fDrMzYpObpJucwqqjzhqKBOp/EeBPJm6WBo00R1Hs9Se1CwulWrOjQqmZzOWNkqU1J8pDJi5sWcxh8ICE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MowrHAlM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB46C4CEF7;
	Sat, 10 Jan 2026 02:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768011816;
	bh=ZVmDDxg57THTNsbNDkjhBjYX6GMVOuT2a2oOfFIP4rE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MowrHAlMtjY2Un6JMtFFydZpwAkblfw3327U13iVJGvap+4BK6fUIb+EqQ+RMk9Ip
	 ZeAhcQyRn9L5H4qegUe90kJF5zBcJJbCTcPTUFPPBaipXB27a1N2dacc+zGNU/bDh8
	 DgzR3SOFZ0/SKhdOBqxEfO7hvZFrs6aCVMFdpvg/b0heuGQdY91frEukRMqA1xXV7p
	 4VPxCzJuIs7C/F5HnIOrzCirwTuOZajp+EbKZxjR9LIZLpEhV9QMaMHz+n2lB0w/oP
	 aSHVC5bg+LkKOBvIMb1WROXe/1WR8YOPDmJP9Xe8L8FYJWi40cvfBJcqEZ1RKgceh9
	 i1G/yxYvlo00Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B5B83AA9F46;
	Sat, 10 Jan 2026 02:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] net: update netdev_lock_{type,name}
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176801161177.454777.18422406039411383213.git-patchwork-notify@kernel.org>
Date: Sat, 10 Jan 2026 02:20:11 +0000
References: <20260108093244.830280-1-edumazet@google.com>
In-Reply-To: <20260108093244.830280-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 Jan 2026 09:32:44 +0000 you wrote:
> Add missing entries in netdev_lock_type[] and netdev_lock_name[] :
> 
> CAN, MCTP, RAWIP, CAIF, IP6GRE, 6LOWPAN, NETLINK, VSOCKMON,
> IEEE802154_MONITOR.
> 
> Also add a WARN_ONCE() in netdev_lock_pos() to help future bug hunting
> next time a protocol is added without updating these arrays.
> 
> [...]

Here is the summary with links:
  - [v3,net] net: update netdev_lock_{type,name}
    https://git.kernel.org/netdev/net/c/eb74c19fe108

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



