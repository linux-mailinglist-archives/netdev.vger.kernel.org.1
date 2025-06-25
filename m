Return-Path: <netdev+bounces-200894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E345AE7419
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 03:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA2217F636
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 01:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D901474CC;
	Wed, 25 Jun 2025 01:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxyVSObC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDEB347B4
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 01:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750813783; cv=none; b=H+PEhybdauAHsnxX/W4rB9XVym/FGtFDU15gcFe5TS9/5UzWn4dCEst+p6CUXR9m75g8t/wnhl6Cbtb1azWfjKe4NZOx5vpc/kUu0DVWF+SsPld8deOjoXrf0N+j2t5NMUE+iO3t9lbonyrQEazkkDeMnnJ47POJTDF66qskFBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750813783; c=relaxed/simple;
	bh=3cR89uuv992quZ5YRC1rXsho1Mazrjn5Gop+SsDSomY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qg/CAoB/0hKaiKwr1ltlkf5bdsUoQKjM3x3Uo0HbM9bQ5LyU+lewWSU+WwckqdysRD/tqzi0Zy7mRGivCCCguoZNiqfe3XFZWw+ctTU/RaNVWwmhgT8Qd2IeZ+pLad5UrUNB6fcCDmht8iucmIJxemH4yPTSvaodE6E7V8tlRfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxyVSObC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CA1C4CEF0;
	Wed, 25 Jun 2025 01:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750813782;
	bh=3cR89uuv992quZ5YRC1rXsho1Mazrjn5Gop+SsDSomY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bxyVSObCNH7GxM7ykTZ5TR8g/PBBofKnjmuL1bGYSyoKH9Inncewv/wkQrPk/o+Z/
	 rVXAN92WcY7sIvahcxxx2rEWr7gcVoD0Syii2rNx0XCR1+5Bg8boFadolOWDudLsqG
	 cNvaTWLnex9viWMkxztdmBskbwvqk/EcBoageqdgqUxpDa7+js7XpleqIsBkV15I5z
	 hDtGtDDqjFeeD7fh3tqcH+xzw7NyBUasPSyjiPo5vJjtbMW8CjWymGUmasfk+Abcgi
	 V7MANGCRdUsUSPV1iOR51IzRuQj2wuAE+nPRuaZlLK9AqDPE0Ti4OEWoft5qbCNju9
	 U0b7HrilavzaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B2439FEB73;
	Wed, 25 Jun 2025 01:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: xsk: dpaa2: avoid repeatedly updating the
 global consumer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175081380923.4090877.16334008056847713853.git-patchwork-notify@kernel.org>
Date: Wed, 25 Jun 2025 01:10:09 +0000
References: <20250623120159.68374-1-kerneljasonxing@gmail.com>
In-Reply-To: <20250623120159.68374-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, willemdebruijn.kernel@gmail.com,
 ioana.ciornei@nxp.com, netdev@vger.kernel.org, kernelxing@tencent.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Jun 2025 20:01:59 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> This patch avoids another update of the consumer at the end of
> dpaa2_xsk_tx().
> 
> In the zero copy xmit path, two versions (batched and non-batched)
> regarding how the consumer of tx ring changes are implemented in
> xsk_tx_peek_release_desc_batch() that eventually updates the local
> consumer to the global consumer in either of the following call trace:
> 1) batched mode:
>    xsk_tx_peek_release_desc_batch()
>        __xskq_cons_release()
> 2) non-batched mode:
>    xsk_tx_peek_release_desc_batch()
>        xsk_tx_peek_release_fallback()
>            xsk_tx_release()
> 
> [...]

Here is the summary with links:
  - [net-next] net: xsk: dpaa2: avoid repeatedly updating the global consumer
    https://git.kernel.org/netdev/net-next/c/da7aee716163

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



