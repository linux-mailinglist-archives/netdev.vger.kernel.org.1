Return-Path: <netdev+bounces-124712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F35BE96A818
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 22:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA52B1F24FF8
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 20:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672D31D589B;
	Tue,  3 Sep 2024 20:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKWRIBUY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0121D5893;
	Tue,  3 Sep 2024 20:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725394232; cv=none; b=X/3CY/9sjAsKVlFbrcZCzll4ORn9iF1gsJXPTB44GiNghYPIaw2dTA2dd7dek26BbEC8dLF7ehBlvLOX6HKGA7oDu4w6udppPwl1NgCTTK03f8KH6qlhkG+xv48lLBsjpdjyMPvFLj7bugBvtPPkCeUVwPdnOPiDNt5p/4901J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725394232; c=relaxed/simple;
	bh=uSp9Jl69b3k+/8tAfKbpey3QNlpf8nfEJ4foPHjBdVk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PKWQZXufhxgseDO77Prm7Rutng6Dq/0OazNCZjfTgrysaEHZdnQkvvrz2r1IBT46IQzlsX1XzCWu9Z8sg44i6aXIZYxxF+yXBfyIPusSlEMD1E463jt5CPeBR4EpAdcIrqovRWqeuadtzGnAkwLHINTrGbjGDq5JqRiZgas2Ukk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKWRIBUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD902C4AF09;
	Tue,  3 Sep 2024 20:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725394230;
	bh=uSp9Jl69b3k+/8tAfKbpey3QNlpf8nfEJ4foPHjBdVk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FKWRIBUYhwBlKvJ48wmhU43A3o6UX8g1aMKZzLQUokNU2iepTD74LVjwt9gVxJo12
	 X0Yx85NWNcx3NCVuFQu/+q0ghhMGEs+ybsaR4mAe+SJGiGEDSUn//HCeGlDhdh5q4Z
	 nWykIPZgBD0umGLhkyM4N1IY03+c/maJu2XeCig1zqmCE8xOULI8QAPVsz7mj4Uxj+
	 Donk5dm5v3hAzm+hKntSmBW/01vZPk7/PPjJwBR2UUjg+qpWGago5Xc0HAG/5QaLhz
	 Sjh51zBHsaW3UG4TTyypurGPCVNUEi9HK65ZFSXtg1C3PJXkDjB1tJ1mwvg9I8BFbc
	 cRbw7CQC+J93g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDEE3805D82;
	Tue,  3 Sep 2024 20:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dqs: Do not use extern for unused dql_group
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172539423136.426047.3291554079738014106.git-patchwork-notify@kernel.org>
Date: Tue, 03 Sep 2024 20:10:31 +0000
References: <20240902101734.3260455-1-leitao@debian.org>
In-Reply-To: <20240902101734.3260455-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, leit@meta.com, lkp@intel.com, johannes.berg@intel.com,
 jamie.bainbridge@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Sep 2024 03:17:30 -0700 you wrote:
> When CONFIG_DQL is not enabled, dql_group should be treated as a dead
> declaration. However, its current extern declaration assumes the linker
> will ignore it, which is generally true across most compiler and
> architecture combinations.
> 
> But in certain cases, the linker still attempts to resolve the extern
> struct, even when the associated code is dead, resulting in a linking
> error. For instance the following error in loongarch64:
> 
> [...]

Here is the summary with links:
  - [net] net: dqs: Do not use extern for unused dql_group
    https://git.kernel.org/netdev/net/c/77461c108191

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



