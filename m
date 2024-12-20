Return-Path: <netdev+bounces-153571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB93B9F8A9C
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 04:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED2937A3B21
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 03:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AB318593A;
	Fri, 20 Dec 2024 03:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2jMzH30"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D131802AB
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 03:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734665420; cv=none; b=sur4IvUWBbS3yT0C7W6IpZLKtro7O2n2ceH/rPfZ1sMCoKQT80CHjicvtps/+zJJxnY/HdcObJpLvC8ps5IPJNmT7Q2TsZnfsKTqvKpHTkp5JuCnreu9EnjdQnKVQFOcuioB67kxRRNWFVan8CjlZGbH49qMStXuXgWp+4F6eJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734665420; c=relaxed/simple;
	bh=ijfY0W/hxjp8sNdcjM3BTEaqim1njj7quZF61Hj837c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pgcZvSviWGrIXrtST/aPW0EC2K/fHXZZmq3dTJsh9/bila9NmqxbXyAJLeLHH2NcBqFLzxJ9YfG0z4I6Y9gcdTm7VirRCCDmajiBAP8xKR5wSvc/X+EDPxkYrBdIjQD8rr1LadG4GPBIg09K5xhh+VJ+iOzRW6J+Rc7jPMnXasY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2jMzH30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72511C4CED0;
	Fri, 20 Dec 2024 03:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734665420;
	bh=ijfY0W/hxjp8sNdcjM3BTEaqim1njj7quZF61Hj837c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J2jMzH30TTzZPZF/yyOzDJ6k4IhQkD4UNhwzWwB0XnYngdK+bTgki6lxcB1A7wv/D
	 BP34OW7GYQDAP8NKmtKnyOyPGtpaEy5GtXhU9ger6JZOkj1mHhBpcpwRKrvJXJ/ahy
	 JSclYboJDITJ9F9pC/riWPAFN1q9/VAAqF5MDOlA8oMjgYjhWlVlLcWF+Cy8xJ2ugh
	 acq1/vdROV21F8nt0+dPpXYpPWk2wkxJBfTvG9f1ONQH8ab/RH148TrPhJjpUzyAyZ
	 fXYeedZI6HWp2DhJ7WS2YzUm3ukBLm56zsEbrR+ho0A0gFv+Y75HAiJthKutT1JKRa
	 /iOUAWIb/uGUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BB93806656;
	Fri, 20 Dec 2024 03:30:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] sfc: remove efx_writed_page_locked
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173466543824.2462446.17982303602750748491.git-patchwork-notify@kernel.org>
Date: Fri, 20 Dec 2024 03:30:38 +0000
References: <20241218135930.2350358-1-edward.cree@amd.com>
In-Reply-To: <20241218135930.2350358-1-edward.cree@amd.com>
To:  <edward.cree@amd.com>
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, andy.moreton@amd.com,
 netdev@vger.kernel.org, habetsm.xilinx@gmail.com, ecree.xilinx@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Dec 2024 13:59:30 +0000 you wrote:
> From: Andy Moreton <andy.moreton@amd.com>
> 
> From: Andy Moreton <andy.moreton@amd.com>
> 
> efx_writed_page_locked is a workaround for Siena hardware that is not
> needed on later adapters, and has no callers. Remove it.
> 
> [...]

Here is the summary with links:
  - [net-next] sfc: remove efx_writed_page_locked
    https://git.kernel.org/netdev/net-next/c/455e135c3042

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



