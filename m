Return-Path: <netdev+bounces-104812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DF490E7B3
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 12:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08A961F2156E
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 10:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3327EF10;
	Wed, 19 Jun 2024 10:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFQ69wdR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EAE770F6;
	Wed, 19 Jun 2024 10:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718791232; cv=none; b=Ultw1DM9mI6z1kEzU8vHZY0MIvJpCCqHLfRlqMQ488llHfbQ9FCtw7N9TNXPqXYJNeau9Roy8YbyVrMC645bCRhJTluK74STtIH2ASmARg9ZS5j+pclp/kOauVd3Gtp+v8B2kk7e4IwvhQShbSHYZsnW6J5CmModKouW/rDQT+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718791232; c=relaxed/simple;
	bh=QurjcNZ2dfcONUAy1aNYQ+5M7kz5uOQJLl4DpbGpUkI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UbQYgHZi3lfaI2eepD2A0Lz/c7ZO/szRKVeIoi1hiEFsksEdnGqtb4ZC2t2dNYSVuiqAk+StdfTDuAWzYprZt2ETvTaZFo4o2ulE8BIoE6GuYl8POb/ap9HHSkkOWn+KFYNFAr9QvW5b6YuQckRh9xqTFdJM6DpyYzK4T19iZC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFQ69wdR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73309C4AF1A;
	Wed, 19 Jun 2024 10:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718791231;
	bh=QurjcNZ2dfcONUAy1aNYQ+5M7kz5uOQJLl4DpbGpUkI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cFQ69wdRNdVQho3cJWJvvpaVZacHsngP9uiU9B90/WQHwmAdi1ghSLl1dJ27s0kns
	 /n1F9pPCWkxIvC3hkJl4AFh5KF7gUVcXoBPAarOm+jS9hhVH8LKdlquTCNj9iUIISd
	 +iyp93eWoCt4rW4kCA9VHZVWyCU/OmhdrYsneOsVwVqqNhfzlRVXvLvr0ewm/sr4qs
	 DOMFyknj/0d0dWWQTzDGFSszZFim5izYXkRufdChdj9HiBbTSllPYG/8XjwIXCNEOZ
	 KKJM3FsTKqGTd8VzOzF2ZGd4H+Rrb0FGQ5mRM1ceiWy0wEgh0M0CIwColwDsxC9Qav
	 uK7M8ecXiqyOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 601ECC4361B;
	Wed, 19 Jun 2024 10:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] virtio_net: fixes for checksum offloading and XDP
 handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171879123138.351.9134689741507431412.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jun 2024 10:00:31 +0000
References: <20240617131524.63662-1-hengqi@linux.alibaba.com>
In-Reply-To: <20240617131524.63662-1-hengqi@linux.alibaba.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 thuth@linux.vnet.ibm.com, jasowang@redhat.com, mst@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, edumazet@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 17 Jun 2024 21:15:22 +0800 you wrote:
> This series of patches aim to address two specific issues identified in
> the virtio_net driver related to checksum offloading and XDP processing of
> fully checksummed packets.
> 
> The first patch corrects the handling of checksum offloading in the driver.
> The second patch addresses an issue where the XDP program had no trouble
> with fully checksummed packets.
> 
> [...]

Here is the summary with links:
  - [1/2] virtio_net: checksum offloading handling fix
    https://git.kernel.org/netdev/net/c/604141c036e1
  - [2/2] virtio_net: fixing XDP for fully checksummed packets handling
    https://git.kernel.org/netdev/net/c/703eec1b2422

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



