Return-Path: <netdev+bounces-177214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB26A6E4A9
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 21:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEC9D7A5B84
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 20:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C301DED5F;
	Mon, 24 Mar 2025 20:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Myg7TDV1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA6B1DE8A5;
	Mon, 24 Mar 2025 20:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742849405; cv=none; b=Jxp+VgNsn6YEoddIHwjNDUuHY0A3xtTIEBzuBsfe+x9msbG5sFIJNfgVYFb43OsWrks6B1552q3C2n3K8hCK2ktUsofEpx9DopCA7Vr8uq+EUQvB4JZSggutzhbO9Drr894SuzSfnmE8P9UXwOcH8H9LVfJm8Y4jYpP1pNsctM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742849405; c=relaxed/simple;
	bh=i3yR7/aQnyPCzPAMyNJ2Vo5LYwTuvCRJQRv23NRhFXo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BTxHgWA890pBqIdfLUbGKItYJNExGb7nCLcz8QlIWxfw9dkjV0DibziwepK3zp+9FSz65XNHgrdRcjDRPGtxtZuj/LHVAhaahqxfDKafa87nXR464+PKfz91EWm+TtDkeCLZi8rwwsyPRyyJ84Yj73RMfjMnWmCP/uwozDZxYBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Myg7TDV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64DEC4CEDD;
	Mon, 24 Mar 2025 20:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742849404;
	bh=i3yR7/aQnyPCzPAMyNJ2Vo5LYwTuvCRJQRv23NRhFXo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Myg7TDV1vcxabQTQpRqpZi44fjbL2wLwALffG1Fl43pyaX7MqVVh3e/bPtMw4h8ka
	 tAdsxEO7kxKkXdSgjeAj7Qqeq6LYhKF0TLchcXcANnzkL4x6/8EunJJ8c/OGGwG3vj
	 UhaRCUo3u06+ZJC9ODPucpgvoNVIA7qkVDKpVghLv9D3YC8Fh6cdDeszynrCcs7ONV
	 qllfLJWTBCXzQhBu8zdIa4jCrwtgO9es5kmUuoM0QjYXNLJ3wwU6Hy7BTEmb7J9odn
	 T1aDzRRXSOFzdW66K3IqWwvVjPyuLGrBrk7zJLkVFZCJJqmHTuRSLPJE+OK4U/COv/
	 GA3laGS+5lYdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 345C9380664D;
	Mon, 24 Mar 2025 20:50:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netpoll: Eliminate redundant assignment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174284944101.4167801.12244877601133663895.git-patchwork-notify@kernel.org>
Date: Mon, 24 Mar 2025 20:50:41 +0000
References: <20250319-netpoll_nit-v1-1-a7faac5cbd92@debian.org>
In-Reply-To: <20250319-netpoll_nit-v1-1-a7faac5cbd92@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Mar 2025 10:02:44 -0700 you wrote:
> The assignment of zero to udph->check is unnecessary as it is
> immediately overwritten in the subsequent line. Remove the redundant
> assignment.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/core/netpoll.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> [...]

Here is the summary with links:
  - [net-next] netpoll: Eliminate redundant assignment
    https://git.kernel.org/netdev/net-next/c/f1fce08e63fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



