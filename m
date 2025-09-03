Return-Path: <netdev+bounces-219386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BAEB41132
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 02:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9769D546BD1
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 00:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2092C179BD;
	Wed,  3 Sep 2025 00:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lr5Va/Ml"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0ED1400C;
	Wed,  3 Sep 2025 00:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756858216; cv=none; b=g6reTWvqm97aBMGlUkY6wyrh8byapjcMGkJeFFNiSf5dqQpLfJkfa0l+I7Dqjlhc1TyNYP47euEDZbhV9uhNKao+2PBnJ31/2rPCGGIXoezwYrDWh4pBZtBkXKDPK3s/tZzXQMLkvGc8K5QdYnhpw8uHKciDHrCexBVxCucUhHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756858216; c=relaxed/simple;
	bh=kqCBITBvvTPGrJDwgG++T2WdoRqclM08P2bV1oYwrJ8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uqBiuMC3HwaQ5EiSuPNkcfVWmLMLXy8DuIQclc/FHSE0I0/jW5+AUEbS8r0iek6hgRzc76+G9PAr1x3ZRD0OBaOCgIt85q761lHkhaG1hcn/eM5AAs/8nB7phVyCKJEMhaWWOcg07gcOZ0A8E2iEXBLVJAmz8TFzfP1zXxWmfNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lr5Va/Ml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BEAC4CEED;
	Wed,  3 Sep 2025 00:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756858214;
	bh=kqCBITBvvTPGrJDwgG++T2WdoRqclM08P2bV1oYwrJ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Lr5Va/MlszG/kzHdrbfw7ZIore6ay2TLyHokqsZk6WYtvXgTTBOY4tKeyyYHLs3xe
	 lIJyRkx9duG+GFjkGEsIFynh8FyLkupksunvqWpExXQpPIUaazfP5XF8eslRVGh7WR
	 mYCsVExLSC3TVheBeaJu7T8nEW5sJYH0NlbUzxraicvFBF+08ZrfgAJ+OX31kUIxro
	 4dl10Tgytt7hSoT+l5tWDj1fzO9R1QLrhQ3/U1KFCZVH0M5Z9yr/8pQHFIQOWWnckA
	 aYtrYZFRQiSv2vgj/BYh8Sxig21qy/EDZdp3UBwSOqzU9FDwLBF+4usrrzZpVSWQDv
	 kX4ULh0wduxAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACAA383BF64;
	Wed,  3 Sep 2025 00:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/2] ipv6: improve rpl_seg_enabled sysctl
 handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175685821973.475224.13168377571393825684.git-patchwork-notify@kernel.org>
Date: Wed, 03 Sep 2025 00:10:19 +0000
References: <20250901123726.1972881-1-yuehaibing@huawei.com>
In-Reply-To: <20250901123726.1972881-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 1 Sep 2025 20:37:24 +0800 you wrote:
> First commit annotate data-races around it and second one add sanity check that
> prevents unintentional misconfiguration.
> 
> Yue Haibing (2):
>   ipv6: annotate data-races around devconf->rpl_seg_enabled
>   ipv6: Add sanity checks on ipv6_devconf.rpl_seg_enabled
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/2] ipv6: annotate data-races around devconf->rpl_seg_enabled
    (no matching commit)
  - [v3,net-next,2/2] ipv6: Add sanity checks on ipv6_devconf.rpl_seg_enabled
    https://git.kernel.org/netdev/net-next/c/3d95261eeb74

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



