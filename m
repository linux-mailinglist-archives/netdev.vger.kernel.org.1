Return-Path: <netdev+bounces-202546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7DBAEE426
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F334718888A8
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F9629114A;
	Mon, 30 Jun 2025 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/Hmesgz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8141528DB5E
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751299781; cv=none; b=UAJxnLudPXZ5UuOBLlu+vbVyH7sXQuGXP+oZzu32oa+3MItAG4oAyY9wb5RB7C/8w4psuQEoPlVI748e5F0Tcc34xCfhGPsz8pZVy7LQBrbxCkYHt77okHXPA75ni95U5yNTAXG5QS0VNWXccpaCBvFU4G3aqFntD9VGpphkfWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751299781; c=relaxed/simple;
	bh=oc3A0fBD3A7C8IaRwhv+y8jFRhSlkuAC28vsIE/cw60=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XBAmyiG75rqfFrXZKZJ2OLtosEO/Xwnw/MXlZuZVgnspHivc5QljGk/PiSFEHLNtyY/hyIn43JYrJdXCeQCPl90MMrhRhRvMR99lsU9uWMLUpf7jW+LQZFsevVJOdqFi7ng/Tfhi3kBg/XrUkIYlDzUW5iCdeO90f7+oejnBWD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/Hmesgz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5459EC4CEE3;
	Mon, 30 Jun 2025 16:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751299781;
	bh=oc3A0fBD3A7C8IaRwhv+y8jFRhSlkuAC28vsIE/cw60=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O/Hmesgz+v4Vccwc3OduJ6UR7MffNFxT6PTXbS/SsqIRa3TqU5H15yCZGA9NwhYqb
	 PUU8/ijWzbkgvn8kDP4iY2LQw/TxJw9TE1kPVV2ZquhJYXc9YP7YN4l6cP5KJFGtTf
	 o4/jZ3AxBIqo6ioEnEkgLSrX3JTgXguIMBAJQ2jzy+UxU3vVq3dRoEfEcs5uxEcPQH
	 /3qLC+THFtNeUptGjsQmCPB2sqTisV3RpoYmqrGbrKNGmKustYRm/HpYSsyjeOYSOA
	 LVdC7sTZytwUPDr/BfYdItYA3Vaq61W5Am+QGrArbFk2De650dYyalr5pNSN1xPla3
	 rx2TQCpjESkaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF87383BA00;
	Mon, 30 Jun 2025 16:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] MAINTAINERS: Add myself as mlx5 core and mlx5e
 co-maintainer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175129980651.3437924.8372418118753575516.git-patchwork-notify@kernel.org>
Date: Mon, 30 Jun 2025 16:10:06 +0000
References: <20250627014252.1262592-1-saeed@kernel.org>
In-Reply-To: <20250627014252.1262592-1-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com, gal@nvidia.com, leonro@nvidia.com, mbloch@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Jun 2025 18:42:52 -0700 you wrote:
> From: Mark Bloch <mbloch@nvidia.com>
> 
> I have been working on mlx5 related code for several years,
> contributing features, code reviews, and occasional maintainer tasks
> when needed. This patch makes my maintainer role official.
> 
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next] MAINTAINERS: Add myself as mlx5 core and mlx5e co-maintainer
    https://git.kernel.org/netdev/net/c/60f7f4afaf6d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



