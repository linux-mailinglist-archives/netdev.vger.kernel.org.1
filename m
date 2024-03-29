Return-Path: <netdev+bounces-83181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C58891373
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 07:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 807CA1C233CF
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 06:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1AC3D388;
	Fri, 29 Mar 2024 06:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2V3spuJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484573C08D
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 06:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711692033; cv=none; b=OOIoNNCSyjxpNlhwiVqB/MAuQfx+51ws/LGW/CjyppoE8l6d5GZYiK4wOUs1Y9i2blDd0ZM2Q+XGxMN9lPAEmdqojfE/X8Fv4eLPHUeHpcdp/nrmEFmflcuNeHMQ83XwyCl37Jn8YVc8xnGf0lMpEtAQLaQqbm4MmZNeHGpevQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711692033; c=relaxed/simple;
	bh=wU56z9fAxU1EBaUTxY/N17vhlocV/A0qxxapQtMU79U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SijdW8RsuihGA0yGvDFUvCV6iIbGsOdzLgJwlWzth8HO2ECilxb/aj4L41T3dtfNHewlZKiYNm9QZy4AUrzDanDTcRFcTkmOTNPb7z5Ks0HJo7Mw4bnPVinEcZpazqwnonqKDzTDyBpuuIurfmrK8Rvjc/hhKGqrdmmfo/L1u+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2V3spuJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B34C6C43390;
	Fri, 29 Mar 2024 06:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711692032;
	bh=wU56z9fAxU1EBaUTxY/N17vhlocV/A0qxxapQtMU79U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U2V3spuJhMyERNqka4j3IkdqJ6XH65kokML6T3ouP8RdmQDFjvFscZaF4FFBZsf2Q
	 IMeSQVeLvIouzmh1vYY/O6RS+rgNy/rge94Ey1G2r/TxNV8EFmFOehw3QlN6pyEFV+
	 pUFjbQwkcQ0z7KzBh9i/9FVK1NvReMjeaHFkcaMWMHd7bhR7hZ8rElv5PrBFlzEBPx
	 C35/8skDsIVJX37SDyRpfJIxb4bI6Y+vfUXg48HvqS9K7W65//dgH2syb5SPGu3692
	 NNECD5M3XLIuNM05BF2FKPhbPgk30qZhZDYK4hsGbLs5e5SlkzUctWSTzRcCzC0Hs3
	 +1CIGyoQKNjuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A5E8ED2D0EB;
	Fri, 29 Mar 2024 06:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8][pull request] ice: use less resources in
 switchdev
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171169203267.14797.9683393618849219656.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 06:00:32 +0000
References: <20240325202623.1012287-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240325202623.1012287-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org,
 michal.swiatkowski@linux.intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon, 25 Mar 2024 13:26:08 -0700 you wrote:
> Michal Swiatkowski says:
> 
> Switchdev is using one queue per created port representor. This can
> quickly lead to Rx queue shortage, as with subfunction support user
> can create high number of PRs.
> 
> Save one MSI-X and 'number of PRs' * 1 queues.
> Refactor switchdev slow-path to use less resources (even no additional
> resources). Do this by removing control plane VSI and move its
> functionality to PF VSI. Even with current solution PF is acting like
> uplink and can't be used simultaneously for other use cases (adding
> filters can break slow-path).
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] ice: remove eswitch changing queues algorithm
    https://git.kernel.org/netdev/net-next/c/8c67b7a914cc
  - [net-next,2/8] ice: do Tx through PF netdev in slow-path
    https://git.kernel.org/netdev/net-next/c/defd52455aee
  - [net-next,3/8] ice: default Tx rule instead of to queue
    https://git.kernel.org/netdev/net-next/c/50d62022f455
  - [net-next,4/8] ice: control default Tx rule in lag
    https://git.kernel.org/netdev/net-next/c/9cba6e1767bf
  - [net-next,5/8] ice: remove switchdev control plane VSI
    https://git.kernel.org/netdev/net-next/c/33bf1e86231d
  - [net-next,6/8] ice: change repr::id values
    https://git.kernel.org/netdev/net-next/c/6235cb6e5b0d
  - [net-next,7/8] ice: do switchdev slow-path Rx using PF VSI
    https://git.kernel.org/netdev/net-next/c/44ba608db509
  - [net-next,8/8] ice: count representor stats
    https://git.kernel.org/netdev/net-next/c/4498159a5093

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



