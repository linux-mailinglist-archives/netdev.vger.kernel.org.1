Return-Path: <netdev+bounces-186596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84253A9FD64
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 01:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A79C15A7C7F
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 23:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB2221577A;
	Mon, 28 Apr 2025 23:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K40faaYt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E360215764;
	Mon, 28 Apr 2025 23:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745881205; cv=none; b=LgRDyDeUyj5qhNC0fMCEYh9MSO3jjHEW2pPRqi9eVGHCd3bCaQdvfmSqBc6szy8YvuyV8yZx/9zfY9BCl3ItaJEqDgATj//X4jHCw07YcdaN1LEXIJOqp4UlXORFbCqpdPkXBs+7lPu945VjfyZvyMWqDglG6hGVDsrp0sgNGP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745881205; c=relaxed/simple;
	bh=m/TUezcl5CvUNs3SVqx2d/Cl7oo/VxLk4B3Ff2SZe/0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BzYXTR4CQiGHCNziDxiKvE4Xe4EGopnOOp4eEVa4UpTqP0RzDqNMfAaXqhfPzTxcUP1UoRrc/3O2ls9fl2GyYwd2yTwSmSOyEg6fXh8h+QxNO0kqLhDcI/4iKaoMoMuMgoIqETDYkODX9D2O5M8MIhyqBFfW6kkt5OmSCfcm9Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K40faaYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58BF1C4CEEE;
	Mon, 28 Apr 2025 23:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745881205;
	bh=m/TUezcl5CvUNs3SVqx2d/Cl7oo/VxLk4B3Ff2SZe/0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K40faaYtXnjhaKA97MplQyUqCTP5tlOucQmHxb7MJgx4cUQGrMtFxDxfaIcGPDzFC
	 lmYW9A8QxridKdN45QID49VXMarYgut3h8sapR49REpiSkelwyVG11yEPBS/8UFzzX
	 HEtBvM7syShp85Mq6CCcLLo5+TUJPU08skY92nGjQVeYgtqk0Raxx2cYdOf9vPtVXk
	 PhBZWVc3rPD2RU//f8xPRZmAHmhsigFnZ4XN2kLl8AP/A+8IJntzcjrzTYSE0TE290
	 D0AOQ+KvFY+lwqJvdYuihL65EPLf6yLiHbxxjY0gjkt1PXFGnK36aB8liQDjJ8lfu4
	 tvpd8GRRa6Yag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E853822D43;
	Mon, 28 Apr 2025 23:00:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-04-25
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174588124424.1071900.523000305063322904.git-patchwork-notify@kernel.org>
Date: Mon, 28 Apr 2025 23:00:44 +0000
References: <20250425192412.1578759-1-luiz.dentz@gmail.com>
In-Reply-To: <20250425192412.1578759-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Apr 2025 15:24:12 -0400 you wrote:
> The following changes since commit 49ba1ca2e0cc6d2eb0667172f1144c8b85907971:
> 
>   Merge branch 'mlx5-misc-fixes-2025-04-23' (2025-04-24 18:20:00 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-04-25
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-04-25
    https://git.kernel.org/netdev/net/c/a54b2e2d40b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



