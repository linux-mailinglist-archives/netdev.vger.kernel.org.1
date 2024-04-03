Return-Path: <netdev+bounces-84249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC35896270
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 04:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0D7E1C23A5F
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 02:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9804517BA9;
	Wed,  3 Apr 2024 02:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFGzrk8S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746B817995
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 02:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712110827; cv=none; b=oim0PZ5WxnD3fyYsXFaKlweWJrnkXd1LI/J0ARpNd5XLoc2VhN5x2Hkfh4NeRNVl5OOobcXwCGI2x+0+ZaRpjyUMuJQySJ3yY0HYFbFie2EqJdptEVueumRaT5+e19Pl+/We2h5Ux11G9ffdJo3RHOudu2JVF5gpQhWdu9f+KG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712110827; c=relaxed/simple;
	bh=O4rVRkh8ibH2EHG1HtjllDwxnIxa9WpKtVaiDoPyJd8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e2aBHXs8/K1TtI7bjRKZMjcoy+G7MEHcjRmm4q5y8X5redqJ3FrxBExlQiOI3W1orbARlCUTj8gu5yO1KKtC/8/QI41mvMcwGSv0Wzgom5aywtJEVv60QDNtBM5a4QtwXBnzEZO6eF6XwvZvQgifPSvWpAxa7TgpcrHxIbgOoKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFGzrk8S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E893EC433F1;
	Wed,  3 Apr 2024 02:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712110827;
	bh=O4rVRkh8ibH2EHG1HtjllDwxnIxa9WpKtVaiDoPyJd8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vFGzrk8SYuQNuLJXbl6XoKhTplODHVRgzTmd8WOkCBz4rJrrBuH7XyVGMggVWkcxL
	 CV9sbGLJ4Z8Ot63epFew9RNMDfq6tZ/JfYcbNTe0MEhYeDnjr3zKbK/8L+/Ooy/CCD
	 SJvBwGDVGz6g3DOZv7u+wrK0E42YykkNFZhT7DEgFey5AdBa3aFmvC+3/n3A31Fec2
	 Kt87aIC5I375OIDekXNCvxCIcHxR7JlwhyJxM64+IJgK34x7PIEr4FP94Zk2LndJe+
	 gqB2/HmObMo918jDqFWNzed/oqGu5UY76svTc7duNM16qiOBIsQ8cuAii9024zH8Vi
	 vk0UqRQ3mov/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8EADD9A155;
	Wed,  3 Apr 2024 02:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] MAINTAINERS: mlx5: Add Tariq Toukan
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171211082688.1409.14999615272343037150.git-patchwork-notify@kernel.org>
Date: Wed, 03 Apr 2024 02:20:26 +0000
References: <20240401184347.53884-1-tariqt@nvidia.com>
In-Reply-To: <20240401184347.53884-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 1 Apr 2024 21:43:47 +0300 you wrote:
> Add myself as mlx5 core and EN maintainer.
> 
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Reviewed-by: Gal Pressman <gal@nvidia.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [net-next] MAINTAINERS: mlx5: Add Tariq Toukan
    https://git.kernel.org/netdev/net/c/c53fe72cb5ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



