Return-Path: <netdev+bounces-232310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C12C04038
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 03:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A10F4F5B60
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 01:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0C11A9FAC;
	Fri, 24 Oct 2025 01:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuG1926T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B344199FBA;
	Fri, 24 Oct 2025 01:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761268828; cv=none; b=qN2IEugQqiqcMp5dtfZ4qvU+FT8+nzfHnZi5OidEwwzn5z4ttimYFWce41Mdg/oQYIf4smFHEzSGQDYw1E4iZBAyzkQW7aVJePMIT4bJqN83ExxpP12HfljuIYVfmxUezN36h0+yZhGJ/lwSXZ5OYNcuhq4doDXGvPVSQzXKwNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761268828; c=relaxed/simple;
	bh=BPvirEaSBDckEVZiZ6jER6Dp8jAo8RcKUhDhY8u7muE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pGaspKDrcyFYUcHXtxNYIVPQ07UvZlxLWUxvD6wIlYz9hu8SzesTbWXLkfM2FM8+dw+6IR4fndQPrfBZYfWrg2VhbxWM9a604rC5z2KDiNSWn5SxhufK9OKwZvPuyu6xHvqphs5fuQ5mRsdGET6urTK7bFSOWCa9tm6D/lq6xsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuG1926T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7043C4CEE7;
	Fri, 24 Oct 2025 01:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761268827;
	bh=BPvirEaSBDckEVZiZ6jER6Dp8jAo8RcKUhDhY8u7muE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CuG1926TxoongJmbBODTRRVfLrh+4U86vWrJEUqPNbrBF0HsCzkcgMO/JTAIyRTNz
	 uU0Kb2X2mQVIyn/Eh9+l/jn9LEPCyA31l0BHKNyUVNLgoef6BE96GxVBJtVZH5YMcD
	 Z8MvK2V9lcs+srgV33tuLun2YVgnws9TZdw8U83LRyukfZMtgZdawquVO2R+/wV7qW
	 59XXZCnGO30U/xQ0cUGf5qifuDnZSKtgbhjawq/K3yEQxSVIA8w46ggEZ+CS3oHQvI
	 TuG0oDKDqesrOhQJWkrJ15E69u9SRZ57JjefELhagjpy/n3KkftnXVhlYQmg0bGzma
	 Jh0OQwJdNuqsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EB63809A38;
	Fri, 24 Oct 2025 01:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V4] usbnet: Prevents free active kevent
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176126880801.3310205.11507768895135874379.git-patchwork-notify@kernel.org>
Date: Fri, 24 Oct 2025 01:20:08 +0000
References: <20251022024007.1831898-1-lizhi.xu@windriver.com>
In-Reply-To: <20251022024007.1831898-1-lizhi.xu@windriver.com>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: samsun1006219@gmail.com, kuba@kernel.org, ahmed.zaki@intel.com,
 aleksander.lobakin@intel.com, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kuniyu@amazon.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me,
 syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Oct 2025 10:40:07 +0800 you wrote:
> The root cause of this issue are:
> 1. When probing the usbnet device, executing usbnet_link_change(dev, 0, 0);
> put the kevent work in global workqueue. However, the kevent has not yet
> been scheduled when the usbnet device is unregistered. Therefore, executing
> free_netdev() results in the "free active object (kevent)" error reported
> here.
> 
> [...]

Here is the summary with links:
  - [V4] usbnet: Prevents free active kevent
    https://git.kernel.org/netdev/net/c/420c84c330d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



