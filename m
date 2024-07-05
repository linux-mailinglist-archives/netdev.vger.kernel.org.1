Return-Path: <netdev+bounces-109339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD683928053
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 04:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91008B24739
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 02:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B12815EA2;
	Fri,  5 Jul 2024 02:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itr5515z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB23312B77
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720146031; cv=none; b=DhQ89s396FRi25OyxaI3PusNwtiXkU8Zqx9ELE8QYM8u5GfzZazkTkC9CLmBzzfa3n3frOYvboHp2Pv7l8cU9uamXDh7kNQ2wTUqym1i0utTRTDS+fkYHbQWU12bpZd3EAeTjdCZAPzhrjN8XIqDFo8V1l8ydpQS4ME2tsfH0wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720146031; c=relaxed/simple;
	bh=MZ9bgZB9jrqTqApatplxl6eS9T9xHD92BtZ29caeLJo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JF8w2pGlvK2xEYVFZm4Ip3aIAew5aHd9bzYjIJTOQ+M5ulwhJ0TUxAqCSNWpM8vjFOxUro1vITB+i7wT1WJQJEu9iigoxRtpyS+tsY38xP2SDN+JfnlZ7JEsGHz1TOdgIYr5nMGEI9ZTO2ZMbD6dgCZuMMCXAdq7jFzl/7wVBJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itr5515z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81FA5C4AF0A;
	Fri,  5 Jul 2024 02:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720146030;
	bh=MZ9bgZB9jrqTqApatplxl6eS9T9xHD92BtZ29caeLJo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=itr5515zKbLMFxBVTz5n7o4EdzJWDn1iueCGY20jhUSI4U1kkdwyxAmr9Ce/CIEkV
	 AVh7ykfhfjCcV2pr6f0crwYNp5IbElJoYJUiuP1orROQYDwGiZ8xYuG7YCrhcaspe5
	 NzsNJFhI25Ml3QegjlUOQnZODB0fdmWgJZ4rg0n1rvW9sALRCpXZ3Sboi/F6l+J4PU
	 3PsU2oexE16NyGLQ13a1qkH9QkBe9C/JsbORLuhnInwwYzQF+IMTZu0Efa2ucljKDT
	 3HFwaqGFTlzgYf/zQNmFaiiERQ9w1WX6RN86KKQotpspEDjp7EoIQkNKqoDPE40buF
	 GMvnIV9FgEKIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72260C43332;
	Fri,  5 Jul 2024 02:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ethtool: move firmware flashing flag to struct
 ethtool_netdev_state
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172014603046.16848.3061228813115022401.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jul 2024 02:20:30 +0000
References: <20240703121849.652893-1-edward.cree@amd.com>
In-Reply-To: <20240703121849.652893-1-edward.cree@amd.com>
To:  <edward.cree@amd.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, ecree.xilinx@gmail.com, netdev@vger.kernel.org,
 danieller@nvidia.com, andrew@lunn.ch

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 3 Jul 2024 13:18:49 +0100 you wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Commit 31e0aa99dc02 ("ethtool: Veto some operations during firmware flashing process")
>  added a flag module_fw_flash_in_progress to struct net_device.  As
>  this is ethtool related state, move it to the recently created
>  struct ethtool_netdev_state, accessed via the 'ethtool' member of
>  struct net_device.
> 
> [...]

Here is the summary with links:
  - [net-next] ethtool: move firmware flashing flag to struct ethtool_netdev_state
    https://git.kernel.org/netdev/net-next/c/caa93b7c2594

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



