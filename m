Return-Path: <netdev+bounces-75951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3935D86BC56
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 00:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD6F01F23CFA
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 23:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5E37440C;
	Wed, 28 Feb 2024 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVHes/+L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8317293B
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709164232; cv=none; b=VAwX2wyK905fi2uh2hcEtpe1bqewGKJ0syZf4V2fwjl3r1qKL+G/090Pr3yjGHte5su/dZ7Fy+4XiRJGj0xgjm68KWfyodmg39SBFbEcqKHlqu1z6mh+Bfm7AA/jEYLxsW76EbMzcdUOCdeIwnrjneOan7wljxX/Bx5YcbOMtcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709164232; c=relaxed/simple;
	bh=A+49AXUm4PKHd3mg2xGfW46MHpkC+Olt5xUV1G4sJz4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rLTOrElj4kThMfXXnWFVIv4cvPiFpePrgXfVfTDs74OjFVGLIQKG1amwe0LseSah6cnBWqXO3X6Pvbs3K3W2ufEGESBb4rdeO4PyA+HDCCNUzmeblwHj3+/r9ue+sBlEja9VeHmeHc8OkDqNlcubyfFu118KzEofzbFCzbZ+C3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVHes/+L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42400C43390;
	Wed, 28 Feb 2024 23:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709164232;
	bh=A+49AXUm4PKHd3mg2xGfW46MHpkC+Olt5xUV1G4sJz4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FVHes/+LPqzGoNa0bQa8HvUSCuGd+RucUtf86LE4Tfn/tkI0W+6PmPwOsB5YjMz2L
	 Zyz7B0FD/F12f7CVeHw5hTNuLY88SoVFhA1TpsldJODfw48VAmgSxeAmzgi1DPxS78
	 ms9jGhxi5FqVDYJLL6oXBnZUBjgC3BcaVYZ9ut0PBtIkUbdH+7ThPcYTxLhL32P6Zy
	 EW/KnzyaJ3kK9YvIHalP45KJdf5FsCjch8IZoND2Olh0YiirLDk1kCYeLs6vrM9EPG
	 MuRST2CCw1C737GQt9I4HUqhsgY/9fe+tNhuahTnGXpte+S/473ojOQoZ8LhMgxG/W
	 Pol40kBh5sYaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E5B3C395F1;
	Wed, 28 Feb 2024 23:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 00/15] tools: ynl: stop using libmnl
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170916423218.30546.12389885775738975150.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 23:50:32 +0000
References: <20240227223032.1835527-1-kuba@kernel.org>
In-Reply-To: <20240227223032.1835527-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, nicolas.dichtel@6wind.com, donald.hunter@gmail.com,
 jiri@resnulli.us, sdf@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Feb 2024 14:30:17 -0800 you wrote:
> There is no strong reason to stop using libmnl in ynl but there
> are a few small ones which add up.
> 
> First (as I remembered immediately after hitting send on v1),
> C++ compilers do not like the libmnl for_each macros.
> I haven't tried it myself, but having all the code directly
> in YNL makes it easier for folks porting to C++ to modify them
> and/or make YNL more C++ friendly.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,01/15] tools: ynl: give up on libmnl for auto-ints
    https://git.kernel.org/netdev/net-next/c/21f6986d19b0
  - [net-next,v3,02/15] tools: ynl: create local attribute helpers
    https://git.kernel.org/netdev/net-next/c/5600c580383a
  - [net-next,v3,03/15] tools: ynl: create local for_each helpers
    https://git.kernel.org/netdev/net-next/c/66fcdad08842
  - [net-next,v3,04/15] tools: ynl: create local nlmsg access helpers
    https://git.kernel.org/netdev/net-next/c/0b3ece442208
  - [net-next,v3,05/15] tools: ynl: create local ARRAY_SIZE() helper
    https://git.kernel.org/netdev/net-next/c/7600875f295f
  - [net-next,v3,06/15] tools: ynl: make yarg the first member of struct ynl_dump_state
    https://git.kernel.org/netdev/net-next/c/d62c5d487cfe
  - [net-next,v3,07/15] tools: ynl-gen: remove unused parse code
    https://git.kernel.org/netdev/net-next/c/9c29a113165f
  - [net-next,v3,08/15] tools: ynl: wrap recv() + mnl_cb_run2() into a single helper
    https://git.kernel.org/netdev/net-next/c/2f22f0b313f4
  - [net-next,v3,09/15] tools: ynl: use ynl_sock_read_msgs() for ACK handling
    https://git.kernel.org/netdev/net-next/c/1621378aab19
  - [net-next,v3,10/15] tools: ynl: stop using mnl_cb_run2()
    https://git.kernel.org/netdev/net-next/c/766c4b5460f4
  - [net-next,v3,11/15] tools: ynl: switch away from mnl_cb_t
    https://git.kernel.org/netdev/net-next/c/dd0973d71e1f
  - [net-next,v3,12/15] tools: ynl: switch away from MNL_CB_*
    https://git.kernel.org/netdev/net-next/c/50042e8051fe
  - [net-next,v3,13/15] tools: ynl: stop using mnl socket helpers
    https://git.kernel.org/netdev/net-next/c/5ac6868daa0e
  - [net-next,v3,14/15] tools: ynl: remove the libmnl dependency
    https://git.kernel.org/netdev/net-next/c/73395b43819b
  - [net-next,v3,15/15] tools: ynl: use MSG_DONTWAIT for getting notifications
    https://git.kernel.org/netdev/net-next/c/7c4a38bf1eba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



