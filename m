Return-Path: <netdev+bounces-211404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6779B188A0
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 23:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B24E556570A
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 21:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E295228DEE0;
	Fri,  1 Aug 2025 21:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUk46MMZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD4028D831
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 21:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754083193; cv=none; b=gS+5/MFlwAQjB7VZjvesrtrMABfjQ8eN+QllxJnN8tz2O5UPxzQsKWLxLJowYUF2IGxqjD+dlGmhsU8THZGK9OO7utWpaqarEOuI+SVvJNXsRXCz1PK+Q2mSmV5GY1TmG4bTA0vIgzh3eyiD0+NR0ax83p+6GzNxnApIKSe9ZzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754083193; c=relaxed/simple;
	bh=zw7q6QujQeHuGeDv2YbOW+aFGXe0we/oA8BPQwe+9xk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OYTiXcgSokFm1p747BLT0dufWFU9FxmLPeJXXunehZtGwESuwyC0iq88CxJONvQhN7LvkMY2/7uuOcujwHhr2IQuHBPMFwXlOLsRt9zGlWaO1TKadJ2c5EkjDsuU6EluoTxiPK8XfNN4+3sScbrTUlnS9V8WLpwR+OHzp0A5xg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUk46MMZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C84C4CEF8;
	Fri,  1 Aug 2025 21:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754083193;
	bh=zw7q6QujQeHuGeDv2YbOW+aFGXe0we/oA8BPQwe+9xk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UUk46MMZrJgYNzibf7Uy3NTHP9igR/B7nxY/hIG4nfJbcqFa95s2zL/ucrYmcu7uE
	 OxLgD94U0ZpDhgfcGw6qFpT3Usv48XnnhdAUGeMU7NcqgIpmlvPvONtMHDMuHXRMuN
	 4sQHg5bb8IKlUe5y5bbMtJ6dmvxE4tBes5YB8QrvVCR3yrp27YYWJ6RWH5vu6lrZ/T
	 WSQ8mcTdKR5hWF0fGn2i0OZz5R6wif4Vauu3n0TuVgVUB34hCWBiRahqvn+Piljbtz
	 bXOOSoW8JAwJgsdDS289371PXm8/qE85yiVvuXO9Bevu98HG1iZ2TTO6+mpT57MZFY
	 TucigeKJs3Huw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C6971383BF56;
	Fri,  1 Aug 2025 21:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: airoha: Fix PPE table access in
 airoha_ppe_debugfs_foe_show()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175408320875.4079639.16331280350179780525.git-patchwork-notify@kernel.org>
Date: Fri, 01 Aug 2025 21:20:08 +0000
References: 
 <20250731-airoha_ppe_foe_get_entry_locked-v2-1-50efbd8c0fd6@kernel.org>
In-Reply-To: 
 <20250731-airoha_ppe_foe_get_entry_locked-v2-1-50efbd8c0fd6@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 dawid.osuchowski@linux.intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 31 Jul 2025 12:29:08 +0200 you wrote:
> In order to avoid any possible race we need to hold the ppe_lock
> spinlock accessing the hw PPE table. airoha_ppe_foe_get_entry routine is
> always executed holding ppe_lock except in airoha_ppe_debugfs_foe_show
> routine. Fix the problem introducing airoha_ppe_foe_get_entry_locked
> routine.
> 
> Fixes: 3fe15c640f380 ("net: airoha: Introduce PPE debugfs support")
> Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: airoha: Fix PPE table access in airoha_ppe_debugfs_foe_show()
    https://git.kernel.org/netdev/net/c/38358fa3cc8e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



