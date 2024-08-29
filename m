Return-Path: <netdev+bounces-123038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFE9963822
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 04:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E5411F23380
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 02:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77FF2746D;
	Thu, 29 Aug 2024 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9y75UN3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4C71C2BD;
	Thu, 29 Aug 2024 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724898028; cv=none; b=Aqb7acAmu+V3ePgVUwJ1Suon8y3i/K4XjcTlbAPYdNOuyE/z21TQbGjz76B1raoqlIMjsYSjPar1bVoUcBSa0LCiLqQdGdAK+yciAiGH9BgZ9vMCvXEZrWk4AXaWT61jeQhBE8L+oDF/wt6QZWuhEeANJdlyP33eFRhmdkrJqIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724898028; c=relaxed/simple;
	bh=u/NzgI+eXNJo30Mr+Kv5erjH76/dvlwg2JmJYtPW3X8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bUIq9aVrox2XX2/Aob+Wvl5nU9B8Fh6vNS0RUxEOTd9bN028XNALzc9OXhkfWzzC4YxEw9DkYUzdlawVD99N+RVqnGxoU/VIkFcyxKZSxHxjR/oce8ItO2YBNoT03RpfQFH7qR+0aqEp7ih8U2IKRpCHRM4hhggmN6ug4lwV/74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9y75UN3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47871C4CEC0;
	Thu, 29 Aug 2024 02:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724898028;
	bh=u/NzgI+eXNJo30Mr+Kv5erjH76/dvlwg2JmJYtPW3X8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T9y75UN33PZjSRoUN4/rNDDF0YVoBceevhRLcnk5q2bygz7zLVLhAtWjoHN5YaLxb
	 K9qBUlqxFe0dNwOPj9u6Kn9nH/+YK7qI02BJn2I6EMwhoTkSBaCFXnn5ZLS0FOcf2x
	 aor3RijyLn/ap0Irg5iqzUgSjmFCb8HqeGQHCIbHrDDYdB79tjAQju4OJWtc83YeZ/
	 AwPN1AMyRqUiqmoRV1BPSbUd0MvN9hK7no2iH2tPasOA6eIsT7lHkGW9XWsyAGiJt7
	 Ef7t8wsdu+g4k6x4S1267RT2Epr7lJ/XThZ9TaWv1YMlAwGkj8u+s7NH1dcJvAWKBh
	 kBaGt80QjtWcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE163809A80;
	Thu, 29 Aug 2024 02:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 1/1] net: dsa: mv88e6xxx: Remove stale comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172489802851.1497345.451325569430097874.git-patchwork-notify@kernel.org>
Date: Thu, 29 Aug 2024 02:20:28 +0000
References: <20240827171005.2301845-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240827171005.2301845-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: robimarko@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Aug 2024 20:10:05 +0300 you wrote:
> GPIOF_DIR_* definitions are legacy and subject to remove.
> Taking this into account, remove stale comment.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/net/dsa/mv88e6xxx/global2_scratch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next,v1,1/1] net: dsa: mv88e6xxx: Remove stale comment
    https://git.kernel.org/netdev/net-next/c/387c415200c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



