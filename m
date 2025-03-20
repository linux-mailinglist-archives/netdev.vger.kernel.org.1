Return-Path: <netdev+bounces-176508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E32A6A949
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 16:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5999348218A
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 15:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9121E9B1C;
	Thu, 20 Mar 2025 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1+njhfS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC06C1E5B90
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742482800; cv=none; b=VwbeJdPGMz9UdFfy6kMwQYVKBy6o805Kvr4zR0jYsnfjdExYpkwiqlROlxhE4Qb6eoEk13yxBro5imWqPgDm+DExcsSLV7O82PlXS0KzO30dX+WQFQK4tKD2LIafkIVXhjnxYTVCsBm8ZQOXaMHZb/M+fPSeGWO7tLvqMGKW7z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742482800; c=relaxed/simple;
	bh=QtOdfDruApRmclitpmn9NFGMuPnGJrztiXUzcv+x3ls=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qikge9zyJ32Pt5lPk3yZD7iQzVetHjrV83o1GaBHp0JhKc/gnfhs09Hzfq3SN1wtIziZDuGUz4N50BEMry9zZtIzTf0WGKR/ax7fGUg+su7qPxAAmenAuZvkOc0LbBNvV59wUjxIPiVmMat3+oLjl+/YVLYfnEFOnat+WzpV5dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1+njhfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5B3C4CEDD;
	Thu, 20 Mar 2025 15:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742482800;
	bh=QtOdfDruApRmclitpmn9NFGMuPnGJrztiXUzcv+x3ls=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U1+njhfSKQmCG9VSGjPOPe53a/9PkggDQyVTJhSitwoNnj2CWo9j1AQJtgj+u93tV
	 PCriLtVAorlJRQ8AcMGUorEVBd6ZgWRYUmNrdvDzrySdQyMBlpBgyP7scmkozaG2ua
	 xmtgxcwghgL4aTv1wFyO+7G8mbWA/biMErv4KXz7Ue/R3tXUSqmhCXB/hCBmHc2vrE
	 n16gDJ41E3Gi8cV0VbjuoSTAHse2CILLk3W0swXsGZNCLQqx5RWofSSy9jpy7XDHYa
	 T+t9+C/vfVQnPR0CTmaXxqN4WSYr0XXRBAVaK9lh9/y02EMC3GgJuDhkb2tu6yB/Qw
	 fie9ZjhyPKB4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 35B1E3806654;
	Thu, 20 Mar 2025 15:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] MAINTAINERS: Add Andrea Mayer as a maintainer of
 SRv6
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174248283575.1799091.10879192771042767128.git-patchwork-notify@kernel.org>
Date: Thu, 20 Mar 2025 15:00:35 +0000
References: <20250312092212.46299-1-dsahern@kernel.org>
In-Reply-To: <20250312092212.46299-1-dsahern@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, andrea.mayer@uniroma2.it

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 12 Mar 2025 10:22:12 +0100 you wrote:
> Andrea has made significant contributions to SRv6 support in Linux.
> Acknowledge the work and on-going interest in Srv6 support with a
> maintainers entry for these files so hopefully he is included
> on patches going forward.
> 
> v2
> - add non-uapi header files
> 
> [...]

Here is the summary with links:
  - [v2,net-next] MAINTAINERS: Add Andrea Mayer as a maintainer of SRv6
    https://git.kernel.org/netdev/net/c/feaee98c6c50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



