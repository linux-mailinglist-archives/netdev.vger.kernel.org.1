Return-Path: <netdev+bounces-143928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD65A9C4C1F
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 02:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A1CBB28737
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 01:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049FD201009;
	Tue, 12 Nov 2024 01:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIUWRNkE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D1D19DF45
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 01:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731375621; cv=none; b=MTuwxFDSCVHqKIzXsxle9elI25K/7bgT41/cOyJG5LA2OhLVAmAduKri6Bm2inDh2Eozdsr6IDfoaDzAaHTaixkeIfboXQuBdjp9nfakSqyd4NCEtKU7e2XuCbxvIkq6LSThifjiXyw8qkDvQya5iaSm+DH6AFk0ayiqv9WXwKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731375621; c=relaxed/simple;
	bh=8NtgV8+DoQO2v8UMKpLBig3zMK6K/qCK1hMPBMqtIvg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KSxj82yIO/CcBuKdejNDX+bJeTdHvkNpXFCsVuqVoQZ2Whyh4KUxXzgGS3NNan5FokH0IUUZM9ge5hMSUUa23JCQXSPyn3gkpAskHxe+hbRDAbiYTgCzO+kzNzQVQseAEKnH8nkiV+UOP55iZyKi0yddg8sdGUqkJco7brXc3L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIUWRNkE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A971C4CECF;
	Tue, 12 Nov 2024 01:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731375621;
	bh=8NtgV8+DoQO2v8UMKpLBig3zMK6K/qCK1hMPBMqtIvg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QIUWRNkE7dmCy+JfVt9xJnAXhYKETlqMaTUngqlkR4Asbq12+7WQWMC2OKVf1QuzC
	 2+0lxQu1dzHYl4FzwuJMFhA91l3FFI7ZOrr68R0rAr1jFqUDAhfWTUt9fR8e7jeeIr
	 FbI42f8gxkkaO35y+Q8jBlDnunt2JtpBC6dyjA+JBqfziU7RjdMi3jk6693iv0411+
	 i6e6zCJ1J8KheS1DqFiJwlLbXHGyP9L95kRarIrmj4oRQKEMdk/sqEaMwzOi/IAtpR
	 ZACkJhYLZgKpSFhK9igZ5cwL8oIJTjYWcZcoErGy4cDXAw77tx3JW+UTgDDxOcEb8Z
	 SBHnVwmUt2snA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBF13809A80;
	Tue, 12 Nov 2024 01:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND v3 net-next 00/10] rtnetlink: Convert rtnl_newlink() to
 per-netns RTNL.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173137563151.43860.965503623477739139.git-patchwork-notify@kernel.org>
Date: Tue, 12 Nov 2024 01:40:31 +0000
References: <20241108004823.29419-1-kuniyu@amazon.com>
In-Reply-To: <20241108004823.29419-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 mkl@pengutronix.de, mailhol.vincent@wanadoo.fr, daniel@iogearbox.net,
 razor@blackwall.org, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 7 Nov 2024 16:48:13 -0800 you wrote:
> Patch 1 - 3 removes __rtnl_link_unregister and protect link_ops by
> its dedicated mutex to move synchronize_srcu() out of RTNL scope.
> 
> Patch 4 introduces struct rtnl_nets and helper functions to acquire
> multiple per-netns RTNL in rtnl_newlink().
> 
> Patch 5 - 8 are to prefetch the peer device's netns in rtnl_newlink().
> 
> [...]

Here is the summary with links:
  - [RESEND,v3,net-next,01/10] rtnetlink: Remove __rtnl_link_unregister().
    https://git.kernel.org/netdev/net-next/c/d5ec8d91f82e
  - [RESEND,v3,net-next,02/10] rtnetlink: Protect link_ops by mutex.
    https://git.kernel.org/netdev/net-next/c/6b57ff21a310
  - [RESEND,v3,net-next,03/10] rtnetlink: Remove __rtnl_link_register()
    https://git.kernel.org/netdev/net-next/c/68297dbb967f
  - [RESEND,v3,net-next,04/10] rtnetlink: Introduce struct rtnl_nets and helpers.
    https://git.kernel.org/netdev/net-next/c/cbaaa6326bc5
  - [RESEND,v3,net-next,05/10] rtnetlink: Add peer_type in struct rtnl_link_ops.
    https://git.kernel.org/netdev/net-next/c/28690e5361c0
  - [RESEND,v3,net-next,06/10] veth: Set VETH_INFO_PEER to veth_link_ops.peer_type.
    https://git.kernel.org/netdev/net-next/c/0eb87b02a705
  - [RESEND,v3,net-next,07/10] vxcan: Set VXCAN_INFO_PEER to vxcan_link_ops.peer_type.
    https://git.kernel.org/netdev/net-next/c/6b84e558e95d
  - [RESEND,v3,net-next,08/10] netkit: Set IFLA_NETKIT_PEER_INFO to netkit_link_ops.peer_type.
    https://git.kernel.org/netdev/net-next/c/fefd5d082172
  - [RESEND,v3,net-next,09/10] rtnetlink: Convert RTM_NEWLINK to per-netns RTNL.
    https://git.kernel.org/netdev/net-next/c/d91191ffe23f
  - [RESEND,v3,net-next,10/10] rtnetlink: Register rtnl_dellink() and rtnl_setlink() with RTNL_FLAG_DOIT_PERNET_WIP.
    https://git.kernel.org/netdev/net-next/c/636af13f213b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



