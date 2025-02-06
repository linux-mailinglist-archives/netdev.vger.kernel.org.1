Return-Path: <netdev+bounces-163321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0FCA29EAE
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 03:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1585167B0B
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 02:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0323514A4F0;
	Thu,  6 Feb 2025 02:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqJLcU0y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5EA14A4DF;
	Thu,  6 Feb 2025 02:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738808413; cv=none; b=hMJM5Kh2UUEwf1jlyA5e3SwDEC5j+uXWWG/mv73PEcgAJgEaIPLe0rF1FckSLeluXr/99Z2Ii0k+Z4Y4sNYYsXQOLbeYuRPw2aNOHXDY2edL1Cso2lIMFwTbeVr0bSW11eQ6Rymm48y6GfWWZ5XyzjN08P0phXMELfxYjz01Y2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738808413; c=relaxed/simple;
	bh=bBZNRj0xCBGUb8AELlGrdkoqsrkw5N5iaPTEvHa6Xp0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GsZOogqWqA0JOoUeakdhrlpMqxuLxgXIdNJ2/8xOz8CfRd3KpzTpd5Q/GETtzsGN8bEKNKmFzrI+CSMzCnNEcH8NNcq9eedrgMi6LxQf94wiTJX0juBVGtmPxyNpffKPv0iDFvM/0yShrXsnMLUqcK5Rt2qA+gGdCqiLXrpnco0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqJLcU0y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D273C4CEE3;
	Thu,  6 Feb 2025 02:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738808413;
	bh=bBZNRj0xCBGUb8AELlGrdkoqsrkw5N5iaPTEvHa6Xp0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PqJLcU0yNkhMiuYeCqHzsYGZb1JjPmDmPuxlrpbUyMX4vEWoCNIGV1kyB+wHJ1dI0
	 ysil73tXqGX/vscwva8nZBKhI+3kG8dy1sgfhUEkTEoM8tSyCvqL/pVYl/KdM1cJxw
	 BcUXfvN7pwbiX5AzVxQmSmliDkKwXZveDQWSHsNSoRzxIapzHrjj0bkD5Urv76seLO
	 GTOM68Uxid9cFL43/4xaJKKTk/5JJ6UYjRM9J4eJKp+8GF4UtLvq/D18rt+/IrHYsY
	 b1oJEW1p/dCz1QWdSOSEMvwHLXFdEyXSAZ0QXVB2TzMfDa7lS8QFYrO4VEL3ihBO9G
	 BAeZLEHkK8rnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DA3380AAD0;
	Thu,  6 Feb 2025 02:20:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bridge: mdb: Allow replace of a host-joined group
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173880844100.974883.10135752018029076064.git-patchwork-notify@kernel.org>
Date: Thu, 06 Feb 2025 02:20:41 +0000
References: <e5c5188b9787ae806609e7ca3aa2a0a501b9b5c4.1738685648.git.petrm@nvidia.com>
In-Reply-To: <e5c5188b9787ae806609e7ca3aa2a0a501b9b5c4.1738685648.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 roopa@nvidia.com, razor@blackwall.org, idosch@nvidia.com,
 bridge@lists.linux.dev, mlxsw@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 4 Feb 2025 18:37:15 +0100 you wrote:
> Attempts to replace an MDB group membership of the host itself are
> currently bounced:
> 
>  # ip link add name br up type bridge vlan_filtering 1
>  # bridge mdb replace dev br port br grp 239.0.0.1 vid 2
>  # bridge mdb replace dev br port br grp 239.0.0.1 vid 2
>  Error: bridge: Group is already joined by host.
> 
> [...]

Here is the summary with links:
  - [net-next] bridge: mdb: Allow replace of a host-joined group
    https://git.kernel.org/netdev/net-next/c/d9e9f6d7b7d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



