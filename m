Return-Path: <netdev+bounces-95660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D3A8C2F0E
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 04:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDF5E1F22923
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 02:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC51F45BE1;
	Sat, 11 May 2024 02:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btin4R6H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29512E859
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 02:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715394635; cv=none; b=pz7AlHlo1gXAN3Cwenup7NqTPEDEEx+SjJQf1pXtA0fwBGaBPyAeKZaxVo8EqnPlRBZk4TCzEZV8TZ3Jd+mHAHiitHhPyYyL5+aGseCdcIDynPDAohsOLhbf4F3WU+FBJH9TuGUEeu21Hv4hOI3TdRdrVevNs+BN+4hSTgYHMEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715394635; c=relaxed/simple;
	bh=rGgiKNSoy/E+0aMNWvFDAOpuHJnSIgFlDnfkHne9Ymo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o5p8vAfkZe8Ac9Q3dUvlzs/xT3zoiuRx49voOedyKIoO3A3mjqP4jHOBj/mTcCeuKwibS8bTzsrhG9pN0zTbxnzIj+o7gn48bpuZrG0KL8mg+avBvJq7DhfwA5F4FxVQFS5+jVb0yxxbru6U+qh/HGG+MdhwocZ33n40rmJZEgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btin4R6H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 749ABC32786;
	Sat, 11 May 2024 02:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715394634;
	bh=rGgiKNSoy/E+0aMNWvFDAOpuHJnSIgFlDnfkHne9Ymo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=btin4R6HH+qhfD6HN0+VSCQL1IltUpeurWXM9IZt7B1MhQuQDKq7g15q6nXFnEErF
	 QnmsLGT1ZKDaI3hKQCzlllnkpHLUAsZEVjM7GD7rxUvRENHiWbSwb7FWy6Ra8CDWdJ
	 3OUMFVjYVeBF/RWjlaSy5dwGkaG60r5VPa1t5roVtllnFAUQkTkWOG7b9nnpLV/iT6
	 UdzSqLaLAt1sFGX7pzgH66nyLV5Oa1H0+POzQSCnH12wzYK0u2hqL/tMexdFh2kO9e
	 dUEGzTJMd22L2FYwTuKHvFfgXMYU4+InJcuSIwwjz3cA+4FPq7CQ5MMdUP171bHeMc
	 TpjD23RbWZIeA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A105C32759;
	Sat, 11 May 2024 02:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next] net: usb: smsc95xx: stop lying about
 skb->truesize
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171539463443.29955.15162306141062181621.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 02:30:34 +0000
References: <20240509083313.2113832-1-edumazet@google.com>
In-Reply-To: <20240509083313.2113832-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 steve.glendinning@shawell.net, UNGLinuxDriver@microchip.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 May 2024 08:33:13 +0000 you wrote:
> Some usb drivers try to set small skb->truesize and break
> core networking stacks.
> 
> In this patch, I removed one of the skb->truesize override.
> 
> I also replaced one skb_clone() by an allocation of a fresh
> and small skb, to get minimally sized skbs, like we did
> in commit 1e2c61172342 ("net: cdc_ncm: reduce skb truesize
> in rx path") and 4ce62d5b2f7a ("net: usb: ax88179_178a:
> stop lying about skb->truesize")
> 
> [...]

Here is the summary with links:
  - [v3,net-next] net: usb: smsc95xx: stop lying about skb->truesize
    https://git.kernel.org/netdev/net-next/c/d50729f1d60b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



