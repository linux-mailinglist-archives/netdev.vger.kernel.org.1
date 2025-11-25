Return-Path: <netdev+bounces-241515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BB9C84D1E
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 12:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C19A14E9C8C
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 11:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64728314A89;
	Tue, 25 Nov 2025 11:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXDggJ3M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD1025BEE8;
	Tue, 25 Nov 2025 11:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764071446; cv=none; b=Yiwhu3ljjhRJta/FQQbUS27ud9ZV3CRlpLlRP8HrDLJPKVgXPucXU6Gz+odODeIYcsp+/UwiqegPWb8fiiQQ/uVNFfu1jh9XuA4LFJFrDA/IuoqPdwVahWfqX4BJ0KiqCWUp6x14D4cea5IXALncmyb47INefvUzj4GGGdh88Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764071446; c=relaxed/simple;
	bh=+MolO2m1XEMRzvS1k0kRd1z7R3XZcU2FdgTToM3uLfQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z/F88zzKlt5NKCSLfvwKkpHWfeJThOIOCuaJDhCt8UEGMPdoQiO32wGTC0sj9xAVrEDWcru4AZ3zAG6YrEliFOVksB9HDhdKJUl7ZM7c/T1OtVPmVrs+FymBHwHStARQ8kmf4fmZbO6g+22FHKZchs4wTj3N+qUao1ueTlvqPZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXDggJ3M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA175C4CEF1;
	Tue, 25 Nov 2025 11:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764071445;
	bh=+MolO2m1XEMRzvS1k0kRd1z7R3XZcU2FdgTToM3uLfQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mXDggJ3MmVxhVN6rBTeR9pE+xZwQHKKB49+1MDZUU6ZSG1olH1Z8H1mpxozEexQjC
	 kprZ4A19Pgfrgfy+cP31uzmKwmI7CzQ+Bpzbn5TTF5+wIfZMyUBHEtvHFbLiXNnNZ0
	 jFEIHo+KzVUrBccK+H97jdkSOc9SoENxwE1JEiBcr8bxPFSoaaw7GGPsBtEE87BP4r
	 xu2Y/q6NnYIEltNfFjtteyPey6RfSDgQfFL8fKBvj+bd9x/CaN/W+xWiEFJPuzw/9X
	 D4EuXzx1UTxtqgDQK29E1w5LblK+uAQqKboJYmubT84uf4NrKLnD5wgffUiGhNYP4/
	 Oud1jf0bb9D3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E453A8D14E;
	Tue, 25 Nov 2025 11:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: mxl-gpy: fix link properties on USXGMII and
 internal PHYs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176407140826.699740.3396196205038468870.git-patchwork-notify@kernel.org>
Date: Tue, 25 Nov 2025 11:50:08 +0000
References: 
 <71fccf3f56742116eb18cc070d2a9810479ea7f9.1763650701.git.daniel@makrotopia.org>
In-Reply-To: 
 <71fccf3f56742116eb18cc070d2a9810479ea7f9.1763650701.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: lxu@maxlinear.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 20 Nov 2025 15:02:19 +0000 you wrote:
> gpy_update_interface() returns early in case the PHY is internal or
> connected via USXGMII. In this case the gigabit master/slave property
> as well as MDI/MDI-X status also won't be read which seems wrong.
> Always read those properties by moving the logic to retrieve them to
> gpy_read_status().
> 
> Fixes: fd8825cd8c6fc ("net: phy: mxl-gpy: Add PHY Auto/MDI/MDI-X set driver for GPY211 chips")
> Fixes: 311abcdddc00a ("net: phy: add support to get Master-Slave configuration")
> Suggested-by: "Russell King (Oracle)" <linux@armlinux.org.uk>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> 
> [...]

Here is the summary with links:
  - [net] net: phy: mxl-gpy: fix link properties on USXGMII and internal PHYs
    https://git.kernel.org/netdev/net/c/081156ce13f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



