Return-Path: <netdev+bounces-223781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E98DB7DB2A
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB65324E11
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1C62F0C4F;
	Tue, 16 Sep 2025 23:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6JxHlfp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DED2F0696;
	Tue, 16 Sep 2025 23:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758065405; cv=none; b=nomLSEfsWSpMFOtH/zeUDxaeavr0ynUTjveHlSJ1lrKqdjmHYp4mP6tnSMR4wcAkS+JskZ+BMLBWR55aMs6+TOM0btcFlCFWXABxg6q0i0qUHVTq2DyATxkHGLooIm07r6HX1CTelr673RiHnvaM0kh0xgzCNlph8hq7nUN3vns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758065405; c=relaxed/simple;
	bh=wwoRB0fhTfnwm2gFJfdD/R3aUgzoy/lof/7kSxL/U6c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ma2+kygMUZWVeJ1tPyOmgOPPaHJyztadExuTZGbWZJqUjh5Yry/Dt/iV7p61hO9P82u8rKoDpZxWS6yLzVdV6q5v7KEbb2P2rEwE5rmnzgDmqFw8e9P9D0jDdU2l9uG9m0L5jjV6RNN/RhwkE7pSrIoXl8yLuedP451RmDZ9VnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6JxHlfp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18F1C4CEEB;
	Tue, 16 Sep 2025 23:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758065404;
	bh=wwoRB0fhTfnwm2gFJfdD/R3aUgzoy/lof/7kSxL/U6c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t6JxHlfpPSQLiGsk6QnBgKsN5u/ytoIJ8bIwHyePWHR0Fbfb3BHKEl0/zqtfrT0sZ
	 5HXh+YLsxwLMpTVPMuw8aIwlfq5H63kK6NajricJMHjtSwmArga4DrGgM71XwOM7TC
	 QBAE7bl3wanAGZbKRlZt19+CqNQ0Hva0opoi4QAywPCXapwMCMZwpXa6plY58Bh5m+
	 /Zot2luB8IwwvpgfU6iOFI1PIYiiSUpUrarRBOo1iYQx+hSPc9LnBzLRlZNnY8h2yr
	 2Lw+1Ayh1Ai4h+T9aGqX2sKgMZ2Bmhg8+cvu9+q4JeGZq1rdZtIjZxWGlNh7v6awgn
	 47oH0UxMhvRgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EFF39D0C1A;
	Tue, 16 Sep 2025 23:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] libie: fix linking with libie_{adminq,fwlog}
 when
 CONFIG_LIBIE=n
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175806540601.1398896.2078220430438993284.git-patchwork-notify@kernel.org>
Date: Tue, 16 Sep 2025 23:30:06 +0000
References: <20250916160118.2209412-1-aleksander.lobakin@intel.com>
In-Reply-To: <20250916160118.2209412-1-aleksander.lobakin@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, michal.swiatkowski@linux.intel.com,
 przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com, horms@kernel.org,
 lkp@intel.com, naresh.kamboju@linaro.org,
 nxne.cnse.osdt.itp.upstreaming@intel.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Sep 2025 18:01:18 +0200 you wrote:
> Initially, libie contained only 1 module and I assumed that new modules
> in its folder would depend on it.
> However, Michał did a good job and libie_{adminq,fwlog} are completely
> independent, but libie/ is still traversed by Kbuild only under
> CONFIG_LIBIE != n.
> This results in undefined references with certain kernel configs.
> 
> [...]

Here is the summary with links:
  - [net-next] libie: fix linking with libie_{adminq,fwlog} when CONFIG_LIBIE=n
    https://git.kernel.org/netdev/net-next/c/5ed994dd0b7b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



