Return-Path: <netdev+bounces-135021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C190699BDDF
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 04:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 643731F23CB8
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 02:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC24450F2;
	Mon, 14 Oct 2024 02:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eN0zs3UL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D09231C98;
	Mon, 14 Oct 2024 02:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728873643; cv=none; b=U6j8D6XMKlJi/Xxr6FHKMsR1O8GxDz+ntS68n8JvyowchsApp7ts3OtYifqy4pChjjoa1ELhKExrHrs8KBx8uJ1cmQwdFV/wB+wXJg0C5vw7m6jvXCDcQHgEZvwpsQBHHQSeri6aKEacYPZVHZ/0+nLapbvES//JO7VcnSEjccc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728873643; c=relaxed/simple;
	bh=t3kb3sk3nqXksOWZLn1m/EtCh5AmbMgfAQEMRKM1ZRI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ANWYP4yfQHR1OVrtS1wT55vG+5zNBn2abSclUwcHN607QHqlrYdYxddJhGMl6+LwzpEyzGBw1eKEiVhpiv1KAbwBqntIFgE9bKAq/9yQ/BvuUeN9Pfra0ie+JAv4LXmn03NFxJa6fsD0mmei2jDpXC38Q2ii1kh3avSXONDQAgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eN0zs3UL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CB5C4CEC5;
	Mon, 14 Oct 2024 02:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728873642;
	bh=t3kb3sk3nqXksOWZLn1m/EtCh5AmbMgfAQEMRKM1ZRI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eN0zs3UL9eRaqhRbmdwyhzx/ttdYM0zrJxkW3sPjblMLsAyDXb3SkCITlfm3/ihxa
	 5zK0iJLinjNx60SVgQAZuf7/EEH4eG6OkEb9SMUBbbKYz3vqX9AusGkPKz3dpSwwXo
	 oqqDwIFPzGaK852yFdmsDshH7TZ4SC5+6XcneIXuChyjXUJ0NAnc6yfBt/+dw0EGIi
	 3tlfsVjDppKC6Ish+xsLG/tytM4zoeSHzsvHVyK+Heoz/lKxNbqAMbpiQQD27qfaX8
	 wp5r8OytSWVZqb8M4aFkkYys8ytTM5p/0e87lI/rbAN3pdhsYXRCJjiWCv8qCengDB
	 4icx3XxsFlPbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF0238111D2;
	Mon, 14 Oct 2024 02:40:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/2] ethtool: Add support for writing firmware
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172887364748.3904732.16162419800738341582.git-patchwork-notify@kernel.org>
Date: Mon, 14 Oct 2024 02:40:47 +0000
References: <20241009105347.2863905-1-danieller@nvidia.com>
In-Reply-To: <20241009105347.2863905-1-danieller@nvidia.com>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, yuehaibing@huawei.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, petrm@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 9 Oct 2024 13:53:45 +0300 you wrote:
> In the CMIS specification for pluggable modules, LPL (Local Payload) and
> EPL (Extended Payload) are two types of data payloads used for managing
> various functions and features of the module.
> 
> EPL payloads are used for more complex and extensive management functions
> that require a larger amount of data, so writing firmware blocks using EPL
> is much more efficient.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] net: ethtool: Add new parameters and a function to support EPL
    https://git.kernel.org/netdev/net-next/c/edc344568922
  - [net-next,v5,2/2] net: ethtool: Add support for writing firmware blocks using EPL payload
    https://git.kernel.org/netdev/net-next/c/9a3b0d078bd8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



