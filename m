Return-Path: <netdev+bounces-140064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 634279B524F
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 990F8B21AA0
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 19:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A5E207214;
	Tue, 29 Oct 2024 19:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6ncj07F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599C0207212
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 19:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730228432; cv=none; b=BehT65zeNr6XfZKcI7q3cjQvcS9u+TNTaKUf5On+ZKHs3ziNuydZM7YuwDiU26CiXSW0tJraVY13QVhIb/se6qjbYbK92gLGjCVHBZ4Aja3QC2W+GsoucftlDsHKPzwL04RWPqJuf/T4U7bHsp2ayVFDEFqvFalPpfjO46wOsdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730228432; c=relaxed/simple;
	bh=hr54iaOXzXc73j2jtDwCoKf72W5Hy01aPZ4C82ylQoY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cSkWoi6xT506YACQOeN7uSfjwkn+JkKksUKSPq2jYJhFpI0ahE8NrtdgffRvCfm7OfUp5LV3nGEKrYEwbvEQhUvcc/dBV6X7CUiHoHPK6dDkk/sHfz6CSzm62UNSY3i3+Xloh+3CYkm/EqMi60uIr5d/Sem1HK/3CWpMXSVGIws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6ncj07F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DD9C4CEE4;
	Tue, 29 Oct 2024 19:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730228431;
	bh=hr54iaOXzXc73j2jtDwCoKf72W5Hy01aPZ4C82ylQoY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m6ncj07FdZrK1peQsXs5CbPXeEwTbYGsamB8OPfhauFGNKjA8iYddA6+r2LZ8JMUw
	 eVl+KKcD5KGl2gzDBlIWxbAjFUbtSMGBSS1Vb+e8EbTKGbmBwPFtWCVGWnf0ykn8CS
	 qEeMKoOGKsuGXL3NrcV9wOr+YF7HHi9Rnkf30ouLHb6j98+SNoL+XU9dejluMCla9G
	 5jPioCKHIkwPNeVwOM0CQelnPApv7eiYCqaLlemkgvdeRJeSDwIuDnXL5uaLRs3pho
	 Z8Gl2eCfoc7Yo4WGzlgKOcpf/q3PuHviGx3r0Z6mFXHAl6Q36sU5XR3w+a6jvhMr8j
	 FUAeKGgldU+EQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE02A380AC08;
	Tue, 29 Oct 2024 19:00:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] mlx5e update features on config changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173022843923.790671.8221557596485555324.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 19:00:39 +0000
References: <20241024164134.299646-1-tariqt@nvidia.com>
In-Reply-To: <20241024164134.299646-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Oct 2024 19:41:31 +0300 you wrote:
> Hi,
> 
> This small patchset by Dragos adds a call to netdev_update_features()
> in configuration changes that could impact the features status.
> 
> Series generated against:
> commit 81bc949f640f ("selftests: tls: add a selftest for wrapping rec_seq")
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net/mlx5e: Update features on MTU change
    https://git.kernel.org/netdev/net-next/c/7999da12a670
  - [net-next,2/2] net/mlx5e: Update features on ring size change
    https://git.kernel.org/netdev/net-next/c/a7b6c074e42d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



