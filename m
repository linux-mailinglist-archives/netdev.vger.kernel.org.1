Return-Path: <netdev+bounces-47937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CF27EC048
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 11:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32AB0B20992
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 10:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8A7C2EE;
	Wed, 15 Nov 2023 10:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+qN/UxC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D30C143
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 10:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73A92C433C9;
	Wed, 15 Nov 2023 10:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700043024;
	bh=8oGuqu5H/DBhBeQLLHGDX/9Rsdie9PSLVreZfLiiFIM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L+qN/UxCrdtRNJJDcBJXDOwCRFBVRKv9m6TsLvb+R0G2/1VBaxdxIul2q1IrQrSl7
	 x2MDHOxL8Z8qKQmdEWv9+jRYRcGLFFHnmpVZFlwHr4PgKvXoNSj5jBCxkvOQHYjuBE
	 N6q2mIOIilx1UvD4uzAGXauWqobBByAV35Q91A7JZdRDr/W99cPuR6mWTFPHz7buqO
	 92loz2GhcC7nz/F1AKzKe9t/j+ZluH5hNPHj6ffqMafbZWMYNGBdp/Kp/ybLItCIQO
	 Co+eoujo6LAJsqW7wf458uVo428BfSthGKtSk+hKslkCPx7m7A+h5jCfl75jXtVa6h
	 7xExxEnc9ck9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5B0F0E1F66F;
	Wed, 15 Nov 2023 10:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] Revert ncsi: Propagate carrier gain/loss events to the
 NCSI controller
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170004302436.28811.7446869431926384259.git-patchwork-notify@kernel.org>
Date: Wed, 15 Nov 2023 10:10:24 +0000
References: <20231113163029.106912-1-johnathanx.mantey@intel.com>
In-Reply-To: <20231113163029.106912-1-johnathanx.mantey@intel.com>
To: Johnathan Mantey <johnathanx.mantey@intel.com>
Cc: netdev@vger.kernel.org, sam@mendozajonas.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 13 Nov 2023 08:30:29 -0800 you wrote:
> This reverts commit 3780bb29311eccb7a1c9641032a112eed237f7e3.
> 
> The cited commit introduced unwanted behavior.
> 
> The intent for the commit was to be able to detect carrier loss/gain
> for just the NIC connected to the BMC. The unwanted effect is a
> carrier loss for auxiliary paths also causes the BMC to lose
> carrier. The BMC never regains carrier despite the secondary NIC
> regaining a link.
> 
> [...]

Here is the summary with links:
  - [net,v3] Revert ncsi: Propagate carrier gain/loss events to the NCSI controller
    https://git.kernel.org/netdev/net/c/9e2e7efbbbff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



