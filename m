Return-Path: <netdev+bounces-202725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0102BAEEC27
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 03:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D1944045E
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 01:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7E118FDBD;
	Tue,  1 Jul 2025 01:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6/Rqufo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7160A18C00B;
	Tue,  1 Jul 2025 01:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751334000; cv=none; b=Ed1uo065g6Lt1NZnXQTsmmRkTo7XBOGg7ZDp14uErDytCSPUW1x3s3t1oFlfpnvYn3K7hYHgKd6+o6QGwrBpnIhnf4ySXwAJfxfMbs1XS+ratQaK+qGJE05LJ5evOPurocjuq4Ljfn3cpXijU+KSPpL9t3+0YwktC+wPq7A3Rh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751334000; c=relaxed/simple;
	bh=ICONkQkCpQFoOiUXYBMrxqK0UDBNHNHIU53LNkZXmJI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DxD8hHPaDFA5Fl+pefa1KwVYH6F59d1UjHqsDh6DDtTtuZlvLaNEib+fJvIWpP1jzwmJr8bOph/RAJFMCaWKSZ2f/EmOWIgLlgVJU+mZij7W9T98+KHX6Ee/ZRcxJMZ9MI4f2Mny++as+cFmsEM+C78efctO0p3172cZEBeIpWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6/Rqufo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA321C4CEE3;
	Tue,  1 Jul 2025 01:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751334000;
	bh=ICONkQkCpQFoOiUXYBMrxqK0UDBNHNHIU53LNkZXmJI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V6/RqufowaKBEQEiNtBV1HfXXeXCfayaRjT737jkxVPpgxh7e5uXy+5+1fl4y2p3z
	 MHNXkhPfoM7yOnvh4w4VuYQu9HV4v31rqzbzPen8V8wmJ8f/YX73J3bGyCI76g6D/h
	 Oi6BgX6Aq2QSnS08ZLGLGL7zKklQ0YDABkjrJzv1TUoOZMjEGNbwChTzarYHEveXXO
	 YszElpR9bRBLPbBdAQ0SAwOKoOuPw5NLKnBAyTeak9wuOaiorBXdeb/MefkvANkCyC
	 e/HLQyHFfOOXw2MmlTAeiuoAxdWJzolVhXzYKmArHTDPY7jylYFjkN9gj9nH4bk1T+
	 QA1lPcTVZVyRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B5738111CE;
	Tue,  1 Jul 2025 01:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 RESEND 0/3] net: enetc: change some statistics to
 64-bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175133402474.3632945.10665763594347995873.git-patchwork-notify@kernel.org>
Date: Tue, 01 Jul 2025 01:40:24 +0000
References: <20250627021108.3359642-1-wei.fang@nxp.com>
In-Reply-To: <20250627021108.3359642-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, frank.li@nxp.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Jun 2025 10:11:05 +0800 you wrote:
> The port MAC counters of ENETC are 64-bit registers and the statistics
> of ethtool are also u64 type, so add enetc_port_rd64() helper function
> to read 64-bit statistics from these registers, and also change the
> statistics of ring to unsigned long type to be consistent with the
> statistics type in struct net_device_stats.
> 
> 
> [...]

Here is the summary with links:
  - [v2,RESEND,1/3] net: enetc: change the statistics of ring to unsigned long type
    https://git.kernel.org/netdev/net-next/c/f5ed33771bce
  - [v2,RESEND,2/3] net: enetc: separate 64-bit counters from enetc_port_counters
    https://git.kernel.org/netdev/net-next/c/9fe5f7145ad7
  - [v2,RESEND,3/3] net: enetc: read 64-bit statistics from port MAC counters
    https://git.kernel.org/netdev/net-next/c/4c7ef319848f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



