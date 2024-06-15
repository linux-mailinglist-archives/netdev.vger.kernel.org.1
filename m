Return-Path: <netdev+bounces-103756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5E990955F
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 03:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCDFBB215D5
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 01:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0BB53A7;
	Sat, 15 Jun 2024 01:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6Y50wR9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4682F4683
	for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 01:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718416232; cv=none; b=NCCFkfY+axhoqyuCgdJnxiYO6hO2I4a3lNXB/rxXFa4hLolRtln+jdt9JWdibdfWmTHyuqvux+G4qROlSL4gb2Of+fB7ha0HHuMNsNZ9Q7qnYaOwId0NWT1uoR2va8w+at97o0eZmmpnD6S9OPvvJC9hoGuxwOVeuQU8KZ34wmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718416232; c=relaxed/simple;
	bh=pwEkhA/jLPDIlvn2BlNcEIaY/RAz/NUlrfe+9HvANkk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FAEASXZDVOPjX8VIbh9pOrbdUAety30S1Pgt2ITFmt3fNMZfGXmJ7TCGHg8SDENzH1ms7TTfu4zcGr6jHzAZSz4GeMr88CYmyDkDNssZioUUYPlIGmSrGFyWoVXZU6nVAJxWXYNGbaBwHZI1DpWLAvYctla7hlfwmqje5BacQ28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6Y50wR9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4B6EC4AF55;
	Sat, 15 Jun 2024 01:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718416231;
	bh=pwEkhA/jLPDIlvn2BlNcEIaY/RAz/NUlrfe+9HvANkk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q6Y50wR9zllD5uAmmk3xf9qQF0GRlwFrMQnntStiH/Nsu7wKcI0d+uSLk1tjgrW9O
	 4G8f3UFTp0SyoH8oW36BmytmPMqdxgj2SK/QI6KdVc49aomlaJ+znnZIsrmC07Vg0t
	 YSsujNlb/DObH3ly1aBbjPrVQO2lSpQYGUSTInm462PV/ksUTAdGiTV3ljNhIpjAor
	 caG0W51aHkX0DrBOxzQUhnIX2WAYjRIN/v6CkFnVZDZm1mVc6qM5NvcK0u8hKTuEbD
	 rkqQvI/EMic1wrErp/VrdaY5gnAM3nD85qT+PviwC68dAeRURR6mRtXGUpyNZBVCLx
	 gsJSeCKduWpUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BBA14C43616;
	Sat, 15 Jun 2024 01:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] eth: lan966x: don't clear unsupported stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171841623176.3120.11050863585818990509.git-patchwork-notify@kernel.org>
Date: Sat, 15 Jun 2024 01:50:31 +0000
References: <20240613003222.3327368-1-kuba@kernel.org>
In-Reply-To: <20240613003222.3327368-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Jun 2024 17:32:22 -0700 you wrote:
> Commit 12c2d0a5b8e2 ("net: lan966x: add ethtool configuration and statistics")
> added support for various standard stats. We should not clear the stats
> which are not collected by the device. Core code uses a special
> initializer to detect when device does not report given stat.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] eth: lan966x: don't clear unsupported stats
    https://git.kernel.org/netdev/net-next/c/72421f35540c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



