Return-Path: <netdev+bounces-188830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0405CAAF091
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 03:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07209C7BB8
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 01:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C061922F4;
	Thu,  8 May 2025 01:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/FsZKNi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63A818FDB1
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 01:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746667192; cv=none; b=tFPEzE/DGwu8xlReEwkx6tsGktIvvXru8ZoX1Bsa845TgR3rmPkgHhnOUeOsmhcElwx+404ypj+TPErhDxdh9VOhTMpiSyHzLhbg06ASinXl2La+7+mra0tsXnxuIRmWuTZukbjvwkB8xahea1BYCLpxLKUJfy6jQOsjz+rurLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746667192; c=relaxed/simple;
	bh=Da/4KA4ru5nuN3AHYoUrLBKV4QSb8eSjgs/JqCWTa34=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sFuxv5/e07XcTfKM24nC79A9FKr3RH8Isaf5Dkq0lT+95Nmw4e7srQ7fdUBn2j9G6kh+W+ZU0rBx3RU2zshxTwz3V16hAfWSnSXEOibDUwIOaxAFloKlX7SSwPbncvu1gSdwh6+pSIC+0sCEz/dpVSYCygWxydmI3Sd0V9IPFZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/FsZKNi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222C1C4CEE7;
	Thu,  8 May 2025 01:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746667192;
	bh=Da/4KA4ru5nuN3AHYoUrLBKV4QSb8eSjgs/JqCWTa34=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P/FsZKNir1ZMqd27mwt0XvV1hBtrfdlJLHbY8U4GbbErbsdUEq0jozYOGa+WvjUih
	 FxiATpxZUi1eLMISi3bzY3tKVgG1/FZL7lxcq9y+zJ2COrWm8YP/EUXhq5wUlu0I7C
	 vEht35Kh994jw5NWIaQZp/AAjXrTvKZEkqsCI360aT+rePAhPiWvafaJP+iUVp4t1Y
	 B0t60PDe8BcWT36hWcrBOz5Z5vvNKSF55TWqYod9Ajr5nyrsSddSz6uy7IzpTh0oUX
	 OjaDnSoWUpU9CUGbBThiZXYjm71oJ5bRTzEdqWJSq23FvXe4yT4SMrDC97YWtsVbTX
	 RUtKjn0+N+hrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BB2380AA70;
	Thu,  8 May 2025 01:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] net: airoha: Add missing field to ppe_mbox_data
 struct
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174666723099.2414619.1850276703791840272.git-patchwork-notify@kernel.org>
Date: Thu, 08 May 2025 01:20:30 +0000
References: <20250506-airoha-en7581-fix-ppe_mbox_data-v5-1-29cabed6864d@kernel.org>
In-Reply-To: <20250506-airoha-en7581-fix-ppe_mbox_data-v5-1-29cabed6864d@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, horms@kernel.org,
 jacob.e.keller@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 06 May 2025 18:56:47 +0200 you wrote:
> The official Airoha EN7581 firmware requires adding max_packet field in
> ppe_mbox_data struct while the unofficial one used to develop the Airoha
> EN7581 flowtable support does not require this field.
> This patch does not introduce any real backwards compatible issue since
> EN7581 fw is not publicly available in linux-firmware or other
> repositories (e.g. OpenWrt) yet and the official fw version will use this
> new layout. For this reason this change needs to be backported.
> Moreover, make explicit the padding added by the compiler introducing
> the rsv array in init_info struct.
> At the same time use u32 instead of int for init_info and set_info
> struct definitions in ppe_mbox_data struct.
> 
> [...]

Here is the summary with links:
  - [net,v5] net: airoha: Add missing field to ppe_mbox_data struct
    https://git.kernel.org/netdev/net/c/4a7843cc8a41

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



