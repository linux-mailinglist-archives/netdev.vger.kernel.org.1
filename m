Return-Path: <netdev+bounces-119078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA493953F7A
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 04:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 094EE1C20CA7
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 02:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D68855898;
	Fri, 16 Aug 2024 02:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnkFK1t5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5001EA91;
	Fri, 16 Aug 2024 02:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723774834; cv=none; b=H759J2S6PY6s8B2W5JyR0qzvGQXjsT7NaAFn8YQBMCigNzN+BW+o/RspAAjLbJi4EpHqH3rDcVRP4qm66yH5u4XnkKAM9s4NvpSlvGHlobNr+0akpFmfA/EOj/VEx0dwQKgUpKIvnZwkr7k5WmuOO0Epw61yczd/tXYy2NqXP80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723774834; c=relaxed/simple;
	bh=WFDDmGHe813zo8X90eIi1XVLr7puad3fxBiv+nCdVGM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pdn/T6pHtZ9yuvOezsaGIfyE9j3ylWd5K4xaUDaEsCSoAKRwPgias3C9yQeNYo9lybYoyxwmt/Y2iUsxrZ1DHyl9VFIP2pdaIsXycjTBNrrUfg/HhTY3XndCQn2nJvYpNrGXj2zSXNYmLIGIjfZEFqHanm6ieUmSJquRwLTu130=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnkFK1t5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76604C4AF09;
	Fri, 16 Aug 2024 02:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723774834;
	bh=WFDDmGHe813zo8X90eIi1XVLr7puad3fxBiv+nCdVGM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fnkFK1t5iswbnuifhC79zGkIufL2WthmwNzEFv6/Zm9yH++kA6Mu2+KAphVyPa0Pu
	 PbrhKedHi25b8uFY6D6fsSJSsedhgRvXbCnq6fieUk6qP+GRZ4oDOVEYVOrKqWPreu
	 3D6XKiGDFiuSIY/PQzfSjkLpcoaHX/4X5urew6YEWkC4QnVMcJfQF922PJLx2q+mOs
	 5EvK3Id3ik2IxWS2Z6Z3psvP20avRIbZvFnJaJxGUvbtEMoB6F9zdwKyQP92as5sA5
	 cIgSY87sP2ds6g11VpnzYXZOIPiITKUyhGiD0HKZAsFSj21VADTo8zqi+p27so4gd0
	 kIoG68LesK0sQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB017382327A;
	Fri, 16 Aug 2024 02:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] netdev: Add missing __percpu qualifier to a cast
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172377483348.3093813.9126625283048482034.git-patchwork-notify@kernel.org>
Date: Fri, 16 Aug 2024 02:20:33 +0000
References: <20240814070748.943671-1-ubizjak@gmail.com>
In-Reply-To: <20240814070748.943671-1-ubizjak@gmail.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Aug 2024 09:06:38 +0200 you wrote:
> Add missing __percpu qualifier to a (void *) cast to fix
> 
> dev.c:10863:45: warning: cast removes address space '__percpu' of expression
> 
> sparse warning. Also remove now unneeded __force sparse directives.
> 
> Found by GCC's named address space checks.
> 
> [...]

Here is the summary with links:
  - netdev: Add missing __percpu qualifier to a cast
    https://git.kernel.org/netdev/net-next/c/d440af37ba6f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



