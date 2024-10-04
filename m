Return-Path: <netdev+bounces-132295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C109912E6
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 01:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4967C2824E6
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 23:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA55E153573;
	Fri,  4 Oct 2024 23:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGR+ShTm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EA0231C9B
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 23:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728084032; cv=none; b=N1maJ3HDqv88fLRGIsexrJZ+nAvSE9JTlAdmxfU4KbaUXxz+BXHoPd0HjY1PK0CUsL77PSRnTokeR55+8KfJL4DTcqRCHffpCfNp9q8G/yT9inphnzvxbv2zsmeuN7BLrAwhtP3Og/NA0IWC6bamIYJKynUGymxiXdxP66ASMSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728084032; c=relaxed/simple;
	bh=l8domj02qhDp7kdqQskLDHebpmbE2udofaKCCn2ngFY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jR6qtsqZ7QGWMyOclvN53wbH7M+YUEH6gtoQzlltz6H8wQDbV4XwbJfHqA5GQBT2rR8oIRz5FxgMg4DYy5SZbQWjRzC4iDY8qAVpHlNw7yqYd8U+6AfK0LE5RTXN9N7VgfgjhNdLC5Al3lRDXQAJ0DCZiUe6r6ShBNRgsalr0QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGR+ShTm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1F6C4CEC6;
	Fri,  4 Oct 2024 23:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728084032;
	bh=l8domj02qhDp7kdqQskLDHebpmbE2udofaKCCn2ngFY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IGR+ShTmHo7Lxp7aTd4zZgIV2F/orN/YYWpc91OFrrs1NqnixASHioeCQ25bqtM+t
	 mJV3bdoPfHDoAO1oPURbRU/609KtyUb1vwHAJ/0n3wPSc0yHl53sXA4PWxAn1AZ/Ie
	 PWyl0QuwzGBrW7jYht9G068Yr+9fHEAr+itxSAHMhYXWpOnBke+N0/hbdc3MKkh3QI
	 tDEp4kwbfO2xCmv/bzlqzuMWknk/F04OwEV8ehlyjZxEBbebNrK3fpTyqy6z4t6/m0
	 qTRFVSlR+ZHFB1Ik+GloVfHTiDHwdb9M2Z4hsF/mgpRVt8s2CVNvOWzlFQ0KK89j1K
	 xeAaDuKKboQhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CB139F76FF;
	Fri,  4 Oct 2024 23:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/2] net: prepare pacing offload support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172808403574.2772330.4461770024084750553.git-patchwork-notify@kernel.org>
Date: Fri, 04 Oct 2024 23:20:35 +0000
References: <20241003121219.2396589-1-edumazet@google.com>
In-Reply-To: <20241003121219.2396589-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, jeffreyji@google.com, willemb@google.com,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Oct 2024 12:12:17 +0000 you wrote:
> Some network devices have the ability to offload EDT (Earliest
> Departure Time) which is the model used for TCP pacing and FQ
> packet scheduler.
> 
> Some of them implement the timing wheel mechanism described in
> https://saeed.github.io/files/carousel-sigcomm17.pdf
> with an associated 'timing wheel horizon'.
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/2] net: add IFLA_MAX_PACING_OFFLOAD_HORIZON device attribute
    https://git.kernel.org/netdev/net-next/c/f858cc9eed5b
  - [v3,net-next,2/2] net_sched: sch_fq: add the ability to offload pacing
    https://git.kernel.org/netdev/net-next/c/f26080d47007

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



