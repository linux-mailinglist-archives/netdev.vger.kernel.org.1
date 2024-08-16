Return-Path: <netdev+bounces-119330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4521D95528E
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 23:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2931B20EB3
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 21:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467961C6884;
	Fri, 16 Aug 2024 21:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xdi0RaRj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2312C1C6880
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 21:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723844432; cv=none; b=ar5MYsOorNYDVXf9DuSrY38zz2m3KnBNxdp1TjgRnBwYquj63CDSj0vNqhZDf0TIs+XJw+bvUVyp9sWBq+HOlfKnA2elm4jQFVmCl9SEFjcAC7q2aPaIQ8j6IQFqHmC4iijq2jdv+hlrIJ24vxzL2byabSFUhJr6FXMjy38lOLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723844432; c=relaxed/simple;
	bh=bA//3liUewtGBpq7C5Za5gSl5dAGa8Z27ODn4AWwh/Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kb3Ojqjb1CD9NpaOPhmxrrLUMB2900UCd+mpcFly442qrbyi6mhYtntPSvoNSss6tG+IlVBkQmrqQFcEjM39vdLGbr6YWmhxobddAaffmH4szG+S4dZHdy/xj8l8bRkM+uWIChU4nxpVRTOJd8UP9zUfl4a1eh4Y8FPJGRVSYqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xdi0RaRj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC272C32782;
	Fri, 16 Aug 2024 21:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723844430;
	bh=bA//3liUewtGBpq7C5Za5gSl5dAGa8Z27ODn4AWwh/Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xdi0RaRjPn/VXJo3x8avRKeoIIl6ezCyLJWnollFHw4VLYTV1rffq6yNlC7fJhY3y
	 naQgbNwMONIqfJSwV4ObchRNwARkcdevo0q2PZhyRDo5QkcASYxhHxggdu3kAExAAu
	 3ggOK1z/K6LVs3MuHjh4Ane09b1rI16Umz+l+u9f3dBxpnuMvOguTl80WNLpidRWby
	 UauHNQGnl703tQQaR9tf3ZTC7N17gJwixMnLVAJGwg2jf8h5EUS0Bq5JBpOg3z2trm
	 6rtWSuEy0P5+C1kntxv/G+4MGxj8R6uuhwqE7HJufa2q5OkVPeP6BwSLx2VGoHHufv
	 ikq4I8rz1mIKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D1638231F8;
	Fri, 16 Aug 2024 21:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] docs: networking: Align documentation with behavior
 change
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172384443000.3634446.7662477584198998934.git-patchwork-notify@kernel.org>
Date: Fri, 16 Aug 2024 21:40:30 +0000
References: <20240815142343.2254247-1-tariqt@nvidia.com>
In-Reply-To: <20240815142343.2254247-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com, dtatulea@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Aug 2024 17:23:43 +0300 you wrote:
> Following commit 9f7e8fbb91f8 ("net/mlx5: offset comp irq index in name by one"),
> which fixed the index in IRQ name to start once again from 0, we change
> the documentation accordingly.
> 
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next] docs: networking: Align documentation with behavior change
    https://git.kernel.org/netdev/net-next/c/9480fd0cd8a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



