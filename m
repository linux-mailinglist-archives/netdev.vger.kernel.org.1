Return-Path: <netdev+bounces-227810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D6933BB7D17
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 20:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C564F4E138E
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 18:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754892C21DB;
	Fri,  3 Oct 2025 18:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRcj65ab"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF2A192B84;
	Fri,  3 Oct 2025 18:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759514419; cv=none; b=D+SNa15c13S6vU3iOtC2EFO/8x7osApZbIyKB/uF9oIESrjYI22w6xERDC8F7w573HFuwnEt8glMUmb8fHffx7A6l58SXsY/MUnrfusRNxCpYtq2E6lZPqxOkb2Nq/p5u9636E8qKsU7/gURHjJgkInhrtNRLpdIKv8E/QvxtTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759514419; c=relaxed/simple;
	bh=nzY2+PAPfllyPn/2g4mYZ53n8QLyqBkvL7jZgfo6Np0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mCwDssiUjzq4rcLdunPXsd+6ZPVoZjmiSh29Pe/e6X0801MEo2zQg1wE8G4zxxWxH5yS4C9f23EEHFfAXQWiDfWSn7M+NcDnEggGi0R6Pg37fyob/MVYkfG6RO9pavUUArYcL7p1VuhbJHJylm17MDdAkZiTdZRla7h+RXW5az0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRcj65ab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254E0C4CEF5;
	Fri,  3 Oct 2025 18:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759514419;
	bh=nzY2+PAPfllyPn/2g4mYZ53n8QLyqBkvL7jZgfo6Np0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gRcj65ablshkQRrhg+q47RZpe5dLi/kUKgAKKdokUzZ/LGnky+FFOrUVZqSaGfasL
	 H30Rv7Ul1Fr4zHQJhAGBa2STc7Im80a7WUTjWF+W+sQV1An57UpKzn5Xv4jOsod/Wy
	 2OafP++6vVbjGiBJuf8zbiktTapwOeVxHis4u+6Uz4s0kSrfbc2tOFMzyIp/faNLnx
	 N2ZIEBQdi6x6SMi8fU67N7QthjEI/qy850tZBDU/u0t6VTdQ2xPkQYulgdbOPtJAIB
	 ekpn8pgsdxrltxsiXTatmC8BYldnDnS0gLdHG2q9WPJThInnmNQd0EOsw35GrMx/Ii
	 SmGVgODXskC3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF7839D0C1A;
	Fri,  3 Oct 2025 18:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: doc: Fix typos in docs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175951441044.20895.3680536240360248719.git-patchwork-notify@kernel.org>
Date: Fri, 03 Oct 2025 18:00:10 +0000
References: <20251001105715.50462-1-bhanuseshukumar@gmail.com>
In-Reply-To: <20251001105715.50462-1-bhanuseshukumar@gmail.com>
To: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 jmaloy@redhat.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  1 Oct 2025 16:27:15 +0530 you wrote:
> Fix typos in doc comments.
> 
> Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
> ---
>  Note: No functionality change intended.
> 
>  Change log:
>  v1->v2 changes:
>   fixed pertaing to pertaining.
>   Link to v1: https://lore.kernel.org/all/20251001064102.42296-1-bhanuseshukumar@gmail.com/
> 
> [...]

Here is the summary with links:
  - [v2] net: doc: Fix typos in docs
    https://git.kernel.org/netdev/net/c/1b54b0756f05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



