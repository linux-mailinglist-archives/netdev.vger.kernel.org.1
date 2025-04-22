Return-Path: <netdev+bounces-184571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9C7A963C4
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 11:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9CB6161906
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 09:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40A0256C81;
	Tue, 22 Apr 2025 09:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WR2+z52t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907CF2566C5
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 09:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745313014; cv=none; b=DRV1IgFmT8G9yMS+Nn7zsdKARmyPCG0KLMW4WwI5BPP1+QLS1z/Gg5JWckSJcvEp2lRGoygRtUMubWYyYgnn3Q2x56AZRPr0X7k6Qvy32lNHsA2JGob5WGHbPivS9QMi0TYS7uH8n3rygyBrmmXXeSmeOQtyE4VsSxFj0i24tUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745313014; c=relaxed/simple;
	bh=4eudOq72MURoqjQQencKELvs+skibjPUyOtIP013cEs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dt3XtQaviqGLtdN+esRdlHqkEzByKLsDgm6P4Xc6XIADjLJaPo9MeQmaREIndY0wxdxD97NYY58xoGFvY6EgtfDS65UkyWb3SzVx3fgZgMF8w2rkKM1Qnh7hCCbYnlE4YcDuSvMesn0GGVVA/qLdbeD6wtOSkYzeGTE5ra+drds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WR2+z52t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B881C4CEE9;
	Tue, 22 Apr 2025 09:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745313014;
	bh=4eudOq72MURoqjQQencKELvs+skibjPUyOtIP013cEs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WR2+z52tbTcPZBJ1bruLumKjL8o/U8XMsP7yfCUaZ0Tri7F0dDHzXwy1rSXWeQReF
	 PCUjTtlGUGIHD+xVN87xfbeIy4X9jEThGbuGuO6dXDE4kWZ3bNDFnoSgz+RHpr4oBO
	 W6McTSg9ZyqC1aRksY1zBm+GeCmOeELdtcsrlDpr1kXaDxXWv+PR6ba0vdS2ZyVxw1
	 Oiz5tpLMipvVU5/rYSmmKH/nMb+RhopT9+vqtDjEFQC3VJfRknlpgfHxHvR0GCqJVb
	 r4kCXu+oBOFcQwT96FBxke/GfgERkncRPdhQuVf4qil+aCDbamQ7M3xdixx3+tTQG8
	 CM90+B0xJEqWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD3A39D6546;
	Tue, 22 Apr 2025 09:10:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] bnxt_en: Update for net-next
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174531305224.1477965.7775754809547291173.git-patchwork-notify@kernel.org>
Date: Tue, 22 Apr 2025 09:10:52 +0000
References: <20250417172448.1206107-1-michael.chan@broadcom.com>
In-Reply-To: <20250417172448.1206107-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Apr 2025 10:24:44 -0700 you wrote:
> The first patch changes the FW message timeout threshold for a warning
> message.  The second patch adjusts the ethtool -w coredump length to
> suppress a warning.  The last 2 patches are small cleanup patches for
> the bnxt_ulp RoCE auxbus code.
> 
> v2: Add check for CONFIG_DEFAULT_HUNG_TASK_TIMEOUT in patch #1
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] bnxt_en: Change FW message timeout warning
    https://git.kernel.org/netdev/net-next/c/0fcad44a86bd
  - [net-next,v2,2/4] bnxt_en: Report the ethtool coredump length after copying the coredump
    https://git.kernel.org/netdev/net-next/c/c21c8e1e4348
  - [net-next,v2,3/4] bnxt_en: Remove unused field "ref_count" in struct bnxt_ulp
    https://git.kernel.org/netdev/net-next/c/5bccacb4cc32
  - [net-next,v2,4/4] bnxt_en: Remove unused macros in bnxt_ulp.h
    https://git.kernel.org/netdev/net-next/c/76a69f360a71

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



