Return-Path: <netdev+bounces-44794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B6A7D9DE2
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 18:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4A53B21105
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 16:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C98F38F86;
	Fri, 27 Oct 2023 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfFvt330"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB255374CC;
	Fri, 27 Oct 2023 16:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65B53C433C9;
	Fri, 27 Oct 2023 16:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698423627;
	bh=W24YusT5sVRpRnD4nJCM/tldYzUF7x3cNF8u7zFtOsM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gfFvt330C7a7zLLLQY71meGXR3q/b7zB7sPUOdvFVXLCh2uk5OQlWdviYuded+t7N
	 RP2SQDxrEt0sYAundrFHCSw9HVPdRtBmhFKupjSfdwhpfq7I6wrckuojpv7YkTp1/A
	 jduemiKADFDHNfFHxKL3K8k0JI2RkzFOvy/aCpH1R8RptCT9X4Lb4XQYxhXa6+T5eP
	 gSa9hvAbhP9OjQ+nhx1i5nNR9gc3w0p+ECwq//bnACcQSCSEwZuurxcL3RRYwvTX91
	 po11+g2eMBE4CAzHhmCb2Q00JAEej3G5rJLoV8weMCT55nX8ox/Oz34XaOQNdlGC4F
	 YozA0Av7KXGtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B92BC41620;
	Fri, 27 Oct 2023 16:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/10] mptcp: Fixes and cleanup for v6.7
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169842362730.5811.9219746703675864811.git-patchwork-notify@kernel.org>
Date: Fri, 27 Oct 2023 16:20:27 +0000
References: <20231025-send-net-next-20231025-v1-0-db8f25f798eb@kernel.org>
In-Reply-To: <20231025-send-net-next-20231025-v1-0-db8f25f798eb@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: matttbe@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, geliang.tang@suse.com,
 kishen.maloor@intel.com, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 stable@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Oct 2023 16:37:01 -0700 you wrote:
> This series includes three initial patches that we had queued in our
> mptcp-net branch, but given the likely timing of net/net-next syncs this
> week, the need to avoid introducing branch conflicts, and another batch
> of net-next patches pending in the mptcp tree, the most practical route
> is to send everything for net-next.
> 
> Patches 1 & 2 fix some intermittent selftest failures by adjusting timing.
> 
> [...]

Here is the summary with links:
  - [net-next,01/10] selftests: mptcp: run userspace pm tests slower
    https://git.kernel.org/netdev/net-next/c/f4a75e9d1100
  - [net-next,02/10] selftests: mptcp: fix wait_rm_addr/sf parameters
    https://git.kernel.org/netdev/net-next/c/9168ea02b898
  - [net-next,03/10] mptcp: userspace pm send RM_ADDR for ID 0
    https://git.kernel.org/netdev/net-next/c/84c531f54ad9
  - [net-next,04/10] mptcp: drop useless ssk in pm_subflow_check_next
    https://git.kernel.org/netdev/net-next/c/74cbb0c65b29
  - [net-next,05/10] mptcp: use mptcp_check_fallback helper
    https://git.kernel.org/netdev/net-next/c/83d580ddbe1b
  - [net-next,06/10] mptcp: use mptcp_get_ext helper
    https://git.kernel.org/netdev/net-next/c/a16c054b527b
  - [net-next,07/10] mptcp: move sk assignment statement ahead
    https://git.kernel.org/netdev/net-next/c/a6c85fc61c08
  - [net-next,08/10] mptcp: define more local variables sk
    https://git.kernel.org/netdev/net-next/c/14cb0e0bf39b
  - [net-next,09/10] selftests: mptcp: sockopt: drop mptcp_connect var
    https://git.kernel.org/netdev/net-next/c/e71aab6777a4
  - [net-next,10/10] selftests: mptcp: display simult in extra_msg
    https://git.kernel.org/netdev/net-next/c/629b35a225b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



