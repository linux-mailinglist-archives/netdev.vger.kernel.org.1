Return-Path: <netdev+bounces-176507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B37BA6A968
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 16:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F093A1894F8B
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 15:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58ED71E5B9D;
	Thu, 20 Mar 2025 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHFMM+bW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3530C1E5B90
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742482799; cv=none; b=izSt6idwJllyojbjza/u9d1VcVqvqQeNzgM+51mBtkT7U7smMsU7aiObjwAvpf0fuWSdhxBMGby8EChEkWm0CLUkbrH71ihEMD5pA9id502+V4padx5qotDYT6hn/XyS5ggk01rbCgAl90Kp0uN75Xs4cKKnGgZMPFtOgWW0ZoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742482799; c=relaxed/simple;
	bh=5VKNO6a5SBy5EC2GhBunVgbLz77/7zsFTmb/0D9Xv+k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OLAY6iLs/T1rierE8+yzQjnsLpkNvo5TdkYOHvqxfQ6u3p9q5J1JcS780tnDU4CBd69JTrXhbngLp/1s3aQiypOjWqqXx7HOPChArgRSbt9ch1shdKpbiqPQiNpmixGwjBEXqJihVuqnRuPM3yupjwC5+LTIObnAqMSqVol6wEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHFMM+bW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94AC7C4CEDD;
	Thu, 20 Mar 2025 14:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742482798;
	bh=5VKNO6a5SBy5EC2GhBunVgbLz77/7zsFTmb/0D9Xv+k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pHFMM+bW1tWffcQwz3EenwPV97enQUYCmAV/afllelXzTGPD/pyr4JgjTGX0qJ+fd
	 ODMaIQWEXAD7LHj2cxK/A6ezUm66sWdomonszcxhcMmaTnTbW9URDMjdw6JvfxLnwe
	 yYBkTpNygvT5p8SQ7G2JqLc8D4VHANoMrPbNz7JjKUEKsXbHOHszhzDs3/dml/O1yj
	 CLY9/9UiYYLG3cr7i4zOBWpdXE58UxSRLvl0QYgSqkb9TrXjrthTzTd2R3OxOEPB0M
	 5unfj6gdcQEIyNIA3APPciUjMS+Rg1yDMdWjmXrIXKkEnfv7tVp4hzK52q2O2liLD3
	 Bub8ZPpQqwP0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCFD3806654;
	Thu, 20 Mar 2025 15:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] gre: Revert IPv6 link-local address fix.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174248283452.1799091.6719873799631324140.git-patchwork-notify@kernel.org>
Date: Thu, 20 Mar 2025 15:00:34 +0000
References: <cover.1742418408.git.gnault@redhat.com>
In-Reply-To: <cover.1742418408.git.gnault@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, horms@kernel.org,
 dsahern@kernel.org, antonio@mandelbit.com, idosch@idosch.org,
 petrm@nvidia.com, stfomichev@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 19 Mar 2025 22:26:39 +0100 you wrote:
> Following Paolo's suggestion, let's revert the IPv6 link-local address
> generation fix for GRE devices. The patch introduced regressions in the
> upstream CI, which are still under investigation.
> 
> Start by reverting the kselftest that depend on that fix (patch 1), then
> revert the kernel code itself (patch 2).
> 
> [...]

Here is the summary with links:
  - [net,1/2] Revert "selftests: Add IPv6 link-local address generation tests for GRE devices."
    https://git.kernel.org/netdev/net/c/355d940f4d5a
  - [net,2/2] Revert "gre: Fix IPv6 link-local address generation."
    https://git.kernel.org/netdev/net/c/fc486c2d060f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



