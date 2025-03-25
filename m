Return-Path: <netdev+bounces-177419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CED4A701FF
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 14:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24F0F17BBC4
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 13:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD72D257ACF;
	Tue, 25 Mar 2025 13:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZ+2ymBR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F2A125DF
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 13:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908799; cv=none; b=f/y8rmhWLwBu3A0kNHYaORHZIo4Iv+Y7mZ3XxN1yY9568DqitiCMmI9Hj+uSrKgoybpM7e3fL0UXzFj9mwK44N58h/exnjANf3jY+rUzbZ3t1CC0Y/PvVAssz3Q2Ia9xoVC/eXHzy38MrsGhTgJmS1Y631dNEmooqhyiuIIJ8IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908799; c=relaxed/simple;
	bh=zD3oTdusjYfks/Pe8/LqLPUfg8W1q/BRRb42TdFIBNM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JM13wbiDQ+JWj9lryCgPBOcmrS9aUlG8XXobOyPiTc+21W/rzPxK3Uew6gAlTr9uNYSGydQMs3kCR+ybOedSvOoviu14nv6lQB8Wd3xX540l2/sDxdQseg4yAWE1HNiqdZgydTqlP2RjMEZzPGeWwm+mqjaHN88nA17wgi7ySiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZ+2ymBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00391C4CEE4;
	Tue, 25 Mar 2025 13:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742908798;
	bh=zD3oTdusjYfks/Pe8/LqLPUfg8W1q/BRRb42TdFIBNM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tZ+2ymBRJhRlJZYWB4mo0h/8EyWuurZMFK04LaFUwTozbjjQFjy2G6V68o0LxllAA
	 061nC7eksTN1jKDn/ntlT0075msB1tU4CUio15MAzJnLnQnoOGVPjPNuhcNrKuLtcD
	 oAbbKIMpmlSTX2D8E1LWwbG/lKoBF+aT7vgcrPNARChyUcPbSaohFucjjMzplTCq0f
	 sR+gA3P/jfFih0Qif4XTHh4P6IwbsTOJoYjc4ZWw9rTRs/pjpujdFcIC+YthwQWmiz
	 F9qNu6ng+/76dBkNlP2sWt+OPcZF6mwLM4FU7URjYk9EFRVOIYXfQQuia8NFioRlT9
	 suGjTiHbM/aCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D6A380CFE7;
	Tue, 25 Mar 2025 13:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/9][pull request] Intel Wired LAN Driver Updates
 2025-03-18 (ice, idpf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174290883427.571725.8985593759731494858.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 13:20:34 +0000
References: <20250318200511.2958251-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250318200511.2958251-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue, 18 Mar 2025 13:04:44 -0700 you wrote:
> For ice:
> 
> Przemek modifies string declarations to resolve compile issues on gcc 7.5.
> 
> Karol adds padding to initial programming of GLTSYN_TIME* registers to
> ensure it will occur in the future to prevent hardware issues.
> 
> [...]

Here is the summary with links:
  - [net,1/9] ice: health.c: fix compilation on gcc 7.5
    https://git.kernel.org/netdev/net/c/fa8eda19015c
  - [net,2/9] ice: ensure periodic output start time is in the future
    https://git.kernel.org/netdev/net/c/53ce7166cbff
  - [net,3/9] ice: fix reservation of resources for RDMA when disabled
    https://git.kernel.org/netdev/net/c/7fd71f317288
  - [net,4/9] virtchnl: make proto and filter action count unsigned
    https://git.kernel.org/netdev/net/c/db5e8ea155fc
  - [net,5/9] ice: stop truncating queue ids when checking
    https://git.kernel.org/netdev/net/c/f91d0efcc3dd
  - [net,6/9] ice: validate queue quanta parameters to prevent OOB access
    https://git.kernel.org/netdev/net/c/e2f7d3f7331b
  - [net,7/9] ice: fix input validation for virtchnl BW
    https://git.kernel.org/netdev/net/c/c5be6562de5a
  - [net,8/9] ice: fix using untrusted value of pkt_len in ice_vc_fdir_parse_raw()
    https://git.kernel.org/netdev/net/c/1388dd564183
  - [net,9/9] idpf: check error for register_netdev() on init
    https://git.kernel.org/netdev/net/c/680811c67906

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



