Return-Path: <netdev+bounces-177246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876B4A6E67C
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 23:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 911943AC286
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 22:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E051EA7DB;
	Mon, 24 Mar 2025 22:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d52QD0S6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74C419049B
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 22:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742854797; cv=none; b=Aj8TCqn/ZSE/XuwWbMSX1u4UzIQ45afy6m10tRGEJgp5vktSCF84GTkpjsDgXPVIEQZlK1qkIC1mHzjwmq+YhLrbXJUtsiDx5z0pA1xzlW1jy/Xpfp3z1F5EHy3KLcFf6No6IaogG5kIibhxBRTAJeoa56yDunT9go9C/s9H5E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742854797; c=relaxed/simple;
	bh=Z3k6/MYw0IClXSufou4UOke3Y1b6iauBex5QeI8X2jo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uaalUGc15+bbTEEfJpoG/S31sR9xDNVbExrCXIo0gcYTT7m93oaj/DBQoefdIvvS3jFj0N5/zZDPBoRiua2Gw0K9nA03qLV2m8qsxF7as7+QDt/SfAQgD9KcnGWvac17DuvQCt5tBh61nO/amSOSWAc1RlrPr2ygtqGyo8z5S2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d52QD0S6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45219C4CEDD;
	Mon, 24 Mar 2025 22:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742854797;
	bh=Z3k6/MYw0IClXSufou4UOke3Y1b6iauBex5QeI8X2jo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d52QD0S6E0jxVUoOVNgV3und4cF3DZ6DN10wBcvw2N1FCrsYU1GnqQOToq8UPXGvd
	 4UY69OCTja/jn8NZrkVNM9W8UN3bZzbZjoZW9VBevRTL1NWAjnUBp6R+AxrLWhSKY+
	 Bn7/Q/fI5EW6jjHszilpg9gYMLqzOJkTnVLHSqCAVSVDYrs+DT0MTF7BRqz3nDe5Wi
	 gVtMp3NA63x2cdeHhs/pFmFFH/cv6rhNs90NAe7CDNnqowyGYTPEtMT/rjN3425Hwr
	 VHkQ544Gn0g2FWca5/Vu0T65RDEqUfFGPiWXPeAQnbwPbEks+z0MCkZVOVQZ+y5R5Y
	 e1RQGkJ/4fOuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF039380664F;
	Mon, 24 Mar 2025 22:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] mlxsw: Add VXLAN to the same hardware domain as
 physical bridge ports
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174285483355.3937.1490840167565257776.git-patchwork-notify@kernel.org>
Date: Mon, 24 Mar 2025 22:20:33 +0000
References: <cover.1742224300.git.petrm@nvidia.com>
In-Reply-To: <cover.1742224300.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, idosch@nvidia.com, amcohen@nvidia.com,
 mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Mar 2025 18:37:25 +0100 you wrote:
> Amit Cohen writes:
> 
> Packets which are trapped to CPU for forwarding in software data path
> are handled according to driver marking of skb->offload_{,l3}_fwd_mark.
> Packets which are marked as L2-forwarded in hardware, will not be flooded
> by the bridge to bridge ports which are in the same hardware domain as the
> ingress port.
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] mlxsw: Trap ARP packets at layer 2 instead of layer 3
    https://git.kernel.org/netdev/net-next/c/6d627a29aab8
  - [net-next,2/6] mlxsw: spectrum: Call mlxsw_sp_bridge_vxlan_{join, leave}() for VLAN-aware bridge
    https://git.kernel.org/netdev/net-next/c/a13fc7ebd994
  - [net-next,3/6] mlxsw: spectrum_switchdev: Add an internal API for VXLAN leave
    https://git.kernel.org/netdev/net-next/c/413e2c069969
  - [net-next,4/6] mlxsw: spectrum_switchdev: Move mlxsw_sp_bridge_vxlan_join()
    https://git.kernel.org/netdev/net-next/c/630e7e20d35f
  - [net-next,5/6] mlxsw: Add VXLAN bridge ports to same hardware domain as physical bridge ports
    https://git.kernel.org/netdev/net-next/c/139ae87714eb
  - [net-next,6/6] selftests: vxlan_bridge: Test flood with unresolved FDB entry
    https://git.kernel.org/netdev/net-next/c/36ed81bcade9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



