Return-Path: <netdev+bounces-128217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0B6978856
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 21:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78ADEB26003
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 19:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D488D13D51B;
	Fri, 13 Sep 2024 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpC05+2r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1E06F067;
	Fri, 13 Sep 2024 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726254029; cv=none; b=AykbTQIk/5+ogbIBuiO09CdHhlkUXdLXcz7ahqcbV5BV5Jtw7ajXLxAq0C/mxIzJgo0R1JBAm1M5hmiqiXmRyUigH5sml4gDYQQ0TggMvz2894h07Q++uJWdf5migny9LhHSS5+D73Hn0XTcNn+X8tDbUt5xJL/b7p36BO1HOCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726254029; c=relaxed/simple;
	bh=CdUdD6gZxW5H+mvEotMQUS9jgG0p/eNp2HVRbKptsw4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KF0OVvh/00gf/BqyfQ+ZDhvBqJ7hDAE0PASAJSStIZzbhjG0FcvbEI+Gc9bk3IOVK9+vHsBiJm/sLO8QOnh3wlJpWmLKgShSkg5DNnxhj7EJPySDh/9y7b99NsC9+6RuTfRv3vxMw1HUskKyruhn9II5UuSUMcu0tC1whU3VRKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpC05+2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7BCC4CEC0;
	Fri, 13 Sep 2024 19:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726254029;
	bh=CdUdD6gZxW5H+mvEotMQUS9jgG0p/eNp2HVRbKptsw4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bpC05+2rfg8eIlAibcQH1HJ7MAVijNOWxiMmTuimS1y/RvHF75MUyVW7Wgp2bxkq2
	 o876t7gcC07xrP4MgH7MHdHr9aN/wxveBMVk02+uOYtynj1A8oRjB2OqAw3z81ieD1
	 NuR0zA0GU5itV+skp4chj6t8l9lzlaYiJPFSwPJeH6Bgif1WKQz+cxJI8UeWW6jwN9
	 D3aT8sc2TpkpL4AgmplgkGNTVD2wu/5d+F0+87p4wMl9SPsE2ZX0QPYcviMjm5OS9P
	 5U0Iun/A7EFFqRcP7/CYIKOGoW4USJpdkbKsGak3RwNW0JDATDN8mQ3r9Y2ZcjWKRB
	 w0HZ/lC80sQnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE49E3806655;
	Fri, 13 Sep 2024 19:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] memory-provider: disable building dmabuf mp on
 !CONFIG_PAGE_POOL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172625403029.2334160.4814640261293738069.git-patchwork-notify@kernel.org>
Date: Fri, 13 Sep 2024 19:00:30 +0000
References: <20240913060746.2574191-1-almasrymina@google.com>
In-Reply-To: <20240913060746.2574191-1-almasrymina@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, lkp@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Sep 2024 06:07:45 +0000 you wrote:
> When CONFIG_TRACEPOINTS=y but CONFIG_PAGE_POOL=n, we end up with this
> build failure that is reported by the 0-day bot:
> 
> ld: vmlinux.o: in function `mp_dmabuf_devmem_alloc_netmems':
> >> (.text+0xc37286): undefined reference to `__tracepoint_page_pool_state_hold'
> >> ld: (.text+0xc3729a): undefined reference to `__SCT__tp_func_page_pool_state_hold'
> >> ld: vmlinux.o:(__jump_table+0x10c48): undefined reference to `__tracepoint_page_pool_state_hold'
> >> ld: vmlinux.o:(.static_call_sites+0xb824): undefined reference to `__SCK__tp_func_page_pool_state_hold'
> 
> [...]

Here is the summary with links:
  - [net-next,v1] memory-provider: disable building dmabuf mp on !CONFIG_PAGE_POOL
    https://git.kernel.org/netdev/net-next/c/26d7460222a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



