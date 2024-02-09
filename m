Return-Path: <netdev+bounces-70652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5430184FE0C
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 22:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84B531C2265C
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 21:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7829414F6C;
	Fri,  9 Feb 2024 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8KBC5c1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547CD12E4B
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 21:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707512431; cv=none; b=tAkdRtu1iT+42g/Ap0RCNGUNvZQunOmXhYMo5czoSv890+YKWRDxUf8134FmH8lQL204Jo4Ej/ckqYJXx9aAlciLyEKvqri5yeMwxR4xwB8CzYm2DZfWO9DxGPgzQkOS8J/HmtOB1W87uLvmImwD1peZsyS8GwWIQLIDPa9JkB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707512431; c=relaxed/simple;
	bh=ENTW3CPdgzrV63Alzh3y5gLDvRK4aJEdIegUtq8UDkA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QWkiX6wckKSnZCTNLoMWBsWMvl/4evSPGjJN01VDkVyyTCeb/Krg3JJfzIbH4RCyl8a8OR2kFQK1IlixleBTS8JsgXEt02PwxNuXIHO0WPjs9kvEFDaYeXpLAc2yuKRs+SVIuHei7aLUcTRHkgU27mZX52a8Z2T1qogm4ABfFuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8KBC5c1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8731C43609;
	Fri,  9 Feb 2024 21:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707512430;
	bh=ENTW3CPdgzrV63Alzh3y5gLDvRK4aJEdIegUtq8UDkA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K8KBC5c1iBE7UgJMthyU24xzNmoHlYOy9Vr7Hlj8O1UOyy0TjyT3tVxFlGI9cuJci
	 SEcG+ftPZIcKmVMfyLiiUr1QN9QQgaogucvrtKGEhRb/Ysy1ercy4bgYDjCejdzWLT
	 +8Wr978R/Ql2OUyJq++xSF+SX5nMtpqoE5Hf81CCDTi2K8hDwkK/A6r3SRNAGjxNYR
	 KkAprItuUQjkjnY+bn6Cl9l+L4m8AiAAG6Rjf6fAMTBEHSLN1Aus8xBij77my7TdzW
	 ieoubM6A/3ryxyjymv0tDOgRjFZdOfaxZ5Iz0CeG3fyeg+d8ygf2NjeSbaTSMKKHDe
	 pJoNOBLV7sBHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5A67E2F312;
	Fri,  9 Feb 2024 21:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: improve checking for valid LED modes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170751243074.9207.12684045279811090986.git-patchwork-notify@kernel.org>
Date: Fri, 09 Feb 2024 21:00:30 +0000
References: <8876a9f4-7a2d-48c3-8eae-0d834f5c27c5@gmail.com>
In-Reply-To: <8876a9f4-7a2d-48c3-8eae-0d834f5c27c5@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 7 Feb 2024 08:16:40 +0100 you wrote:
> After 3a2746320403 ("leds: trigger: netdev: Display only supported link
> speed attribute") the check for valid link modes can be simplified.
> In addition factor it out, so that it can be re-used by the upcoming
> LED support for RTL8125.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] r8169: improve checking for valid LED modes
    https://git.kernel.org/netdev/net-next/c/4c49b6824a60

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



