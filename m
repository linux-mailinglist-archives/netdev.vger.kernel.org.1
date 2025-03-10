Return-Path: <netdev+bounces-173651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E896A5A546
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 21:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47B8D188D020
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 20:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065831DEFD7;
	Mon, 10 Mar 2025 20:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJ8Lpdi8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0AE1D5150;
	Mon, 10 Mar 2025 20:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639802; cv=none; b=jhlaQx7gLCMEmq9ex/VaQ/ts/09XurSY5M4WRAWOsnCrkMQ6aCjpEE7brB2YBmB+3ukTysfSoikc5URHh4COKd3/R2sxIS6ddJ8CpdUk3rJbnoGgoFSo3TeEMP6+BfwS9kTdpELJ55veywCMEA9bUEfo3fstYhwt5H6Jeydpgto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639802; c=relaxed/simple;
	bh=CYGGp7rWU103fsuOZ9lJT+vvLji2uulj15ckfU6FoH8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EIEhcnTe97ltGi7SaGbGm824hyF3PTZ3gPG+lnd54w11sHX2JwovuAi+oj9j75rSHI9hHzbEd2KcUnroabMZxFHq/8dDRju0Y5rauOGlUGLaXgnnsqdk98hph+TE8PWYh3GX7/gWcw34X1j7s+z4K91QnaZNPLBO85RmJyKtbQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJ8Lpdi8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3340DC4CEE5;
	Mon, 10 Mar 2025 20:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741639802;
	bh=CYGGp7rWU103fsuOZ9lJT+vvLji2uulj15ckfU6FoH8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MJ8Lpdi8JqpWarA/vc7U1W/52ADRyMA0S/mh6Hm2GpC6B4EQPOLG3SBcUg8kfsoOs
	 DKe1CbHFk94qKlhl+bT0sPJcAsjkiT2GuwijX62eewVFOTH/Wu0BhjknZ1dnxVX1W1
	 /QZhos37RMxKDuJLAlMRoBeohecJ6YIFZt25YCQgl0YFWY+teatsBEA/frhbD1cVDq
	 U1JOF/OkMOBbtCwyslF8m223tiNt+pgsgLMkqmMiixGJr2p/GW35bhpxS4CiMe6Mos
	 RqTnlkJqPqtwFxn/94a6xizjioB7NfKaADd/KxVAEUDsocHMvmi1BZNZIvVBi4NYHv
	 bIv6H7fODpEHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713A4380AACB;
	Mon, 10 Mar 2025 20:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/15] mptcp: pm: code reorganisation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174163983626.3691119.3217596204968315026.git-patchwork-notify@kernel.org>
Date: Mon, 10 Mar 2025 20:50:36 +0000
References: <20250307-net-next-mptcp-pm-reorg-v1-0-abef20ada03b@kernel.org>
In-Reply-To: <20250307-net-next-mptcp-pm-reorg-v1-0-abef20ada03b@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 07 Mar 2025 12:21:44 +0100 you wrote:
> Before this series, the PM code was dispersed in different places:
> 
> - pm.c had common code for all PMs.
> 
> - pm_netlink.c was initially only about the in-kernel PM, but ended up
>   also getting exported common helpers, callbacks used by the different
>   PMs, NL events for PM userspace daemon, etc. quite confusing.
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] mptcp: pm: use addr entry for get_local_id
    https://git.kernel.org/netdev/net-next/c/7462fe22cc74
  - [net-next,02/15] mptcp: pm: remove '_nl' from mptcp_pm_nl_addr_send_ack
    https://git.kernel.org/netdev/net-next/c/fac7a6ddc757
  - [net-next,03/15] mptcp: pm: remove '_nl' from mptcp_pm_nl_mp_prio_send_ack
    https://git.kernel.org/netdev/net-next/c/d1734987992c
  - [net-next,04/15] mptcp: pm: remove '_nl' from mptcp_pm_nl_work
    https://git.kernel.org/netdev/net-next/c/551a9ad7879d
  - [net-next,05/15] mptcp: pm: remove '_nl' from mptcp_pm_nl_rm_addr_received
    https://git.kernel.org/netdev/net-next/c/636113918508
  - [net-next,06/15] mptcp: pm: remove '_nl' from mptcp_pm_nl_subflow_chk_stale()
    https://git.kernel.org/netdev/net-next/c/550c50bbc2b7
  - [net-next,07/15] mptcp: pm: remove '_nl' from mptcp_pm_nl_is_init_remote_addr
    https://git.kernel.org/netdev/net-next/c/498d7d8b75f1
  - [net-next,08/15] mptcp: pm: kernel: add '_pm' to mptcp_nl_set_flags
    https://git.kernel.org/netdev/net-next/c/40aa7409d30d
  - [net-next,09/15] mptcp: pm: avoid calling PM specific code from core
    https://git.kernel.org/netdev/net-next/c/a17336b2b2e0
  - [net-next,10/15] mptcp: pm: worker: split in-kernel and common tasks
    https://git.kernel.org/netdev/net-next/c/a49eb8ae95b8
  - [net-next,11/15] mptcp: pm: export mptcp_remote_address
    https://git.kernel.org/netdev/net-next/c/a14673127236
  - [net-next,12/15] mptcp: pm: move generic helper at the top
    https://git.kernel.org/netdev/net-next/c/bcc32640ada0
  - [net-next,13/15] mptcp: pm: move generic PM helpers to pm.c
    https://git.kernel.org/netdev/net-next/c/e4c28e3d5c09
  - [net-next,14/15] mptcp: pm: split in-kernel PM specific code
    https://git.kernel.org/netdev/net-next/c/8617e85e04bd
  - [net-next,15/15] mptcp: pm: move Netlink PM helpers to pm_netlink.c
    https://git.kernel.org/netdev/net-next/c/2e7e6e9cda1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



