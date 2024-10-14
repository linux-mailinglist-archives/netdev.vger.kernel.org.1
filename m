Return-Path: <netdev+bounces-135352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F9899D94E
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 23:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258A31F226DA
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 21:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9871D150D;
	Mon, 14 Oct 2024 21:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6UCfIsB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1746C15575E
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 21:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728942027; cv=none; b=O6UzCZ7sYSpcYjXl6pou5uGSiGmvAdu3TlDBV0J/WwkzO5cJzuJh0DoXy/sbSO7hWwPSmKAAtsY+Mni8In82p7am8XpVOujuzqJcVGF1QPMRG1+Af7jy4RZ2Vg3SDzOozy4HBFdvRdm7xzEysYNI6Bh1eu+fHeF3bXX+2Erzvmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728942027; c=relaxed/simple;
	bh=zeFH/cGOpymCJ2jbk1CvFpRqtTJB+osDNww5DDeFric=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nGhAZxe35JEG2QM3SA3NVrhgjyUSmuQzrUSs8NLA4V97R0g24jq3+ZbGkJgp0tIPYVq1M8ZIYclClesNPJAueEVboUc9rUBvD7haVMjByxWmoYpL0VvKxE5jbNXf1zH2rNsHAjE9HxmworxGDz4NKXO8HZ28sZrUwTrn9PoN5pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6UCfIsB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC0BC4CEC3;
	Mon, 14 Oct 2024 21:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728942026;
	bh=zeFH/cGOpymCJ2jbk1CvFpRqtTJB+osDNww5DDeFric=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q6UCfIsBnMDJPxmTx+H0t1FR0GOjKVHNxsmqg04NaMinqb/aSStWtYciBADcaGeiG
	 ttBlRLpoy2hpcHHUz0aI+83jsIA/kOGMMeQ7xeoSJ7INf+F8UbtPo2fgxWgp2PkXD8
	 k7YGkqR0QjgGNCdeX1P4EI0kjZ5obaettH2ohQg0pnRx6oBdNhpsxdFzYuFL9eNzdI
	 iE99pgnv6W6x4zaAa23W9DBUVL8uh6URHbVoWMUxKIsC7y+fsEA4hA4czF/3y6DFlw
	 T8sTBH+0IF71h7gcnvSJ+2VUWjp/s9x9N3J4cNL0469dJGeWd9te4iNA7Nieqs8ICn
	 Ip/8rcBLtHzGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0053822E4C;
	Mon, 14 Oct 2024 21:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] rt_names: read `rt_addrprotos.d` directory
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172894203175.647169.2967692358395264524.git-patchwork-notify@kernel.org>
Date: Mon, 14 Oct 2024 21:40:31 +0000
References: <20241004091724.61344-1-equinox@diac24.net>
In-Reply-To: <20241004091724.61344-1-equinox@diac24.net>
To: David Lamparter <equinox@diac24.net>
Cc: dsahern@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Fri,  4 Oct 2024 11:16:38 +0200 you wrote:
> `rt_addrprotos` doesn't currently use the `.d` directory thing - add it.
> 
> My magic 8-ball predicts we might be grabbing a value or two for use in
> FRRouting at some point in the future.  Let's make it so we can ship
> those in a separate file when it's time.
> 
> Signed-off-by: David Lamparter <equinox@diac24.net>
> 
> [...]

Here is the summary with links:
  - [iproute2-next] rt_names: read `rt_addrprotos.d` directory
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=b43f84a0a9fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



