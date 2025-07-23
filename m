Return-Path: <netdev+bounces-209161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1401BB0E81E
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 03:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A5EC17270F
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 01:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD741DF24F;
	Wed, 23 Jul 2025 01:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9YT2ved"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC101AA1D2
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 01:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753234222; cv=none; b=i/t0N6nnmuqJ0wqLrC+aHJTpRNXCaecFMvDFnVGuXfH6zvIMF9ztPp7fyqx4eB9W0OCdNRnOxfB68b1jWK+cNXmRnEwi3vPKM78lLBHmDbKpt2uWGyxjGXrgfRgj3ekfchFCB6G4OA/uZVmZnkCsjjrK2pefYNbvciodPOaivAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753234222; c=relaxed/simple;
	bh=9oBEtF0TEONGa3De735iTnGWhJCRaQp7/SMvwTQOA/E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xt413w6LRUzV3PgOGiCUn7cZCJqafWoxMRXLVUBuQ1uiqvyhSNV5wr/TkKBa0AWftCiBKdUJCUPn/qI0s/RSEpCfMNdy/NkwQeWB021hhJXlgUfnoURUgj5W0RcSbDJ2LmQwAOb/9wrIxGGZFYVvEKXOXY/CZB+t7CyvyKDtHXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9YT2ved; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCED3C4CEF1;
	Wed, 23 Jul 2025 01:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753234221;
	bh=9oBEtF0TEONGa3De735iTnGWhJCRaQp7/SMvwTQOA/E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E9YT2ved3WSFz5JVCn5bumPkpnj39iaAxsooAUOZUQxMrn2CRnGz9/IdtyUMYXklA
	 YhJithlXB6YFcixtP2QY97ci1aNTgPRckucfytR3g3q2wU5HsL6DaasXZqBto9xLLN
	 /2/QEWSAB/ENn6+6J3ttBWZwD4MkeIHPXL/VgumT257ahreVrjWJC4KUfwQ6v0tjTI
	 jLFZTiwOLYnRgsC5RaecyNG8Yu5QM6hvkZrjvEA2JwIJC6IX9UKGSgi67KyWV97yeQ
	 562dcfXVJW0f+gJx/gb0gUvgapKXaIhqVl88aQmZk/UdUDHd2oLmbbVMe61KDja9FO
	 VigmY2b1r5a7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70A77383BF5D;
	Wed, 23 Jul 2025 01:30:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/2] tcp: a couple of fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175323423999.1016544.649440813048068442.git-patchwork-notify@kernel.org>
Date: Wed, 23 Jul 2025 01:30:39 +0000
References: <cover.1753118029.git.pabeni@redhat.com>
In-Reply-To: <cover.1753118029.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com,
 kuniyu@google.com, davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 horms@kernel.org, matttbe@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Jul 2025 19:20:20 +0200 you wrote:
> This series includes a couple of follow-up for the recent tcp receiver
> changes, addressing issues outlined by the nipa CI and the mptcp
> self-tests.
> 
> Note that despite the affected self-tests where MPTCP ones, the issues
> are really in the TCP code, see patch 1 for the details.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/2] tcp: do not set a zero size receive buffer
    https://git.kernel.org/netdev/net-next/c/972ca7a3bc9a
  - [v2,net-next,2/2] tcp: do not increment BeyondWindow MIB for old seq
    https://git.kernel.org/netdev/net-next/c/b115c7758802

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



