Return-Path: <netdev+bounces-229834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A91EBE1230
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 02:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EF6C4E02B6
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 00:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5313F1DC985;
	Thu, 16 Oct 2025 00:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1QaXMRU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFAA1D90DF
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 00:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760575831; cv=none; b=uxBpi5GPe2HNdx7zTfVIZZOLohZxjXrF8zN0HDSW4yp6Qvq76K3X3vOMQfhy8aCX9GVEF0VI0mFUCRpJE4sA3CxFT8cA9AwQ+EM68UPQW+/GrbZPtYEqFTlOStFs5qEgRAmDNws6JX7Ez5/nR9RI1gl9ToZ7PktAWT6cewQMngc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760575831; c=relaxed/simple;
	bh=MRCy47Y4ZraO0jf/KGGKpJP1L4jQU8bmr2aDGJ3CHq4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DJMuTenQ5sZNRURmyXKT8kQ4CSDK/DAehnrpZkbF+rZdvPkqOSx8fx6rwq04TGM9e08BNMX3M1XjGGWkZEfU5hYj35Bm40yP98XOBoFjn4UlMc6jLnQ0Jt1WEPT7GEu0nxTPufrs0LeF9pAPH8g9qt3AaCnoa/IhYxkZ3J7IGzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1QaXMRU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6276AC4CEF8;
	Thu, 16 Oct 2025 00:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760575830;
	bh=MRCy47Y4ZraO0jf/KGGKpJP1L4jQU8bmr2aDGJ3CHq4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u1QaXMRUcxXsMmUNjrPBElDBeosQwzJtzVgADUQtMrQSmNNO4zukxORMsE0bEZSJl
	 DS4+XYnrFVt0QGnXKN0yF+QXxYFKjkeMswF/++vSyVJcf/+a0f5pnaoJhY5KJAvqkI
	 5n0cOO/KRVb6tQ69kF2h/Xa/AKS4SvO+TURFPtDM/+b1JtqlbjmG8O3p+ACTmSp0LX
	 mGIeP5wE3Ai2W5ID2TqX1zq5H3sMmJiNAyM2Pq0nyp15UG7LJvoqG7k5amizNel/az
	 1fv/tqNgFPGbcs/zQ4YtRzz0ET2QkaHw4rFigCV8YSK2wg3lnTCnInJFtndIQZ5w2K
	 +Pxfn7bjtH1Hw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DDC380DBE9;
	Thu, 16 Oct 2025 00:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/7] tls: misc bugfixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176057581500.1114538.15242372033816116442.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 00:50:15 +0000
References: <cover.1760432043.git.sd@queasysnail.net>
In-Reply-To: <cover.1760432043.git.sd@queasysnail.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, jannh@google.com,
 john.fastabend@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Oct 2025 11:16:55 +0200 you wrote:
> Jann Horn reported multiple bugs in kTLS. This series addresses them,
> and adds some corresponding selftests for those that are reproducible
> (and without failure injection).
> 
> Sabrina Dubroca (7):
>   tls: trim encrypted message to match the plaintext on short splice
>   tls: wait for async encrypt in case of error during latter iterations
>     of sendmsg
>   tls: always set record_type in tls_process_cmsg
>   tls: wait for pending async decryptions if tls_strp_msg_hold fails
>   tls: don't rely on tx_work during send()
>   selftests: net: tls: add tests for cmsg vs MSG_MORE
>   selftests: tls: add test for short splice due to full skmsg
> 
> [...]

Here is the summary with links:
  - [net,1/7] tls: trim encrypted message to match the plaintext on short splice
    https://git.kernel.org/netdev/net/c/ce5af41e3234
  - [net,2/7] tls: wait for async encrypt in case of error during latter iterations of sendmsg
    https://git.kernel.org/netdev/net/c/b014a4e066c5
  - [net,3/7] tls: always set record_type in tls_process_cmsg
    https://git.kernel.org/netdev/net/c/b6fe4c29bb51
  - [net,4/7] tls: wait for pending async decryptions if tls_strp_msg_hold fails
    https://git.kernel.org/netdev/net/c/b8a6ff84abbc
  - [net,5/7] tls: don't rely on tx_work during send()
    https://git.kernel.org/netdev/net/c/7f846c65ca11
  - [net,6/7] selftests: net: tls: add tests for cmsg vs MSG_MORE
    https://git.kernel.org/netdev/net/c/f95fce1e953b
  - [net,7/7] selftests: tls: add test for short splice due to full skmsg
    https://git.kernel.org/netdev/net/c/3667e9b442b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



