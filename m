Return-Path: <netdev+bounces-165144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67546A30AEB
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 13:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 274AE3A7BE5
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 12:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E691FBCBC;
	Tue, 11 Feb 2025 12:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jf0Un9f6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253761FAC5E;
	Tue, 11 Feb 2025 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739275208; cv=none; b=CI81fppTL0VbPJfy4CqmTqZI17knb9txLr2rdENuQA3COo6j160G6EeAEJlsey3bD3UaNi+VZpK8iFVlksMIdwZXNGLKDDLqcZFZNea3bIksyUJiHCtnqEm9mwe23p0jG97rhyP/3Ev2sVEtmWOXfqfEDMbAI/sWniXBGn27rEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739275208; c=relaxed/simple;
	bh=DxNubQ82BSZPNr9Q4aWGZXDD+6hlE4NvdnH2GOjIkYo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G0ALPTfkgcdOiF7h0IdBxC4rg0BEzZj/F5qfxejJbBRsYmasAYOdyTb6wymvz8A4g2fkL4RgSfJqfo+JI9P0lQk8pXet6sIIryuFI5o5GlUc4VC4ZVSGNljWPnSjXWN/C/RwXpw5mywB9u3WyABKkr3nH5aXxWoMokfUxWUqFv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jf0Un9f6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86DE0C4CEDD;
	Tue, 11 Feb 2025 12:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739275207;
	bh=DxNubQ82BSZPNr9Q4aWGZXDD+6hlE4NvdnH2GOjIkYo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Jf0Un9f6fgt+xsHQoEewcvtt/PmxnSTl1blNMwfN5II1phCl8yqyQwLCLS9JlxK0G
	 4kP0z5LkzO9/9hwJZI6uCBHiVJG6SiMgnWNf3LXnqBNLZRVVdhd2nskkNBBaxNIh2V
	 yfyPpKnTO1tp/dQl3nUTpQa96DdWrEHHRyWZQiPpPHaeKV7zW9fCA+19Rt4qK5NFG8
	 1M+vxEyQioFukQ7S4Hbas7Dp9SIsc7ozN3ilbrUrXnsHmZpuLnNBBCDUeTjvMGbn95
	 l6yMnhw7cZj6BCy1oh2fQH8cXEDx0YRWpoRDgLRC+FdS37SJ5W9Ab8qrIwlnF65UDR
	 buECrlJffpq1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F61380AA7A;
	Tue, 11 Feb 2025 12:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 00/15] mptcp: pm: misc cleanups, part 2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173927523626.4027827.1076693017347574469.git-patchwork-notify@kernel.org>
Date: Tue, 11 Feb 2025 12:00:36 +0000
References: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
In-Reply-To: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 07 Feb 2025 14:59:18 +0100 you wrote:
> These cleanups lead the way to the unification of the path-manager
> interfaces, and allow future extensions. The following patches are not
> all linked to each others, but are all related to the path-managers.
> 
> - Patch 1: drop unneeded parameter in a function helper.
> 
> - Patch 2: clearer NL error message when an NL attribute is missing.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,01/15] mptcp: pm: drop info of userspace_pm_remove_id_zero_address
    https://git.kernel.org/netdev/net-next/c/a9d71b5de76c
  - [net-next,v3,02/15] mptcp: pm: userspace: flags: clearer msg if no remote addr
    https://git.kernel.org/netdev/net-next/c/58b21309f97b
  - [net-next,v3,03/15] mptcp: pm: more precise error messages
    https://git.kernel.org/netdev/net-next/c/891a87f7a76c
  - [net-next,v3,04/15] mptcp: pm: improve error messages
    https://git.kernel.org/netdev/net-next/c/b2bdec19beec
  - [net-next,v3,05/15] mptcp: pm: userspace: use GENL_REQ_ATTR_CHECK
    https://git.kernel.org/netdev/net-next/c/07bfabf8407b
  - [net-next,v3,06/15] mptcp: pm: remove duplicated error messages
    https://git.kernel.org/netdev/net-next/c/60097f03fc7a
  - [net-next,v3,07/15] mptcp: pm: mark missing address attributes
    https://git.kernel.org/netdev/net-next/c/8cdc56f99e6c
  - [net-next,v3,08/15] mptcp: pm: use NL_SET_ERR_MSG_ATTR when possible
    https://git.kernel.org/netdev/net-next/c/a25a8b10491b
  - [net-next,v3,09/15] mptcp: pm: make three pm wrappers static
    https://git.kernel.org/netdev/net-next/c/7aeab89b090f
  - [net-next,v3,10/15] mptcp: pm: drop skb parameter of get_addr
    https://git.kernel.org/netdev/net-next/c/67dcf6592544
  - [net-next,v3,11/15] mptcp: pm: add id parameter for get_addr
    https://git.kernel.org/netdev/net-next/c/d47b80758f4c
  - [net-next,v3,12/15] mptcp: pm: reuse sending nlmsg code in get_addr
    https://git.kernel.org/netdev/net-next/c/8556f4aecc9a
  - [net-next,v3,13/15] mptcp: pm: drop skb parameter of set_flags
    https://git.kernel.org/netdev/net-next/c/2c8971c04f74
  - [net-next,v3,14/15] mptcp: pm: change rem type of set_flags
    https://git.kernel.org/netdev/net-next/c/ab5723599cfd
  - [net-next,v3,15/15] mptcp: pm: add local parameter for set_flags
    https://git.kernel.org/netdev/net-next/c/c7f25f7987c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



