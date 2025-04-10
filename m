Return-Path: <netdev+bounces-180977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D59E1A83557
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 03:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80A40179894
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 01:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046121E102D;
	Thu, 10 Apr 2025 00:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDtoEt4v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BB71E0E0B;
	Thu, 10 Apr 2025 00:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744246798; cv=none; b=VW3y6Xa3MGKYrahZz85PGfNec8wdEXDWBkhTuo/wM96h2lwiftLKZ08g0wDdpjvpVNQZmYHLJBkKwFXu6sDaYNVf43oViCH6cPZY3SdtADuhVREHLF5u0lp0WTF/ozpPGB4skpo2qsSj/oED8+xXVQ0SmGHqhXpBqDhsJ1/1uTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744246798; c=relaxed/simple;
	bh=PeCn8AzAC6MQrT3G2lq7oLtiR4IzIpTGthfWBZfWC38=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ez8CaJYNyCKeEsyfxFwfi+aN+VGMHsIQUkh1mNIA5f+aOujQm52E5xxn/BzcYc1xQfeopKfFIaMHJd6kLpsQ0dtly6Au0Huq8JxIGKqPhcAAX9O2f3PC3JZssIUc09X9ulOdFv7QmWw/2aY/ys6w90xppbC9/mzSrL12nSa06JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDtoEt4v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39050C4CEE2;
	Thu, 10 Apr 2025 00:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744246798;
	bh=PeCn8AzAC6MQrT3G2lq7oLtiR4IzIpTGthfWBZfWC38=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KDtoEt4vSmFrqbOa2nyjOtKtA3h5hC0CHivn8edv8jZtrljPXVybpSDhIubhv0LEy
	 uuUeKTKuEx3vkUuYkPMRo17J6k/AJFh4qx24BysX1OLnFypDw8NbSNbtRKy0DqYAA4
	 WAYQ2ZwQLbXhUyFV8htu1gAqcQSPmXthltJ1zJyOnCmg2sgPMb68hGcfNKrrU/qaKu
	 y8YxT697sO5y0L3qN748Jji/jI5wwT7vL/wO9TqKGKBqUxCh7ALYtGeUemFrb5GlxB
	 gSs644opaeo3pD41y9xei8R43eMHqMMOzhkmJxx4CR0SU9MOPXBMxyJ/stUzeJUQLu
	 fNuHFPv76GvJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE8938111DC;
	Thu, 10 Apr 2025 01:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] configs/debug: run and debug PREEMPT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174424683541.3096919.18023331757196166323.git-patchwork-notify@kernel.org>
Date: Thu, 10 Apr 2025 01:00:35 +0000
References: <20250402172305.1775226-1-sdf@fomichev.me>
In-Reply-To: <20250402172305.1775226-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, paulmck@kernel.org,
 joel@joelfernandes.org, steven.price@arm.com, akpm@linux-foundation.org,
 matttbe@kernel.org, anshuman.khandual@arm.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Apr 2025 10:23:05 -0700 you wrote:
> Recent change [0] resulted in a "BUG: using __this_cpu_read() in
> preemptible" splat [1]. PREEMPT kernels have additional requirements
> on what can and can not run with/without preemption enabled.
> Expose those constrains in the debug kernels.
> 
> 0: https://lore.kernel.org/netdev/20250314120048.12569-2-justin.iurman@uliege.be/
> 1: https://lore.kernel.org/netdev/20250402094458.006ba2a7@kernel.org/T/#mbf72641e9d7d274daee9003ef5edf6833201f1bc
> 
> [...]

Here is the summary with links:
  - [net-next] configs/debug: run and debug PREEMPT
    https://git.kernel.org/netdev/net-next/c/311920774c40

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



