Return-Path: <netdev+bounces-224781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81689B89FC5
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 16:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875A73B5C34
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 14:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6D33164BD;
	Fri, 19 Sep 2025 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5N37Xzh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521D6314B70;
	Fri, 19 Sep 2025 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758292224; cv=none; b=j0o17/H2ZjaxGr/IddBCs+pKSGLM8oMW8u+wgbF9wgmlma6wRABDMAiazdkGll6cgcHQF63jqXlT08BAjaprp56WebNN046cU2gYrBciAzA5ndYXeQqtlOXJaGjLauMPSN1knsx42ljnbkN11qdZcJxxcazF7zb+FPmr2iPFpmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758292224; c=relaxed/simple;
	bh=9jnMOdrjgatuoKYIL/8vKkBJZet0KQ1s5vSx3987tZM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AP0vfsIdJle/CrE62OiBlBTio6HEvuaGvfOAa8MPYrL+tqF3IGSqmfHWhQ/nemnM/05AYYqnK7sUY0+yPvA0TNo9d4nVKSaf7EhKrFjSFOQVXY1OqLwdV8edO6g4GxKC/zQUzRdLgjNMTxbjngdl1/WNytPAoyoRkbOOw01C3Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5N37Xzh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFB9C4CEF0;
	Fri, 19 Sep 2025 14:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758292223;
	bh=9jnMOdrjgatuoKYIL/8vKkBJZet0KQ1s5vSx3987tZM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s5N37XzhyaHtRTL8qlGgpsai0QuLVTzq18YU0DTnM/blSyfpLx0lR1R1pOZHwXMGR
	 Z7CpqnxsBMTiuJfGFNAcr3WcbfEkG+ecI/ZLV5Uo5fSO5JWwxwdQagf3x0DzvT1a27
	 47kDAG7pixoxMOJemL3nkPk1KR9qEPy98sZhJGx6MSEU5aGE6pAJTgakQjPiFnSItp
	 g11lvv0jQVgX4C+3oQ0KckNU95Ii8Dvunqycs+nhgJzn9oI9BckcGsNBuaLpwmwLSN
	 lgO5E381H7mdoYOnPh4cw5s0qY+MtiDq4iFDvNbr3JXadbcfz5DrbmXefjt4R48vld
	 osvkGFycH51Zw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DDC39D0C20;
	Fri, 19 Sep 2025 14:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] r8169: set EEE speed down ratio to 1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175829222324.3219626.3424279690978099587.git-patchwork-notify@kernel.org>
Date: Fri, 19 Sep 2025 14:30:23 +0000
References: <20250918023425.3463-1-hau@realtek.com>
In-Reply-To: <20250918023425.3463-1-hau@realtek.com>
To: ChunHao Lin <hau@realtek.com>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Sep 2025 10:34:25 +0800 you wrote:
> EEE speed down means speed down MAC MCU clock. It is not from spec.
> It is kind of Realtek specific power saving feature. But enable it
> may cause some issues, like packet drop or interrupt loss. Different
> hardware may have different issues.
> 
> EEE speed down ratio (mac ocp 0xe056[7:4]) is used to set EEE speed
> down rate. The larger this value is, the more power can save. But it
> actually save less power then we expected. And, as mentioned above,
> will impact compatibility. So set it to 1 (mac ocp 0xe056[7:4] = 0)
> , which means not to speed down, to improve compatibility.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] r8169: set EEE speed down ratio to 1
    https://git.kernel.org/netdev/net-next/c/bf7154ffb1c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



