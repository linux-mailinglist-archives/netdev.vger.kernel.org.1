Return-Path: <netdev+bounces-96235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CC18C4AF7
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 03:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E90DA1F21F97
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 01:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610271C36;
	Tue, 14 May 2024 01:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGVPJlRc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CA917C2;
	Tue, 14 May 2024 01:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715650832; cv=none; b=e5rTiHy/RIC/iQVy60fRGrHsnKW6ZMSXq3g8rp9+sYuCJTdDR33IaxAUeUM1Uu+gSYAC7E/dhWot1G8dXkHgLMHzZSoRqTXe440egnJL+qOijYiVW2Yr+TOzYP3Ba5ifGDVAgIIP4l8LlkUlt/CKQBNRn5pS30IT1xDk7kn6IcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715650832; c=relaxed/simple;
	bh=LpEhxwul1QYZLgIZ+U+xiw7tIybUHrsG3fa9rOq28G8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZcXrPAsXhn8k7ppvs8UQp5GZe2qvnD2rfZK2h/G3G2vs47R8kf+LcyWyDZEkod5AsUk5HV8/v9RKpBVCEZ70Fv1AJ57C5iUZGcKqjnX5+41Ute2T+YTZ5ZABVIETrIum4EBildoLI6ZpxRCiFY+fiBw/eIfMIQ2/WfuRWz5OlbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGVPJlRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B35EFC32786;
	Tue, 14 May 2024 01:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715650830;
	bh=LpEhxwul1QYZLgIZ+U+xiw7tIybUHrsG3fa9rOq28G8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uGVPJlRcwxYOun8rX7D9nUtnTUwDWj9Qmwwwod0vwuOtQ4K6pvk/9K/KjJSvhOLww
	 PudzYRzwkhjYJd6XNw+uuxiTJwqTMU+l8/FJxFGy8ASedJyMiF341kSBiv3d59nHHb
	 eUx4mYSWrIjgcF/ioumhMDAjYKS8/1Jc347uBfbXbT9NdHN4QChZcfrokpHYezB9Hm
	 OUW8H6bGvvLNWkO+jC5ny1uhURczj5KZiZqCddo8akP48EDSgSjvXXcDD6sT7oWuwK
	 C2riQlcjN6DaHFG4kAEUM7qJjJKNq+P3xFx+zUHAt185mQTm0FVifKy28FVI9v/egc
	 nni5emPqmgzxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A156DC43445;
	Tue, 14 May 2024 01:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net/net-next PATCH v6 0/2] Move EST lock and EST structure to struct
 stmmac_priv
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171565083065.25298.6578381671622937855.git-patchwork-notify@kernel.org>
Date: Tue, 14 May 2024 01:40:30 +0000
References: <20240513014346.1718740-1-xiaolei.wang@windriver.com>
In-Reply-To: <20240513014346.1718740-1-xiaolei.wang@windriver.com>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
 bartosz.golaszewski@linaro.org, horms@kernel.org, rohan.g.thomas@intel.com,
 rmk+kernel@armlinux.org.uk, fancer.lancer@gmail.com, ahalaney@redhat.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 May 2024 09:43:44 +0800 you wrote:
> 1. Pulling the mutex protecting the EST structure out to avoid
>     clearing it during reinit/memset of the EST structure,and
>     reacquire the mutex lock when doing this initialization.
> 
> 2. Moving the EST structure to a more logical location
> 
> v1 -> v2:
>   - move the lock to struct plat_stmmacenet_data
> v2 -> v3:
>   - Add require the mutex lock for reinitialization
> v3 -> v4
>   - Move est and est lock to stmmac_priv as suggested by Serge
> v4 -> v5
>   - Submit it into two patches and add the Fixes tag
> v5 -> v6
>   - move the stmmac_est structure declaration from
>     include/linux/stmmac.h to
>     drivers/net/ethernet/stmicro/stmmac/stmmac.h
> 
> [...]

Here is the summary with links:
  - [net,v6,1/2] net: stmmac: move the EST lock to struct stmmac_priv
    https://git.kernel.org/netdev/net-next/c/36ac9e7f2e57
  - [net-next,v6,2/2] net: stmmac: move the EST structure to struct stmmac_priv
    https://git.kernel.org/netdev/net-next/c/bd17382ac36e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



