Return-Path: <netdev+bounces-127613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B79F975DD8
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 02:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50DB628547B
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 00:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3059B640;
	Thu, 12 Sep 2024 00:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ofv4TJ1F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0179475;
	Thu, 12 Sep 2024 00:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726099832; cv=none; b=YFOzSxhRvmFULSz+ArySXBzsf9GaAC1czLQHpWNfI9TeFD7yk72CBUA5NeDQSejSTDT5RfI7kaaZUzY0eaPJCvSLLfZv8pYSrwUdDf5KZpwLqMfGGlaGmjNc0LwzwYcxySbbGCmSMUOr5Roku4mreInIMMITckiAimEdCHttzTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726099832; c=relaxed/simple;
	bh=jeBCBquT69OD1geEBDVJXBvGqIUM3nlErijhnSEL/fQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g/qGzRVaC1QXFH3t3BHc74eeuJrq+kvQNzQqBlSnGqUFbEZiZUlnfIGdQmIxkdUUQuXF04zIksPhXWIjaalX9I+hlvVHKTLFbdBW2ehGmgyFMNYSs+twQ4q3lw417hGpmzNyyVLB64PB/xtcolvwyXqseyyz/04MkY60rLiVNd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ofv4TJ1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56283C4CEC5;
	Thu, 12 Sep 2024 00:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726099832;
	bh=jeBCBquT69OD1geEBDVJXBvGqIUM3nlErijhnSEL/fQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ofv4TJ1FgqaSDWkXafTU5FUZYo8MZBrLRNJ8q5qcBtNVtVPDANRmXE5zuVRJPUx83
	 59BjcDbiIpVjVFVinEihNBN0XETko1bv6VorpDbZwWNeavIoW6c98c4F9E2+fQq8H9
	 Z7uLp5vbM1/aUb7iH+ZNndEgdZgLL7yO2pVt1wpkIXwvXDuhS7IV63zjpe4sjyqjXQ
	 Yy6nAlpBUrW6VP/tffHUb+7Hm4omc/36qRbGsmA82yxPP/FUhp/FdjLxfbs/b47N/M
	 PFr6YJ9wY4q/lgQBjEOIpgW+mSOn86dS7Jez/LOrdLbtQBCeeJ5KP/vNObmFouGcHQ
	 lFkCJ0WHf0ZEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2FE3806656;
	Thu, 12 Sep 2024 00:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] sfc: Add X4 PF support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172609983325.1114191.8940826236559448042.git-patchwork-notify@kernel.org>
Date: Thu, 12 Sep 2024 00:10:33 +0000
References: <20240910153014.12803-1-jonathan.s.cooper@amd.com>
In-Reply-To: <20240910153014.12803-1-jonathan.s.cooper@amd.com>
To: Jonathan Cooper <jonathan.s.cooper@amd.com>
Cc: ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Sep 2024 16:30:13 +0100 you wrote:
> From: Jonathan Cooper <jonathan.s.cooper@amd.com>
> 
> Add X4 series. Most functionality is the same as previous
> EF10 nics but enough is different to warrant a new nic type struct
> and revision; for example legacy interrupts and SRIOV are
> not supported.
> 
> [...]

Here is the summary with links:
  - [net-next] sfc: Add X4 PF support
    https://git.kernel.org/netdev/net-next/c/cf06766f1525

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



