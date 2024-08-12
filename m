Return-Path: <netdev+bounces-117868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BBA94FA18
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 01:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C38961C21B51
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 23:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCE116DEBD;
	Mon, 12 Aug 2024 23:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRPQxexC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4979614D28F
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 23:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723503629; cv=none; b=kDp2MJE2RdEQSswe/8hkP8Bdc8wYw7n8eh7qsKAkKdwBfnXnNbefRfGxQwNJOSMpG7Xk3buqIICLCaCd6yC+uwGlfOx2ULRT6lfKtShbXjyp9xUSy+H0qsBT08Mf70OJOGuUZeoowflBf0pJ/T/U58yjePVQ6xjs9IalMWbt28o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723503629; c=relaxed/simple;
	bh=WxfHM15Kr/OwjHw/EpcUoyRXfpTwIvOnO6Ila8E9gUI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lajkBIC7zB/9kIzV7AcY5tDsA6p8lZmCV4sCymRawwSZ5m8Ay2kUyo7WB3J4v6Kn0wogwJE5pZckI3t0UGt8QCFspoXA5XY3u2Ui4neqVZOsl3ZglDGwLtahcte0qJhBavCkTK8T0iXqWroBpUxwMigwUmbfWgjZreF0g4MEipk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tRPQxexC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8014C4AF0E;
	Mon, 12 Aug 2024 23:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723503628;
	bh=WxfHM15Kr/OwjHw/EpcUoyRXfpTwIvOnO6Ila8E9gUI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tRPQxexCueD7OY4Rwqj+SxXWHiOaYQqDekfjEcuKskGVrAktVe3Bc5ikHd/Z7K5uQ
	 j4Dy/NaiDxolq2yYSa7oHQM022ZMx3fkvh3V2Lv/p89G0HlYZjZYBV2DECmdXQwsZa
	 X6wQ1AfDJuWVtmbj1t5lfp/cWfQnk0naLLS16xaSh+gEP6eUEJWNoD9kcgt7mseAyP
	 Qsu664NXeqWnhrED9YI3X7IpA83TTnwjNqWeBOku4GiBX07OoaFG0SskKH8XioSlxm
	 V12ZXz+8EQXpuLBG0zPtQPb1CXmRV6xqouJQhfUdb5a6CRfeBcnZiw7T0gPgrUvuR3
	 l1oBWgEaIURVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD4A382332D;
	Mon, 12 Aug 2024 23:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] eth: fbnic: add basic stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172350362776.1161715.13586554397431969794.git-patchwork-notify@kernel.org>
Date: Mon, 12 Aug 2024 23:00:27 +0000
References: <20240810054322.2766421-1-kuba@kernel.org>
In-Reply-To: <20240810054322.2766421-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, alexanderduyck@fb.com, jdamato@fastly.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  9 Aug 2024 22:43:20 -0700 you wrote:
> Add basic interface stats to fbnic.
> 
> v3:
>  - add missing sync init
> v2:
>  - drop duplicate check
> v1: https://lore.kernel.org/20240807022631.1664327-1-kuba@kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] eth: fbnic: add basic rtnl stats
    https://git.kernel.org/netdev/net-next/c/45d84008ccbe
  - [net-next,v3,2/2] eth: fbnic: add support for basic qstats
    https://git.kernel.org/netdev/net-next/c/8be1bd91db71

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



