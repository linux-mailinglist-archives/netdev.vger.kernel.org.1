Return-Path: <netdev+bounces-128290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D4A978D58
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 06:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECE2F287B8B
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 04:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356197344C;
	Sat, 14 Sep 2024 04:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eP/ioJ61"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C86428689;
	Sat, 14 Sep 2024 04:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726288244; cv=none; b=tqnhu5oZA/d4MhVDklW4xU43PWj485bEmsLB5zRLsadgnj+VdGVsr0I8fK4/eln0l3cKp8b4uvJ0JfPnTqB/vya5Suw26K6jvMbKw7gUJj6QWWwX0KDOpGp8JkjfyjAPfhZwX/dtGfNvJru3l/IRsycDi8S7nvgK9+K/kcV0gAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726288244; c=relaxed/simple;
	bh=gX8FjFm8+rZzyOuFKZmByOKTL8BxWdICKbVdqrOJtjE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YGtzT1wICx18CnHLc8lViTdk/hzlwOOCPLKmf6ADyTFDPDKUDe7CU9HBfZVSX+4X84/h6DoPdz73PBCxJEfEM8zfSXH0zUCR2LwdyYkQK8zudJMZCj3Tavlhj1JGEXCnzl+X9JUp2C48RO/m6STwp1IVAAtJ3O2OVHKUqRQfCqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eP/ioJ61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3ABEC4CEC4;
	Sat, 14 Sep 2024 04:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726288243;
	bh=gX8FjFm8+rZzyOuFKZmByOKTL8BxWdICKbVdqrOJtjE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eP/ioJ61s44REdmUGkyUmVIJGt3cHDGInxWArBLMlarVPqJEYqPp2rM0pFUaEqpaM
	 VG6Ql9KXMt4e3/jLbfApP6EUhf0kNmpC9mHyyjdoWiERRiSThjrGkKoo5dL8p3ftOi
	 Fq4XDp6Svea5npVa7TDnPFsGa6O8cFNdLkK30UaSFXu3xpgzmHhXub1r5ifujO4QJa
	 yis3rW/in42uX3KplgvePw0J3K49SEtWCL2NuMQNiD8QvqEMfv8xvGQLmegm2rEzYV
	 ZFjY2l9WmyoIJlTF+6+rO7SJMxNAsCwWzR5ZW+FSrevlJT87p84k9kGNqyd3Kpk0bN
	 X0BML/rhXu6CQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 346B43806655;
	Sat, 14 Sep 2024 04:30:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] rtase: Fix error code in rtase_init_board()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172628824486.2458848.11010446236065995234.git-patchwork-notify@kernel.org>
Date: Sat, 14 Sep 2024 04:30:44 +0000
References: <f53ed942-5ac2-424b-a1ed-9473c599905e@stanley.mountain>
In-Reply-To: <f53ed942-5ac2-424b-a1ed-9473c599905e@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: justinlai0215@realtek.com, larry.chiu@realtek.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Sep 2024 11:57:06 +0300 you wrote:
> Return an error if dma_set_mask_and_coherent() fails.  Don't return
> success.
> 
> Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this module")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/net/ethernet/realtek/rtase/rtase_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] rtase: Fix error code in rtase_init_board()
    https://git.kernel.org/netdev/net-next/c/37551b4540bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



