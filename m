Return-Path: <netdev+bounces-73863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E573185EE98
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 02:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1FDB2844E8
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 01:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5B917576;
	Thu, 22 Feb 2024 01:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLBJ2ShU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C597134CD
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708564829; cv=none; b=u+UzA2sdJXTjEg+O60hSikDLPbfFGLKuPNoMDAWb9mA9JaVe7T8/iJO34tYgTjgFb2hBtAVdxzC7COgxU+BtWf0p+W/WQYKrGo7aN727EGWfe+VBPSqTZgA4t2Jf2K5xV1K6svkxY/xZvWLJl26xhC1c6Jqq47xCZ9gI2hKB+oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708564829; c=relaxed/simple;
	bh=LCnu7Yn0ssmZxmdLtJEqu5eent5Ux9eBXtujjfvPlXY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LlEqmbEdrzA1zD05Z+fAGcPsoXyULjDnAHo6G1T10s+SY9NDw92VTcd9CNOO8d8kBJrdZ4X+j/4V93sWCDKwVVNNMl9Ax8EawaZjXPQgWtX9lyscuydbBGRRquwmulnyccFBJtMT+tQtf/ki0JmQPOAk9HUKoinJ3si3z3FbaIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLBJ2ShU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D746C433B1;
	Thu, 22 Feb 2024 01:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708564829;
	bh=LCnu7Yn0ssmZxmdLtJEqu5eent5Ux9eBXtujjfvPlXY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JLBJ2ShUHjVLRfQlLox3fwRqTRvXACChMh8PlBaV3Q2wPdsrkJXfEG8+tV8+PWvPH
	 YQWNc2TLaxOtbnso/U6efUl5KFBKjwcEissZiDR+Udov+/sVul6bBMni7G0s2vyKoK
	 lfvijl9s/xlcr2x4bYs0Li0j7Lu89AsXfxrNK30Zqfbbq+QnOt/ONuZZy1vGTxbVOc
	 eY2kC3rxYs08LnkHtpgAiSgiLir2URo23SvnSX5+lg0ZIFILxpwzoAOtlELPpLAoWU
	 c4g1dPOBdATiZBLIZocyspDVswk0Nafyt13oHNP/bHcNRVPvo7T6o0xh26BSbRbihN
	 i8pqBbNyq9spg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34600C00446;
	Thu, 22 Feb 2024 01:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] udp: add local "peek offset enabled" flag
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170856482920.21333.6490329982375561974.git-patchwork-notify@kernel.org>
Date: Thu, 22 Feb 2024 01:20:29 +0000
References: <67ab679c15fbf49fa05b3ffe05d91c47ab84f147.1708426665.git.pabeni@redhat.com>
In-Reply-To: <67ab679c15fbf49fa05b3ffe05d91c47ab84f147.1708426665.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, kuba@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Feb 2024 12:00:01 +0100 you wrote:
> We want to re-organize the struct sock layout. The sk_peek_off
> field location is problematic, as most protocols want it in the
> RX read area, while UDP wants it on a cacheline different from
> sk_receive_queue.
> 
> Create a local (inside udp_sock) copy of the 'peek offset is enabled'
> flag and place it inside the same cacheline of reader_queue.
> 
> [...]

Here is the summary with links:
  - [net-next] udp: add local "peek offset enabled" flag
    https://git.kernel.org/netdev/net-next/c/f796feabb9f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



