Return-Path: <netdev+bounces-115854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A213948176
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 20:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE83D1F23825
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 18:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DDA15F30D;
	Mon,  5 Aug 2024 18:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrQonOsT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE7F15C158;
	Mon,  5 Aug 2024 18:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722881787; cv=none; b=hLZGGfA2PkrdDh+r8fLf6e0x/nCSNsd7ys44V21fsOsTq+8mQSpo5IrHaWHFd/s8zKbrVHccoU74WBPgBs4IdYYmneCNdyjlVYDLLFKpphjSLAlak+8V/txb28U7gv7/VO+wlgHoJzv2hxQDZIfp4CME1zYv/NobzihHtk+MeAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722881787; c=relaxed/simple;
	bh=eJUoHerdZjeqiT5fk5bXf0bsRyEZVEMsVnnFAfWle5w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LNEvXkkpNA7t/EJ00elt1Hp9TZlEn1mWApmcSrpheB+Uc2wHR3X/JBs96qi7TK6dULP0nPxVzTds/reim6bMiPCfsnDpid4nPdGb77fbwzr6RF6zzMj+TB8qUpW2yV1Yd+8n5IOmCV2rJFL/SlGKALxXyD6fSIj//ugVrBlSx7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrQonOsT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A0A0C4AF12;
	Mon,  5 Aug 2024 18:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722881787;
	bh=eJUoHerdZjeqiT5fk5bXf0bsRyEZVEMsVnnFAfWle5w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XrQonOsTIg/KZd6Splz05IaI64KQ64ZHuMmx3kKtM4Hh9NCUQt58KUE8uYtjMuGPb
	 2906XMMSx8H86A5wCkoCGYOqFglPJpdbE+s29XJ6hShFZJRJfvAuFVky6890kX/pj8
	 kxNggWMpmf+GPajg7uaG4xIlFwCGtV536l1UFdzL9qMZCUmSGJ+T5fBozhWk7ZTn6Z
	 jLNXG1g/012eYgCapCJZC7Ot0Ev8JvU0B1wlbAIPxK6bLjZ1nUZ/RUMyqHzPEGD6Vs
	 iaeTnKqLBZIVE57guENCnJd8ZhOl/OiRv9DT9AhFDx6qi3RUL9cdHb1L2M2PeGomCh
	 vx9Za+enkQKsA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5C63BC43140;
	Mon,  5 Aug 2024 18:16:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: netconsole: Fix MODULE_AUTHOR format
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172288178637.30956.6645778093585257802.git-patchwork-notify@kernel.org>
Date: Mon, 05 Aug 2024 18:16:26 +0000
References: <20240802080723.1869111-1-leitao@debian.org>
In-Reply-To: <20240802080723.1869111-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mpm@selenic.com, stephen@networkplumber.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  2 Aug 2024 01:07:23 -0700 you wrote:
> Update the MODULE_AUTHOR for netconsole, according to the format, as
> stated in module.h:
> 
> 	use "Name <email>" or just "Name"
> 
> Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: netconsole: Fix MODULE_AUTHOR format
    https://git.kernel.org/netdev/net-next/c/10a6545f0bdc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



