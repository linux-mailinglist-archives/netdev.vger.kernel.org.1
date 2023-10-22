Return-Path: <netdev+bounces-43282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 848707D22C6
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 12:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BE1AB20EA2
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 10:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA8D79F8;
	Sun, 22 Oct 2023 10:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Clh8RXgj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B8D79EC
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 10:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93915C433C7;
	Sun, 22 Oct 2023 10:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697971825;
	bh=HUmstUJ5CzDo8AW5ImMMCLi9HVBCagmO6Z4nOlWHWwk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Clh8RXgj4bF6q6l9FsBi9tvLix1kg5dELmiXufIBlUNW3wMQR/PY/GWycRHnSvXAh
	 iiX1HZ2KVUZirwrs9QY2yBlKruHSTtamsV6aCjClcsgYM3+XpVl0US+42Dau//qIWn
	 2neHTfDVNDgKfndyW8+qzU1vW+4SWaaOJ+qvOlnMM0vU5Fml9toONSQNXjIFMiMVlN
	 Xrfs+CpzwQn/q1QqOsPz+Uiz6fBqgq+0gS5bBhJTJJfM5MpFEMVRQ09ebES3Pj0QjS
	 czlfk/uiP09isNvrZECVB7UHXWnSnHFLgE3+trn9/O+jviMHVIIjV5KviwVXQWzajz
	 7DGAO3E8d2nxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7CF7EC595CB;
	Sun, 22 Oct 2023 10:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8] bnxt_en: Update for net-next
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169797182550.5465.16838606595531520664.git-patchwork-notify@kernel.org>
Date: Sun, 22 Oct 2023 10:50:25 +0000
References: <20231020212757.173551-1-michael.chan@broadcom.com>
In-Reply-To: <20231020212757.173551-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, gospo@broadcom.com,
 kalesh-anakkur.purayil@broadcom.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 20 Oct 2023 14:27:49 -0700 you wrote:
> The first 2 patches are fixes for the recently added hwmon changes.
> The next 6 patches are enhancements to support ethtool lanes and
> all the proper supported and advertised link modes.  Before these
> patches, the driver was only supporting the link modes for copper
> media.
> 
> Edwin Peer (5):
>   bnxt_en: add infrastructure to lookup ethtool link mode
>   bnxt_en: support lane configuration via ethtool
>   bnxt_en: refactor speed independent ethtool modes
>   bnxt_en: convert to linkmode_set_bit() API
>   bnxt_en: extend media types to supported and autoneg modes
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] bnxt_en: Do not call sleeping hwmon_notify_event() from NAPI
    https://git.kernel.org/netdev/net-next/c/55862094a9d0
  - [net-next,2/8] bnxt_en: Fix invoking hwmon_notify_event
    https://git.kernel.org/netdev/net-next/c/fd78ec3fbc47
  - [net-next,3/8] bnxt_en: add infrastructure to lookup ethtool link mode
    https://git.kernel.org/netdev/net-next/c/ecdad2a69214
  - [net-next,4/8] bnxt_en: support lane configuration via ethtool
    https://git.kernel.org/netdev/net-next/c/d6263677bb1b
  - [net-next,5/8] bnxt_en: refactor speed independent ethtool modes
    https://git.kernel.org/netdev/net-next/c/94c89e73d377
  - [net-next,6/8] bnxt_en: Refactor NRZ/PAM4 link speed related logic
    https://git.kernel.org/netdev/net-next/c/5802e30317d9
  - [net-next,7/8] bnxt_en: convert to linkmode_set_bit() API
    https://git.kernel.org/netdev/net-next/c/64d20aea6e4b
  - [net-next,8/8] bnxt_en: extend media types to supported and autoneg modes
    https://git.kernel.org/netdev/net-next/c/5d4e1bf60664

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



