Return-Path: <netdev+bounces-140058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC0C9B5220
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 19:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 465E01C22D2B
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 18:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB5A2071EA;
	Tue, 29 Oct 2024 18:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbfLC3fh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB83E206E67
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 18:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730227839; cv=none; b=Vw5QZpsxVvDdi/MMV+1CT7S8jCmaP/RTo42TTu37molBOJtBwA2eej+dVunyKAd4MGW7dY1rdwibbNleHLccCmU2DHDFa3uuVWiJvSdCpPDmcIOXRV7N/98/qnAgojZysQrW8NIVTWikGKo5/lUjICKgIZaQgJkO77l+NLNvCSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730227839; c=relaxed/simple;
	bh=AWbC8lxLu+5RtFi+ulbVIOHdJtwfSQO8VzL/5W2F/6U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mMqyPkEkRSkGA4A9LLA4PQ5Kb4pQPrX/lm6r12oNlbluzDjrXBpfXMyHgnf3D26Mq00Xry9HZBteBiOn9sZLY1qYvxIcz156qNU1BAYLk1Q+oxOiRs65kCFp45gbfrHxSxYT0k0WBY8t+F5v2lRX/Bqz9/zL2bK7sVo+Wm4DsXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbfLC3fh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23EDC4CEE4;
	Tue, 29 Oct 2024 18:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730227839;
	bh=AWbC8lxLu+5RtFi+ulbVIOHdJtwfSQO8VzL/5W2F/6U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cbfLC3fhMxvA4GAGRWhVWAoV0B/67IuhXUrwKWGZHPt5vrp4ppGMTmViJHFIEHnuJ
	 cEP5sEPzfJvn//iqO/XI6kJqQ7Z3KTN/qv9As1dDNuAk1civEFFh9auORC76WjPNzt
	 XVojVj2REkpR2OehyMG8q2/JLWGL0H9WmY8wClWw1258l6FTyKDrqre3u6FPXUwSVU
	 a9bklclZTDK7PnOFIYgdNU3H2bRWOKeNYefgZ5mJIguO2xeUuDYORq4UVLO0QUg9k7
	 OPzODhdEnBPh0hJ/dtyXxh/nxuZ/6D3nA9QA9eusVrsBqVtYXJHHmzrOpspqe0FQJh
	 oy9QHaf58M98A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D07380AC08;
	Tue, 29 Oct 2024 18:50:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] rtnetlink: Fix kdoc of rtnl_af_register().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173022784701.787364.15343985136184039928.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 18:50:47 +0000
References: <20241022210320.86111-1-kuniyu@amazon.com>
In-Reply-To: <20241022210320.86111-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Oct 2024 14:03:20 -0700 you wrote:
> The cited commit made rtnl_af_register() return int again,
> and kdoc needs to be fixed up.
> 
> Fixes: 26eebdc4b005 ("rtnetlink: Return int from rtnl_af_register().")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/core/rtnetlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [v1,net-next] rtnetlink: Fix kdoc of rtnl_af_register().
    https://git.kernel.org/netdev/net-next/c/bdd85ddce5a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



