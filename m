Return-Path: <netdev+bounces-211846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCECB1BE16
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 02:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6909D622E89
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 00:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D165BAF0;
	Wed,  6 Aug 2025 00:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuLkg7np"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B21CAD2C
	for <netdev@vger.kernel.org>; Wed,  6 Aug 2025 00:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754441993; cv=none; b=enqz7G7MzqK6h9C6ADgjKVkW+HXaN6BsCUB7PSuLqwjw+Fw4S7/FDXATXfN9uLwKGutF7MqehgauGKpx9CpXML0pZwyCR45SgIzN0WmsbKd9bEbWRnQNAoON4LTOys+ncgZ6h2LFb5abi3nS/VT3ZI443npKzP6bcNCZYXPrTi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754441993; c=relaxed/simple;
	bh=orXbHGnYJJzFGVVB1bOOaoY0wN+J6eBDbS8ZRzTYHPY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Gqkhp/sVNCN1HBU6n1Q8PuhSEkiENFk00MgmG1U1abwvv7/2dE3EyfiV0OvDxh9aLiUwxmzZYVge7BnHnV9WVz65r09fR+I0z5/OMP7hY75Okw35N2msMk+6xUb51KLvKT7zJ0Gl4az8Lob4mAnjnOEoX5rwlRgeQJZIbiSeTB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuLkg7np; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36A1C4CEF0;
	Wed,  6 Aug 2025 00:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754441992;
	bh=orXbHGnYJJzFGVVB1bOOaoY0wN+J6eBDbS8ZRzTYHPY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WuLkg7npJ3CKtk4z55lQ8qlsun9OROv6w6+XBlNZ7WG4j9hCvFlmO9BrkEaHepFD8
	 BoFm7dDbfnrZMgpTMldr1bwDjIos6XbngwrSXOsn7nqqIL/k3nEEuJfGE2mdWiUm3W
	 wAzai3V62z3P0z+iM9I5conLtzgEbQrkgrNCthXJyt2M/eCAnL4Fc2hMV2eM/W283G
	 M+Z7n1JhrEgzRtNzdnzq8RXTcZEoNDjQcsadFuqddVpqC++jURrdKN0pXJDABXGRFz
	 remEemu80Z3pnlNMneP1gJeyQvtH09rTKQzHOtwaWpkJ0RJRN2Qsf3BPBlPfbg9eji
	 w/AIHN0JxP9nQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE8F383BF63;
	Wed,  6 Aug 2025 01:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: Update threaded state in napi config in
 netif_set_threaded
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175444200676.2225004.6755140210461026267.git-patchwork-notify@kernel.org>
Date: Wed, 06 Aug 2025 01:00:06 +0000
References: <20250804164457.2494390-1-skhawaja@google.com>
In-Reply-To: <20250804164457.2494390-1-skhawaja@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, willemb@google.com, almasrymina@google.com,
 netdev@vger.kernel.org, joe@dama.to

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  4 Aug 2025 16:44:57 +0000 you wrote:
> Commit 2677010e7793 ("Add support to set NAPI threaded for individual
> NAPI") added support to enable/disable threaded napi using netlink. This
> also extended the napi config save/restore functionality to set the napi
> threaded state. This breaks netdev reset for drivers that use napi
> threaded at device level and also use napi config save/restore on
> napi_disable/napi_enable. Basically on netdev with napi threaded enabled
> at device level, a napi_enable call will get stuck trying to stop the
> napi kthread. This is because the napi->config->threaded is set to
> disabled when threaded is enabled at device level.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: Update threaded state in napi config in netif_set_threaded
    https://git.kernel.org/netdev/net/c/e6d76268813d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



