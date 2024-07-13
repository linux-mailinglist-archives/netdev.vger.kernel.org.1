Return-Path: <netdev+bounces-111312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D109307FD
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 01:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70CA5B2219C
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 23:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F0C7346C;
	Sat, 13 Jul 2024 23:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tu14vWQ2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE8C10E0
	for <netdev@vger.kernel.org>; Sat, 13 Jul 2024 23:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720911632; cv=none; b=W2UzSJ2h33m0qIN54tSiWfVrDMmYgmSr14DhLELj2eZ6VNZlKdjW3cZpQ+YjE1wST0NEEJ1B5v1kFBOJ/1EokM+Ps9EhVyGLbS/eWOVoNcKjxj+i61ZWKH+YFtQTLjMK2wol1ZqdC5dR58GapAdCUbwBm+Cuh8QtauKzaxvS6rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720911632; c=relaxed/simple;
	bh=3w2RQ2CpuVXiiDnw8Nfw0w6rCLFSxSJhj6vLoF0Z2AI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EuwSXqMrIeHvIhI+VDesS1oLKJ7Ku4pEV64LTMXsE6oWVkJJ48Qe0CVbnFIKX7MjuGpC8aWooXkppQfMgpfW+s2+gtSb6tHQ8BIn0lmMr2XTiQIwGZE3B+l82e+oGS3qj0J2//lu7saEXEOg0HRyq4s9nAnH4Dj+7CZt6ymCJvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tu14vWQ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB886C4AF0C;
	Sat, 13 Jul 2024 23:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720911630;
	bh=3w2RQ2CpuVXiiDnw8Nfw0w6rCLFSxSJhj6vLoF0Z2AI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tu14vWQ23JyjJPZCyBg0AxYvV6Uv4T7dDbV6oFC3V6VpwhjpsQfdaOGKx4eH023Pw
	 GJsSynOEqz7xZxNeD+k4pzEz4xgPAyOkFelmWzRoRatp//z4LjcEEG6Cbn+lRc9lya
	 XaDuIw8BWt1jtdvY93edKM0MMLG6gioTbt2MdMSPr/YI+m2pKLHvCxSg0aul/98ZZi
	 +NCh/P/xbPtiH8+u0W37L70GvaCE5PdUrkpfX3zWJgS1n/3WXmtRq31dbXRsVENAco
	 YMdeHacm49i1CrY8fr3TA7XXJH2JRLqkNtahqblxjslTd6BaeBy2eAW1Zcq3PLaj2c
	 V8NAtqQiOFEzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3DEFDAE961;
	Sat, 13 Jul 2024 23:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] eth: mlx5: expose NETIF_F_NTUPLE when ARFS is
 compiled out
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172091163079.4696.3679979428347302498.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jul 2024 23:00:30 +0000
References: <20240711223722.297676-1-kuba@kernel.org>
In-Reply-To: <20240711223722.297676-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, tariqt@nvidia.com, rrameshbabu@nvidia.com,
 saeedm@nvidia.com, yuehaibing@huawei.com, horms@kernel.org,
 jacob.e.keller@intel.com, afaris@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jul 2024 15:37:22 -0700 you wrote:
> ARFS depends on NTUPLE filters, but the inverse is not true.
> Drivers which don't support ARFS commonly still support NTUPLE
> filtering. mlx5 has a Kconfig option to disable ARFS (MLX5_EN_ARFS)
> and does not advertise NTUPLE filters as a feature at all when ARFS
> is compiled out. That's not correct, ntuple filters indeed still work
> just fine (as long as MLX5_EN_RXNFC is enabled).
> 
> [...]

Here is the summary with links:
  - [net-next,v2] eth: mlx5: expose NETIF_F_NTUPLE when ARFS is compiled out
    https://git.kernel.org/netdev/net-next/c/3771266bf841

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



