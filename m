Return-Path: <netdev+bounces-83879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DFD894AA9
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 06:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73A8D1F246AC
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 04:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D39917C67;
	Tue,  2 Apr 2024 04:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edrtewWG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A7F171C9
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 04:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712033435; cv=none; b=r+NPmG2F9OEtm2R2LYVZ4nPI+AmqbZ6Ksdx77OLUzoytcfvJFjF+UbBFMJc27O35hiTV6JePuEFyM+wJJDVc7dEBYbqJCXug5pd5Vvo6OtayqLoNboEEeLrjir6K9Kx8aXFTdKj8ytOpUcozzCiil+aNUpOMUOnlg6fJdHiZvxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712033435; c=relaxed/simple;
	bh=bN65byvsDKqh4wZRlnNooHOUgGbMCh7zK/WYiFc3iyc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rliQeKOvqF63f6E8OmYituzsAKCgf0oStcmGVK9cVRS0Ma7FJ6wOTNnPkWYQPR5gUpaVZc4Qng+330lPB276rW+M9u2PC1V7C2GrpMJgWNqDB3V0iELSdGeIVIKA83n7SttxEeDoAzbVL0C4k1Ws1n0F//IA1EY7+/UfNUeoPrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edrtewWG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4E95C43394;
	Tue,  2 Apr 2024 04:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712033434;
	bh=bN65byvsDKqh4wZRlnNooHOUgGbMCh7zK/WYiFc3iyc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=edrtewWGBSgyrMH2uA/Bm+5IKuwstqwbsomuyNa1wr0iZdtaR34xaG4tOtkKLS2Ee
	 n/TRsoiagYw1u4gFf6PP3fitfnCTROxtt2wByzXwh0+emzFBs4BpWDJIT0ew4BcXJ5
	 czCn6HHo3Tq6m+bNZaGDwYU1UDIbvjyi4MXcPQ8Di6X0gnBEQPKbcI6t0aebpEsslp
	 IDQn2beQGcyBi2vI0oGntU9H88XEaDzonwWDUAaIT+qJ6Yu0kqN5umXAaqqivpZJZ/
	 HwFtG3Dr7Pactetm5Y9ivW8+wqv534EVDuR5iZe6NA7WnNj0X6S5IuQHaPWaYOg/JG
	 jWAaDaFczWi2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC14FD8BD16;
	Tue,  2 Apr 2024 04:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp/dccp: do not care about families in
 inet_twsk_purge()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171203343483.12415.6124476040288084489.git-patchwork-notify@kernel.org>
Date: Tue, 02 Apr 2024 04:50:34 +0000
References: <20240329153203.345203-1-edumazet@google.com>
In-Reply-To: <20240329153203.345203-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, kuniyu@amazon.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Mar 2024 15:32:03 +0000 you wrote:
> We lost ability to unload ipv6 module a long time ago.
> 
> Instead of calling expensive inet_twsk_purge() twice,
> we can handle all families in one round.
> 
> Also remove an extra line added in my prior patch,
> per Kuniyuki Iwashima feedback.
> 
> [...]

Here is the summary with links:
  - [net-next] tcp/dccp: do not care about families in inet_twsk_purge()
    https://git.kernel.org/netdev/net-next/c/1eeb50435739

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



