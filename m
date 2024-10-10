Return-Path: <netdev+bounces-133989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BF6997A01
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 03:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ABC21F237DB
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 01:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3E62BD0E;
	Thu, 10 Oct 2024 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJfq/wiF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254AA2B9B0
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728522629; cv=none; b=CewUsbsGpM3tnW3HxOTeHMV3LotYVyRsK8c2l68OihEDEeNwPT8HjsP+5fEKLeNMFt23iZXJ6jiOLdB+VZfKtXCcL0aE5UnPB8DrGgzVkXeLQxdF4Cnng5xW5IZNUx+hyXidUUte6888EX1kSUQCnvZx/GYDPvO0RzldJemgEgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728522629; c=relaxed/simple;
	bh=avuKk1PZlkverN7itY/vVQ5VwMmDJwEjddA48ON96aM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aw76YUsox2Kuz3Ne7IJeZ6R0koiQlR6ckwssAAmbNBU3pKDJiEdo/v/jbpC8MvksjQQPhgbwh5BwxM/vKAG6rrXzUzSFgp1vR6IlDSESnghoF+QCTbD6iJCNgeRYeKfSIp0g3X8k+1RJ00oQvjvLvzfDXtLzgg+Ht51sDXwkzss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJfq/wiF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4D9C4CED1;
	Thu, 10 Oct 2024 01:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728522628;
	bh=avuKk1PZlkverN7itY/vVQ5VwMmDJwEjddA48ON96aM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LJfq/wiFzMrvkDR5yCkxJi9vZDHqdAYQaUaqLKG5u52Y8FVseXilqAun5P+E14J4O
	 6oLfEOrQBYxMtdc7zIVCutz1bsPFSj/zVrOBNeONQdzuH4WHulLBN0mkGhQ7NoSAS9
	 VpeMb49SZcwz1tzjUa8+NIV2UpMLCEbA/T2v/Qkvx2W8dGvUKtJL234RaKhtSTVwke
	 rvqwcBlGxeE/Jm+FEmCVpPpEmgb/1xXbIXUX4Cq79cy99qIh7mskrgi+9YsrFRFe8a
	 +rdMt2sYrCLBpzidBddX0x88NGykCHTlY389xyGdNVdoorMRG8x9kNmoyXlyWsRbgX
	 hd6FBe2+lRYtw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 342E23806644;
	Thu, 10 Oct 2024 01:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] tcp: remove unnecessary update for tp->write_seq
 in tcp_connect()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172852263301.1528050.5673496766619295375.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 01:10:33 +0000
References: <1728289544-4611-1-git-send-email-guoxin0309@gmail.com>
In-Reply-To: <1728289544-4611-1-git-send-email-guoxin0309@gmail.com>
To: xin.guo <guoxin0309@gmail.com>
Cc: edumazet@google.com, ncardwell@google.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Oct 2024 16:25:44 +0800 you wrote:
> From: "xin.guo" <guoxin0309@gmail.com>
> 
> Commit 783237e8daf13 ("net-tcp: Fast Open client - sending SYN-data")
> introduces tcp_connect_queue_skb() and it would overwrite tcp->write_seq,
> so it is no need to update tp->write_seq before invoking
> tcp_connect_queue_skb().
> 
> [...]

Here is the summary with links:
  - [net-next,v3] tcp: remove unnecessary update for tp->write_seq in tcp_connect()
    https://git.kernel.org/netdev/net-next/c/d35bd24cea94

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



