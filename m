Return-Path: <netdev+bounces-232312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 075F7C04047
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 03:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F1D44FF1E5
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 01:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010141E7660;
	Fri, 24 Oct 2025 01:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3PnmmlH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80471ACED5;
	Fri, 24 Oct 2025 01:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761268833; cv=none; b=BLDQ2/aS6Ccz9XyMGEY4bW+CIwrb7IDagSoKbtMWruSizvMroOeeexyOamuCghhl4YPWFHWBlDB+RhA7N8KXo2K2lJRr2wntoLT4ZbxQLKJaf16Xx0tJ+ngY5CQ+Ybz9HGadqHHrprC8JWcZOqxDFurIOFLcpljlx8nknIRxfVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761268833; c=relaxed/simple;
	bh=tlDojOMPUzmLOzZJJ/z+jWO/8mkgNeXOeHjTh0VzK5w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YQnmixAxhOJMiYTjpKtKxUZ5tFAAHgb55cGU1a14N9S7aCXiB8GGVolyzk21yGax6pGwTO8o0KKA77RAaVA/iAMZ1TBSlCpkT2UI4+obLGIus9w+kGNa2hiKKuw5LPt2BE7VY9gHVtlYB1qj7sZaQSMUidtLVUSJ+tqBptg8jww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3PnmmlH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD1DC4CEE7;
	Fri, 24 Oct 2025 01:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761268833;
	bh=tlDojOMPUzmLOzZJJ/z+jWO/8mkgNeXOeHjTh0VzK5w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S3PnmmlHUbs3tfjcpuK1BmQJm1dno8xdTWiKUbS8ETYWB/+LH6m41na8VgwmZX+pa
	 vdlj/f8vxkpvfwFyhCxhPD58MbTWernDuALpHqy+gO2sZDFLYHIy7Y9LoLhFUg+V2z
	 R9u8sbJlPwqAF78aNctmPRPZOg5o+QF5aZ7ObmwaCZqznW+Xtd0obvMwkI9/r14lLC
	 Ko6rxWK371W3NFXDg1vpWcDGIB/gM/7kwMS/1CY6NRx8UH5wa7lTYHkHStCZXxlpa4
	 2Db0EIDJmWKS5C3PFIGpwS/mPM2a5fNWpis51Y1emReUrAlwiVIPaAYCC0uw8a1Alh
	 eoSs8XqczOpxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE21B3809A38;
	Fri, 24 Oct 2025 01:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: rmnet: Use section heading markup for
 packet
 format subsections
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176126881324.3310205.2043841398135141215.git-patchwork-notify@kernel.org>
Date: Fri, 24 Oct 2025 01:20:13 +0000
References: <20251022025456.19004-2-bagasdotme@gmail.com>
In-Reply-To: <20251022025456.19004-2-bagasdotme@gmail.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, subash.a.kasiviswanathan@oss.qualcomm.com,
 sean.tranchetti@oss.qualcomm.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Oct 2025 09:54:57 +0700 you wrote:
> Format subsections of "Packet format" section as reST subsections.
> 
> Link: https://lore.kernel.org/linux-doc/aO_MefPIlQQrCU3j@horms.kernel.org/
> Suggested-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
> Changes since v1 [1]:
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: rmnet: Use section heading markup for packet format subsections
    https://git.kernel.org/netdev/net-next/c/9ff86092655f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



