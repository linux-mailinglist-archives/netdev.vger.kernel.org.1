Return-Path: <netdev+bounces-92057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A628B539C
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 11:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AF821F21C6C
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 09:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11DD1805A;
	Mon, 29 Apr 2024 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAipQKHe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1A417C61
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714381230; cv=none; b=tonCPkxOQcJwULIn5RBwEeRXOn9ptVP1B3jmVGWmLK8LHyIPfzLgQH9IfsxnG1zBcRyZO1kxQBI3RKro7CY18PFjFc8KZyVLrycpLbDbDlFcWmagz9HD2dntQVBQtAiTHhwB4v6M1G/9dEOpOCLP6Afoc4q5bUdpONLIIWEAdFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714381230; c=relaxed/simple;
	bh=LFQnAoMY4rmXJmB90wwJHsq9cp8numid2OFEJ+IQdxQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=teNfSn2jY20GzIEGl9Dkr5EQPi58085fEFSYiI7XJFyUJq7QfGwmykfsWha1r98q5sz58uDf04Y4wVKY6IcSwP4yzNfPV+KYRQaqQ3MJJLZtj5UzLcRGCi7h4WJdzQ8RP1q2mopdqaZp6xhaGW0jo31FfTITCxxg+IhFJmQ+V3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAipQKHe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F195C4AF1D;
	Mon, 29 Apr 2024 09:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714381230;
	bh=LFQnAoMY4rmXJmB90wwJHsq9cp8numid2OFEJ+IQdxQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IAipQKHeXqN6lquucoz2lNhjIbzWLtNk/hKGz70MDjcdP+u9Wvqv6fE0sushaG3d1
	 RWy51yiLvX6LvEB+2ooo0fG4+bHC6I2oXYp26uvPxXJ5y8wc06jykNZFEFJmwRQJWg
	 NFY7zS4uAiSVgdTRD/TvKe4Zsb2pOSYLGSuJTYR4aKiEfJEKu44HEkFo+9k8gYhxvY
	 BvfgpSvaQIaF4HFKYMThOnakS16luRwqXB3sQpEv6HewVKH2hE+WE+B+cjJiB/h6ax
	 fBZ/XFoKWzW5bJn+jirlsTvaFI+epANGe4iVqK+p/Y21AmeDhRnsGmotdLwCQVdyLs
	 uiBGjGQTjm2aQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6507FC43613;
	Mon, 29 Apr 2024 09:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] inet: use call_rcu_hurry() in inet_free_ifa()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171438123041.5873.9161801291690913772.git-patchwork-notify@kernel.org>
Date: Mon, 29 Apr 2024 09:00:30 +0000
References: <20240426070202.1267739-1-edumazet@google.com>
In-Reply-To: <20240426070202.1267739-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 26 Apr 2024 07:02:02 +0000 you wrote:
> This is a followup of commit c4e86b4363ac ("net: add two more
> call_rcu_hurry()")
> 
> Our reference to ifa->ifa_dev must be freed ASAP
> to release the reference to the netdev the same way.
> 
> inet_rcu_free_ifa()
> 
> [...]

Here is the summary with links:
  - [net-next] inet: use call_rcu_hurry() in inet_free_ifa()
    https://git.kernel.org/netdev/net-next/c/61f5338d6267

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



