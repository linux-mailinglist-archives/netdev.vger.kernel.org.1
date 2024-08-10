Return-Path: <netdev+bounces-117367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D44694DAE9
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 07:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80CC21C20AB6
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 05:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57566381D5;
	Sat, 10 Aug 2024 05:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgJEz0O6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337ABEC2
	for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 05:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723267837; cv=none; b=KPZPoue1DEu62cgNyUhlFyqBqw6CW2lUN0clzUSvwP2c9RJd9cljMVKBvznxRqQUaGgLxcrrFvpBgVpdQB1ZNr3bg4fIoUGBZQLCU+CDl2q4v2OsOCBMgOxSPbRyMJPn57FGS/gHqi1ZwvBiY8OzJrkcIvxNm/ikTG9KnaZj1Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723267837; c=relaxed/simple;
	bh=wl+AAjeDmEO/wnAmYPdFRDa7nx2ufEA7rePBOPHd/G0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I03xw9i/7bwqjKMI9YnULq++yG2WSTmUHkMxScFmrGQyJgla3STQ43sHfdgS9qu5VsDt81NYDO6/teUCvMP896tkYXc3eDqcngk5bzLn1FEYGtU19EJcMN99HCS7LUI1v3exC/3wCFi6GallSr/8IDbuRC6pAQTSaJwlO5IR2ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgJEz0O6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B911C32781;
	Sat, 10 Aug 2024 05:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723267837;
	bh=wl+AAjeDmEO/wnAmYPdFRDa7nx2ufEA7rePBOPHd/G0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tgJEz0O6xYR8XN8SYBCUokVIzXPfC8LwfIC2nOvonLwsotyTdoKBhVQJKRs60ADx9
	 pAnHHgt6//aycxcM7Qc8WtyvUF4wapaxr6e4OoqoZtvAxxQRSLh4/Uv9fzQu25Ot3d
	 R0Y2qUKx1p4+xZd9ENSKBEAD1t+SgdA5S/aqgS/0ogWpeOdJD18ko8QaYUtdSzAZ3n
	 02pwgT7aFoi35XyuLgeSwsA0Jfadlc6+wPmhhdkBeZQM5SXTLLM+qStdCbGpOb5FXR
	 6cm1/T8ZM7G+DcYehr4ZmLKfVINnjlu2KidNK8O6a2w1Fl/m6hzAadLNiXZ+IcFQqM
	 5g/pMGLwizFRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FEC382333F;
	Sat, 10 Aug 2024 05:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] mlx5 misc fixes 2024-08-08
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172326783601.4146810.4423118138880091263.git-patchwork-notify@kernel.org>
Date: Sat, 10 Aug 2024 05:30:36 +0000
References: <20240808144107.2095424-1-tariqt@nvidia.com>
In-Reply-To: <20240808144107.2095424-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 8 Aug 2024 17:41:01 +0300 you wrote:
> Hi,
> 
> This patchset provides misc bug fixes from the team to the mlx5 core and
> Eth drivers.
> 
> Series generated against:
> commit b928e7d19dfd ("Merge tag 'for-net-2024-08-07' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth")
> 
> [...]

Here is the summary with links:
  - [net,1/5] net/mlx5: SD, Do not query MPIR register if no sd_group
    https://git.kernel.org/netdev/net/c/c31fe2b5095d
  - [net,2/5] net/mlx5e: SHAMPO, Increase timeout to improve latency
    https://git.kernel.org/netdev/net/c/ab6013a59b4d
  - [net,3/5] net/mlx5e: Take state lock during tx timeout reporter
    https://git.kernel.org/netdev/net/c/e6b5afd30b99
  - [net,4/5] net/mlx5e: Correctly report errors for ethtool rx flows
    https://git.kernel.org/netdev/net/c/cbc796be1779
  - [net,5/5] net/mlx5e: Fix queue stats access to non-existing channels splat
    https://git.kernel.org/netdev/net/c/0b4a4534d083

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



