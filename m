Return-Path: <netdev+bounces-102225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11122902010
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 13:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B18C287050
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 11:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FC739FF3;
	Mon, 10 Jun 2024 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPTxRqG7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66CACA62
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718017232; cv=none; b=VeapWA4l75RkczDaK7C4MNCTDM7sdvda+cwLu0opXkCSq33kqz0sfrMIf/yM9Cnikf4amcOu7lW0ocdyXntV55yFznu0PcftM4BYErXpHtgY5RJDZJYoxOH+ROZ9QW/oa9VJPESF3S726ck26br3DQ3FQhJa7N10F7AJ5xECrfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718017232; c=relaxed/simple;
	bh=AtgMHB08xkSAsAKOyZc3CzNPiL4dDw73fmEmBgvP58w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oHomzPwvxGJmGCtHjngGdUDnxc7TkS3HEputPaEmyB8AF+023KdzpNfWOrL8SmebE4SHUOi46KgcIzcNTh7OGuAuNZjs7hQRkEbdmbgZkoNIb5RiTMTw4/dAMkf8IYDTNRaSxHAk8ijj8MUznh9PqbJ5vfsTQFgUG9GZsA0js8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPTxRqG7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10C90C4AF1A;
	Mon, 10 Jun 2024 11:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718017231;
	bh=AtgMHB08xkSAsAKOyZc3CzNPiL4dDw73fmEmBgvP58w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gPTxRqG72V5b61FtJ/2LgQuWQPVuyDrTB1w1YQrEz6YasoFqDVbFlTEGeirf7mWVW
	 NZYPY1YAF/Czlm8qVpg64JstkDk9a9tY4mYrbqrwYNTqwiFKGN9Eab1m87EfctwOuo
	 UPjaQRnFjzGUnY5X+cWAnUBsEvxwWHiE4sGVwjRNwBGcwGkMJ3jAVzn4eSwohD/Yok
	 a42GfOVB8Y0PZuHM1OcVgFGJk5T5z9zw5KPDw0XgeV5b5iYxghSwbRm/4sdroN2jvH
	 z38/C5iJkyKTAb6V2hwkTWaED+6eEf2DRVolfRMGFMDQki+3cxywk8NnCs5b0Xs8Pv
	 MxxX3mfsStECw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F373FE7B60A;
	Mon, 10 Jun 2024 11:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netdevsim: fix backwards compatibility in
 nsim_get_iflink()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171801723099.20490.11750490638512111843.git-patchwork-notify@kernel.org>
Date: Mon, 10 Jun 2024 11:00:30 +0000
References: <20240606145908.720741-1-dw@davidwei.uk>
In-Reply-To: <20240606145908.720741-1-dw@davidwei.uk>
To: David Wei <dw@davidwei.uk>
Cc: watanabe.yu@gmail.com, netdev@vger.kernel.org, maciek@machnikowski.net,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  6 Jun 2024 07:59:08 -0700 you wrote:
> The default ndo_get_iflink() implementation returns the current ifindex
> of the netdev. But the overridden nsim_get_iflink() returns 0 if the
> current nsim is not linked, breaking backwards compatibility for
> userspace that depend on this behaviour.
> 
> Fix the problem by returning the current ifindex if not linked to a
> peer.
> 
> [...]

Here is the summary with links:
  - [net] netdevsim: fix backwards compatibility in nsim_get_iflink()
    https://git.kernel.org/netdev/net/c/5add2f728846

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



