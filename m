Return-Path: <netdev+bounces-98352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD558D10B0
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 02:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6EC71F21E29
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 00:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F0651012;
	Tue, 28 May 2024 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYBHfA7T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B8417BCE
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716854430; cv=none; b=VNm64DZ4HsBW0E5P90l4qlSR0dUX8LhWPDFbbDuNmeTfyg1sT+eyM3aMColsD3+NDgJcq2sPk/RXNNGQKdUIyvwJ3YdSli4meAEOknV22bNV86bDK3o/31XPtgKEwLg7+xtPqvBaUarhqsWE4NmEJ+0JmpLWIuzXqdkNdSGMyR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716854430; c=relaxed/simple;
	bh=TU82ZgSwIYNOvNzR3iY6WvatwR78QmNNNms5L0f0eBk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JVXPeUcijh1Gr+EeihNJNdWm8ghE8xJPsvFNJOyj7AVL8iHtk7yIaWRmVA4fmAfnt2Wj9Vo55FUzXHDMLlRXD8Ib+B4/XB5khG2LAjodDzPE7EJ0zOsi2LT9fBPeJ4GsVH7t8bMB21CJMgLwIU1oZV2PAXe6KcrZcjNKmVU8PZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYBHfA7T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B55AC32782;
	Tue, 28 May 2024 00:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716854430;
	bh=TU82ZgSwIYNOvNzR3iY6WvatwR78QmNNNms5L0f0eBk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RYBHfA7TX1J9egIY7jWN0Y3fl/7UtcU2NbA3w4FrbPFkrF/GzPQbhXQ3utnj4a/+w
	 RWuNbZRycNmfA7z+IYmHYZASHL8t0/xehwFz/Kc1c+c+Y/tli8Lxk3YHeWRLEIdStS
	 vrs9cru6pWwqHmbpSUnQc8l8WzKiizw9TMATJzKiFf58vMQs/QlyoKG2oYoeO7eDOw
	 6wbOfK3czfIs9NG7p7tzCa84Qh5S6jtG4+SNPTs9AY9/KV8b5N9V/0+yfrjW+I8qUO
	 e+Pujy2Qf+trCQVrpUKkY5wrvc0WnNpRkRCn5UFYTDre12T6ifkoBs2089L8Xf34DX
	 NRPgN+VWEbFdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A14FD40197;
	Tue, 28 May 2024 00:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv4: Fix address dump when IPv4 is disabled on an
 interface
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171685443023.27081.9157334317658337325.git-patchwork-notify@kernel.org>
Date: Tue, 28 May 2024 00:00:30 +0000
References: <20240523110257.334315-1-idosch@nvidia.com>
In-Reply-To: <20240523110257.334315-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org, petrm@nvidia.com,
 cjubran@nvidia.com, ysafadi@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 May 2024 14:02:57 +0300 you wrote:
> Cited commit started returning an error when user space requests to dump
> the interface's IPv4 addresses and IPv4 is disabled on the interface.
> Restore the previous behavior and do not return an error.
> 
> Before cited commit:
> 
>  # ip address show dev dummy1
>  10: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
>      link/ether e2:40:68:98:d0:18 brd ff:ff:ff:ff:ff:ff
>      inet6 fe80::e040:68ff:fe98:d018/64 scope link proto kernel_ll
>         valid_lft forever preferred_lft forever
>  # ip link set dev dummy1 mtu 67
>  # ip address show dev dummy1
>  10: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 67 qdisc noqueue state UNKNOWN group default qlen 1000
>      link/ether e2:40:68:98:d0:18 brd ff:ff:ff:ff:ff:ff
> 
> [...]

Here is the summary with links:
  - [net] ipv4: Fix address dump when IPv4 is disabled on an interface
    https://git.kernel.org/netdev/net/c/7b05ab85e28f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



