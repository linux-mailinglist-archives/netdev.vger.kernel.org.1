Return-Path: <netdev+bounces-110011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EC792AAD4
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 23:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E78AD2831FC
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 21:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113142135B;
	Mon,  8 Jul 2024 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrNdWq+9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0BF1CD3D
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 21:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720472431; cv=none; b=ZCb4Kw8nzlw5G+/gIs/yZ+AI5hbAeWo39vV/svSGRXZzXzHf9vLkWZU7bqIr4vmnnq/hpLAnuGtAk18PlhN9AlyfdX7bTp4Xkw6qeqQq9yP+ECN9eBKD4BDDyVG3teuGlCtbf5Uqkt65tbwxnFC7HM4zNFV3iHcq5uif73OE21g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720472431; c=relaxed/simple;
	bh=ytEGmtkXeuJFb0Vf4MlEqkPk8rfwVMwCvGv3yFai1vE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eFUR89UYICnTvtWyxmPZ526xs1xS+x5KnbE1ukYMU/fqB/iuFmn8qtp1eLDcwSF/lS8cJJ72LZUd/u14Bg14jwSjkMM+E91f+HtAGy7GpoOn83PN49O1fyust+7+ztS1Mkr0ByrV96G76dIPsLVB+Y5TvFtXRDV7UTsdHWaLdqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrNdWq+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 778F4C116B1;
	Mon,  8 Jul 2024 21:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720472430;
	bh=ytEGmtkXeuJFb0Vf4MlEqkPk8rfwVMwCvGv3yFai1vE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UrNdWq+95VWs5L4/9Po1pxxM3YRNmDejOMWIe+VCO2RiCv7VQ9CCYGUe6kxCJS2Uc
	 NnXV/tfXiT7ZGO9I+oBA2I2rYjbj8EDejxoozA9J2DflWzlBxtX6+TmocfPvNRQbF6
	 B2j2LMQvyxTeGURSLPma8CERU8pSDZJFb8MOA9tXHmWCi6+aPcLMwFsdsP+feoPtjX
	 vmcj6p1H45RbDwYklO+ap4zlbHtCaLu6sdRroouUhrjJECcUkUQi6tpeEMffjTxN7g
	 +MJZW462FXWKm4x/JpfBgRJgQvbsvH/ATwkSt+JQliIJ3BJSnt5ife7uUv1GZKBMz+
	 jkUzm8Vbok01A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64E08DF3713;
	Mon,  8 Jul 2024 21:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: net: ksft: interrupt cleanly on
 KeyboardInterrupt
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172047243040.30785.8088736601277658051.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jul 2024 21:00:30 +0000
References: <20240705015222.675840-1-kuba@kernel.org>
In-Reply-To: <20240705015222.675840-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, petrm@nvidia.com, przemyslaw.kitszel@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Jul 2024 18:52:22 -0700 you wrote:
> It's very useful to be able to interrupt the tests during development.
> Detect KeyboardInterrupt, run the cleanups and exit.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/net/lib/py/ksft.py | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] selftests: net: ksft: interrupt cleanly on KeyboardInterrupt
    https://git.kernel.org/netdev/net-next/c/e0ee68a8bef9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



