Return-Path: <netdev+bounces-128598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8995497A825
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 22:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13775B2A123
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 20:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBB61662FA;
	Mon, 16 Sep 2024 20:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiTMwpFR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A5A1662E7
	for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 20:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726517432; cv=none; b=bOtm+iiTZyHG7AetDqbypD7fU/DkE4l11Q3DjbA8mF9LnQHBPVjGn5rfvXKChA3oJ0nTABKey2UBr12C5XdRPmPeEvoY9wW9W6WY1ndc8D2xMjRzgwe+FcuP7eYjWvaf/wqe9FOBIHy2XaovzNW1y/ndoiJE6KvEaeQH+6a0Z5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726517432; c=relaxed/simple;
	bh=DiyEYrGtuJ2RGVH4fRZLbD4M9YdYdQ2070TkGyRjlCU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bGHQ58aePcEzR8EsEBSlRT11CQks7hzcVwnNH7cR1ctMHpvCmRJVJVkZvUflSMazzLNRv0QJ8csH9o68/2H1fiVsJCrwSrLfCeQzU3O3eP/iQeTNUrF/GDTYpKGDydFlOUcn720I0SFs7UfSNJpuyUrHApaKkNgwNlolF+Y/z2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tiTMwpFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51D1C4CEC4;
	Mon, 16 Sep 2024 20:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726517431;
	bh=DiyEYrGtuJ2RGVH4fRZLbD4M9YdYdQ2070TkGyRjlCU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tiTMwpFRehaTXNAyuvHOTP7Lfwo+tsk6YCDcWn+l5CyhWIpvN6oswLSqaRNAgBnsG
	 yo4o3XXtj8G96escCU6aNcqMeG8t10p/x09vXnXzgaF8LF270MDx275nR0KXfF8O44
	 QphhuizxPp4zrvyOwaZz8WDsPVz3RCKcy4hEoJTVOp6S6X/MwSEh/Ut4jGCDves3pP
	 cdushtJfZPCJblR4nCnNhPE+OeZv5J/hkIgv/wZkFoPmRTkRbqAegg4MIW8VG5B+6B
	 brIM2QdGUUUkvNyooqPSPcapTggg+PmrNsEKX21QeHeHLS0RjmjzELLCz7SNmIIiW8
	 a/N+Dzdx3YWLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEDD13806644;
	Mon, 16 Sep 2024 20:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH ethtool 1/2] Add runtime support for disabling netlink
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172651743325.3804981.5368526577782740472.git-patchwork-notify@kernel.org>
Date: Mon, 16 Sep 2024 20:10:33 +0000
References: <810dd96b-aff6-403a-88e5-3608ef248b90@ans.pl>
In-Reply-To: <810dd96b-aff6-403a-88e5-3608ef248b90@ans.pl>
To: =?utf-8?q?Krzysztof_Ol=C4=99dzki_=3Cole=40ans=2Epl=3E?=@codeaurora.org
Cc: idosch@nvidia.com, mkubecek@suse.cz, andrew@lunn.ch,
 netdev@vger.kernel.org

Hello:

This series was applied to ethtool/ethtool.git (master)
by Michal Kubecek <mkubecek@suse.cz>:

On Wed, 11 Sep 2024 23:56:45 -0700 you wrote:
> Provide --disable-netlink option for disabling netlink during runtime,
> without the need to recompile the binary.
> 
> Signed-off-by: Krzysztof Piotr Oledzki <ole@ans.pl>
> ---
>  ethtool.8.in      | 6 ++++++
>  ethtool.c         | 6 ++++++
>  internal.h        | 1 +
>  netlink/netlink.c | 5 +++++
>  4 files changed, 18 insertions(+)

Here is the summary with links:
  - [ethtool,1/2] Add runtime support for disabling netlink
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=6e3ac505bcc7
  - [ethtool,2/2] qsf: Better handling of Page A2h netlink read failure
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=814980faaef1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



