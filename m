Return-Path: <netdev+bounces-125299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CD796CB5B
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 01:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32CD8B24E51
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 23:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D4017920E;
	Wed,  4 Sep 2024 23:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M60xkqJA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2AB1487DD
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 23:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725493831; cv=none; b=D+YrLKGz2pGg8MQlJWxXIKCBlkwODaHc97clRjg/s2RNC0TamVgkGDvH3Jkp4IDzz+w63yV/uqOjRmQJwCx9dAZAtHbxzaQkXUaqcyHkKllZ4MDf8UQRP0x/Oj8fZ2tt051t5duSG443lyEpzUnLCmZ2tGFTlduje1oRxTYlTSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725493831; c=relaxed/simple;
	bh=H7VSLzQQT0pVIWXOoJ8BCVP79jImGuVYalJGRuQFLSU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZNmHhdDlh6aPDAh6HQ+nB+K2zBiGgNF3ELMb0rvFu5/vlb0j3gQRhe/7Umylgn1G3zfpjMjEvSKAUrj0mQrYSq/zdpk42tzNYbMWETBSuOYAv6ltMbcI2YJCsDwuiI8SBYyNtXM0NfRkkIyw86BatuMRzVj8AkEIPp271K9rCYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M60xkqJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8B6C4CEC2;
	Wed,  4 Sep 2024 23:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725493830;
	bh=H7VSLzQQT0pVIWXOoJ8BCVP79jImGuVYalJGRuQFLSU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M60xkqJA4DMKT3a8DAcK1rqocSv8r17hJYsZVzR8XawSndpxw5TbqjqWOS5KXYWXh
	 Jl3fQPdpDkVoyetofQZKaOWIurjaac1s3DzX+jjkiRLTe7hsG5Oe60nokCuIuw38xq
	 heunAzTpl4C/YyYT7v5LkW3rhE5yJtmBjkPvptciZEpwuSN8YuTBGAgy4iVkzK3IbZ
	 mywa1IF9XUdijhOka5/Nj1sz84N7BdFmx8LQzK29AuzJfWPJihiUWmfMfzfQs5s2/U
	 9vFvOeTFietl+SZriCyayg2D7wXC1Bfp59TjYh5Pu1A4vGXxYKKVNqKHVR0TE+iMCr
	 iIZx0b/CAg9uw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CF93822D30;
	Wed,  4 Sep 2024 23:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] l2tp: remove unneeded null check in
 l2tp_v2_session_get_next
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172549383107.1201174.15025057832527381536.git-patchwork-notify@kernel.org>
Date: Wed, 04 Sep 2024 23:50:31 +0000
References: <20240903113547.1261048-1-jchapman@katalix.com>
In-Reply-To: <20240903113547.1261048-1-jchapman@katalix.com>
To: James Chapman <jchapman@katalix.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, lkp@intel.com,
 dan.carpenter@linaro.org, tparkin@katalix.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Sep 2024 12:35:47 +0100 you wrote:
> Commit aa92c1cec92b ("l2tp: add tunnel/session get_next helpers") uses
> idr_get_next APIs to iterate over l2tp session IDR lists.  Sessions in
> l2tp_v2_session_idr always have a non-null session->tunnel pointer
> since l2tp_session_register sets it before inserting the session into
> the IDR. Therefore the null check on session->tunnel in
> l2tp_v2_session_get_next is redundant and can be removed. Removing the
> check avoids a warning from lkp.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] l2tp: remove unneeded null check in l2tp_v2_session_get_next
    https://git.kernel.org/netdev/net-next/c/510c0732fc8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



