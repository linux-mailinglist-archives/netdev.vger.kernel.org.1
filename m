Return-Path: <netdev+bounces-127982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6209977647
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 03:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2F21F24334
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 01:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009EEA23;
	Fri, 13 Sep 2024 01:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCR/lhX5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDBDB64A
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 01:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726189831; cv=none; b=P/FtaTOj+uaPGvlG2gkYSNtVFEjXVkHV0DeevZU2pj+fMJgR6TyleiLWEtJRYk1Rq9WIGsJxW+OX4LrXyeE0NAuSlGyxWahGMGCFb/f0q1C6mMFRyLhvBr6lpZOthZquE7pMWR5CGNCne86O6Ko373CqzD8w3zuZdQTGy4bRbDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726189831; c=relaxed/simple;
	bh=LE8wpmJkDJ9Ml2vcRcvSSsZBP4B1l83egXKYIErNQzg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NX+6tXb0QgOWSUpczOTo0lYyn/qnhoc8PoxL01hQVEtbZZ8aTSo0qmavh2Z9nmrMfnX7DMg5e+WugY22ck9PavBy2Oq46ztyB+NZIaFXQLxJfSfK+XzQGuNfFIYR5N2eKr9dWFGZYdUU9ik3gAIRVsfNs9E/+NnyUc5rqQwJuJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCR/lhX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473FAC4CEC3;
	Fri, 13 Sep 2024 01:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726189830;
	bh=LE8wpmJkDJ9Ml2vcRcvSSsZBP4B1l83egXKYIErNQzg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kCR/lhX5cDGJUfiSuHMeV+eqFMPAQ7G/bwQ1+v8pk0r+ulkYj1X0JJvODxbihhX3Q
	 VGMdzBQ0Ygmhko/HKaLXvc6J4SBjVEtQnwYwQoni6PnncWUWoYB+YsQhdBdKbomPPW
	 c+KktKaI8i1Ra4BPrGsG4fThfiuuJmoIBh7vI0TBkhIdNRY1qWJXiduUdon38LzP8x
	 co87EC30xzx5bV71wP3qYN0LniE5I2MTV4VJg8nCOTav559ofzHXFu79zXM5tUIuVW
	 WN4GuN/ScxFh5GS0JyatXYdz+fNIb3WApKEmoxZayrdrET3BuGPlJKiBG7QLDm6rm9
	 SB+nopuVrmJng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD903806644;
	Fri, 13 Sep 2024 01:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/2] ENA driver metrics changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172618983151.1775511.9641433270139330677.git-patchwork-notify@kernel.org>
Date: Fri, 13 Sep 2024 01:10:31 +0000
References: <20240909084704.13856-1-darinzon@amazon.com>
In-Reply-To: <20240909084704.13856-1-darinzon@amazon.com>
To: David Arinzon <darinzon@amazon.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 edumazet@google.com, pabeni@redhat.com, dwmw@amazon.com, zorik@amazon.com,
 matua@amazon.com, saeedb@amazon.com, msw@amazon.com, aliguori@amazon.com,
 nafea@amazon.com, netanel@amazon.com, alisaidi@amazon.com, benh@amazon.com,
 akiyano@amazon.com, ndagan@amazon.com, shayagr@amazon.com, itzko@amazon.com,
 osamaabb@amazon.com, evostrov@amazon.com, ofirt@amazon.com,
 rbeider@amazon.com, igorch@amazon.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 9 Sep 2024 11:47:02 +0300 you wrote:
> This patchset contains an introduction of new metrics
> available to ENA users.
> 
> Changes from v1:
> - Utilization of local `dev` variable rather than a mix
>   of `adapter->ena_dev` and `dev` access in ENA ethtool code.
> - Modification of the commit messages to make them more
>   informative.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/2] net: ena: Add ENA Express metrics support
    https://git.kernel.org/netdev/net-next/c/49f66e1216ff
  - [v2,net-next,2/2] net: ena: Extend customer metrics reporting support
    https://git.kernel.org/netdev/net-next/c/403cdc41773b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



