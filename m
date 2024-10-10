Return-Path: <netdev+bounces-133981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE70A9979B7
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 02:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A3FE1C217C7
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 00:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156401773D;
	Thu, 10 Oct 2024 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKyqXuIe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF05915E81;
	Thu, 10 Oct 2024 00:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728520827; cv=none; b=WJ0qTtLcIoj3zdP7aTP19ZJnxJJ7G3v9k5eGpxk6LfcPDcALZp4zcmpfPWrG5O7FtKKldylVYFjV4PbngSRDJ0lhm7gr3ayDhOLI4amUFpS5hRPY/ozlzDA3quJweolKp3kcUyUGhFFtoAUR4KARQR1kIJOIgJKdEiz3kZElt+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728520827; c=relaxed/simple;
	bh=Qy415GliyDPfVuzf8nhC8y7Hrp25b42nlwhd6QfEtL0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jGde8PIYF0gZNYFLZICoceoRtT1m7JKMNtYUQqYstbuaTHIHRKx5yCiaswzxDpjv1NMVtTV/x4+TPSyJUNyhOS8Mrmg5tIoEUHWSCHWFEKUBqDnJeSUQE+p8hZ+LPZTFgvvCGN5IcDxozYC0tl2ieee7+6nFwGYphl47OmnFuGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKyqXuIe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EDA2C4CECD;
	Thu, 10 Oct 2024 00:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728520826;
	bh=Qy415GliyDPfVuzf8nhC8y7Hrp25b42nlwhd6QfEtL0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UKyqXuIe33VB5GMFlumNr3myRoNg9DY4B9nShqOTsJG2D+t1CLVHag37onhSLqBJn
	 Z/8IsNiy1TB91AoNSiIdUBDMpbZr7rx+bIJkf3rO2GwD2Kf3tRbsCf39n9fab4IOZO
	 njRg5ydTLx/0w8PavY9jzWNKJmuGY6d4a14M29qzGmFpyNwRingb9G8m36ehWUmMdc
	 IZN+4flmI5nLWLRvukni4d1zfgKWDCTmysSvUhpX9j0nQNDBt3y6BP0nAF25tRWQrV
	 tufHgAT6z1sOjvJ6sCdbM7wCiPdRkK+/9ZYAFStO38OsZKJL42e0m9kohMxPNakGyW
	 eTiXa2kw+RLYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD7C3806644;
	Thu, 10 Oct 2024 00:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] doc: net: Fix .rst rendering of net_cachelines
 pages
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172852083049.1520677.8896251580489961896.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 00:40:30 +0000
References: <20241008165329.45647-1-donald.hunter@gmail.com>
In-Reply-To: <20241008165329.45647-1-donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-doc@vger.kernel.org,
 corbet@lwn.net, donald.hunter@redhat.com, bagasdotme@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Oct 2024 17:53:29 +0100 you wrote:
> The doc pages under /networking/net_cachelines are unreadable because
> they lack .rst formatting for the tabular text.
> 
> Add simple table markup and tidy up the table contents:
> 
> - remove dashes that represent empty cells because they render
>   as bullets and are not needed
> - replace 'struct_*' with 'struct *' in the first column so that
>   sphinx can render links for any structs that appear in the docs
> 
> [...]

Here is the summary with links:
  - [net-next,v4] doc: net: Fix .rst rendering of net_cachelines pages
    https://git.kernel.org/netdev/net-next/c/54b771e6c675

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



