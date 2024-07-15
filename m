Return-Path: <netdev+bounces-111406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FC6930D0D
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 05:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F0921C20DDB
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 03:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37B918308D;
	Mon, 15 Jul 2024 03:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkJ7dwxZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC67318307B;
	Mon, 15 Jul 2024 03:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721014835; cv=none; b=KQbKFoi1B7tm6+aclfmPh0kaPu25tZLt5bRzari1Sqr+EgYouN+38sTqsqGPyjo9Y330XMaJ1sPE7BUKLDHmbNtYCEpyFGxhWQfFWiRikfsvUwq8owFH3fPcdR8HSXL/ZyWVNQMnYXOBXYrbm2lHH1KE8DZp0cGAPc8x3NAGX2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721014835; c=relaxed/simple;
	bh=mnT8cXW+QvRBq3wDvKVm8UOmMR1dFpPq2MEHJMeYmQ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P0g0Zgl4aMrS2U4+FeAbCr3MrROB7h+SIU3aN03cjsIHG+Ec2Ex7R9W5V+qnX3Ne+v1SXWss90ZkywmKcQ1XB1PzZmnu76eSBPqddMCPwqkSJfxJW9SboX/DJg8FHpAgmitcP2VXf/1PBJ+jsX2oZC/0mRO6Mm80M9u4+BYNQis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rkJ7dwxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C2A7C4AF0C;
	Mon, 15 Jul 2024 03:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721014835;
	bh=mnT8cXW+QvRBq3wDvKVm8UOmMR1dFpPq2MEHJMeYmQ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rkJ7dwxZ6Y2VZ8a7xFWjsAnnb3uxJ2OgHNulqgkhv7cZK0D3ujwzfslOZJiKzjKlx
	 CJsC/RMje/nmX6xL2FtUGwparYlrxhJW/NwE5+Xf56teu0AbCkHgJ1RJWbZukVjonN
	 ACAw13jwn/0FIinfqDeE4ZvuC2A/PNeCYorp3TGgDrnYr/JQHOiSMnnyssx7xv1nxo
	 eeIub73RxmBf0OS4obTEYjqJ9KhcEkeLHkL4z6JbUvMKYGzHzZPHnCVJbRbLj73p8l
	 +QxKFjt2nPmHrL1ztbzcKi+2QpDkbdc09KFtA7JRF4O8Uav4ranzcg4LwKRF9KnfYQ
	 ApurMpd+bJ9Aw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36EE4C43331;
	Mon, 15 Jul 2024 03:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/5] Eliminate CONFIG_NR_CPUS dependency in
 dpaa-eth and enable COMPILE_TEST in fsl_qbman
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172101483522.5253.5175623354065393488.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jul 2024 03:40:35 +0000
References: <20240713225336.1746343-1-vladimir.oltean@nxp.com>
In-Reply-To: <20240713225336.1746343-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, leitao@debian.org,
 herbert@gondor.apana.org.au, madalin.bucur@nxp.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 14 Jul 2024 01:53:31 +0300 you wrote:
> Breno's previous attempt at enabling COMPILE_TEST for the fsl_qbman
> driver (now included here as patch 5/5) triggered compilation warnings
> for large CONFIG_NR_CPUS values:
> https://lore.kernel.org/all/202406261920.l5pzM1rj-lkp@intel.com/
> 
> Patch 1/5 switches two NR_CPUS arrays in the dpaa-eth driver to dynamic
> allocation to avoid that warning. There is more NR_CPUS usage in the
> fsl-qbman driver, but that looks relatively harmless and I couldn't find
> a good reason to change it.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/5] net: dpaa: avoid on-stack arrays of NR_CPUS elements
    https://git.kernel.org/netdev/net-next/c/555a05d84ca2
  - [v2,net-next,2/5] net: dpaa: eliminate NR_CPUS dependency in egress_fqs[] and conf_fqs[]
    https://git.kernel.org/netdev/net-next/c/e7072750bbcb
  - [v2,net-next,3/5] net: dpaa: stop ignoring TX queues past the number of CPUs
    https://git.kernel.org/netdev/net-next/c/e3672a6d5e89
  - [v2,net-next,4/5] net: dpaa: no need to make sure all CPUs receive a corresponding Tx queue
    https://git.kernel.org/netdev/net-next/c/6d2338205d78
  - [v2,net-next,5/5] soc: fsl: qbman: FSL_DPAA depends on COMPILE_TEST
    https://git.kernel.org/netdev/net-next/c/782fe08e9861

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



