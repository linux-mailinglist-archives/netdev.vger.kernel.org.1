Return-Path: <netdev+bounces-151949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2832C9F1C6D
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 04:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 897AB7A056E
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 03:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E926C4D9FB;
	Sat, 14 Dec 2024 03:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLkABP6b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDBD17579;
	Sat, 14 Dec 2024 03:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734147617; cv=none; b=H73WL080mHF7lxyoDJSUQFmI1g6NcYPJqSQ/AqkZQBwbgU39/jZLFrNFZ4O9dPchyN5UCsxqmF7eiFpuZusP68fnTCdOiuBUOSu7P9zDqZjd3wuL7qm2XkNfZZCezuhn+G260YjxWuOxe1wwsLc/lBXe/Z8aMEPjWDAq+OtbMvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734147617; c=relaxed/simple;
	bh=YDgnXG5WCYEBSkQpsVmqq1r7mQrwm3iyan9MExSKB6M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WHZbZugSyhdsUHIazTggvP9Q4g4VBxfqbW6ESvuT+eMEW/4IhmBLlfS0JYrbGOFZGZ2l3UwkDUST7+9GOrqoFhFVMgMM/CuT1IDKeMSclDBw56wy05kF2cljjuvYYRukJBuX1IS3S8H/J3AHo2PAzp5mZF1+hFw7u12JNCgZ8VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLkABP6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC47C4CED3;
	Sat, 14 Dec 2024 03:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734147615;
	bh=YDgnXG5WCYEBSkQpsVmqq1r7mQrwm3iyan9MExSKB6M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iLkABP6bAFbvceSxRminblY6hQGbi5rk0bqnn8vercTUSMGJUq5oYb3Z68Jehrt3o
	 QJ4Q7fiC7323XbMAP6//9zqf626SAfSFujtsZbbJJ5BloMW7jZXZSVwCHWFhrTDpa4
	 OLleMBswQm1ykAAGX9CEliHF48ISQxfQpML11Wfi5Is9pXIQ0dJpatzpfaK92XV7Rj
	 pdfGT1eLRWo31WXyhLZdxpyqLdPoVeT5MmSEC9CrQLbRYKAiE3Fc6Q6T9MqXv7MX7l
	 YEPneYYtN8yOwHRkYudZpm2Wo+OFTdeg/mwEB+LbkBvUta7TeGWDLlTgG12mdfJbNK
	 uhcKRbdLnPYRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ECC9D380A959;
	Sat, 14 Dec 2024 03:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] net: stmmac: Drop redundant dwxgmac_tc_ops
 variable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173414763174.3237238.13876454174821375749.git-patchwork-notify@kernel.org>
Date: Sat, 14 Dec 2024 03:40:31 +0000
References: <20241212033325.282817-1-0x1207@gmail.com>
In-Reply-To: <20241212033325.282817-1-0x1207@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, xfr@outlook.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Dec 2024 11:33:25 +0800 you wrote:
> dwmac510_tc_ops and dwxgmac_tc_ops are completely identical,
> keep dwmac510_tc_ops to provide better backward compatibility.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/hwif.c      |  4 ++--
>  drivers/net/ethernet/stmicro/stmmac/hwif.h      |  1 -
>  drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 11 -----------
>  3 files changed, 2 insertions(+), 14 deletions(-)

Here is the summary with links:
  - [net-next,v1] net: stmmac: Drop redundant dwxgmac_tc_ops variable
    https://git.kernel.org/netdev/net-next/c/9bc5c9515b48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



