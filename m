Return-Path: <netdev+bounces-197692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9329CAD9961
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 03:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 031807AD618
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 01:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B5C1802B;
	Sat, 14 Jun 2025 01:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqsYhSS0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCBA2CA9;
	Sat, 14 Jun 2025 01:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749864004; cv=none; b=PJavBgGqzqxjc6DAAIJ5UwQe8jleNUqm3jz1ieKIh04+bueX6OEiwLMrVw1bA9CULqSAmKwD0epc+6Ys8TnMn7I6kgDIBfQkVPx2nhB0zUUdC4uB1C6b0jsyUtGTMh7AwAiakBLrr2NrSVZ1uk+bNFLPtH7X88hb/TVlST2hyuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749864004; c=relaxed/simple;
	bh=liKv19Te0RzkI75J9r3x9sEe+HoeKeG5c9bjd5WiiXw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CNgM/vU1eAMa7KaP0t6VY5IQiu1osj2fNuFeCU9ROl8X3CQP7n55gHMY35eeTPzgHUXTAZcVaVtO/af6Xu2uYVjEQjgmayioQX8RYcwvuUx3mVAPSk4MUjZmHP/bWfXP7TdTQHDefp+ALeuOQv8iYRMGJ8pOY5oE8pe/QDchlts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqsYhSS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0F1C4CEE3;
	Sat, 14 Jun 2025 01:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749864004;
	bh=liKv19Te0RzkI75J9r3x9sEe+HoeKeG5c9bjd5WiiXw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PqsYhSS0eiyddszswm3tmv2Pru7RnRVuE0ITdBymZGBY6kfLv15ugZI0KCGY/0paR
	 qZbmV3/wFcbeqA18RGYfs8QgZIgk/WTWYh5q49zWOnFI8sxC2vxnPVT3VQwYtVavv9
	 9hbHoa/qoG1PzdrHLwzmOG1mN7zCILiAEObWsLTGgM4kQPUBYCIm1thozaW+UhyBc8
	 8o0uF+g7ALqG/JrQ+XTCfamKBLzLlI/gOzHTlzkUwdl1MuYzuj4+z/gqb8d2GsesKT
	 /vV9JPqxz/opzq+hg62X8TJjfzXo6XtkADbGSDdMU+hep2Xh9uHShnY707AKiX18Uw
	 khxkuFraMSndw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCBB380AAD0;
	Sat, 14 Jun 2025 01:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: pfcp: fix typo in message_priority field
 name
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174986403351.949218.16498839735634988981.git-patchwork-notify@kernel.org>
Date: Sat, 14 Jun 2025 01:20:33 +0000
References: <20250612145012.185321-1-rubenkelevra@gmail.com>
In-Reply-To: <20250612145012.185321-1-rubenkelevra@gmail.com>
To: RubenKelevra <rubenkelevra@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Jun 2025 16:50:12 +0200 you wrote:
> The field is spelled “message_priprity” in the big-endian bit-field
> definition.  Nothing in-tree currently references the member, so the
> typo does not break kernel builds, but it is clearly incorrect and
> confuses out-of-tree code.
> 
> Signed-off-by: RubenKelevra <rubenkelevra@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: pfcp: fix typo in message_priority field name
    https://git.kernel.org/netdev/net-next/c/b776999bf25d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



