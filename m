Return-Path: <netdev+bounces-216830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AE9B355DF
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 09:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A36B8189326C
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 07:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76312F547A;
	Tue, 26 Aug 2025 07:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8GrXQXm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD042F5307;
	Tue, 26 Aug 2025 07:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756193998; cv=none; b=VEi5MpekOb58OLXGkgtGNC+eGvgQeElo5gHEjYMeWpi1LZbvd7Cjc7fQQnozcE5L07HgfS9ULqs9xQPKx0E5BBd/2fXKjudoKrAhWKyDQvOtN/yaeqJpZYjjbyZliGHCyPcmJb9d2cPjIoevft5niqjUC7r0Y9jGGWnUyA3v90M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756193998; c=relaxed/simple;
	bh=oEq8H6EfVNjsg+UO9rpShA2CXXXpl88BFCa6VmYHAh4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g8tbyUkfhJfa1CCHDLNfNLq1nzuuNPJP0wHbvuDAKWivG55j8zfEDBDP1StkckUiJz/fvtnaAp97Ky4db19/yV7tMIc/LNnMkNWOMNL1Aqdckfa7ULP0TWWR4t/5Ljg1owMp2UdMqhbGVr3Cc6Tp7HbF8wgmmWOyL7dPrsqtlpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8GrXQXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACB8C4CEF4;
	Tue, 26 Aug 2025 07:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756193998;
	bh=oEq8H6EfVNjsg+UO9rpShA2CXXXpl88BFCa6VmYHAh4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R8GrXQXmUGPDBpnWH367lCBqsbirT2QNC9+1TGVUu3tLQjQnLguIOcmW6+DpqahEr
	 jmz63rELSz1dRpFTnmJNiWg1TbpiTf5Jccf7NFyjTSydghXmyRXrgonYkmRhdq2uqR
	 xNe/Qcd89x2wsDdHujUl+rcY73YdQUSfqf+3tnsnGipvaKJAslNN72rN/6SRE5FXRg
	 vP8vj8TPumadWwYeiLyp4E/UO/BxeGqmFhscgcgrCJBxmDAqqIHp133z4IOEdGGyXq
	 A2/XXhJqA7z3oTgnDjeUfwRX3v3f2lKcXNA+QlfZQdVrRCweiOUhqGGJGy8WWUB0x3
	 DAWjH8pEdzGYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEEB383BF70;
	Tue, 26 Aug 2025 07:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] octeontx2-af: Remove unused declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175619400575.3695592.14849572687350740184.git-patchwork-notify@kernel.org>
Date: Tue, 26 Aug 2025 07:40:05 +0000
References: <20250820123007.1705047-1-yuehaibing@huawei.com>
In-Reply-To: <20250820123007.1705047-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 20 Aug 2025 20:30:07 +0800 you wrote:
> Commit 1845ada47f6d ("octeontx2-af: cn10k: Add RPM LMAC pause frame
> support") remove cgx_lmac_[s|g]et_pause_frm() and leave these unused.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/cgx.h | 4 ----
>  1 file changed, 4 deletions(-)

Here is the summary with links:
  - [net-next] octeontx2-af: Remove unused declarations
    https://git.kernel.org/netdev/net-next/c/07ca488d688c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



