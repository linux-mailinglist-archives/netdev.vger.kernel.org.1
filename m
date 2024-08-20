Return-Path: <netdev+bounces-119965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5410957AF6
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 03:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B40E1C22D98
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 01:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABD912E71;
	Tue, 20 Aug 2024 01:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObOkGFwc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B494679C4;
	Tue, 20 Aug 2024 01:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724117428; cv=none; b=mMfZyt6mXniRXDwUFP9e40C7KQvgZBmt6/g1WXXjVx81kl8kmSOowNZUhKekgPnP7QE/MBFBdpqT0q9RYjLYtmSUqZPah33t8KkS7tsMiYc2qLFxLSL+a63HfCWwbCKKSilki0eDfUe2+YFXUwR6KXxhw+AydVZ1TSv9dlFcz/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724117428; c=relaxed/simple;
	bh=oQuUV3THMZ1qX75oMqGoP2cWZsyeeE5HQMLtTqsSvqs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IWtP9OBGTIur3xT+taCaLaei1opKy3LBqiDjrusFayPG4n3aLEtNX6RAbFAMtMZTSsjzUwFhNHEgqRwgs4UHt/n2AmIdFECwY0pw7j62C69qqhxTZGtoIIkoU9RfxzzVvkuylGjD5ObvfP2ZuggZzqCRtw1nTnExxLtMKnH0ZtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObOkGFwc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8F2C32782;
	Tue, 20 Aug 2024 01:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724117428;
	bh=oQuUV3THMZ1qX75oMqGoP2cWZsyeeE5HQMLtTqsSvqs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ObOkGFwc78I/knQrwt3ubTQFHeOiLEfFkY/Sgb1rAc8uHCs/MStSchyM2MUQUQDJc
	 lPyDhNyy7ToK18+8uPlVraIu4ISurqxpJpdlutyzJf/s8csbfMCkxirQsIVw26Hya8
	 4Ksc385JZBJ77uu1g2op9DG5oW7PzupyEtJHAEklSX5iWoIpIIeadCGJyPSEs7hMPr
	 q8KnQakw2i30oEU13brREF95lDpV9eVbSt90OFEAJB9aJo+JUYIO2QkMfl7eJ0NkqX
	 3FwnL98fXLRBFSHEJnlinpPdydLcP3MJIdxQDh1Qenv1tbsRY0Bqw2plg7xW9WBOiA
	 lvv4OISaZwXdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF523823271;
	Tue, 20 Aug 2024 01:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: remove redundant check in skb_shift()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172411742777.703463.16217334147635045125.git-patchwork-notify@kernel.org>
Date: Tue, 20 Aug 2024 01:30:27 +0000
References: <1723730983-22912-1-git-send-email-zhangchangzhong@huawei.com>
In-Reply-To: <1723730983-22912-1-git-send-email-zhangchangzhong@huawei.com>
To: Zhang Changzhong <zhangchangzhong@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Aug 2024 22:09:42 +0800 you wrote:
> The check for '!to' is redundant here, since skb_can_coalesce() already
> contains this check.
> 
> Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
> ---
>  net/core/skbuff.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] net: remove redundant check in skb_shift()
    https://git.kernel.org/netdev/net-next/c/dca9d62a0d76

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



