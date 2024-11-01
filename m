Return-Path: <netdev+bounces-140909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DCE9B8961
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 03:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38EC282ACF
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B40137742;
	Fri,  1 Nov 2024 02:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSLZP+7w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBC81369AE;
	Fri,  1 Nov 2024 02:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730428823; cv=none; b=XSIlrGUElfwsJJgNtpsDGxC7iu5djkfPoWjBSTOn+MFeFbFQzA0dzkon+wfJ5COlliZ22L9xSl/xA0tpAdvJBr16WBiInJcRZpfCfzLX4cq3kiSUWaxfWDzmbzjqG6qwG9b9PTj80QXTv6TglOyQKPDqTGD1BNjJgpamSZOwzFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730428823; c=relaxed/simple;
	bh=rz9Upq9cqAd2Nmw0YIf11VODfPd1VekuV3h+8hSpXbo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a7gTEAXaoVLUvkB17Ya1GKUgDfRb3NPouHWzCrkZeSvnXXj9HxpN3TK/D+G4weha+C/CIpa729NzcxMqBpdtwv90KzakjwdpKq55xfyomKP9a03W+q5lSHaf24LJBcQGbwj9R+KAklZPzQdPZjoBK/sPHvvzoS0OIWRtl8JPPaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSLZP+7w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F19C4CEC3;
	Fri,  1 Nov 2024 02:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730428823;
	bh=rz9Upq9cqAd2Nmw0YIf11VODfPd1VekuV3h+8hSpXbo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pSLZP+7wfC6QFdm6MTiYC407XVHEt6H0ECI7htG74DL3IUrCzs0BkF/9LjG9cyF1g
	 JoiuizVu5LrTV323KDos6qfG80JL2fdMjRhKC7ffbIcAuLoIyKki6Ggto+sidTGckQ
	 r/7FQnXGINPvrrCzGA8SqKKJG5xVMkiHqEH3nakHAOq4NGs171mNGbsl+VV7b9NX5R
	 xiFNEDJpRqgc9U9mUDC7QOeuu1z6LnpgmmmUVqOUGrYdv5nFIy/cFos0Jt8QWvlDet
	 L7lpI71W/msa/Q/ryzEWV3Tx+QE4OlmR30jJmM+lkfgNvbSenHgb3XRfHFIumNex3R
	 CU3px4SLhOLFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D28380AC02;
	Fri,  1 Nov 2024 02:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: enetc: set MAC address to the VF net_device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173042883126.2159382.8815071931482398817.git-patchwork-notify@kernel.org>
Date: Fri, 01 Nov 2024 02:40:31 +0000
References: <20241029090406.841836-1-wei.fang@nxp.com>
In-Reply-To: <20241029090406.841836-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, claudiu.manoil@nxp.com,
 vladimir.oltean@nxp.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Oct 2024 17:04:06 +0800 you wrote:
> The MAC address of VF can be configured through the mailbox mechanism of
> ENETC, but the previous implementation forgot to set the MAC address in
> net_device, resulting in the SMAC of the sent frames still being the old
> MAC address. Since the MAC address in the hardware has been changed, Rx
> cannot receive frames with the DMAC address as the new MAC address. The
> most obvious phenomenon is that after changing the MAC address, we can
> see that the MAC address of eno0vf0 has not changed through the "ifconfig
> eno0vf0" command and the IP address cannot be obtained .
> 
> [...]

Here is the summary with links:
  - [v2,net] net: enetc: set MAC address to the VF net_device
    https://git.kernel.org/netdev/net/c/badccd49b93b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



