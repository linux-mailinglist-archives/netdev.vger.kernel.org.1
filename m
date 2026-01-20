Return-Path: <netdev+bounces-251423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53685D3C500
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 11:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A04A57214F4
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0628B3D6696;
	Tue, 20 Jan 2026 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrCXhQVD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB633D2FF8;
	Tue, 20 Jan 2026 10:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768903220; cv=none; b=hSlZWNbBgIBq6RJq79gsEoIWvOPPYM/FiS1tUJMUeUlNbaqdJ1mgDJW+GxSq+VPtJrQwaR0iLPuyi1DJryWR3Dn6orJ4KHsMgPrVj7Miu687eDRiOKquDWUi1hIi/EQNnwdgNbfbIkH+vpRYxzJdOjOUzr1xePvKj0Q5/pv0AiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768903220; c=relaxed/simple;
	bh=b2n5kG0JEndNa7HHXCIfoTBimaf+cfdFNox0IXsVlnc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MBQpk8yOVoZe2T5JHf4Yh7e7hKEDtwaqwW5rq35TTI3C9es7EXF3lWGIPL+N94DjHJtwx5tMjt8dALEE3gacuv5tWKVLYGLGXTCvXesBzeACqp51/H3JDgHF1ELSdJ2p6XB0AJa5d38TIgMJQHS0ttDSUic7+YcEsUHZSGbdBVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrCXhQVD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A79C16AAE;
	Tue, 20 Jan 2026 10:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768903220;
	bh=b2n5kG0JEndNa7HHXCIfoTBimaf+cfdFNox0IXsVlnc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SrCXhQVDkP1GWJFrUzKS+Ewo60ZQGqrujVlMuicBT7l6FTuCq9c+ESt02UjsevEF1
	 8hrpN4fQQcPTLVy+B4lKzBPaZO8UPrjg4esURkkda3FMgq6Urs6A4q+5JzwRxSttod
	 kqiAmJL6KfWdcZA9lZ/DhkDqSkFlOECzt/IJwbj1JKtJwW4GRgxhBtSZd6SCQxasP8
	 ql6OubbnakUnTbrMcjdsZc1UfvqlF6qL0MnZ7dbZmNcEsTkTkMn9cmX6hNeNPzKW84
	 wqpCDqLdWMLVKqUo7wyVgICg+kRoZ0nX2OlgesXRs1m5EsF00Tuy6VVivql/COe/Tv
	 KGYY5yaIqK3jQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0216E38068DF;
	Tue, 20 Jan 2026 10:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v11 0/9] net: hinic3: PF initialization
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176890321754.717702.14796258240197928726.git-patchwork-notify@kernel.org>
Date: Tue, 20 Jan 2026 10:00:17 +0000
References: <cover.1768375903.git.zhuyikai1@h-partners.com>
In-Reply-To: <cover.1768375903.git.zhuyikai1@h-partners.com>
To: Fan Gong <gongfan1@huawei.com>
Cc: zhuyikai1@h-partners.com, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, Markus.Elfring@web.de, pavan.chebbi@broadcom.com,
 alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, luosifu@huawei.com, guoxin09@huawei.com,
 zhoushuai28@huawei.com, wulike1@huawei.com, shijing34@huawei.com,
 luoyang82@h-partners.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 14 Jan 2026 16:38:19 +0800 you wrote:
> This is [1/3] part of hinic3 Ethernet driver second submission.
> With this patch hinic3 becomes a complete Ethernet driver with
> pf and vf.
> 
> The driver parts contained in this patch:
> Add support for PF framework based on the VF code.
> Add PF management interfaces to communicate with HW.
> Add 8 netdev ops to configure NIC features.
> Support mac filter to unicast and multicast.
> Add HW event handler to manage port and link status.
> 
> [...]

Here is the summary with links:
  - [net-next,v11,1/9] hinic3: Add PF framework
    https://git.kernel.org/netdev/net-next/c/53200a8605d7
  - [net-next,v11,2/9] hinic3: Add PF management interfaces
    https://git.kernel.org/netdev/net-next/c/a30cc9b27790
  - [net-next,v11,3/9] hinic3: Add .ndo_tx_timeout and .ndo_get_stats64
    https://git.kernel.org/netdev/net-next/c/f47872bed40f
  - [net-next,v11,4/9] hinic3: Add .ndo_set_features and .ndo_fix_features
    https://git.kernel.org/netdev/net-next/c/721df7639c83
  - [net-next,v11,5/9] hinic3: Add .ndo_features_check
    https://git.kernel.org/netdev/net-next/c/2467a0466028
  - [net-next,v11,6/9] hinic3: Add .ndo_vlan_rx_add/kill_vid and .ndo_validate_addr
    https://git.kernel.org/netdev/net-next/c/0f9e2d957474
  - [net-next,v11,7/9] hinic3: Add adaptive IRQ coalescing with DIM
    https://git.kernel.org/netdev/net-next/c/b35a6fd37a00
  - [net-next,v11,8/9] hinic3: Add mac filter ops
    https://git.kernel.org/netdev/net-next/c/aebd95b00a3a
  - [net-next,v11,9/9] hinic3: Add HW event handler
    https://git.kernel.org/netdev/net-next/c/cb36f89b1001

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



