Return-Path: <netdev+bounces-112061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00925934C3E
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 13:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF0E6285A51
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 11:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859751386A7;
	Thu, 18 Jul 2024 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9wXSFpf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F5B12EBCA
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721301078; cv=none; b=jsi5soDxgEgV1gcPz+ph3xHDSL4LelgQY+UXJOcrwoF8+ScpS3XLBB8yfv1Y82PcYVMKCY0SwN+Duzo5uZwb/eTXW+Jx/32PnWf47gHG89ByhMLKmFytAYlLdljKAgdxpQjm8bURssJXUfI2nWFZtgpstH0y3pc0UxHhYN7invE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721301078; c=relaxed/simple;
	bh=nHLQySi4Qxed3a4/EtilX7JDD87dxqGt+3hDiY7Wtu8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AL0TgmjaE3YsmOqTByrlQiWhksy7/oYfWjx/SexWQxEnMxwJ3erqknnN9A4NSdJPsvo+EVbe1U+gdeykXmXiKh2Xyy7yRyc7CoOSSrsb8ovJuWr6h4S9WAg7soODhnQ3i/HbdJv/bBa5cVhhRfjWiWvJzJimQJh/DkQaq/cO1Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9wXSFpf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D0F0C4AF0B;
	Thu, 18 Jul 2024 11:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721301078;
	bh=nHLQySi4Qxed3a4/EtilX7JDD87dxqGt+3hDiY7Wtu8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G9wXSFpfOk6/bFB10yskzWi/bfVXTA+9qS3SbgGLcdf5apD5riqhqrsyXkWqwwKGm
	 0BVG3k1QwqXUuHyndwyg2jwgjK+9UARiifYIkJ/nfhpS/8/2OOPg73GVC66hJSr1hO
	 4FuoygsFOjYLAigIlK8hc1mTiBIGfreHtHkijwEdv5m2ln+qq7H9Ykvjb8b6od0qx1
	 6WIFifEUW4sqIxRdzgLmkQPHv2He7D0thqyZHuR700etSfovMS6N2ZHyWw15oBR3PS
	 qO5jjVPpW1hi+fjvbV+Za3l2/EJmrJIzC2EMtBZp45zo9Bg3FBFmEzTZwG0TFPA2XW
	 C3jRzgmf8hi8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19D46C433E9;
	Thu, 18 Jul 2024 11:11:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: airoha: Fix NULL pointer dereference in
 airoha_qdma_cleanup_rx_queue()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172130107810.19541.15489798914514509660.git-patchwork-notify@kernel.org>
Date: Thu, 18 Jul 2024 11:11:18 +0000
References: <7330a41bba720c33abc039955f6172457a3a34f0.1721205981.git.lorenzo@kernel.org>
In-Reply-To: <7330a41bba720c33abc039955f6172457a3a34f0.1721205981.git.lorenzo@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, sean.wang@mediatek.com,
 Mark-MC.Lee@mediatek.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, angelogioacchino.delregno@collabora.com,
 lorenzo.bianconi83@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 17 Jul 2024 10:47:19 +0200 you wrote:
> Move page_pool_get_dma_dir() inside the while loop of
> airoha_qdma_cleanup_rx_queue routine in order to avoid possible NULL
> pointer dereference if airoha_qdma_init_rx_queue() fails before
> properly allocating the page_pool pointer.
> 
> Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] net: airoha: Fix NULL pointer dereference in airoha_qdma_cleanup_rx_queue()
    https://git.kernel.org/netdev/net/c/4e076ff6ad53

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



