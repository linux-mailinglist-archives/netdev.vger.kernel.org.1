Return-Path: <netdev+bounces-148927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A359E3827
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 12:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26E4BB22041
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 10:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204D018BC1D;
	Wed,  4 Dec 2024 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TODlm8Se"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0E52B9B7
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 10:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733308816; cv=none; b=bAAUqRDmm5u+XhEM+1P2P6Q5Ud36y4amQ4N4xwxAbcTPaiUfixulFFnTtydKPCx7If5LJovHSFoFEkD/ZS5Nb6FT4Whwu4YkwOrv+2wwLTo/swwRtHKtTasFJG63ZVrwuhIpMj+I9LlphRtEWs5dreTdrpim8C1aJKvJrZF+83M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733308816; c=relaxed/simple;
	bh=IH6x/Ashz/3/4hrEeoQURFBiDCK5dDXaciFW88Mt1l0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K1GD0bW4GvRsGCBDAxIfR5YK64pHVolpSW6Fnd0chyPT/q0D2jWo0T/1niAsrW/LnJsuCf26YgS2GNObTKxIZhEx/jh4bTqyjMH9wBZTvmy8Mlmv9V/AAsmyzhkR19ZleRTIuf6wZr0LuhjP14sSSP/wJKpWGlBzpFDCUBAaunY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TODlm8Se; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8079BC4CED1;
	Wed,  4 Dec 2024 10:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733308815;
	bh=IH6x/Ashz/3/4hrEeoQURFBiDCK5dDXaciFW88Mt1l0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TODlm8SesOF+4DRMsvj8dGEA19d2u1rylEltxpGUTb8EKLTXWSyuZnz8XEzwCuKFx
	 lL1Wc/U7MU9g+siGZTFwxjGgFz4ITf+kWvOOtPxouwDDeOiImhwLobc62tAyf/LUP/
	 7voUGZhJeCrGaVSGjmHuvsFaYGEiHTp/iM+KwYHiSpFcTyQvvZgN+++J7cOMiV8Lp4
	 gh+B2X4F6suaiavbD5k9CsOVfrJHR3nyS2tTiQSYcZBVxOwmVWyaQjBis9jPGrKv0p
	 memJ9JthSBZyw+hRjZA9T1CI2pwhY+H0zZ3wJ8gzWigDWm02cLTWrnZA07NKqDOEPz
	 JyfRBXfjjnmjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341373806656;
	Wed,  4 Dec 2024 10:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net] net: sched: fix erspan_opt settings in cls_flower
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173330883002.827781.13150735276256077279.git-patchwork-notify@kernel.org>
Date: Wed, 04 Dec 2024 10:40:30 +0000
References: <981381d3d1aaa4f81619145180e06338af487a42.1733152898.git.lucien.xin@gmail.com>
In-Reply-To: <981381d3d1aaa4f81619145180e06338af487a42.1733152898.git.lucien.xin@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, dcaratti@redhat.com,
 horms@kernel.org, shuali@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  2 Dec 2024 10:21:38 -0500 you wrote:
> When matching erspan_opt in cls_flower, only the (version, dir, hwid)
> fields are relevant. However, in fl_set_erspan_opt() it initializes
> all bits of erspan_opt and its mask to 1. This inadvertently requires
> packets to match not only the (version, dir, hwid) fields but also the
> other fields that are unexpectedly set to 1.
> 
> This patch resolves the issue by ensuring that only the (version, dir,
> hwid) fields are configured in fl_set_erspan_opt(), leaving the other
> fields to 0 in erspan_opt.
> 
> [...]

Here is the summary with links:
  - [PATCHv2,net] net: sched: fix erspan_opt settings in cls_flower
    https://git.kernel.org/netdev/net/c/292207809486

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



