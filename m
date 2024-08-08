Return-Path: <netdev+bounces-116946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F77A94C289
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 18:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B10181C21168
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 16:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33A6191466;
	Thu,  8 Aug 2024 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEDueKKy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4E118E02D
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134040; cv=none; b=gNLIv20vpjWX49lt6fHYdrbPQl93x9uutjHSTmqf5RScrT4z6q7lWhrf/YvCjJCKh0QpuD0qJSrosnqTSfs7U5+ApOSN260dn+13MBKVrZMsi5wNfL7nmc9TZV8CCV8IEpJ9O12AAAg4D2c2XWxTwM2oSKroVGlcfUixmvGQTXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134040; c=relaxed/simple;
	bh=xqZPtweevNYTbfdjJ/zi16VQdhJh5DSkdPpMb6vWfJs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mdNHyaXbhDaNRz2dmPmH2XmXffo2PMgVA3oCSIxRLh4o+ut1tI60Ut0cux8OEN5MQ2kcnhaVlJyE2lAYs5a10gXRlAujD0ir+TTaRJZtH+yZA5OB6a7TOQKvY+0596Yw6gW7ZOpJlSyYSSmwl3GupZyzBmD23SoCCAQD608TULs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEDueKKy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8EAC4AF09;
	Thu,  8 Aug 2024 16:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723134040;
	bh=xqZPtweevNYTbfdjJ/zi16VQdhJh5DSkdPpMb6vWfJs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BEDueKKyMWLSed4ph2FhJOoibmK23IO0DoI+DFCYMxJGV6ld/eKk33H9G2V1ChMyb
	 uiE/CENtyojCV5cyXdsv9jkloiZTEi8ylHnaAfz1VXph4UltnJU+St3sk2IYvOq8A4
	 fmtmemauZ+pqRKC3VQQZc6oqcymSOfax0IqHNWsNk4dlkCCQ5me/h8wgEvZJS3qbVc
	 tjcnJGYZP/HypAb7iEe6qYR93aetvF2yw0TcjUtpI0I3SEkGV+4bL+9HCnIj4Xb4k9
	 K9h4p9nCIHVwq2ld6cPIygatIm8WhUsPwG5rlWqyNqctB3WTFIS6/v1SS+Wosucmya
	 Mdi4J22OPQ9IA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F15382336A;
	Thu,  8 Aug 2024 16:20:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates
 2024-08-07 (ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172313403899.3227143.9688857293912395754.git-patchwork-notify@kernel.org>
Date: Thu, 08 Aug 2024 16:20:38 +0000
References: <20240807224521.3819189-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240807224521.3819189-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Wed,  7 Aug 2024 15:45:17 -0700 you wrote:
> This series contains updates to ice driver only.
> 
> Grzegorz adds IRQ synchronization call before performing reset and
> prevents writing to hardware when it is resetting.
> 
> Mateusz swaps incorrect assignment of FEC statistics.
> 
> [...]

Here is the summary with links:
  - [net,1/3] ice: Fix reset handler
    https://git.kernel.org/netdev/net/c/25a7123579ec
  - [net,2/3] ice: Skip PTP HW writes during PTP reset procedure
    https://git.kernel.org/netdev/net/c/bca515d58367
  - [net,3/3] ice: Fix incorrect assigns of FEC counts
    https://git.kernel.org/netdev/net/c/c181da18a730

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



