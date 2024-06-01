Return-Path: <netdev+bounces-99941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6AE8D7281
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 00:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84FE21F2191D
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 22:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AE22B9C7;
	Sat,  1 Jun 2024 22:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBQvyX74"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC062224CC;
	Sat,  1 Jun 2024 22:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717281030; cv=none; b=HO0mpSR8ZUbBgByXEHtgRC74/mId0mK9rK6WSEiKD1sAKKN0UivLOVbRhlwQJJG9YTiS0z4N6aQyr3u8gI4D3ZAhWz0R6CifdQgveaP/LW3injYNpjHINXBbmca0f/wZaVU1KD6kRM3ZqMpnnbC3RyyKfyZWtAG/ClpEe+NMUzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717281030; c=relaxed/simple;
	bh=BxJehKDbY16NeSK4HqgSAPE5UO3fb+8pHTqhsHA8MO4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SSo9yth74rjKgttDorvZVEcosFaAofHpu7JuuL7Cv0WALpQHo4F0DM0y+1NvroWIKpWLfKT+GaM4CEEmkZazm6ope6EVTp+ZfYDI/NFZ1BhZxhTFKNzDAPClbDiS+/W1F7TpHp58G9O9sL4VoqbMEOcqavlQLe05Uv2GIyeG7rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBQvyX74; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79774C32786;
	Sat,  1 Jun 2024 22:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717281029;
	bh=BxJehKDbY16NeSK4HqgSAPE5UO3fb+8pHTqhsHA8MO4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sBQvyX74T8gvi7TCiLQcHq2XUMK2sntMrYZGjYjC53aCtkCDHKMD2ybf2a1R11FsE
	 RLepBlSsPmnfIczy4pJ3jHDWyxT120e6Cc1qvIicFUJuKvHXDQwXgSz2f/eJjMVs3z
	 qh3+sJhiPQbk/thvrw6qNLtG9zk8cdfKP42/8tTAluHp9NlQk/dEyigt6RblcIBxzQ
	 or7za3aQp8hBt+JySpFKLBirHdx8bH8cMosnGL55//KRL2RQqjqvAlTAklG7FmZAj6
	 nrKJo3cq1uDuqtTLFdSNE643AnQwtzamzjcK9Z/GIkLfnmdoiZtY0RQMbokBKVD+cv
	 38pGY883t/IRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69FD6DEA711;
	Sat,  1 Jun 2024 22:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] doc: mptcp: new general doc and fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171728102943.22013.15601696646895135776.git-patchwork-notify@kernel.org>
Date: Sat, 01 Jun 2024 22:30:29 +0000
References: <20240530-upstream-net-20240520-mptcp-doc-v3-0-e94cdd9f2673@kernel.org>
In-Reply-To: <20240530-upstream-net-20240520-mptcp-doc-v3-0-e94cdd9f2673@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 corbet@lwn.net, gregory.detal@gmail.com, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 rdunlap@infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 May 2024 16:07:29 +0200 you wrote:
> A general documentation about MPTCP was missing since its introduction
> in v5.6. The last patch adds a new 'mptcp' page in the 'networking'
> documentation.
> 
> The first patch is a fix for a missing sysctl entry introduced in v6.10
> rc0, and the second one reorder the sysctl entries.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] doc: mptcp: add missing 'available_schedulers' entry
    https://git.kernel.org/netdev/net-next/c/ccf45c92d746
  - [net-next,v3,2/3] doc: mptcp: alphabetical order
    https://git.kernel.org/netdev/net-next/c/a32c6966b23d
  - [net-next,v3,3/3] doc: new 'mptcp' page in 'networking'
    https://git.kernel.org/netdev/net-next/c/c049275f24de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



