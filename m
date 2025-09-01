Return-Path: <netdev+bounces-218887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8D5B3EF73
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 22:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07D551A875BE
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 20:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6301274B31;
	Mon,  1 Sep 2025 20:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="or/+tF4B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD2E2749D5;
	Mon,  1 Sep 2025 20:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756758005; cv=none; b=n69o3WP4nyxRmbBMqZX3uedWv3thiF7d6ZNMNozkSceydJsAiftAsZSSU4kKbH8XFY3PSh1o6h1In+LfZI8wWHE1fPFOtexmbqYGbs7w1t/QNV78PtpH19PzgYxAfayRMbasQWd/u5Ql8x6XM4ef27Xus0/aG5zXBqXpAYwJosE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756758005; c=relaxed/simple;
	bh=b39CVSIpvQ82eMLGXDvwCDl7jmyv8De4VrwQSDpPtkA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q78ZB9oA+6QmLDY2KOP93z2Bc89gA90HZzKogWk9TxJpiWX0RkvN1zrk0Hub3XZDv5HayDISi7Fsain6xqLZeP6Y7vw2WXje23Iecg7bN63Y7/QkJZJMVSESF+WXEJtFEs7MOUIua0i8u7gvqrxZgtdCsWN6GwUF4rpTvlbjRjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=or/+tF4B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48122C4CEF5;
	Mon,  1 Sep 2025 20:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756758005;
	bh=b39CVSIpvQ82eMLGXDvwCDl7jmyv8De4VrwQSDpPtkA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=or/+tF4BeQA3GU5BfVdH+az5Kk1xrA0fmAu7a4DtKqT46Yi77yq1CecQ0CdxDQ3gO
	 wBHR876j8Z9aiqqZlvVNYDa+dYaiB0M2TNUeKo+Jd7taPt3yjmHsbIyg6siw2Ggw9S
	 psnvEvhhGF5+ay1L8z2jviMg8Emnu9KMksiUhF+Fxe6Kbprw2wtEISG6vMjoSNplXS
	 5Zj5gmF3b/7U6Irgt5Eo9/QM9pqcjcCyQ/8z57YGFcwx9GLAuyUkKC2Mp45iJB4z+a
	 rVWlxw/qtsZAtjS/nbtn+4yUgBtku3aavX2MzZUmc5WT5XS2NGmOqnSctpRq/WQwvv
	 Es4G0PnPFQ3HA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D5F383BF4E;
	Mon,  1 Sep 2025 20:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] docs: remove obsolete description about
 threaded
 NAPI
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175675801099.3872744.4982119550826737443.git-patchwork-notify@kernel.org>
Date: Mon, 01 Sep 2025 20:20:10 +0000
References: <20250829064857.51503-1-enjuk@amazon.com>
In-Reply-To: <20250829064857.51503-1-enjuk@amazon.com>
To: Kohei Enju <enjuk@amazon.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, skhawaja@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Aug 2025 15:48:42 +0900 you wrote:
> Commit 2677010e7793 ("Add support to set NAPI threaded for individual
> NAPI") introduced threaded NAPI configuration per individual NAPI
> instance, however obsolete description that threaded NAPI is per device
> has remained.
> 
> Remove the old description and clarify that only NAPI instances running
> in threaded mode spawn kernel threads by changing "Each NAPI instance"
> to "Each threaded NAPI instance".
> 
> [...]

Here is the summary with links:
  - [v1,net-next] docs: remove obsolete description about threaded NAPI
    https://git.kernel.org/netdev/net/c/b434a3772dca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



