Return-Path: <netdev+bounces-94650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC008C00D3
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 17:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D8D61F272EE
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 15:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D990F127B7D;
	Wed,  8 May 2024 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3EQoMtJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5264127B75
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715181631; cv=none; b=rE3gOPNllR2z1VA/d02JJ6uatWPFKQCRPm/SgluQsReWbS13CGjuY7kx9TQ3q7NtVhg2TzWYUkw+PSESfr1m/82SEzxNN/pD9y2PqktCEDitCTkTudi1yPcPuXkY7W/fkdy6r0jf9uN0oF94IBspBfojrh8dZ9WTaOzrCWFopR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715181631; c=relaxed/simple;
	bh=9rb8Td1hOfVsqmCudook8olYUFnlBP0z45oITJJseoo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PHkriIonHf0pEImYBiI0UyiTNM8opMYXcE7/SOcMkXj8UXSDvVnYJecbjoxR6oxqhSOzIiiAiu8o7WuM9gBX6fxvQgjLwvitav+OK/Umj+9Mw77uaZQ0/S7SoVikemskaZ6rJtcMjfE7aNz5dtZgSIWjKQZogAsAi2S6Jbo98No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3EQoMtJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7BB86C2BD10;
	Wed,  8 May 2024 15:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715181630;
	bh=9rb8Td1hOfVsqmCudook8olYUFnlBP0z45oITJJseoo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T3EQoMtJDGM+siyU9HdedJN/HBKgcI4N63gk8h+nRVmKt+ruJ89m+1GBh38kzrche
	 I9tTr6aBfbqdD0TtEIXAjlk8po7HrL4Eq6EOxbg2+J98fkzGPCDr6wsJgQKBo7CGJv
	 3VNKqEJSyuEk3UHUcVIZU0yeiOTlN3sxGmD/JRc3vroec0SYzDIaN+ngp0HN7ts2jV
	 aJlfdI4NqrYgBXAEN17ELjTwYTYwQovT4YOM7Wkcbjb8IkmarXIjvJr9WW6myXq6qH
	 sxsVXl4lNeRvZIYS1HJIFEIkwm7RDSY9Yw8b0mXf4ubE+nkQB3/6AtEdxICZ61k0ss
	 KOurHJiMtTwew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67DC8C43332;
	Wed,  8 May 2024 15:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] man: fix typo in tc-mirred man page
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171518163042.23428.89173723653115085.git-patchwork-notify@kernel.org>
Date: Wed, 08 May 2024 15:20:30 +0000
References: <83c969899db103576310bf3837595ab32984c8b4.1715164702.git.aclaudi@redhat.com>
In-Reply-To: <83c969899db103576310bf3837595ab32984c8b4.1715164702.git.aclaudi@redhat.com>
To: Andrea Claudi <aclaudi@redhat.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@gmail.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Wed,  8 May 2024 12:38:52 +0200 you wrote:
> Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
> ---
>  man/man8/tc-mirred.8 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [iproute2] man: fix typo in tc-mirred man page
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=397383a30c3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



