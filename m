Return-Path: <netdev+bounces-217806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDE4B39DF1
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1AA0E4E43CB
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 13:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7141930FC1B;
	Thu, 28 Aug 2025 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwQFIwhM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478853101AA
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386005; cv=none; b=nj+L9f3J/kuRnDr0kkD1alrj0g4ZMNFdPl5cXF0H6S7lI5YCUq637ASl4DL61dkeMLu5MgSEKS1pQwCAOzZTd+np9VWWVQdIy99XDuTYyo5MDLkypHX4aWdQvP8lSTW7ZgAvuo6H1kWiRYZmHdEael3iI/MT7Dqe4ri6GEVciyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386005; c=relaxed/simple;
	bh=sa1+GG1jBs5TivfXE7eJltjYH+0b25KPdnhHc7zeZuE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=un3Pd2r6z7KfCLJofGeU+C0IZ/AHw2Qtjp+Q4y1mvJjOwB94HSZaI2JJldblJ7V4O6a5P0VZ9VU8cs5WzY5LyS1zOCMKNco9ksa7l//YfyuoGbpe4mvaPL6z4Wu8TONFArF/VlGTOh5belUM1wx9QIj63pTs2OUKDM8O4lmlv/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwQFIwhM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC710C4CEEB;
	Thu, 28 Aug 2025 13:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756386004;
	bh=sa1+GG1jBs5TivfXE7eJltjYH+0b25KPdnhHc7zeZuE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BwQFIwhMvQeGo2hIE1zDMLsxKBoWgBu2Gj5i0v1gXuct7iQ/ZW1FnugT9hNxpa1P0
	 CSFRs0St9YlmNorYbBPAaPCI/peMdCD4sEJnQR627wyN3QGkpSKNLcf6WUUQxsvBJZ
	 y1KvHwHbL8zmun/v/8yFYJIo4zoo3fqWgetnF33cTdx5ltWlO9L+7iyctxY6bdIPk8
	 Ys0F+1ZuDxP5klLB/DCZnVh8enLQha8eG+KTRCD2rtwZIuY/Bf8HJXBTGWzGmR2fnX
	 R0CeAR5oM6rnkCLRxEP5v3egWgnVgZhh8p7tdwUPuv9u4pq5xpHe0OW2GljtNvey2A
	 xNcmRE91VnHEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FAE383BF63;
	Thu, 28 Aug 2025 13:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH 0/4] fbnic: Synchronize address handling with BMC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175638601201.1445956.12249410120174725676.git-patchwork-notify@kernel.org>
Date: Thu, 28 Aug 2025 13:00:12 +0000
References: 
 <175623715978.2246365.7798520806218461199.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <175623715978.2246365.7798520806218461199.stgit@ahduyck-xeon-server.home.arpa>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, pabeni@redhat.com, davem@davemloft.net

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 26 Aug 2025 12:44:41 -0700 you wrote:
> The fbnic driver needs to communicate with the BMC if it is operating on
> the RMII-based transport (RBT) of the same port the host is on. To enable
> this we need to add rules that will route BMC traffic to the RBT/BMC and
> the BMC and firmware need to configure rules on the RBT side of the
> interface to route traffic from the BMC to the host instead of the MAC.
> 
> To enable that this patch set addresses two issues. First it will cause the
> TCAM to be reconfigured in the event that the BMC was not previously
> present when the driver was loaded, but the FW sends a notification that
> the FW capabilities have changed and a BMC w/ various MAC addresses is now
> present. Second it adds support for sending a message to the firmware so
> that if the host adds additional MAC addresses the FW can be made aware and
> route traffic for those addresses from the RBT to the host instead of the
> MAC.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] fbnic: Move promisc_sync out of netdev code and into RPC path
    https://git.kernel.org/netdev/net-next/c/cf79bd449511
  - [net-next,2/4] fbnic: Pass fbnic_dev instead of netdev to __fbnic_set/clear_rx_mode
    https://git.kernel.org/netdev/net-next/c/284a67d59f39
  - [net-next,3/4] fbnic: Add logic to repopulate RPC TCAM if BMC enables channel
    https://git.kernel.org/netdev/net-next/c/04a230b27d8f
  - [net-next,4/4] fbnic: Push local unicast MAC addresses to FW to populate TCAMs
    https://git.kernel.org/netdev/net-next/c/cee8d21d8091

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



