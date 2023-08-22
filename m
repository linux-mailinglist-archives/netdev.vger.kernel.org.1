Return-Path: <netdev+bounces-29749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4387848F4
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 20:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCD281C20BF4
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 18:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533E51E513;
	Tue, 22 Aug 2023 18:00:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182F71DA2D
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 18:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89EA3C433CD;
	Tue, 22 Aug 2023 18:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692727224;
	bh=CA4M6FOnkgvsrBsK39CteE1Ne8G4NDDOV7069W7ZRXY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jpVZtuRbJmbNNFNXhDlWZ89jYvAq2FVJqrP+XRtyyRnZW7Ve9jaGOKcNaw7bJyh23
	 Ln0oMvFwBn+bgpEkoQ+iAZ4eg+ZUDtZJzuxY03ky5fWB7Kz5lAbJY28m3bY/ihh9aJ
	 CmvlSbm+lUchAwhPTLk20h5XTJe+/yUnLgEX3ZpU241ead9b0SiL0+PFqe1FUAPiw/
	 8B1lHD2VXoA7Lm6/LgW5zJzMS+u5KCbtA6FZVciQ6xvAOkyTBp2BM1fgxdHt3Di2qb
	 zdXoq0TZYYQ+hhU7vdGtGFIBEPL905uDW7iKWIs++gXrtkQLcnwfCx2TZTFkNXr+lh
	 eudNyMmwojB0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6BAB5C595CE;
	Tue, 22 Aug 2023 18:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: microchip: Remove unused declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169272722443.9690.1722209003477337400.git-patchwork-notify@kernel.org>
Date: Tue, 22 Aug 2023 18:00:24 +0000
References: <20230821125501.19624-1-yuehaibing@huawei.com>
In-Reply-To: <20230821125501.19624-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 linux@rempel-privat.de, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Aug 2023 20:55:01 +0800 you wrote:
> Commit 91a98917a883 ("net: dsa: microchip: move switch chip_id detection to ksz_common")
> removed ksz8_switch_detect() but not its declaration.
> Commit 6ec23aaaac43 ("net: dsa: microchip: move ksz_dev_ops to ksz_common.c")
> declared but never implemented other functions.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: microchip: Remove unused declarations
    https://git.kernel.org/netdev/net-next/c/73582f090f05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



