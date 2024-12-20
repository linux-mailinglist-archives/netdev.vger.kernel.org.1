Return-Path: <netdev+bounces-153573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10DD9F8A9F
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 04:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 722617A41E8
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 03:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA58156C40;
	Fri, 20 Dec 2024 03:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkkDxW2g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735204501A
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 03:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734665422; cv=none; b=bpgC6GVWKEXPjizeQVj1UcHq1HpgSPKeemCCFdfJQ2N4lC4rh1qI4KeE2AewD/jMlgUQVozmIrZthAs7iV2qNd4bmdpEAtNQBj/AK4RBnwGxIVM/S15WQ7WSG4u7RVyr4WJWCFfULhVETpzVPWBR6x79tg65fPhvmQsMbgw1GCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734665422; c=relaxed/simple;
	bh=+rxoxI/51iCRUT4+GDTvzJHOnNeGePnj/c6zmS8zVHg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s8kFaXOLwg7jdlyAX0hpJsneusRg+zRmbKtGy1AHFVMYGDoSB5qi/9kGo82Qj0zFQDz7hqL8rGFdCiY0pJRLfZqm97iUTJOd2GWUDmOve66fJwon92qqsO4OQciHGUhg5PW8x2MdkRO2oYCczCByzz9KPOp9S+u2tBZ3sx+L5G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkkDxW2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F81C4CED0;
	Fri, 20 Dec 2024 03:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734665422;
	bh=+rxoxI/51iCRUT4+GDTvzJHOnNeGePnj/c6zmS8zVHg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RkkDxW2gEpF5enaLndQm/9mcmH4M/EO66+oUc/tl0nEK50s+R9w2LN8ecbzoLF8aT
	 XSMv5LY8puzyrNOjxJamy2YfPGxF9LhScEzLFGLe4msI3XciBIX+0/nCF9pUeLdOj3
	 W1fhJsbaE8eLpCraLBy9W1z0AIiZoyZCe6azEh43mP/iZx+KUVkfq6KGxNI5k7KzY1
	 CjcijsR0sYQyB8NwIt/K81slNuNy3GjBRN2cqQ+c//DI/nw55Bo9dNWYqYix05fCkU
	 PY9m8vqZBGi95gJkXGAN0OZXXftuZUyRbd1lgg4okXebEFG5SBspxGCYyPBISvDmYl
	 FKd9M5U/j0YTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD3C3806656;
	Fri, 20 Dec 2024 03:30:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: airoha: Fix error path in airoha_probe()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173466543949.2462446.3986917315473515090.git-patchwork-notify@kernel.org>
Date: Fri, 20 Dec 2024 03:30:39 +0000
References: <20241216-airoha_probe-error-path-fix-v2-1-6b10e04e9a5c@kernel.org>
In-Reply-To: <20241216-airoha_probe-error-path-fix-v2-1-6b10e04e9a5c@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: nbd@nbd.name, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, michal.swiatkowski@linux.intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Dec 2024 18:47:33 +0100 you wrote:
> Do not run napi_disable() if airoha_hw_init() fails since Tx/Rx napi
> has not been started yet. In order to fix the issue, introduce
> airoha_qdma_stop_napi routine and remove napi_disable in
> airoha_hw_cleanup().
> 
> Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: airoha: Fix error path in airoha_probe()
    https://git.kernel.org/netdev/net-next/c/0c7469ee718e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



