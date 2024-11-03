Return-Path: <netdev+bounces-141363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 664599BA959
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 23:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0016C1F21167
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 22:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F053518BC15;
	Sun,  3 Nov 2024 22:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPCMWFHa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AA5433AB;
	Sun,  3 Nov 2024 22:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730674221; cv=none; b=OPSCMHBWqyu/7c9dbH8P5w3drzsw5r4594sSnaX7E7yahCIFQjJs3gjKv1XLGJ8iQvaPjAqpUKhjWjp/+ZHnEJ2VRRSshTsPczONdjydTBVIk6Uivyti7hF9kSJcmpOY4ujqULnKmSQ4HU6RN6dTVApEo9KP9v4BBqJq1Q5YTUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730674221; c=relaxed/simple;
	bh=0SkRTSGIsqiHs5Dh71zvHWv9TulxU8fWVKzt6rhmO3I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bYgkWoTGPDcmVxqNada4bBWA1vd4mmMNDIaN6Vfbm+ebwZHr8zdHxFGYgeJOhlpF6/nGO+kDOnx9z0FVpbOEeWnsO74cLlx7NFGLMs8osiT1RmuFL+KLoNGK8ZkCkmg2tCKO6RLlkvgVzsR3xe159P4wNQQUqvBZULt3jNugRvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPCMWFHa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4289AC4CECD;
	Sun,  3 Nov 2024 22:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730674220;
	bh=0SkRTSGIsqiHs5Dh71zvHWv9TulxU8fWVKzt6rhmO3I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BPCMWFHaP3Z8NTmYEyOHOkT/3VHxcCmtgnh91Z3tLN2Nr5AOl1UypTmkHX3jJ2HTh
	 lhxDE71KEBBoEdMrO2GVLBFzOP/+t22y6RPHhvjU3oof3hepLHcmr8F4Hwkosh2AK0
	 GOsQ0gKVwXWd+blPBzRPVjYORcdJL8L+WueQmDzBw6Hp8TkYK7SocYv+2OECnqe8uN
	 QaKosYae+yrLtg5XFueEDZh9HAdyCSA6mstmI0zQgtWCb7FdAyggIPai0/rdFq2SCm
	 jdB/ihBkaw4OtVfXXb3813O8oL36cDsDc3Etpy7UikU7zD22Blj1NhwvhDFCmfQsAs
	 Ai9rimwXOf8ZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF8538363C3;
	Sun,  3 Nov 2024 22:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] net: xilinx: axienet: Fix kernel crash in dmaengine
 transmit path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173067422875.3271988.4124250768668395576.git-patchwork-notify@kernel.org>
Date: Sun, 03 Nov 2024 22:50:28 +0000
References: <20241030062533.2527042-1-suraj.gupta2@amd.com>
In-Reply-To: <20241030062533.2527042-1-suraj.gupta2@amd.com>
To: Suraj Gupta <suraj.gupta2@amd.com>
Cc: radhey.shyam.pandey@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 michal.simek@amd.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 git@amd.com, harini.katakam@amd.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Oct 2024 11:55:31 +0530 you wrote:
> This series fixes kernel crash in dmaengine transmit path. To fix it,
> enqueue Tx packets in dql before starting dmaengine and check if queue is
> not stopped.
> 
> Suraj Gupta (2):
>   net: xilinx: axienet: Enqueue Tx packets in dql before dmaengine
>     starts
>   net: xilinx: axienet: Check if Tx queue enabled
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: xilinx: axienet: Enqueue Tx packets in dql before dmaengine starts
    https://git.kernel.org/netdev/net/c/5ccdcdf186ae
  - [net,2/2] net: xilinx: axienet: Check if Tx queue enabled
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



