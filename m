Return-Path: <netdev+bounces-198286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B647BADBCA3
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 00:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35FF61892429
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 22:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4ED2288F9;
	Mon, 16 Jun 2025 22:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GB2m6pk5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6B6226D1E
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 22:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750111811; cv=none; b=u+Ah4wIGiwscD0vS1yUk+5O/C3KBjM/KeWDGnTTZ+RdUanGXvma0LHipce2+Yy8g1XpZ0vzU/qiwTG5bmNng8Kfa7LcJ4PlN7jAlQWS5nz8GNDKAMUj0Ed8yi0p2U9IpBNBsetMZK2br0Ny022SiMhFAGxwojMot1R7FrNxg9eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750111811; c=relaxed/simple;
	bh=AgC/V4G5wZKFSYSZLc3xigF315dr5O5pWDajQ1uPUCI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QE/pVhrg0UjLjKN79YqUm+d8abnzcWqYup7hSOoOoCHhgUVA8a7n9sHAJdAPglVEMdV4dBRtapKQIgmKR+iPNWWvBkxfJpcTMAsjq59/SZPb/Sr+Le6cIPcdWnyfW10onjY6/28KfTn+Im/jbxfHcj8WRIopQ0UC8Cg36o8nYlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GB2m6pk5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA740C4CEEF;
	Mon, 16 Jun 2025 22:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750111810;
	bh=AgC/V4G5wZKFSYSZLc3xigF315dr5O5pWDajQ1uPUCI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GB2m6pk5DsgtE+fjt8/B8Mz8MwoWk6escleNACNZBMPhU1EmenzcguFv59JkIHWhi
	 W2/KTOVojyY9G3qhAO1vnT0pLgPDazxWpPbnHFkf0HB/P2ooyBIrRPjdFSyzgxJiiu
	 UsM2HRGzIs/ZE4swvSJXO4ZSkfmKG3PStMTnnU4xfEj946rJyDQowDRMz1XX1DkRGa
	 LY9zfc6Eq0VfegFPl2zBDoCUgQ8w6ITou4wZUmMIHt9056GjE8BGTWJ7ujK1aDX+Ht
	 D2gxKhFpTnBe1fint/3y5Sf7mZzzeecXKk/Tem4HQ8EUshw1yldaanZBJrwA5Mndhw
	 xjPReYv7fsUSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBE938111D8;
	Mon, 16 Jun 2025 22:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests/tc-testing: sfq: check perturb timer
 values
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175011183949.2530350.6134337972444923790.git-patchwork-notify@kernel.org>
Date: Mon, 16 Jun 2025 22:10:39 +0000
References: <20250613064136.3911944-1-edumazet@google.com>
In-Reply-To: <20250613064136.3911944-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Jun 2025 06:41:36 +0000 you wrote:
> Add one test to check that the kernel rejects a negative perturb timer.
> 
> Add a second test checking that the kernel rejects
> a too big perturb timer.
> 
> All test results:
> 
> [...]

Here is the summary with links:
  - [net-next] selftests/tc-testing: sfq: check perturb timer values
    https://git.kernel.org/netdev/net-next/c/de74998c3008

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



