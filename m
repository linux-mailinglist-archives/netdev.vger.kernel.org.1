Return-Path: <netdev+bounces-137300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D09229A54F8
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 18:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9197C282763
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 16:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5F3194C65;
	Sun, 20 Oct 2024 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYlM7IEb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49683194AFE;
	Sun, 20 Oct 2024 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729440631; cv=none; b=dyln9TjZS0iAMMWrm0TDKfBAbs/4TY0eLN6OvTF2eO4bkmCX/9/mVVsdo0bFYmYBjt+8EkvgMS21qHcRQbMa66IxUDzExRH5ANlk+B7QDANMxr76684vRY2ZU5vK8udIA8czHw6QbnSSbRKcbGZmjRfo7Dt6My5o6Jcw8My9wi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729440631; c=relaxed/simple;
	bh=FCqIMLFNYPPVRO9tZA32jxWkzdYuaXy9Ii3ulQSYUbY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sejSbod/KKcUU6WSKfWEUoiboq7uas/NX8RlHz7tJZj1MoZQuCO0t5HcbPCGDUt6ARhHvdTTEhqVKBcd4oA4DzmiMaFVoyzwKh9Adr8zC3CLytWzx7Bviq7OqgcFZj3+LkgjwzRQldI9yCa/H1jtqOyUXII5wyjNAujumsjZF1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYlM7IEb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B50C4CEC6;
	Sun, 20 Oct 2024 16:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729440630;
	bh=FCqIMLFNYPPVRO9tZA32jxWkzdYuaXy9Ii3ulQSYUbY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eYlM7IEbtDrukTa+3Gui0ywnNtjOD6rm4ykXRygc43AEAH6TsxhMLTKajKmsvegkv
	 b9pI5f70P9kmsZkBpsQUhIIBvpKKbP/UJTKkbJycwrGWGyPos5y1H7VVahPr/nKJBc
	 FSgsZVKw+m7M2Sx6aE9W8bjH7yAUu8g0Naa6ZvAdfF+m+l6x+Dcd5iJN+j6kO6sXPA
	 /eaD9jHX4ibNPtmWd5NthLB4kcStR0FkPPfIAJ1hM3eub2fmQa5uEJLoFxCSyk1bb8
	 fFSLyH1fualjuWwhN/HPRXZFDwXxcTROtngyQyAX/an5yW2s2p9mjBv9ZlkaRoYR2v
	 i3yXhrMJrAyeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2043805CC0;
	Sun, 20 Oct 2024 16:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] eth: fbnic: add CONFIG_PTP_1588_CLOCK_OPTIONAL dependency
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172944063674.3604255.979906103808518054.git-patchwork-notify@kernel.org>
Date: Sun, 20 Oct 2024 16:10:36 +0000
References: <20241016062303.2551686-1-arnd@kernel.org>
In-Reply-To: <20241016062303.2551686-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: alexanderduyck@fb.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 richardcochran@gmail.com, vadim.fedorenko@linux.dev, arnd@arndb.de,
 kernel-team@meta.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Andrew Lunn <andrew@lunn.ch>:

On Wed, 16 Oct 2024 06:22:58 +0000 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> fbnic fails to link as built-in when PTP support is in a loadable
> module:
> 
> aarch64-linux-ld: drivers/net/ethernet/meta/fbnic/fbnic_ethtool.o: in function `fbnic_get_ts_info':
> fbnic_ethtool.c:(.text+0x428): undefined reference to `ptp_clock_index'
> aarch64-linux-ld: drivers/net/ethernet/meta/fbnic/fbnic_time.o: in function `fbnic_time_start':
> fbnic_time.c:(.text+0x820): undefined reference to `ptp_schedule_worker'
> aarch64-linux-ld: drivers/net/ethernet/meta/fbnic/fbnic_time.o: in function `fbnic_ptp_setup':
> fbnic_time.c:(.text+0xa68): undefined reference to `ptp_clock_register'
> 
> [...]

Here is the summary with links:
  - eth: fbnic: add CONFIG_PTP_1588_CLOCK_OPTIONAL dependency
    https://git.kernel.org/netdev/net-next/c/d3296a9d0bc2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



