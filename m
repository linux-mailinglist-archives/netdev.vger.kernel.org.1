Return-Path: <netdev+bounces-215869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BA4B30ABB
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 03:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C13221D0415A
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 01:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474F71C549F;
	Fri, 22 Aug 2025 01:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBLltYVC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD891C1F02;
	Fri, 22 Aug 2025 01:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755825603; cv=none; b=TmijvhoiPMMeumbxk0UjWqd4DCE3/qvGQrb9snEFFS51bOVdXtkQKbzfCRzHvN5irS/MIubAJzonEZ/U2KseMNak/tQeVkShjSpxR6nwnXe1zfhpycl0BcInSDV07vIRMzGFu/Y2+FaMZiCTG9e/boWK3X0y0GNE3/SnqHSSX08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755825603; c=relaxed/simple;
	bh=oOO3ie4hfstobcHHlzmO+TVfvshoU1uuWOswgELCK8E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dBq2A0wpVCurloSVJNWQhxQKTruCaqWqGfGtncQfpqBGbPnpT58MZWzvVku8sFr+tpnGmvPIDY/ng4BMqXdKBy/ZvAzNA2hLDF9U0lWUHZaV4jl036c508MUty0gt0au1WMaBsFxP01pv7HyXJZ9NPg3kgCvTiPAvstbRiibYeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBLltYVC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B8CC4CEEB;
	Fri, 22 Aug 2025 01:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755825602;
	bh=oOO3ie4hfstobcHHlzmO+TVfvshoU1uuWOswgELCK8E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mBLltYVCsQQDYoHRaq13wnw7tO3X2HjtEVbpelINwIebAApWjxjeBGq+jePep1VIX
	 tUaW+AVd6dVqQa8galXadA+NVK+E4IbC/t0ExMKkMnu8OoNwUSFkzXOg0W74dogJ3Z
	 XcKVYOM1cdF6RK6/B4Z98D8IMKpg/8E8mP1tendOiiW0MtLuHWayCoyMqUvNUx7YF0
	 keSpIwcA1r5QksTUAGquRn/FtpRAgm9NZ7VSCUvUqnyGl9iVAKA0wKWjNVu1PZFXLv
	 v3Kh+1mgoScgWGu6Rfixuhx63YcE3SPj+uRfa/AVpboQOR5OCxtuymKSCDyuq6mHVE
	 M3ugA+RbuFHLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC28383BF68;
	Fri, 22 Aug 2025 01:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] Fix vsock error-handling regression introduced in
 v6.17-rc1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175582561148.1263133.8095775634903727151.git-patchwork-notify@kernel.org>
Date: Fri, 22 Aug 2025 01:20:11 +0000
References: <20250818180355.29275-1-will@kernel.org>
In-Reply-To: <20250818180355.29275-1-will@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 davem@davemloft.net, edumazet@google.com, hdanton@sina.com, kuba@kernel.org,
 jasowang@redhat.com, mst@redhat.com, pabeni@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 18 Aug 2025 19:03:53 +0100 you wrote:
> Hi all,
> 
> Here are a couple of patches fixing the vsock error-handling regression
> found by syzbot [1] that I introduced during the recent merge window.
> 
> Cheers,
> 
> [...]

Here is the summary with links:
  - [1/2] net: Introduce skb_copy_datagram_from_iter_full()
    https://git.kernel.org/netdev/net/c/b08a784a5d14
  - [2/2] vsock/virtio: Fix message iterator handling on transmit path
    https://git.kernel.org/netdev/net/c/7fb1291257ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



