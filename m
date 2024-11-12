Return-Path: <netdev+bounces-143954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 441289C4D56
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 04:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 042BA1F23C92
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 03:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646CB205ADF;
	Tue, 12 Nov 2024 03:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYbw/CSp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40152204F7A
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 03:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731382222; cv=none; b=pNYEAjXSdJHtv58mJ31bZDiQqO1G7Th58AWQPa5MweYCHRFqZDOqBHuzOpETrMOrH30evEl5/NtpKXnDX4Ql6qViurO7Az86n4EpRqMgxWvqEOHkxrKK/Y6euRThU+20rjM2O96G4mdQA7l4SHOQyoBLLI2O+MnBkx0OJeBA1YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731382222; c=relaxed/simple;
	bh=B0tW7I/Ia1mrWLM9XCAQ652yW6gfdGhf+MQJ03xlO9I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P45V7Y2ADD4iEXTGiBz8VR816Nao6WSnHoAS7G8rNfpH+4Pzh025ZhGpKP2G4aG2uGQXije8Kj8Ik7rOQ2qo3wRYV+x8lWZBc4bMZqdoMltP2oU+s/wqR875ia+FAvmb80NkCvLWQIU+fDZuOhxCzLGYZmcx6VcXBUvinI8SYgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYbw/CSp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3BCC4CECD;
	Tue, 12 Nov 2024 03:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731382221;
	bh=B0tW7I/Ia1mrWLM9XCAQ652yW6gfdGhf+MQJ03xlO9I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sYbw/CSpwAHWdKsc0qc8Mg7qPNKDDWo8xtvIrFGwNvA/XEfulfHhsEbrgTImuJuKU
	 WX4JBi70C0EID2MX28lNCKSgFWddT/XEc15AGlA76lDZcudDjwnsEqYagu5VFGE9E5
	 IjnAsdZpy5SrOI+DIV7U8FMxnf5uEPl9OEqeh1VlJ+RJtlB1keQyJaHaOuUZDr/QON
	 DI3/Gfs5jYV44cionnvRQWJPWtEUYPJu6oa+ZE2f9hSQXy4Rh/pvODwWxjjUA9VOjM
	 JFQnpBFBeQ3ZKlEIwBNALYX8Miv4oVu4H+jGK+g1KM1pNPLb/iWXMOYo23XaYHRRNV
	 mitqbdLfGIlmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB7B23809A80;
	Tue, 12 Nov 2024 03:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/7] mlx5 misc fixes 2024-11-07
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173138223176.69157.16396705104896814239.git-patchwork-notify@kernel.org>
Date: Tue, 12 Nov 2024 03:30:31 +0000
References: <20241107183527.676877-1-tariqt@nvidia.com>
In-Reply-To: <20241107183527.676877-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 7 Nov 2024 20:35:20 +0200 you wrote:
> Hi,
> 
> This patchset provides misc bug fixes from the team to the mlx5 core and
> Eth drivers.
> 
> Series generated against:
> commit 5f897f30f596 ("Merge branch 'fix-the-arc-emac-driver'")
> 
> [...]

Here is the summary with links:
  - [net,1/7] net/mlx5: E-switch, unload IB representors when unloading ETH representors
    https://git.kernel.org/netdev/net/c/1220965d6191
  - [net,2/7] net/mlx5: Fix msix vectors to respect platform limit
    https://git.kernel.org/netdev/net/c/d0989c9d2b3a
  - [net,3/7] net/mlx5: fs, lock FTE when checking if active
    https://git.kernel.org/netdev/net/c/9ca314419930
  - [net,4/7] net/mlx5e: kTLS, Fix incorrect page refcounting
    https://git.kernel.org/netdev/net/c/dd6e972cc589
  - [net,5/7] net/mlx5e: clear xdp features on non-uplink representors
    https://git.kernel.org/netdev/net/c/c079389878de
  - [net,6/7] net/mlx5e: CT: Fix null-ptr-deref in add rule err flow
    https://git.kernel.org/netdev/net/c/e99c6873229f
  - [net,7/7] net/mlx5e: Disable loopback self-test on multi-PF netdev
    https://git.kernel.org/netdev/net/c/d1ac33934a66

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



