Return-Path: <netdev+bounces-40201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9436E7C61B5
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 02:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18774282629
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 00:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FDF7E4;
	Thu, 12 Oct 2023 00:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7eJ3qhN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7B87F3;
	Thu, 12 Oct 2023 00:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF8EDC433B8;
	Thu, 12 Oct 2023 00:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697070625;
	bh=JygYXv/iY2L4YfL3LQXXh3cOvpCmrEV6BuAM2IZkvXU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V7eJ3qhNjVkM7W5nCe7ih12nbjrJysAUnTPoR5w4YneFbMZzrhySAvPkyZX3AVMys
	 e122Nx+q6x62Pp4oUtkUZdUifT2npjT5Y9Fpa0E1PGCzhcBMxJk6DV0ZDNIpq2taJP
	 paMVYkyF2itpgpRVXmeqqUnwtSoGUioS0Uy3gFOR1G+SK1CH2up+CPKYJYEU75TK8J
	 MC8hfNd64OgOsUfK5lNnhVGJuVAj0gLuiC2aRPXG2JfQoiGgUtFn/nFIRHYjKVe4NJ
	 LaQ9RbZAQ9ngZx/RRL/QFKsuQ+rqHuX3onTREU9ji13+513/nOtDCbPlaC/eVvNbha
	 DohCAI57xzIMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8421E000BB;
	Thu, 12 Oct 2023 00:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] octeontx2-af: replace deprecated strncpy with strscpy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169707062568.15864.7454843502958715402.git-patchwork-notify@kernel.org>
Date: Thu, 12 Oct 2023 00:30:25 +0000
References: <20231010-strncpy-drivers-net-ethernet-marvell-octeontx2-af-cgx-c-v1-1-a443e18f9de8@google.com>
In-Reply-To: <20231010-strncpy-drivers-net-ethernet-marvell-octeontx2-af-cgx-c-v1-1-a443e18f9de8@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Oct 2023 21:38:11 +0000 you wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We can see that linfo->lmac_type is expected to be NUL-terminated based
> on the `... - 1`'s present in the current code. Presumably making room
> for a NUL-byte at the end of the buffer.
> 
> [...]

Here is the summary with links:
  - octeontx2-af: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/473f8f2d1bfe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



