Return-Path: <netdev+bounces-235184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A8FC2D32E
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 17:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8820318852EB
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 16:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE693164D8;
	Mon,  3 Nov 2025 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ij1y7wSg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D939A30DEDE
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188031; cv=none; b=ps2o9ymfIPI3CaV1UyKzsxrgbo1rkDn8EniaqnIHV3moP6bFTSC19HcUuglsg7qdGLcFRScs0iTlwMRNAILMy/XtKKzzk3HBXfXYLD909BgL6W4LaLamAL0P/n2oP3wd6t4rrFmZWM4z52Uo+DSJtB4jx1haFFCiH69R1daYpCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188031; c=relaxed/simple;
	bh=H3AqCmRKciEkp2XY1B2glaSTOt38KSa80eFx95BvP5U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R852fTAYn2ZzJYKSQQ7qY+BkSOHZECtj8cVeBX0xL096rrPZaxLnMDI968L/Yd4qCJ0N1kAAUXgw4joHhtney3urHaMwgKdvNpZPfG+RCI8HBvYrj9AZll0tZnVyyMsm+aE01hd7/85xXgIA7gS9drN4IxB1V73EaMnCa0i9J5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ij1y7wSg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76532C4CEE7;
	Mon,  3 Nov 2025 16:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762188031;
	bh=H3AqCmRKciEkp2XY1B2glaSTOt38KSa80eFx95BvP5U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ij1y7wSgLAhj3GhpPCVEUm9UChtTk90Su+z/swt3qOO4m5cgDGWr1+nncqwnuvJAS
	 Vw7r3Ipi5q0gtFCGn6+AEvCMpoUtSxjsaHc171eLoe6aJTJHTnnMDC4Oq8CuAPjIM8
	 LtTjaghFbTvSfImVgDd1qdviZ60IbFuwMBM7EKEhafrOUKuRHvfDKO8GGDJG/5xmIN
	 9v2+6fT2moisVVk+aKpbP3ZM2UDbtZuRZRUa66k5V8pxFUyJxZk/D70W0c7TDyPJ38
	 pqrO5E88YOVTWFbcqtTJZ7sB3JE3QmkPELJADh387u1bUev8QENANRBn9JcZcVUgqF
	 FPU2fyzUOwZvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F6A3809A84;
	Mon,  3 Nov 2025 16:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] iplink: hsr: add protocol version to
 print_opt
 output
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176218800601.2118112.580270042614591896.git-patchwork-notify@kernel.org>
Date: Mon, 03 Nov 2025 16:40:06 +0000
References: <20251027135205.3523660-2-jvaclav@redhat.com>
In-Reply-To: <20251027135205.3523660-2-jvaclav@redhat.com>
To: Jan Vaclav <jvaclav@redhat.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@kernel.org

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Mon, 27 Oct 2025 14:52:06 +0100 you wrote:
> Since this attribute is now exposed by kernel in net-next[1],
> let's also add it here, so that it can be inspected from
> userspace.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=16a2206354d1
> 
> Signed-off-by: Jan Vaclav <jvaclav@redhat.com>
> 
> [...]

Here is the summary with links:
  - [iproute2-next] iplink: hsr: add protocol version to print_opt output
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=d6bf24a06053

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



