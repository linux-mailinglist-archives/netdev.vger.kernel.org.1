Return-Path: <netdev+bounces-196341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7132AD44F8
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 23:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB30717673B
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 21:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FE426980D;
	Tue, 10 Jun 2025 21:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/2kXy8w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EDD245007;
	Tue, 10 Jun 2025 21:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749592199; cv=none; b=UnDqZUMDMYRP2GW6IBgpiDBNF27JF5Pu7KMnH4soItdIfJGqXbv31L3aF0VTCFw+n+y5Sqam5vJxYHsu5N1vC9qJdMcfxXthcWwcbcYxcfTpFV/cqq9NV/lNbuQF0dSeRlKfslk5mehP7ZuJPAQHE50iNSQaYkxcfaNa4Fyuai4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749592199; c=relaxed/simple;
	bh=3v3KDffzGVIHhQCWFOO/7kXK7VpNLiWoC7TKe7D8+ZA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n4wD/lunirSxQWx+Pm65aoy7M0zY1TQZHwauC9rx4SDoSp40ZLYAjqpvTJUQDjoFWpSuapvLjZBc+Vr1iC/vLBt9TRJbKDzdeqJaG5nRJv9imERxB338z26Ochxt5+7tUbEhIiusQUvkwrskBer6JyZdk/RkGsv7/ATOD5ZF6QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/2kXy8w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F73FC4CEED;
	Tue, 10 Jun 2025 21:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749592198;
	bh=3v3KDffzGVIHhQCWFOO/7kXK7VpNLiWoC7TKe7D8+ZA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J/2kXy8wfSc5VREM5/rp6OlcwFkpNwr35MByowjDjJImTKIhiu6sHp4oJv1zM/gWG
	 ldOegAUosq8s1V7DLTguiFCilktgfZ9Lwhm5uZMrzO4fUTJc9xjPIHDh0Ib0D2ImbN
	 fw0lrqhHBXoRvNwY03mrvywhzMEI3s4kHdMgee6fCLp5Bs2QsiK4EviK2UwxuEoFig
	 8cDLqozqYmjFKfUiIPZ22LhBrxhtb3dr48faWOhYWJ4Tpbc5FF1+3HZJ5V6IU3yEq3
	 toitefVVrF2tSFc1h248UF5p6780T9stRESefiYh0K4253VpO12pkaksUCoG29OYcP
	 C78mtbtoGaJUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D8538111E3;
	Tue, 10 Jun 2025 21:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: usb: r8152: Add device ID for TP-Link UE200
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174959222900.2621984.6053351569462412932.git-patchwork-notify@kernel.org>
Date: Tue, 10 Jun 2025 21:50:29 +0000
References: <20250609145536.26648-1-lucsansag@gmail.com>
In-Reply-To: <20250609145536.26648-1-lucsansag@gmail.com>
To: Lucas Sanchez Sagrado <lucsansag@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Jun 2025 16:55:36 +0200 you wrote:
> The TP-Link UE200 is a RTL8152B based USB 2.0 Fast Ethernet adapter. This
> patch adds its device ID. It has been tested on Ubuntu 22.04.5.
> 
> Signed-off-by: Lucas Sanchez Sagrado <lucsansag@gmail.com>
> ---
>  drivers/net/usb/r8152.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> [...]

Here is the summary with links:
  - [net-next] net: usb: r8152: Add device ID for TP-Link UE200
    https://git.kernel.org/netdev/net/c/dc9c67820f81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



