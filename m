Return-Path: <netdev+bounces-143543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BD89C2EEA
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 18:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACB5B1F21700
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 17:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0131819F13B;
	Sat,  9 Nov 2024 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gr/e6UYr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0BC19F115;
	Sat,  9 Nov 2024 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731174625; cv=none; b=bS+G5L0Z0pyOLpf3cFLVcagY8CvDfKK7Hlra2OQx/WXIaj/mMglGQE7J+ZivVa/N4J9gN3DH5Un3zWe/WK8rVz/2X5cC+lMxnoH40H0Si/xxBMPMUuQDbgV7F9JctjkM43MO2NOpLVVMYCLWmAdBfUEYWVgdY8aLcpgCLtksiTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731174625; c=relaxed/simple;
	bh=pYtKEpzSG42YcWjJM2DOhi/N3tNUOuOOPYpXtUBWNRs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tlPEoPFp6ax8qnCm5WgazAfseJbJg1Rt+8x/KmMOe8Bhb7pp2p2LWCGISbMwjcVMssq3ePHhXgKP1cbFcxanaWiQKgkgG15x6rUoMN4AEgEIXAfvcoQ8AdQcPMFxNBZ/snxtYaD9qPncMNM0yffIG6pfu/6I2tXlU052SNl2hFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gr/e6UYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FDDC4CED3;
	Sat,  9 Nov 2024 17:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731174625;
	bh=pYtKEpzSG42YcWjJM2DOhi/N3tNUOuOOPYpXtUBWNRs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gr/e6UYrdFuiygnQlCBM3Co3bX1ofKCfB7TQ9D0xO/EalevEh/7Usnfeav2UYeB7H
	 x5KFlWu8/7r50cokloD6/Cy56ZPpunrA1bR+aMLqna92jOphl2dz720Ydzcy2A6ebR
	 +IOCBj/jbuanmiGDDuAJ4o4QN43XFB9wN913gZ6pP1+MJ35wQNe9nNcZVTj6PlxC3j
	 wBtM9B6k34C11tO2sRGyh04RBIA76LuG8bj4KY34Gr6eh3VDhN3mI/rg/7a27dp6t2
	 xQdVirwpM0u2n8rtG5h9yjsFI0fTloINIg087xdnZL/0CiW9DcEcVPlpDpPu2VClyH
	 GzZR0BfG7P6Sw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710343809A80;
	Sat,  9 Nov 2024 17:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tc: fix typo probabilty in tc.yaml doc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173117463524.2982634.11425896086661081930.git-patchwork-notify@kernel.org>
Date: Sat, 09 Nov 2024 17:50:35 +0000
References: <20241108195642.139315-1-xandfury@gmail.com>
In-Reply-To: <20241108195642.139315-1-xandfury@gmail.com>
To: Abhinav Saxena <xandfury@gmail.com>
Cc: linux-kernel-mentees@lists.linuxfoundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, donald.hunter@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, ast@fiberby.net, liuhangbin@gmail.com,
 alessandromarcolini99@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  8 Nov 2024 12:56:42 -0700 you wrote:
> Fix spelling of "probability" in tc.yaml documentation. This corrects
> the max-P field description in struct tc_sfq_qopt_v1.
> 
> Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
> ---
>  Documentation/netlink/specs/tc.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - tc: fix typo probabilty in tc.yaml doc
    https://git.kernel.org/netdev/net-next/c/cf6d9fe09185

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



