Return-Path: <netdev+bounces-217799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 720D8B39DBC
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD051C23AAA
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D2230FC14;
	Thu, 28 Aug 2025 12:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+eEx/eJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE4624BC07
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 12:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756385409; cv=none; b=nSVU9lbMihzxWB55lUe8+lNCI4O59YqEoeFhw9tHtugbr+E0UAaz/qP8NmyJv2qaag0XQvQXaNb22U06tlP3FIxL8I/85rhoNEDCQCaIwIZu3CfDqqMc7K21Wv0kRnyMIffED7PPhFK7izDzhX0QKCxHI/PiauygCT54r/Nx8XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756385409; c=relaxed/simple;
	bh=PRjZvs3gz+CsDp0kf01cIAxXCNBeVxHISXRS1ADgYMk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Le8j/yTCrjJc3So2KpZruG3i4nY7G5JF8JTeu+tZVxwdmFFagNObhalfVnEBi4B1gdDeTg6OhfFkXBPV66ycsU5l5xTQ6VnFaz9PTE5Zj3AXprL4HykwS8YQ0ujKCivHNwO0CxYEMZ0rglcTSk4H5UvloJfM4qerWfIvT5OtL3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+eEx/eJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20BF1C4CEEB;
	Thu, 28 Aug 2025 12:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756385409;
	bh=PRjZvs3gz+CsDp0kf01cIAxXCNBeVxHISXRS1ADgYMk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f+eEx/eJcSuu+toBEDE8knm2CKb88NqLe4FowO3Ld87wJG6G/GS00VILrrJd1rCR2
	 t2hmmwzV+YA0G3frSd83hhzL98OGS7oRYgIc7MrhKs8EE3a0e9WLjWudodlmyRPSSh
	 +IwERMiZyVkD9jqBXi3cPUjvKNYi5qplQcb3lskaaVh32IX3NegerME5kBBKYpayiV
	 HDiSgz0lkINYeJbh77/w0Q8NDq/4alXwKiDQc73jWw5F/PhpsqY1jukoICFSpgUho3
	 FUVOC9f11YT6UjdN91z91WSnxXmvwgOrUYdRa4KfToLBsT1aNFcII2mCr24BIjKEM/
	 hSLwjPECCokHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71061383BF63;
	Thu, 28 Aug 2025 12:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/5] net: better drop accounting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175638541626.1442882.881605934383075124.git-patchwork-notify@kernel.org>
Date: Thu, 28 Aug 2025 12:50:16 +0000
References: <20250826125031.1578842-1-edumazet@google.com>
In-Reply-To: <20250826125031.1578842-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, willemb@google.com,
 kuniyu@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 26 Aug 2025 12:50:26 +0000 you wrote:
> Incrementing sk->sk_drops for every dropped packet can
> cause serious cache line contention under DOS.
> 
> Add optional sk->sk_drop_counters pointer so that
> protocols can opt-in to use two dedicated cache lines
> to hold drop counters.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/5] net: add sk_drops_read(), sk_drops_inc() and sk_drops_reset() helpers
    https://git.kernel.org/netdev/net-next/c/f86f42ed2c47
  - [v2,net-next,2/5] net: add sk_drops_skbadd() helper
    https://git.kernel.org/netdev/net-next/c/cb4d5a6eb600
  - [v2,net-next,3/5] net: add sk->sk_drop_counters
    https://git.kernel.org/netdev/net-next/c/c51613fa276f
  - [v2,net-next,4/5] udp: add drop_counters to udp socket
    https://git.kernel.org/netdev/net-next/c/51132b99f01c
  - [v2,net-next,5/5] inet: raw: add drop_counters to raw sockets
    https://git.kernel.org/netdev/net-next/c/b81aa23234d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



