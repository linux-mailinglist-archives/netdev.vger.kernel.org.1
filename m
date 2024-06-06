Return-Path: <netdev+bounces-101366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3118FE477
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 12:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F3D284589
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 10:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099E7194AE0;
	Thu,  6 Jun 2024 10:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAeXS0pJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FC213D28C
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717670428; cv=none; b=CDAiXUS0hwrkq3u5O7JB2JwXNwL2pjkIJTChjaH9garbAb1MmwWLGtovSb37e9jwA8CgaMAARYq8FIgiLFGR7Ygwgg3K9dSfvQzuE3+cte2iA1rx2phcv1pjuF2s3UQ49G7hzkCYrGit6pmpOZ/GjN3Mnk1YN9pFlAQ+CrdMfOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717670428; c=relaxed/simple;
	bh=bW58UChMA5ULp25rjBKfC+6nURXfVUNeaHFcg3iHD2w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RB+WSa4kfrywgX7aCuUKO3ZpGmAgpuCcWFLTcDgMzekGtJig4VaVZFjkclgFU5cYFnHPDjT2F0uRliSo6IrVRMMt1nyiY7+WLVEwmzdSs9T67AoyJ/nF9CkiouEHL05oo6+PdP7kvbphabPMRRr+2Hkl6sHO/nySC+ZE4W9JWBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAeXS0pJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C7D4C4AF13;
	Thu,  6 Jun 2024 10:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717670428;
	bh=bW58UChMA5ULp25rjBKfC+6nURXfVUNeaHFcg3iHD2w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KAeXS0pJYoLPz/CZ9Ne3bHgw6W0KnpBhJwPap/aSqd4m/IuNHddhJ+Jfx1rXvDY87
	 7S0xUrQzqVoLCDqtEGNyRDEbrYabBEriXqvg053L5AGx8XBop7MUxbC14VsM7jk5qI
	 KAdeOP4L8iwRZd4PKt+msSDpxhcgH/4dKJNd4sl/oM74j/RHn31OzqWu87hoGJBI2E
	 9zDPBqhY81T9qN4DInFL5Z7JhbkmldNu9d1os/FKP1h/jKg2p7x8dx6X9wL9CP6CcO
	 MRXGml0dN19L5eeC1qtV9GKKNIy5/Bl6Va44p9ENKv1JKYRuv2Ot9QPnol1Wc+GNlR
	 DxA7BLAh1QZIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56D7BD2039E;
	Thu,  6 Jun 2024 10:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] inet: remove (struct uncached_list)->quarantine
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171767042835.10301.5696449570968279888.git-patchwork-notify@kernel.org>
Date: Thu, 06 Jun 2024 10:40:28 +0000
References: <20240604165150.726382-1-edumazet@google.com>
In-Reply-To: <20240604165150.726382-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  4 Jun 2024 16:51:50 +0000 you wrote:
> This list is used to tranfert dst that are handled by
> rt_flush_dev() and rt6_uncached_list_flush_dev() out
> of the per-cpu lists.
> 
> But quarantine list is not used later.
> 
> If we simply use list_del_init(&rt->dst.rt_uncached),
> this also removes the dst from per-cpu list.
> 
> [...]

Here is the summary with links:
  - [net-next] inet: remove (struct uncached_list)->quarantine
    https://git.kernel.org/netdev/net-next/c/98aa546af5e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



