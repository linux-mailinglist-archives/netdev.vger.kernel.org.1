Return-Path: <netdev+bounces-106414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFA2916210
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 11:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE537288261
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 09:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD43149E17;
	Tue, 25 Jun 2024 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fv0l8iF6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD90149C7D
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 09:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719306630; cv=none; b=ksWPESm7ddrjQraoL+UindHtDqTw1vndTtRYQWkL2/GWqUMEDmubBfESZjvnwZ7FA6zDPWhiC5Tu9JA9dz25So3hurR6BwRxr2lVIUKqcGDzztWk07xmUOR4vMFi0hSr0EsbAXeATR9SSONcTxM9w3zq3VXtlxoPh8W+RRsNpeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719306630; c=relaxed/simple;
	bh=HRkFdZLzGCiBSxhFTdNYnPv42CNDsCy0vI99jCckptI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d23c5hIz8wjvdN3rRPMf1n5Jc34BoLFfKtrQIoq8d75odSEVwGPH3lEi5gff5J0x4rT5A09sSGC1eyHkbg4QU2Ha4iuy0CAlCrR3Fet1HNXWmRFdtgRDll1YN0k7CQlJI3klkqpSfh7ywaOTwJPEQ9pNoaQ4hZmknPyr54FNvw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fv0l8iF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88970C32789;
	Tue, 25 Jun 2024 09:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719306629;
	bh=HRkFdZLzGCiBSxhFTdNYnPv42CNDsCy0vI99jCckptI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fv0l8iF65H/5u/9dxeg6n/XOtn5/Q0cNew2fuXKBq6AapfflhOQvcjMZ5lglciKLJ
	 y94OzjwwwVFkZcsg1hjo8Jkh7sQ0AjgivfFnEewx+wkNN4iWfELK+rJ+HjBdJKRgz3
	 mpu+53EOdRuP+MXBFyqeW9v7PbiWk1AcJu87G1O0Sgu6QGiTcDh8NqDVmf8lPSuRV1
	 PcGSJFAID6vF+WC3YGnSsIhY3O28vf9579anqTQiMKUBut9upuOPU/Qz0ewsoXvsnL
	 bez1pM3xLX+HL56T6CqDH0n3L55Gl8PA2uJLZ5mu9R666R81J/YO6QbzKb81E5n81T
	 1XDepzYPCTuHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7499DC32767;
	Tue, 25 Jun 2024 09:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] ibmvnic: Fix TX skb leak after device reset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171930662947.3966.10907113087456004516.git-patchwork-notify@kernel.org>
Date: Tue, 25 Jun 2024 09:10:29 +0000
References: <20240620152312.1032323-1-nnac123@linux.ibm.com>
In-Reply-To: <20240620152312.1032323-1-nnac123@linux.ibm.com>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, nick.child@ibm.com, haren@linux.ibm.com,
 ricklind@us.ibm.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 20 Jun 2024 10:23:10 -0500 you wrote:
> These 2 patches focus on resolving a possible skb leak after
> a subset of the ibmvnic reset processes.
> 
> Essentially, the driver maintains a free_map which contains indexes to a
> list of tracked skb's addresses on xmit. Due to a mistake during reset,
> the free_map did not accurately map to free indexes in the skb list.
> This resulted in a leak in skb because the index in free_map was blindly
> trusted to contain a NULL pointer. So this patchset addresses 2 issues:
>   1. We shouldn't blindly trust our free_map (lets not do this again)
>   2. We need to ensure that our free_map is accurate in the first place
> 
> [...]

Here is the summary with links:
  - [net,1/2] ibmvnic: Add tx check to prevent skb leak
    https://git.kernel.org/netdev/net/c/0983d288caf9
  - [net,2/2] ibmvnic: Free any outstanding tx skbs during scrq reset
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



