Return-Path: <netdev+bounces-178468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5A4A771AC
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 02:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 333B4188B5CE
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 00:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1422E136E;
	Tue,  1 Apr 2025 00:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1ov6/6o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF27D12B63;
	Tue,  1 Apr 2025 00:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743466210; cv=none; b=fVv9nPns8Pjmisic8sB97f+Ll3ZGlsmPjJddhFiCOy+CD/nOp9VMiEd07ZtK/o3aTHY5DJglgdqqgj1ZWpi2VFdUBC87bMrMOI+2R8IejuVw5C//mG2aSONwCl8I4ug63DsxOXR/rECuG2NE9Khb7LVdL4qiJqlXV86ikgQ9Xiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743466210; c=relaxed/simple;
	bh=1j2Mgg/WCppxFyNkcbTxsGcFVKC5Y25M2nU0VYdO6dc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kdG1vfwgnjrlYKZOXVjirR7Vp0DiFatHgl3wrUrpGiEYJ+dGduaXJR6g0QTPQg0ebYrdtCnxDzAGmKwlx3nq8LtC/eqgLYZ8dLyPy3eIRyHpXBZl6QKR9tFLyoK+cjZjujP5x+kfUY/NiYA8x/g6A1JemYZI1wVXJ7EAl66wwno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1ov6/6o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA4FC4CEE3;
	Tue,  1 Apr 2025 00:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743466209;
	bh=1j2Mgg/WCppxFyNkcbTxsGcFVKC5Y25M2nU0VYdO6dc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y1ov6/6oTXDI8V7ohfMDBVMiVXKHSAdwvDGgKph6UbzVBMeQHmezglPjSOfNE8cD2
	 75SKNJCM4LIeE9ZIrPfHETySDaFursu+jLVRgegYmL+qhh9Sa/ko0sGU5PK1THd4i3
	 l2Qg9873aMk5BP7pHOu5s3sO4QLYdhMwLQnRZIvNET5iIZxqOXK4yjxg0/VknZEgRb
	 uqtzbMkxcDtgAt+G3jM4X30MZTdwDnDT8jz0Yih0eUpDaHIXGAoLPgSoSZuuU+FLni
	 b7m3oaKh7qH4VoySD/ppWbcw1ryZ2djYBg/L0vawRD+aKF+dZZWXKJ0+67DTnbZHQj
	 FknzzMYozmlCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 350A9380AA7A;
	Tue,  1 Apr 2025 00:10:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH] octeontx2-af: Free NIX_AF_INT_VEC_GEN irq
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174346624603.178192.9529544176248832437.git-patchwork-notify@kernel.org>
Date: Tue, 01 Apr 2025 00:10:46 +0000
References: <20250327094054.2312-1-gakula@marvell.com>
In-Reply-To: <20250327094054.2312-1-gakula@marvell.com>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
 tduszynski@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Mar 2025 15:10:54 +0530 you wrote:
> Due to the incorrect initial vector number in
> rvu_nix_unregister_interrupts(), NIX_AF_INT_VEC_GEN is not
> geeting free. Fix the vector number to include NIX_AF_INT_VEC_GEN
> irq.
> 
> Fixes: 5ed66306eab6 ("octeontx2-af: Add devlink health reporters for NIX")
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: Free NIX_AF_INT_VEC_GEN irq
    https://git.kernel.org/netdev/net/c/323d6db6dc7d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



