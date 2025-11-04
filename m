Return-Path: <netdev+bounces-235331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26764C2EB45
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 02:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DB323AB789
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 01:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FD02135B8;
	Tue,  4 Nov 2025 01:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qM9vVIRM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6754120CCDC;
	Tue,  4 Nov 2025 01:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762218646; cv=none; b=IpNmhVBp5JMqPhoVuMVmt1+a+eeMOk4LYLUzPdAscX/nPQ5tJmJ4428NVlCwIcMICp2xPpzhDGRUuwnLWbm3inXtx9XiyvAAEV7LlAZuGSGA0zcGvvdS6rLhuFqhs2g5mHorW5tJfXTgn5l4WUnj7rH4nBff6arZp4NuEE2sj7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762218646; c=relaxed/simple;
	bh=KmLRKbPEB1dkEqUb0OPe6Uyy25qssI/XWuR1qIixhds=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fNWIapIMOJphGTtm9Eg914gtrOkub2l4B0jMjE24kO5JiQwMB91916235Rdj0tLOyiWRtf2YULNIyRnKCGnZLhVGXvRtR9Z8aWhIi7O8VRjGTqm5Opz5tVsYsVdM++kbWchGf+P80s2q8T5NzU6BnNUXB1e3Xc3bJK2STfWT3tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qM9vVIRM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9427C4CEFD;
	Tue,  4 Nov 2025 01:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762218645;
	bh=KmLRKbPEB1dkEqUb0OPe6Uyy25qssI/XWuR1qIixhds=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qM9vVIRMCoFLiJSNmyVBoipcvwDvacPl58GPuC6dM2NpHgoso5YUZe0PGx61U/Bd0
	 SW4xp+J1SpyArUSKVQBmiyeAGDY6dtxt2WUmqj6ObcaTsZ9jGkAENTQoLUe+h9qQtP
	 iiJba7ziIjbGocupAZBQmqtNIp0tf4zHnkzBsOb0U3nAvClOxjWVyYlZ/memLE5Maf
	 oCVM6eLcjYk5sog0FDIRwCQJJqjroOcJ4qf2vhJrLaAmLd4OBUVI6PJpQFsgukEjl6
	 9I7ipSeYyROC1zXZq5vrTDQvek8/mIcISFTPP8T10J2b0IqcmW5MLdnJtyhUvU+KCo
	 NE4d6xfcMg+oQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CC93809A8A;
	Tue,  4 Nov 2025 01:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] net: dsa: b53: minor fdb related fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176221862024.2276313.12848174234048572482.git-patchwork-notify@kernel.org>
Date: Tue, 04 Nov 2025 01:10:20 +0000
References: <20251102100758.28352-1-jonas.gorski@gmail.com>
In-Reply-To: <20251102100758.28352-1-jonas.gorski@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 vivien.didelot@gmail.com, f.fainelli@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  2 Nov 2025 11:07:55 +0100 you wrote:
> While investigating and fixing/implenting proper ARL support for
> bcm63xx, I encountered multiple minor issues in the current ARL
> implementation:
> 
> * The ARL multicast support was not properly enabled for older chips,
>   and instead a potentially reserved bit was toggled.
> * While traversing the ARL table, "Search done" triggered one final
>   entry which will be invalid for 4 ARL bin chips, and failed to stop
>   the search on chips with only one result register.
> * For chips where we have only one result register, we only traversed at
>   most half the maximum entries.
> 
> [...]

Here is the summary with links:
  - [net,1/3] net: dsa: b53: fix enabling ip multicast
    https://git.kernel.org/netdev/net/c/c264294624e9
  - [net,2/3] net: dsa: b53: stop reading ARL entries if search is done
    https://git.kernel.org/netdev/net/c/0be04b5fa62a
  - [net,3/3] net: dsa: b53: properly bound ARL searches for < 4 ARL bin chips
    https://git.kernel.org/netdev/net/c/e57723fe536f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



