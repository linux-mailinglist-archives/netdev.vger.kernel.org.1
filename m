Return-Path: <netdev+bounces-208067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B61FB09980
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 04:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EB2C1C46E6B
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 02:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6571A76DE;
	Fri, 18 Jul 2025 02:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="othhL9zl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBC31A23B9;
	Fri, 18 Jul 2025 02:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752804003; cv=none; b=JgWtjqjiZcK2jKkhj/Nj0DWVsg6Lise6oT8Ddt4Rm32uC+1EW+dipWTtvRQx2hJj5C4BAkZ6bdmTO1WioYwy5hvbWhfXJRMvZm0dvA7EHqLJKwOAIPysGOina4wTj9vDL+7ld0Sn4WYHIxX1rtkVURLW727f8vCv6QCoCFKz95s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752804003; c=relaxed/simple;
	bh=+7wiZuzj0yMoHnu/9si51sXowCgUOaXc6z20kcCoavo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=joPmLejwY9PfetMFxbmCblpwODdEZ/KI8HUuXApgl1VulKdsSj9A33PZwMteprIZrySskoL/CdNI+HyAm7XVWHNgQCIe7NwILhHQ+y0nET2WLky9aFS8chPLgh8tLfdULqFj+aSQEkk8VWHJsFsQYv4zOydqwVVnVvh0i92daho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=othhL9zl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5518CC4CEF4;
	Fri, 18 Jul 2025 02:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752804003;
	bh=+7wiZuzj0yMoHnu/9si51sXowCgUOaXc6z20kcCoavo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=othhL9zlqDZKNANGMD5wqYAxXWHOnO+EJXicl0LkPogteFiw3lnKHL1nM0dtw2Ag/
	 lzlvhFccU29AmSF7UpKMkW0x5BT1VofXb6kluoKea7xsZgBiVQc1oHyIDtNt3X+Kfd
	 P5eiIMaGjRg53w2x38Z3B5SuIgQSV4ZEJYTKlryPnkIj3UnDn/4Sio0PMnLfcyNKFL
	 joMRXq283+Ry97zN3CXiYK+7glguO2LVZ4GMf+mM0a694PGBGe/FGadtE2XYQmtQIz
	 f3mDyoWidkWAi4oEgr/qB+BDxOYpmVW8eJfoeUEvFpxgPUn4tgfDFAyLAgI+jwbHt/
	 t9Vo2GXXSZsnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BA2383BA3C;
	Fri, 18 Jul 2025 02:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: airoha: Fix a NULL vs IS_ERR() bug in
 airoha_npu_run_firmware()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175280402326.2141855.15347450324403463630.git-patchwork-notify@kernel.org>
Date: Fri, 18 Jul 2025 02:00:23 +0000
References: <fc6d194e-6bf5-49ca-bc77-3fdfda62c434@sabinyo.mountain>
In-Reply-To: <fc6d194e-6bf5-49ca-bc77-3fdfda62c434@sabinyo.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: robh@kernel.org, lorenzo@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Jul 2025 18:01:10 -0500 you wrote:
> The devm_ioremap_resource() function returns error pointers.  It never
> returns NULL.  Update the check to match.
> 
> Fixes: e27dba1951ce ("net: Use of_reserved_mem_region_to_resource{_byname}() for "memory-region"")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/net/ethernet/airoha/airoha_npu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] net: airoha: Fix a NULL vs IS_ERR() bug in airoha_npu_run_firmware()
    https://git.kernel.org/netdev/net-next/c/1e5e40f2558c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



