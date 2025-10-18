Return-Path: <netdev+bounces-230630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F699BEC107
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 02:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC5F41AE00D0
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 00:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D622E7167;
	Sat, 18 Oct 2025 00:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wte1Cr0y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B5D2D94B7;
	Sat, 18 Oct 2025 00:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760745633; cv=none; b=Ooj9Jyy9KIubvE7Lp4G8wTnisuF2t4iJPsER6ZcuUq/noArtKp0hUtrRd/RxTj+vbbDP+zlsBbUW2X3qOnScBi67KRJxt9mUZLtrsK88uAHtI976yRcH5qC5V53lCWrO96M8egVqDchVjWQjxBmLprmde6BTe4lSJ4T23XBclqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760745633; c=relaxed/simple;
	bh=ouH4rZmdVYwMhtQGqtITuPCWUWfpP9mThtcLVXhUp6c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iuTfU+NjfS4wdXi8vRb2MInAUAC/YPFkJJTsKbRoOasW/Lu0sXlFUKz6f7IN5lxQs9f45tf4aHwVHSWOPsWWQpoDUco7aJ9JikzuuhqCRyPzAIWtPj5pUaBSYIsdpTGzQyuJ+OZgmxs6K+QlIjGAS1NCVmxAWZw0Z+JlGkqhqfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wte1Cr0y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD23CC4CEE7;
	Sat, 18 Oct 2025 00:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760745632;
	bh=ouH4rZmdVYwMhtQGqtITuPCWUWfpP9mThtcLVXhUp6c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Wte1Cr0yZMaHmC5sJ46be4OkqAd7SPOcaOaCLXFMGnUsVlZoRsFUvjBh3rKQtH0Dz
	 ua2zXeB2N2dVgj3xqYmDBe7fwxsiyXv0z9ik2wXmyyNO09e5MgoGTyx05PrKPDvjgT
	 bhgTUT3sJQSyHf9uNUa26OFp57ShVWg91X8d4HHPcmBVg5PlTZZQ7q1ycZn7OcYOl7
	 2uXSQd6WEuuIfU3qZUwJl1eREzhtLAQcYvVigdHK4eOExFgQw6i3HmO5WD6yjOswJP
	 7TQieb+kwo8mQ14AZUYPb8bmkK+Eeg4ZfDXIB8y45OY0mjODE/P/24qKjdcusP8Ylt
	 +M2W2Xmfmbsjw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7105D39EFA61;
	Sat, 18 Oct 2025 00:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] dpaa2-eth: fix the pointer passed to PTR_ALIGN on Tx
 path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176074561600.2830883.6132558086043890627.git-patchwork-notify@kernel.org>
Date: Sat, 18 Oct 2025 00:00:16 +0000
References: <20251016135807.360978-1-ioana.ciornei@nxp.com>
In-Reply-To: <20251016135807.360978-1-ioana.ciornei@nxp.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 matt@traverse.com.au

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Oct 2025 16:58:07 +0300 you wrote:
> The blamed commit increased the needed headroom to account for
> alignment. This means that the size required to always align a Tx buffer
> was added inside the dpaa2_eth_needed_headroom() function. By doing
> that, a manual adjustment of the pointer passed to PTR_ALIGN() was no
> longer correct since the 'buffer_start' variable was already pointing
> to the start of the skb's memory.
> 
> [...]

Here is the summary with links:
  - [net] dpaa2-eth: fix the pointer passed to PTR_ALIGN on Tx path
    https://git.kernel.org/netdev/net/c/902e81e679d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



