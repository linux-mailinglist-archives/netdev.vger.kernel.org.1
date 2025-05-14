Return-Path: <netdev+bounces-190287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6410CAB6034
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 02:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56B58642B0
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 00:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EE3225D7;
	Wed, 14 May 2025 00:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyFI1H6O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308A525760;
	Wed, 14 May 2025 00:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747182593; cv=none; b=rsVuxnUDPrdHjJQwaCAQJ/mb3egM4xEZMLtJVQPeS+aDKXrud6xDITI04+u3TrrXhNnpuLVCYQjozqCoUyRZVvW23c2z2nxIJv8JrF0PxBwThWFCyaGvteQxo00yQjG2/+xFlaQ8uHQDSfvUuKJQxIAb1TIWk+6os0BwutPHSBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747182593; c=relaxed/simple;
	bh=/tWBXSqBsWK0/0++UUW/l22Ugc9piDNSl+WPBk5asaM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pXrPyNcD9DRkb+/eNTdhFBNZOMRsiY9CpBVLoFNBI0rDyqweN3YQLzbw6DjQ6ZX51cc+eqlM8nDEdxERySvvZ6AXOXBq6NhQJ6WyQCp2tJrXX4tzVPqEp5V7BfB3y95pBIimKLFjFMn0kjWkNzQ2wCX/kneGALcvTM6XlvY3Sy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyFI1H6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5A9C4CEE4;
	Wed, 14 May 2025 00:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747182592;
	bh=/tWBXSqBsWK0/0++UUW/l22Ugc9piDNSl+WPBk5asaM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tyFI1H6OV0ovpBXd7X9NKQ/k0APzXbrdWfs3DrUtEn9drb1cntrWu/UGcLzIxTNnt
	 VYSKiLq7iJNCj7dGUVRJ7Ih9Y8GdCILgtJbsOeUBmA8VYztqKUMSNcXe7UMTe5Ly2F
	 ga+EFitGAhiHDXCNB46zZhmlp/89HoMpUWWHIs7TMkdqlwjxwtT8qvLyR/BtWQeqP/
	 EpF0uWdVHZpsUCLvwhmIawS7fPj55/xinSbiywnO5hmWsIF5NvepaWs2T082ld2XFw
	 ubOOQkEPntr172a2/hFcrjf7X2BCpcsnwf6tAcY0N7eWy/Jwf7PKJqJw4fcf14Ggoz
	 tN30NfM3NsStA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341AD380DBE8;
	Wed, 14 May 2025 00:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] qlcnic: fix memory leak in
 qlcnic_sriov_channel_cfg_cmd()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174718263001.1832687.7775702578018906906.git-patchwork-notify@kernel.org>
Date: Wed, 14 May 2025 00:30:30 +0000
References: <20250512044829.36400-1-abdun.nihaal@gmail.com>
In-Reply-To: <20250512044829.36400-1-abdun.nihaal@gmail.com>
To: Abdun Nihaal <abdun.nihaal@gmail.com>
Cc: shshaikh@marvell.com, horms@kernel.org, manishc@marvell.com,
 GR-Linux-NIC-Dev@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 sucheta.chakraborty@qlogic.com, rajesh.borundia@qlogic.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 May 2025 10:18:27 +0530 you wrote:
> In one of the error paths in qlcnic_sriov_channel_cfg_cmd(), the memory
> allocated in qlcnic_sriov_alloc_bc_mbx_args() for mailbox arguments is
> not freed. Fix that by jumping to the error path that frees them, by
> calling qlcnic_free_mbx_args(). This was found using static analysis.
> 
> Fixes: f197a7aa6288 ("qlcnic: VF-PF communication channel implementation")
> Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] qlcnic: fix memory leak in qlcnic_sriov_channel_cfg_cmd()
    https://git.kernel.org/netdev/net/c/9d8a99c5a7c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



