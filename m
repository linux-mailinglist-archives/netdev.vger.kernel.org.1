Return-Path: <netdev+bounces-176240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B33E0A69741
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 19:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C4221B60F01
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0926205E16;
	Wed, 19 Mar 2025 17:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ggu+00dJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74851BDA97;
	Wed, 19 Mar 2025 17:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742407199; cv=none; b=N+ID8CmznmsNT7Ac7NX35GG0XH9Cs+3smv27jupelN+E/2Hf2vF7fOEkDrw3ES5KcKIqI/8a8AzfR2k9Z6J+GbJaOSZTPhRyDUrqoq/ERvKkrcIJNmyx9fd/jTibOEBMglLhOfgzhpel6aPutB40Im4LtzKeSzgAEauCIg+ebUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742407199; c=relaxed/simple;
	bh=pubQqk0fE2SGrob8NAXTpvcux5d2Wunz1otSWFYAhqg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PS1t2KAkje415Abwx2TMrsh6AWlscmwK5bl9WH+SM7mUMTnrkcVHMGCS909dsSH72ZS7HIZGBk+D9gP9NKT/O+rAbdtb72BhH+AHf6om4c7Iq84nbDAa70jc06SFKqhlTQDcsKzPiPLKCyo0ujv/KMIcg48hC+3FoqKGDShfSPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ggu+00dJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B223C4CEE4;
	Wed, 19 Mar 2025 17:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742407199;
	bh=pubQqk0fE2SGrob8NAXTpvcux5d2Wunz1otSWFYAhqg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ggu+00dJpK3erk/sslpetOCMDp6nl9mhN5XlMZ+QDgna+Zgyc8jHJFh54vFN4B6la
	 JTV113ln8mVetvkIliYwkJrfId4YxUA2hyoOfJbnkHOywzFznIBna5FzxrlGCLgEP2
	 fUpGWLHPa6tPEGxyS/L/e7o8N5WcujV6WbTlbBjgsd6yrJiyyoTQbfvO9/YJoKq+fx
	 B03mbL4YzhxZnmpUurmNT7PSI6Tvr+EOjnES+RqIQgfjm2POZacsEmSRBYuf09fF8Z
	 DGjLh/OILOJQHs0k4C6KJz4jYsBmWeeERU22SdpPxUhDIO1PagRx40reKcFfp5l029
	 nCawhSqLQVfmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 38292380CFFE;
	Wed, 19 Mar 2025 18:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: bring back dev_addr_sem
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174240723503.1136881.3874262773936408000.git-patchwork-notify@kernel.org>
Date: Wed, 19 Mar 2025 18:00:35 +0000
References: <20250312190513.1252045-1-sdf@fomichev.me>
In-Reply-To: <20250312190513.1252045-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 willemdebruijn.kernel@gmail.com, jasowang@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org, jdamato@fastly.com, kory.maincent@bootlin.com,
 kuniyu@amazon.com, atenart@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 12 Mar 2025 12:05:11 -0700 you wrote:
> Kohei reports an issue with dev_addr_sem conversion to netdev instance
> lock in [0]. Based on the discussion, switching to netdev instance
> lock to protect the address might not work for the devices that
> are not using netdev ops lock.
> Bring dev_addr_sem instance lock back but fix the ordering.
> 
> 0: https://lore.kernel.org/netdev/20250308203835.60633-2-enjuk@amazon.com
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] Revert "net: replace dev_addr_sem with netdev instance lock"
    https://git.kernel.org/netdev/net-next/c/8033d2aef517
  - [net-next,v2,2/2] net: reorder dev_addr_sem lock
    https://git.kernel.org/netdev/net-next/c/6dd132516f8e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



