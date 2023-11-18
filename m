Return-Path: <netdev+bounces-48940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5547F015D
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 18:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B88F6B20982
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 17:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758841A29B;
	Sat, 18 Nov 2023 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+TvlbdA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EFB182DA
	for <netdev@vger.kernel.org>; Sat, 18 Nov 2023 17:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E9BEC433C7;
	Sat, 18 Nov 2023 17:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700329226;
	bh=t9pRX6dDw5qDy/c7Rqnmuox16RZ3sScozbVos2RRdJI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R+TvlbdA4py5GGzKwmXJXsW98QHFbFSNGiBztWqM8OeYIN2sKtF81cb98KTEsPObz
	 BtMRcuVM4kSZ7OclRrVgmunOoYpYDqAwTg6KdP11TngH+CWWcTn4g8lqDa+fjcnrCL
	 8fye+zWBRBHQi2IQYbTDnxn7dasuBvD9fFs4kJ9JSK7OevtOO/mX4+pP+AXpsSmeVt
	 1XV0euCpmvSESm6Q7B4MFjNSvQ8vCeocSjVu1MM1hYC772RsZG4S/3iv+PoWMNB3hX
	 jAtWC3AfPNKnzt7Q1IUPK04tc7uWOumvAWNX6ebwOCdExM3n1tbVaYHShEqPfnH38p
	 SsC9FagpbtJBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 53AF7EA6303;
	Sat, 18 Nov 2023 17:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/14] mlxsw: Add support for new reset flow
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170032922633.15726.18001648921061847677.git-patchwork-notify@kernel.org>
Date: Sat, 18 Nov 2023 17:40:26 +0000
References: <cover.1700047319.git.petrm@nvidia.com>
In-Reply-To: <cover.1700047319.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 amcohen@nvidia.com, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 15 Nov 2023 13:17:09 +0100 you wrote:
> Ido Schimmel writes:
> 
> This patchset changes mlxsw to issue a PCI reset during probe and
> devlink reload so that the PCI firmware could be upgraded without a
> reboot.
> 
> Unlike the old version of this patchset [1], in this version the driver
> no longer tries to issue a PCI reset by triggering a PCI link toggle on
> its own, but instead calls the PCI core to issue the reset.
> 
> [...]

Here is the summary with links:
  - [net-next,01/14] devlink: Move private netlink flags to C file
    https://git.kernel.org/netdev/net-next/c/526dd6d7877b
  - [net-next,02/14] devlink: Acquire device lock during netns dismantle
    https://git.kernel.org/netdev/net-next/c/e21c52d7814f
  - [net-next,03/14] devlink: Enable the use of private flags in post_doit operations
    (no matching commit)
  - [net-next,04/14] devlink: Allow taking device lock in pre_doit operations
    https://git.kernel.org/netdev/net-next/c/d32c38256db3
  - [net-next,05/14] devlink: Acquire device lock during reload command
    https://git.kernel.org/netdev/net-next/c/bf6b200bc80d
  - [net-next,06/14] devlink: Add device lock assert in reload operation
    https://git.kernel.org/netdev/net-next/c/527a07e176ea
  - [net-next,07/14] PCI: Add no PM reset quirk for NVIDIA Spectrum devices
    https://git.kernel.org/netdev/net-next/c/3ed48c80b28d
  - [net-next,08/14] PCI: Add debug print for device ready delay
    https://git.kernel.org/netdev/net-next/c/0a5ef95923e0
  - [net-next,09/14] mlxsw: Extend MRSR pack() function to support new commands
    https://git.kernel.org/netdev/net-next/c/e6dbab40fa09
  - [net-next,10/14] mlxsw: pci: Rename mlxsw_pci_sw_reset()
    https://git.kernel.org/netdev/net-next/c/bdf85f3a695f
  - [net-next,11/14] mlxsw: pci: Move software reset code to a separate function
    (no matching commit)
  - [net-next,12/14] mlxsw: pci: Add support for new reset flow
    https://git.kernel.org/netdev/net-next/c/f257c73e5356
  - [net-next,13/14] mlxsw: pci: Implement PCI reset handlers
    https://git.kernel.org/netdev/net-next/c/5e12d0898583
  - [net-next,14/14] selftests: mlxsw: Add PCI reset test
    https://git.kernel.org/netdev/net-next/c/af51d6bd0b13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



