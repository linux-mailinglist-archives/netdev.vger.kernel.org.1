Return-Path: <netdev+bounces-169281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D85A43311
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 03:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92FE617BFBF
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 02:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB6F15FD13;
	Tue, 25 Feb 2025 02:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJQoKo5s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8CB15B980;
	Tue, 25 Feb 2025 02:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740450607; cv=none; b=W+raRhG0R+Oco0cFD+Z8q3RbPOxp9NBYMOpWyuPHALaUhB3qmV4bkBD2HNUvuiMl7rviGplJxf+deBgCg8SPXw75u+HddGGPkgisQAPA+XfFZuOw0Ftjr9FlhXT6FgOGMOkw+XNbH6Uuu+WouVorq3PlyOfTZsFgo9iXgFGGnrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740450607; c=relaxed/simple;
	bh=pGhIeDgVro3WnQNDUGPY/gM/16DqF2aP+gTqj6q8N04=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k5yl2XH+9HtBzdOt3D1EB9ZbnU0okOVKQ0Y8E72CqZV32ol0c7lfbUfXehoCl3hB/mTkslHRPtHgDptEsaFSoT4Hy7OHUKiRlfJsqNgpQeQWTfqX5FHdsqdCJaMwnobx791qkok6UAzIEWohvXxbGz/slMpOCNHX5aMtVaOCzk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJQoKo5s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A03C4CEE8;
	Tue, 25 Feb 2025 02:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740450607;
	bh=pGhIeDgVro3WnQNDUGPY/gM/16DqF2aP+gTqj6q8N04=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uJQoKo5sf5OYoqteSmlIO9TGMJn2RMod1UP5fFubTO0QQivqoPu+44uJlRv4hXGFW
	 5swiUlULqdcpNKk82m9/jAHgi5L+gkpGcA1bxNtPFNU3HXY/azckeRScxG3lXJkXJj
	 9XYRzxF40mtZokSkGX6xB/dNMrYy2gKyvKkioIom1ezYo1U5L0viSxOiI8XF1IXsH0
	 FARm3Gp9SeZ+lTknzF9ZTLQZGHamu+uohvmftYXy9450RsmmgGAHlyFBv4satqPzg0
	 fI9Ur31G07QilTzEXeIhP7dNQPRLIJbKLFcmoo02YWWDrC0CGS/UmzYvoLqVzif+cy
	 /1x8uZy5s6yDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCFC380CFD8;
	Tue, 25 Feb 2025 02:30:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/10] mptcp: pm: misc cleanups, part 3
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174045063849.3682145.16015341527538028739.git-patchwork-notify@kernel.org>
Date: Tue, 25 Feb 2025 02:30:38 +0000
References: <20250221-net-next-mptcp-pm-misc-cleanup-3-v1-0-2b70ab1cee79@kernel.org>
In-Reply-To: <20250221-net-next-mptcp-pm-misc-cleanup-3-v1-0-2b70ab1cee79@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Feb 2025 16:43:53 +0100 you wrote:
> These cleanups lead the way to the unification of the path-manager
> interfaces, and allow future extensions. The following patches are not
> all linked to each others, but are all related to the path-managers,
> except the last three.
> 
> - Patch 1: remove unused returned value in mptcp_nl_set_flags().
> 
> [...]

Here is the summary with links:
  - [net-next,01/10] mptcp: pm: remove unused ret value to set flags
    https://git.kernel.org/netdev/net-next/c/bc337e8c0e76
  - [net-next,02/10] mptcp: pm: change to fullmesh only for 'subflow'
    https://git.kernel.org/netdev/net-next/c/145dc6cc4abd
  - [net-next,03/10] mptcp: pm: add a build check for userspace_pm_dump_addr
    https://git.kernel.org/netdev/net-next/c/63132fb05474
  - [net-next,04/10] mptcp: pm: add mptcp_pm_genl_fill_addr helper
    https://git.kernel.org/netdev/net-next/c/f8fe81746573
  - [net-next,05/10] mptcp: pm: drop match in userspace_pm_append_new_local_addr
    https://git.kernel.org/netdev/net-next/c/640e3d69d0bc
  - [net-next,06/10] mptcp: pm: drop inet6_sk after inet_sk
    https://git.kernel.org/netdev/net-next/c/dc41695200a1
  - [net-next,07/10] mptcp: pm: use ipv6_addr_equal in addresses_equal
    https://git.kernel.org/netdev/net-next/c/7720790fd56b
  - [net-next,08/10] mptcp: sched: split get_subflow interface into two
    https://git.kernel.org/netdev/net-next/c/9771a96a7a35
  - [net-next,09/10] mptcp: sched: reduce size for unused data
    https://git.kernel.org/netdev/net-next/c/b68b106b0f15
  - [net-next,10/10] mptcp: blackhole: avoid checking the state twice
    https://git.kernel.org/netdev/net-next/c/8275ac799ee1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



