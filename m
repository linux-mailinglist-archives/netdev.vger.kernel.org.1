Return-Path: <netdev+bounces-237600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACDDC4DA31
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 13:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72634189C2BF
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 12:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A685D358D01;
	Tue, 11 Nov 2025 12:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzODyf1n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D68357A5F
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 12:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762863640; cv=none; b=Q0LTQwVIF7uz7MTmjUFivOHsuCNj4FUW9q0DHOO1uf8hHz/iUM8A3OTaicdkIAmZF1HJXcRxnqfQVDvi+w666a18QqW8QrQp8URosZFQJq9HCtGwht/BKhnNFJ2ajF7NQlEsh8u9Q/26RbC561a0Y4xODWR6qBLI0EEQbpRtvBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762863640; c=relaxed/simple;
	bh=00T8/7KTOdsRHJPQVc5lMiZjzXf/GiSbMeDbcR65TXg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ItGHWHv1L51nyqQbYH0NqtL+NcnMPTeF6eRdXme2q3sYngB5P7F2/zc+lvk+08voVZw+i9HJqxlhKi3SM+LwS1sJ7FgDRe2lMDszZQydSo6krLYpu6CFc42+5qozTYcJVdFANXQ5B35Wag+4wBlu5o9o4w1jQV7aQFdnlFPd4SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzODyf1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1C9C4CEF5;
	Tue, 11 Nov 2025 12:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762863640;
	bh=00T8/7KTOdsRHJPQVc5lMiZjzXf/GiSbMeDbcR65TXg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lzODyf1nQw4g4It3Pilk7QFn0iLcOFFlT2sD+xlVQWnXbaNyFpFSKrt0IV7xNZ9lt
	 bQIrmrdc6e1pC2JifKa6xuEPGShm3UiTWURZ2VBMOD9kJLkNUg6HbRdvldj/WlYHh8
	 5Hi5ULYR8gs4RdMomSM6fmKNPV0+Afi1JiM/iHa5mDeJRct5+hQCfE1d/a7At3AOh6
	 F7XI223pAF6GE20Wyx7M+PRGDDxZVCCBQPVYrsK+6KEgf0ZxoVKf3u1UuChyYwUlRA
	 fF2ts0OeBQ3weshPj6q9EnsrLOi0qv6uuHU+tSB6QhjUmowJrmZr+6e0QrZSNtPKXd
	 k7TaagorNqonA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF1B380CFFA;
	Tue, 11 Nov 2025 12:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V3 0/3] devlink eswitch inactive mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176286361051.3417146.8495442358677824245.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 12:20:10 +0000
References: <20251108070404.1551708-1-saeed@kernel.org>
In-Reply-To: <20251108070404.1551708-1-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com, gal@nvidia.com, leonro@nvidia.com, jiri@nvidia.com,
 mbloch@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  7 Nov 2025 23:04:01 -0800 you wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> v2->v3:
>   - Fix cocci check %pe
>   - minor improvement: create FDB drop counter once.
> 
> v1->v2:
>   - Introduce new devlink mode instead of state, Jiri's suggestion.
>   - Address kernel robot issues reported in v1.
>       no previous prototype for 'mlx5_mpfs_enable'
> 
> [...]

Here is the summary with links:
  - [net-next,V3,1/3] devlink: Introduce switchdev_inactive eswitch mode
    https://git.kernel.org/netdev/net-next/c/0e535824d0bc
  - [net-next,V3,2/3] net/mlx5: MPFS, add support for dynamic enable/disable
    https://git.kernel.org/netdev/net-next/c/9902b6381d76
  - [net-next,V3,3/3] net/mlx5: E-Switch, support eswitch inactive mode
    https://git.kernel.org/netdev/net-next/c/9da611df15aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



