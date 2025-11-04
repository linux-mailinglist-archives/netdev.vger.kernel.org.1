Return-Path: <netdev+bounces-235353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C4AC2F003
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 03:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49A683AF0DC
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 02:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0E923EAB3;
	Tue,  4 Nov 2025 02:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0iiV20t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC8D1F75A6
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 02:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762224035; cv=none; b=PktS/aC/rV8KfR29PeSAY1As6LYsopsT/xJKEPrYghLCI6CGWsleyyOwmcXiAJwnvZ1v4rfR4n1aRVlPsRcoe94go9WF76DeA0jOYGiJfIfPKPahkiBLmWBDANSJRq+lungJxGpRW2APWpBiHYtswqExTXs4F/1fCl2L72O6OEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762224035; c=relaxed/simple;
	bh=sHHdSFKglmLVQvxez6cnvzFc/P5IuWlTLM2FZkUSoN0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Gcgkjncci/ETb9EnJrlzP9IsNTVZ4DjobRaWLwbY+evadrN/2KYfxvPKkBJZueMDJzxmXKeuTmtMRgDSmv9p2zTSE92rpd9rJaKQUrQ0CuBo976SwPAjpMM4CO7LQWsKMBJI46ZXkDaE0lMNWQtm7jeHb1KF514F/vtaBY2v8o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0iiV20t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68294C4CEE7;
	Tue,  4 Nov 2025 02:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762224034;
	bh=sHHdSFKglmLVQvxez6cnvzFc/P5IuWlTLM2FZkUSoN0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z0iiV20tj9/TlmTwphX+Rn/zsaUQNYgXoIsCv1ZzZGPY8uC2OkYl41m0PRfZns8Gh
	 PsYs17CGbhG2Mwxf70ywcFYNGi/TKhk13Se5fSj5SCpaBLP4cmdl+tIp/x2af8tMAB
	 x4X3qbxSArE5Ty5Lil6ADpiRhIXJdx187jW5TyYnnCupLho0kdHZARy/4jiodnlUzh
	 /LP5sfSK497odfgFoHhfLRA86hsCBpEB/VkAtMXp5VLv3Bl1aZaJS7vKpx3CcwiYqB
	 eGtCVjmetcz57Fokv6K+92yZ1HoEnfCNLf+mNF00oSEnH8QmynCIHhssQd6F+xpoHV
	 MxNXNoUZjDgoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE553809A8D;
	Tue,  4 Nov 2025 02:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v10 0/2] Add support to do threaded napi busy
 poll
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176222400875.2301509.6000409126267991675.git-patchwork-notify@kernel.org>
Date: Tue, 04 Nov 2025 02:40:08 +0000
References: <20251028203007.575686-1-skhawaja@google.com>
In-Reply-To: <20251028203007.575686-1-skhawaja@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, almasrymina@google.com, willemb@google.com, joe@dama.to,
 mkarsten@uwaterloo.ca, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Oct 2025 20:30:04 +0000 you wrote:
> Extend the already existing support of threaded napi poll to do continuous
> busy polling.
> 
> This is used for doing continuous polling of napi to fetch descriptors
> from backing RX/TX queues for low latency applications. Allow enabling
> of threaded busypoll using netlink so this can be enabled on a set of
> dedicated napis for low latency applications.
> 
> [...]

Here is the summary with links:
  - [net-next,v10,1/2] net: Extend NAPI threaded polling to allow kthread based busy polling
    https://git.kernel.org/netdev/net-next/c/c18d4b190a46
  - [net-next,v10,2/2] selftests: Add napi threaded busy poll test in `busy_poller`
    https://git.kernel.org/netdev/net-next/c/add3c1324a89

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



