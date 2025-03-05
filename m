Return-Path: <netdev+bounces-171909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2944AA4F4CE
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 03:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D1AC3A87A2
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 02:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4887718A6A1;
	Wed,  5 Mar 2025 02:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1gz1m67"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0A517588;
	Wed,  5 Mar 2025 02:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741142405; cv=none; b=HPBJXvbfI1QEYMH38aQaHG9/s5iNMjXfBiKV+ipk8dEBnfPDA+ijnajJZz7FG1bik1YK8UqdDmI9BAMWk1aXVhyCJIYDxH3YO6pkWi/88d1HotAccPhrH20slDm1PC2/UlJhy1KEuAkO45+18umrU2duIBdIinwEALB/FiWf6Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741142405; c=relaxed/simple;
	bh=J9egK8uICC543nCxvnlqhfgN2jAyK50GGkfr+0Bzgto=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WJX7PaQNIfMNTo1IBb/vfkS4XsrKg5qDb02OOm0yaE4Cg1U4aPBlotEysqyOVbMkC4yR26TJHn1z0JptJL4/Fz5/tyYWRm3wxJdrxRNjyTfhS/wZwbbXPOv271EBQ4Xbv749fvIsM49+9PYjKw5y/izCqKlG9NIRvJqO3uypgzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1gz1m67; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE26C4CEE5;
	Wed,  5 Mar 2025 02:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741142404;
	bh=J9egK8uICC543nCxvnlqhfgN2jAyK50GGkfr+0Bzgto=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e1gz1m67WCK4Nx1NRtGvEKHn+eIBZDokAGpHVmm0SelCFjw+kwKDaDPSKQJhzvx+P
	 sKlbu8ffFbJRdsS2zZzgE0Lgix768fU8CraKOmPx0OI1g3ccDzoPHb34HsGl+MM0MJ
	 0scPUd/+785IK2c71sR98ZycjkRfmDbuOeMQMkctHgewyuBSjT/akrCb8LbtnRAUL5
	 JfNEXgqRxS5GjEyCJVAZlvGuLMMgXUL0g7dLQs/BT5HZROFXeckzqlKqqzgVnc1Fh8
	 uCgZZup26kQBNdG08ovCSEq8yHwXgjRUPz1CswCYJpz2IwvzFAHZDL8i0oH/ewAnAd
	 5qB0WYg6rRlKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC41380CFEB;
	Wed,  5 Mar 2025 02:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: Silence use after free static checker
 warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174114243725.377491.12130065610243689441.git-patchwork-notify@kernel.org>
Date: Wed, 05 Mar 2025 02:40:37 +0000
References: <Z8alMHz89jH3uPJ9@stanley.mountain>
In-Reply-To: <Z8alMHz89jH3uPJ9@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: ahmed.zaki@intel.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@amazon.com,
 bigeasy@linutronix.de, aleksander.lobakin@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 4 Mar 2025 10:01:04 +0300 you wrote:
> The cpu_rmap_put() will call kfree() when the last reference is dropped.
> 
> Fortunately, this is not the the last reference so it won't free it
> here.  Unfortunately, static checkers are not clever enough and they
> still warn that this could lead to a use after free on the next line.
> Flip these two statements around to silence the static checker false
> positve.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: Silence use after free static checker warning
    https://git.kernel.org/netdev/net-next/c/f252f23ab657

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



