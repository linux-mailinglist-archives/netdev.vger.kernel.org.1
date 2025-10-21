Return-Path: <netdev+bounces-231041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B922BF4296
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 02:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9017D4E563D
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 00:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D5E20102B;
	Tue, 21 Oct 2025 00:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXMWxPUZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9083A1FC0EA
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 00:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761007252; cv=none; b=g3Z6FGG9Vj1e6LKvDI4v6DDKKdwtIT7YpXSEWrH4KWGevoMuQ1kt/cjS5fkNzNHTD5xISQ/JDzSI+ZJgidKP0VXQhYiYNvIjkpX97aBe3WtOvV7f4Ruts0k6oUaOz1fobCx7R+bhnFAtzdVbJn54rUlcKqOJCcd5RVgSgAGJEbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761007252; c=relaxed/simple;
	bh=ZqWea6XZm8LxpNEnbbKZyXqhWtkMarxkaURtMLCChBk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J4/m4j+bEQjypMdEZ345wjvFP7d6gM7fik0wvnWbGyU1WBBVYJsig9LpdHHl2QaFFUjnWEbiuwPu+f6G7x+iveSqWcXHSCm6yAWzBc90r2OX/jA3dSenewsJ+C+OY8jNiy2g0NqU9cHMsmHqbg/uAYIKnv+AjO2YHRyyUjkj80k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXMWxPUZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200FDC4CEFB;
	Tue, 21 Oct 2025 00:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761007252;
	bh=ZqWea6XZm8LxpNEnbbKZyXqhWtkMarxkaURtMLCChBk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WXMWxPUZwGhQTaRWiHQOz25dFzhuDpbf0NU3n9Kb9nZeNtTjmJmW9ZerslSHBr9z+
	 aKdQtt5GUacmqLxFll3suQYsRzK9Fzc7ztaQw2aUKQiphoeIWb/PGxCo9qAOoXezvf
	 nbx7WcilzFtz6Ve2fenomFDvcWrmUwRbXbY6o8/fQloJ9QlWN1IzUmRBk4Jsj/eevX
	 M3SMtQIbb7dVP4Q1Vr8999ZEfrd4zLVA//yIpRhsfzdoNYnVLvo51VnBXTcFJYsA8A
	 qqSrmWjeUj2QBomcbTBJjzdyMOO2nHDNHFRdAy0J4RvYZ5ml1F/T1kBgQ4Oevd3tJc
	 C6F2ohiuR2ExQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 343C23A4102D;
	Tue, 21 Oct 2025 00:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/7] convert net drivers to ndo_hwtstamp API
 part
 1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176100723376.470828.13115546758428194297.git-patchwork-notify@kernel.org>
Date: Tue, 21 Oct 2025 00:40:33 +0000
References: <20251016152515.3510991-1-vadim.fedorenko@linux.dev>
In-Reply-To: <20251016152515.3510991-1-vadim.fedorenko@linux.dev>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Shyam-sundar.S-k@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 epomozov@marvell.com, bharat@chelsio.com, dmichail@fungible.com,
 danishanwar@ti.com, rogerq@kernel.org, richardcochran@gmail.com,
 linux@armlinux.org.uk, vladimir.oltean@nxp.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Oct 2025 15:25:08 +0000 you wrote:
> This is part 1 of patchset to convert drivers which support HW
> timestamping to use .ndo_hwtstamp_get()/.ndo_hwtstamp_set() callbacks.
> The new API uses netlink to communicate with user-space and have some
> test coverage. Part 2 will contain another 6 patches from v1 of the
> series.
> There are some drivers left with old ioctl interface after this series:
> - mlx5 driver be shortly converted by nVidia folks
> - TI netcp ethss driver which needs separate series which I'll post
>   after this one.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/7] net: ti: am65-cpsw: move hw timestamping to ndo callback
    https://git.kernel.org/netdev/net-next/c/ed5d5928bd54
  - [net-next,v3,2/7] ti: icssg: convert to ndo_hwtstamp API
    https://git.kernel.org/netdev/net-next/c/b8fa98ea4a22
  - [net-next,v3,3/7] amd-xgbe: convert to ndo_hwtstamp callbacks
    https://git.kernel.org/netdev/net-next/c/149cfae71166
  - [net-next,v3,4/7] net: atlantic: convert to ndo_hwtstamp API
    https://git.kernel.org/netdev/net-next/c/8a15a84e80dc
  - [net-next,v3,5/7] cxgb4: convert to ndo_hwtstamp API
    https://git.kernel.org/netdev/net-next/c/a6a64bb4115f
  - [net-next,v3,6/7] tsnep: convert to ndo_hwtstatmp API
    https://git.kernel.org/netdev/net-next/c/d8db98db0d46
  - [net-next,v3,7/7] funeth: convert to ndo_hwtstamp API
    https://git.kernel.org/netdev/net-next/c/dc34040654e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



