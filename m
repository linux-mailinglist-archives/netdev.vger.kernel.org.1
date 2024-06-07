Return-Path: <netdev+bounces-101797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF920900200
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7504E1F25DFE
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 11:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC17F18734B;
	Fri,  7 Jun 2024 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiBjUqyV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877D515ADA8;
	Fri,  7 Jun 2024 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717759228; cv=none; b=doiqOmfye1c3kHIM7zchq0NoMkpq+UaGP0gYk773DPHbt8fWZIR0NAEYrJqNhRzv1D6jtnDXvo+fbhdhWDMnv5uO6zLXNYGjmFadEvJCwC5CrGtQjC8jOFOxRHgxBZUp34tcOqwwAuaoKfeo/NAP1mEnSyKncA8MxHNykB9uGO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717759228; c=relaxed/simple;
	bh=OTS4WciQrQWWTkQbA87947xhEriWzIvauGYGyoVKjDM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Wpf4HaypPerGrTVgf+dMNPtTf0e1e9zuH55htJaLxDJAdguPRV017IV2jp58pA0WCl4jl+l4NPfl8J83OM2BwiX+AVHbl0qR8zSWv01NUBeqyswnvhzpgKOJsGrue9yaDXWoAepGV8EoRy3bcLLoQb5iT4oL0roYK4rw1fWYeyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiBjUqyV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13027C2BBFC;
	Fri,  7 Jun 2024 11:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717759228;
	bh=OTS4WciQrQWWTkQbA87947xhEriWzIvauGYGyoVKjDM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eiBjUqyVBl8urLl/WkHIdPY1jT8uwU6Bt2pdWmUg6vOYciUDLxD8XQrehXNHWeTCG
	 /wNrgQMiNff0KhO4xkffbc/fCR+tEHnKNgjS+Z9IvRP8gs2av5Lx49ibIN3ECceoQk
	 Dk2c3SYkQU+sBLNfGajULKK0MJyqOayHYFdz3vATFKqfQf7g3mo5TWPAsuJ0YeAVG+
	 0R1q/whV8od0dep7EODRUjyz2Fmb8vNiid4aUiAhxQOwMchK07k2hIcfu7B5NIlW1P
	 czPuEH5P08pxNpEs9MFIR9GdzFbwKz6TrH5MKzM2NAUkPwHxbO6PCQOAVF2dz+lM2D
	 BLAWkE/dwuKNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EFD88CF3BA3;
	Fri,  7 Jun 2024 11:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] dt-bindings: net: dp8386x: Add MIT license along with
 GPL-2.0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171775922797.19374.4466559724588776468.git-patchwork-notify@kernel.org>
Date: Fri, 07 Jun 2024 11:20:27 +0000
References: <20240531165725.1815176-1-u-kumar1@ti.com>
In-Reply-To: <20240531165725.1815176-1-u-kumar1@ti.com>
To: Kumar@codeaurora.org, Udit <u-kumar1@ti.com>
Cc: vigneshr@ti.com, nm@ti.com, tglx@linutronix.de, tpiepho@impinj.com,
 w.egorov@phytec.de, andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kbroadhurst@ti.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 31 May 2024 22:27:25 +0530 you wrote:
> Modify license to include dual licensing as GPL-2.0-only OR MIT
> license for TI specific phy header files. This allows for Linux
> kernel files to be used in other Operating System ecosystems
> such as Zephyr or FreeBSD.
> 
> While at this, update the GPL-2.0 to be GPL-2.0-only to be in sync
> with latest SPDX conventions (GPL-2.0 is deprecated).
> 
> [...]

Here is the summary with links:
  - [v2] dt-bindings: net: dp8386x: Add MIT license along with GPL-2.0
    https://git.kernel.org/netdev/net/c/b472b996a434

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



