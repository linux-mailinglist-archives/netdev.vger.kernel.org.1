Return-Path: <netdev+bounces-233688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C54CCC17653
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 00:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE498402A32
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 23:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A264305040;
	Tue, 28 Oct 2025 23:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LP7152BF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254FC2DECC2
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 23:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761695429; cv=none; b=hSY9pXfQ1OXCVovbYgnrVM7b4cps5L3C8doKph7UtnZ6Gj0rwP4aRjSZYFsUjmplSJ9sOtHZql46+YnJ0NF8UrFzkHn6TDjcTipDQehK4R7z+sfJuCkc4iBNa45IDyoXC2sPPjFNVlyP3/Cyk97UtjPdjYV3ii2sj1lRZJJ3eUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761695429; c=relaxed/simple;
	bh=13XZaThonvmVAaTjRXO1SOYGKUykjUwE8G3l6OZNPFM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pfj9/mbngObrEm7+AwfL4z0NDpHxYeEaWcBLi/bxChwBLKoLlXOlmIxlyFi/MaWkmXcqmKEutz6X0DqkYm0VsfMdDhL0TS2ImpV8bmEv9HY8DoJLesGYeC9sgkVjcUZdjf12xW6Yy4wtmkr2/uDSPdQMXKd1liNOrnmAelfdds0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LP7152BF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E85BC4CEE7;
	Tue, 28 Oct 2025 23:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761695428;
	bh=13XZaThonvmVAaTjRXO1SOYGKUykjUwE8G3l6OZNPFM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LP7152BFUXOrIfxpFWHZPwyf1WsGwD5kSKjs0MTTKVGOZaeCUe/cz9E0sZ8tXaw29
	 mK0gFgTi3mPmLFyRmZnbRoI86zdR+Jd7h9oHutbHytcc/w4QSFBavDZ7XlkxbFh+W0
	 GqKm914jlKQNcSbagJJKTzpidsgYug9bjc+IZ2l9DfL0YGUpC1FOaUsAQwIAkaK4HV
	 y0/cJ9cRSs+3m4KOyMoT+1Y+sxHHBT8zf4+Jv6jLCplsvgGPRr/7/pG/ycQlBiwgJ0
	 juvqxoAkt3kfcOXqMBLzoXKVBdAT/4He+QrXhN1Fia3JmXRjagb6mMAHM5hwjodCcf
	 IULtaVZfhzWJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C1339EFBBF;
	Tue, 28 Oct 2025 23:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/2] tools: ynl: fix indent issues in the main
 Python lib
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176169540625.2425663.5316619299461217988.git-patchwork-notify@kernel.org>
Date: Tue, 28 Oct 2025 23:50:06 +0000
References: <20251027192958.2058340-1-kuba@kernel.org>
In-Reply-To: <20251027192958.2058340-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, ast@fiberby.net

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Oct 2025 12:29:57 -0700 you wrote:
> Class NlError() and operation_do_attributes() are indented by 2 spaces
> rather than 4 spaces used by the rest of the file.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - new patch
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] tools: ynl: fix indent issues in the main Python lib
    https://git.kernel.org/netdev/net-next/c/09e260351384
  - [net-next,v2,2/2] tools: ynl: rework the string representation of NlError
    https://git.kernel.org/netdev/net-next/c/34164142b5fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



