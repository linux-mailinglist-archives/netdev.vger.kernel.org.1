Return-Path: <netdev+bounces-73095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE97885AD78
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 21:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85EF61F25112
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 20:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3464951034;
	Mon, 19 Feb 2024 20:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tgxktbnl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109E944373
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 20:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708375826; cv=none; b=HVLWgz5k6etYb2KuKRe/qsvY5k+Imp9BLEt4xpyVNjC6mFSznUBJEK78ZRFHVOw4uUY6CYvL8RZtERFB8b6UXwKpJMEfb7LVUyy0QM/UCTxOHYesyMS/EDrFHbMoHXrgcDve5yOo11AdwjwLB06axzgZFmQvWVSLxTPVMXU0Huw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708375826; c=relaxed/simple;
	bh=Nd8r//Xq7kL6tqDycvToSiqtVrQILiA1R9pFTnWMJVE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z5n76g2cmg2Szqn7kdExcOGLIlpU4gvFqttybBwY3cQpqzklxP9FxObR1Ul3wNoO90Cr9LH4z9N81xRgGeIIut8VAN06MhIRKRXUXncsLaG4rbIdLr0NY0Zd43sX4uCvr3260v6VdU1MnPwMjqRUkil2zsuKhzDVkT7ET9pvGts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tgxktbnl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84B96C433F1;
	Mon, 19 Feb 2024 20:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708375825;
	bh=Nd8r//Xq7kL6tqDycvToSiqtVrQILiA1R9pFTnWMJVE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Tgxktbnl36xlR5d3QZO1X+jFfppv0tmPi/JhxELhoN49ojRt3U14kGaNOF2VtME1t
	 0qLm36csjpkgu+CYsIzbvZI2qz4qWQ3+yAri+jo6eJsPEqfqULVLhNiRPhzSbox0wz
	 DsrXczNOwb9qp93Y4pAEIJenwuOFFnEtiF+PtbUUjL/jkjcNKtDrz3mNxnFm3IY+1J
	 mphNDmbk4fwa4PPhounFEbbe1AMOimddv3L9Uvh87Tg+AZBU6AwEo0fhSpB7nHwGcT
	 KALDvTePkBF39pXND/p1+rbvdnsaY9YWuHCIl2iwra1HwAcIRvO6+Fbfw2jLzMN+xB
	 TJRqdqYMVIPXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 683BBD990D9;
	Mon, 19 Feb 2024 20:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: page_pool: fix recycle stats for system
 page_pool allocator
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170837582542.30120.12359019871889942759.git-patchwork-notify@kernel.org>
Date: Mon, 19 Feb 2024 20:50:25 +0000
References: <87f572425e98faea3da45f76c3c68815c01a20ee.1708075412.git.lorenzo@kernel.org>
In-Reply-To: <87f572425e98faea3da45f76c3c68815c01a20ee.1708075412.git.lorenzo@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org, linyunsheng@huawei.com, toke@redhat.com,
 aleksander.lobakin@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 Feb 2024 10:25:43 +0100 you wrote:
> Use global percpu page_pool_recycle_stats counter for system page_pool
> allocator instead of allocating a separate percpu variable for each
> (also percpu) page pool instance.
> 
> Reviewed-by: Toke Hoiland-Jorgensen <toke@redhat.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: page_pool: fix recycle stats for system page_pool allocator
    https://git.kernel.org/netdev/net-next/c/f853fa5c54e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



