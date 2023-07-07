Return-Path: <netdev+bounces-15948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A8974A8DF
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 04:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B513A1C20EF1
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 02:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8221114;
	Fri,  7 Jul 2023 02:20:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1067D7F
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 02:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A7DFC433CA;
	Fri,  7 Jul 2023 02:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688696424;
	bh=+JaKem95dxKHw7PgPfFmcPVu10hw5IcWQ6wMI3GuIVI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JFRJrPoHgmKhUeqUKTus47mZsro1TeXvGFwzv34Gshm7ZtpGQ2Dom6zpIppC/mwMN
	 Z5PReWNc2ZIjXJf9k/mzrQo/wWhcf6fTaUgoRE6b2BmnQUK47zZibVbuu5ailwK4K/
	 yOuk9MGSbD9dVZtph6ko1DdkldjnmBBlJVr+/p+wH+hzxchcAnfIaOPhC4jClOWfoC
	 HYxg6iEt9gyBn2YpjwyecOORJAeQaCoHkfC0o/RJZv5A/+j+9PGj/S3AWRdx4T6JMr
	 MpS5VItpnTakP9cvgcv5x7NofYl981HiUZylnWlt+1UZYhDQgYqbPWYmmoXbiP6ySa
	 NeoB1+pjZB/IA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5718BC73FE1;
	Fri,  7 Jul 2023 02:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net V2 1/9] net/mlx5e: fix double free in mlx5e_destroy_flow_table
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168869642435.27656.16292824662024422242.git-patchwork-notify@kernel.org>
Date: Fri, 07 Jul 2023 02:20:24 +0000
References: <20230705175757.284614-2-saeed@kernel.org>
In-Reply-To: <20230705175757.284614-2-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com, shaozhengchao@huawei.com

Hello:

This series was applied to netdev/net.git (main)
by Saeed Mahameed <saeedm@nvidia.com>:

On Wed,  5 Jul 2023 10:57:49 -0700 you wrote:
> From: Zhengchao Shao <shaozhengchao@huawei.com>
> 
> In function accel_fs_tcp_create_groups(), when the ft->g memory is
> successfully allocated but the 'in' memory fails to be allocated, the
> memory pointed to by ft->g is released once. And in function
> accel_fs_tcp_create_table, mlx5e_destroy_flow_table is called to release
> the memory pointed to by ft->g again. This will cause double free problem.
> 
> [...]

Here is the summary with links:
  - [net,V2,1/9] net/mlx5e: fix double free in mlx5e_destroy_flow_table
    https://git.kernel.org/netdev/net/c/884abe45a901
  - [net,V2,2/9] net/mlx5e: fix memory leak in mlx5e_fs_tt_redirect_any_create
    https://git.kernel.org/netdev/net/c/3250affdc658
  - [net,V2,3/9] net/mlx5e: fix memory leak in mlx5e_ptp_open
    https://git.kernel.org/netdev/net/c/d543b649ffe5
  - [net,V2,4/9] net/mlx5e: RX, Fix flush and close release flow of regular rq for legacy rq
    https://git.kernel.org/netdev/net/c/2e2d1965794d
  - [net,V2,5/9] net/mlx5: Register a unique thermal zone per device
    https://git.kernel.org/netdev/net/c/631079e08aa4
  - [net,V2,6/9] net/mlx5e: Check for NOT_READY flag state after locking
    https://git.kernel.org/netdev/net/c/65e64640e97c
  - [net,V2,7/9] net/mlx5e: TC, CT: Offload ct clear only once
    https://git.kernel.org/netdev/net/c/f7a485115ad4
  - [net,V2,8/9] net/mlx5: Query hca_cap_2 only when supported
    https://git.kernel.org/netdev/net/c/6496357aa5f7
  - [net,V2,9/9] net/mlx5e: RX, Fix page_pool page fragment tracking for XDP
    https://git.kernel.org/netdev/net/c/7abd955a58fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



