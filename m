Return-Path: <netdev+bounces-169682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0992A453C7
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 04:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B290189F40F
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 03:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CB222AE7C;
	Wed, 26 Feb 2025 03:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7riKW2y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0B722A4F7;
	Wed, 26 Feb 2025 03:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740539413; cv=none; b=fprM11nLZd9kJ+ns5CrPN4tYhUaBX6wLcQYJsW7gmsrTQQdh2b5aKpZTBEKgBXCDUdnojMA4hQxpOFd4odM18Muh3TdTL9wh1dYwJBYbyi4CAZVQTWffzMyt3xiu2QsOZkAEoIDtayv3mbyudUMkxwlx4fM4NPzu0ls3tXA/6B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740539413; c=relaxed/simple;
	bh=7SZKCabJX2HhzOUVLWc4O6ED5KbebiL7NRXD7bLYeDs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZVYH6Ti9XgREpzXslGbi0hGDd67pEE/ylINq1vZyTn0aPuRZTI4SkWtjml2MJL2XPeCQasJJjCqtflhue8sxlt0KgOhK4/LuQtC2Zx5mgtlnvvU2majJvYorRTHVlEy+p2u9oPXVoqWcuCH0Cse2+BHXSZ/54TmFsHe+tCEXnss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7riKW2y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21BCC4CEE7;
	Wed, 26 Feb 2025 03:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740539412;
	bh=7SZKCabJX2HhzOUVLWc4O6ED5KbebiL7NRXD7bLYeDs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m7riKW2yeZiEyIsB0QWoJhRpLUmAOwYUtUlqUSecnU6LhPO5bHRobROJgnBumA1LU
	 OsAZqHhwE3emp3ss0g2nF0yL+WYsOAjTKKfT50xDlRqHtApDx5QtRhuGkRc5Zv+sY3
	 2lwCGw8WRZx0sIrDljVsH4jhw78+A7ove9mf059naedxZrOIIPCp2/vaxktlx+vNSe
	 SzNwwRccjI2lKrN/iJdSIWwhW9N7DedD27vpPUu3HKx4zCJbP1kwknnVEVlTc2PJkV
	 Hx3IhZ97qB7+K2j57hXbv5CjKRpPD2WUK+3Hs6PBus6odRb+JF8N0PJ1JTE9yThB1g
	 pZX6VVIAuQ2fA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE011380CFDD;
	Wed, 26 Feb 2025 03:10:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] Add OVN to `rtnetlink.h`
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174053944450.217003.5009204346469404479.git-patchwork-notify@kernel.org>
Date: Wed, 26 Feb 2025 03:10:44 +0000
References: <Z7w_e7cfA3xmHDa6@SIT-SDELAP4051.int.lidl.net>
In-Reply-To: <Z7w_e7cfA3xmHDa6@SIT-SDELAP4051.int.lidl.net>
To: Felix Huettner <felix.huettner@stackit.cloud>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jonas.gottlieb@stackit.cloud

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Feb 2025 10:44:27 +0100 you wrote:
> From: Jonas Gottlieb <jonas.gottlieb@stackit.cloud>
> 
> - The Open Virtual Network (OVN) routing netlink handler uses ID 84
> - Will also add to `/etc/iproute2/rt_protos` once this is accepted
> - For more information: https://github.com/ovn-org/ovn
> 
> Signed-off-by: Jonas Gottlieb <jonas.gottlieb@stackit.cloud>
> 
> [...]

Here is the summary with links:
  - [net-next] Add OVN to `rtnetlink.h`
    https://git.kernel.org/netdev/net-next/c/6002850fdfe0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



