Return-Path: <netdev+bounces-145482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C06B59CF9CD
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 23:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8631F25370
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 22:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBE418FC65;
	Fri, 15 Nov 2024 22:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blRs0nmR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FE5187876
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 22:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731709824; cv=none; b=Rk0rgpu2S9OHiDJOrfEBKG6HtshNm2le7bqX28056G36/+hAwVRUTim7d8kyBXmTXnnDyXFEhGyyp5SNIPN7366GEfQqQkYH33mFQd1cvDpveFlwJg27YU+pUCIdVoGPAMtpB+uwyjm/bElQU95KyLKi5iR1wZBU0I2a2+fhIck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731709824; c=relaxed/simple;
	bh=6w1o7nRaks0ohhcJz8ZUTDQeVxrQhzMJPgnzEjF7x74=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j/eiR6xX3ocmcP4aZfA1Cs3XS3FzM7LJN9UVcTtrneWXesTOWWFoeToaAI8JYaZaOFjtxA2+BSaEHg4erSKfR8QMQQc2kAxxPOUCXI3oEo2ZjI5fMhEVREclLqOjUR4m8gF5lq6BT4Mi+Cz/apCMzlBGU6Osmr6X1KsfwUlt78E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blRs0nmR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E312AC4CED2;
	Fri, 15 Nov 2024 22:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731709823;
	bh=6w1o7nRaks0ohhcJz8ZUTDQeVxrQhzMJPgnzEjF7x74=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=blRs0nmR/m/6lLv/jJInrA0DZY0ZW+sltzhsglrMJ3O+O1wAVQtDdt0zRRh8L8Ixb
	 fnlQ9vwgkyaGa6JdRMiGSfESaXJmLs7Q60cNuceEpp/tQTkHra6AfO4+4UTSp2BV6u
	 761zCMKtXIFp2d0DMldE8ZQDsS4vIyGCLdDUorYeOHVMO/wCc5Gh7ySFGFM/netfdj
	 OHxr/SmovgvJE5/kMvWFZfCB2S/knvvwkH9H+2fjs42dlHZZkEyJtUaFqvz3ArHv/K
	 6OOS5HISvFv9hdmLYD1L+sc0JyUDx2y6YbP/2ABt5n6MfrI6O/my9k0/c8oo7LHZdz
	 STT0KDGM3BWtQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD8F3809A80;
	Fri, 15 Nov 2024 22:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] bnxt_en: optimize gettimex64
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173170983475.2752190.16027206230047890074.git-patchwork-notify@kernel.org>
Date: Fri, 15 Nov 2024 22:30:34 +0000
References: <20241114114820.1411660-1-vadfed@meta.com>
In-Reply-To: <20241114114820.1411660-1-vadfed@meta.com>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: vadim.fedorenko@linux.dev, pavan.chebbi@broadcom.com,
 andrew+netdev@lunn.ch, pabeni@redhat.com, michael.chan@broadcom.com,
 kuba@kernel.org, richardcochran@gmail.com, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 Nov 2024 03:48:20 -0800 you wrote:
> Current implementation of gettimex64() makes at least 3 PCIe reads to
> get current PHC time. It takes at least 2.2us to get this value back to
> userspace. At the same time there is cached value of upper bits of PHC
> available for packet timestamps already. This patch reuses cached value
> to speed up reading of PHC time.
> 
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] bnxt_en: optimize gettimex64
    https://git.kernel.org/netdev/net-next/c/c7a21af711e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



