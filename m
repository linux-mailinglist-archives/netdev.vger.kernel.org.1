Return-Path: <netdev+bounces-96177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7628C495C
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 00:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48C77B21AD9
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 22:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9079584A3F;
	Mon, 13 May 2024 22:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYm8Id1J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4ED84A32;
	Mon, 13 May 2024 22:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715637631; cv=none; b=SoLyzlRzx4VPuSj23jueLgD0MgE9KDxDcSShToIhKla7gxuV2cU+zSEUMYvx465nmMY8AatC/u7xjCtxMQvdbJQBPTN0DYMFOzABM33BUTdqNqBoqr/fv9/LNrmrzGbBk16L4ur/R6MXjisMBC+sjThW/WoW1Am9NimT73uubK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715637631; c=relaxed/simple;
	bh=Lr/2odPaex2heP0klUvWfA40R2wy3UHboAHTLtWrDOI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GBJS1/nXcuUfVytFAWiKEMjkAN6RxfoyE+2rMM/ZKFHtOHFlElPmU9Ta2Ze/JsCEbrNca07Ek/Bkf+/cNtq8ynH3fMsDLz22EE0cWwzsttzrS3UReJx7DvsuOa8HZMAzXx2ShkBVZpt6HM6YopZUA9VpXOM3cXuac9RjpNHy/50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYm8Id1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DAAC4C4AF0C;
	Mon, 13 May 2024 22:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715637630;
	bh=Lr/2odPaex2heP0klUvWfA40R2wy3UHboAHTLtWrDOI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hYm8Id1Jto9eHiVlq0qMo2uSnfXrzliyujk/9vNjcO0MuSWtxQoZlvf+n1/G2/OXK
	 fVzcdcwRbcmR5aeUtMG9HnPf3GraG5o2aGI7MvEPF8tRUkfBeJMJU0702/ulfYkvLf
	 xpxM5CoQi8gkZjIhx1U3YBaIs1RTHxu4c6UUjfQxQ2MOwifmgX7R24vlmzOvTAo2uK
	 /dERlAnnOqeVsQMWF1BT4KiBtxMamJAzeQOwmnHUArjie4pgxkNi5FDKjrENGKI8KF
	 L1miFrfKfOIfoa3QCHaTo5gyLzlczxDNTx8dUdNcRMaM+2t4i+mNOZfpAMM9owGtdu
	 G7dTOna5rISJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC49EC433E9;
	Mon, 13 May 2024 22:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: socket option to check for MPTCP fallback to
 TCP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171563763083.31066.11558902540602032643.git-patchwork-notify@kernel.org>
Date: Mon, 13 May 2024 22:00:30 +0000
References: <20240509-upstream-net-next-20240509-mptcp-tcp_is_mptcp-v1-1-f846df999202@kernel.org>
In-Reply-To: <20240509-upstream-net-next-20240509-mptcp-tcp_is_mptcp-v1-1-f846df999202@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, edumazet@google.com, davem@davemloft.net,
 dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, martineau@kernel.org,
 geliang@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 09 May 2024 20:10:10 +0200 you wrote:
> A way for an application to know if an MPTCP connection fell back to TCP
> is to use getsockopt(MPTCP_INFO) and look for errors. The issue with
> this technique is that the same errors -- EOPNOTSUPP (IPv4) and
> ENOPROTOOPT (IPv6) -- are returned if there was a fallback, *or* if the
> kernel doesn't support this socket option. The userspace then has to
> look at the kernel version to understand what the errors mean.
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: socket option to check for MPTCP fallback to TCP
    https://git.kernel.org/netdev/net-next/c/c084ebd77a00

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



