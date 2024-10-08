Return-Path: <netdev+bounces-133349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77B7995B8E
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 579B0B23479
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC61D2194BA;
	Tue,  8 Oct 2024 23:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaz/nP7p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65EE2194B2
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 23:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728429633; cv=none; b=jvQztQFmt9GSOIXDKHlTo0IiZlAa4zFxW3UqsHJ8aKczcTp4pF+c4Z2poGS9s3VxOton8MXFI+UWxmXnaL0PtlI9g7PyNSxXXUJjMec9mXuwevz50j/qa3MJWpgN+KfR2pyRkfHAFi63iiKB3PaMS4Hr11MRWFWvkTlwCMU4c8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728429633; c=relaxed/simple;
	bh=lxseESrxoZ8PjqlvoCLl34KCK8irkRNeOuOiVHLoo2M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hqp2c/Dsw963g6B6T9TiEMMqIeTeDms7MQNeKct8UfEqVhRM1hPnqMb7q76j/etwkBwwupBdvQvDgRQZnl/ehOqDt/opOyYKer+8bunKlxbpeCLR2Kv5HJlq46DhuMYOPPPxffzFe6FOKh1+TB1qx8PEMyCp+bLOA3utXk+gegQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaz/nP7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86AFAC4CED1;
	Tue,  8 Oct 2024 23:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728429633;
	bh=lxseESrxoZ8PjqlvoCLl34KCK8irkRNeOuOiVHLoo2M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jaz/nP7pd5HXml2DikXhv3IZNy7BXhw6c7MP0BAD3WmRItWM7ax+LSkwTHmPLkVMD
	 2/IvFAA+CpOC3ShdgQoknY1m2UiyeAR9wz36Y4FIM/CE21DyVKlSjN/rXNHGwJPRZu
	 C4TJFQ/R8MUSJskHm7LGTEOo+7c5chbo0qR9tnBFcDCZaKCNy7QTdHfHPXEzuHEzMH
	 p6jrlR130DOFrDN8+lQzh3imjcJBVjW6Dkw1TzeGg9MQBeVO1U2g6IURQTN4ATszpQ
	 tRgSfPXfkmg0z+ORDMVk1Hq9hpzmhBxYkm0CSXIjIC8RaR9NHpY7C596qw1fdXdWq8
	 waowWJ/OpptaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADDE3A8D14D;
	Tue,  8 Oct 2024 23:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net-timestamp: namespacify the
 sysctl_tstamp_allow_data
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172842963773.718280.4117941839718863673.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 23:20:37 +0000
References: <20241005222609.94980-1-kerneljasonxing@gmail.com>
In-Reply-To: <20241005222609.94980-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, willemdebruijn.kernel@gmail.com, willemb@google.com,
 kuniyu@amazon.com, netdev@vger.kernel.org, kernelxing@tencent.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  6 Oct 2024 07:26:09 +0900 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Let it be tuned in per netns by admins.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> v4
> Link: https://lore.kernel.org/all/20241003104035.22374-1-kerneljasonxing@gmail.com/
> 1. use u8 instead of int to save more bytes (Kuniyuki)
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net-timestamp: namespacify the sysctl_tstamp_allow_data
    https://git.kernel.org/netdev/net-next/c/da5e06dee58a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



