Return-Path: <netdev+bounces-126763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B56D97265A
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 02:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7E4285B74
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 00:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47B855E58;
	Tue, 10 Sep 2024 00:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urC6A89n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFFC558BA
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 00:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725929435; cv=none; b=KPhH4smBcDFqANgrcdWarHyo0N9fgc+F3IQIVD8g7PGHKiHgVMIATpvA7VaUR8RdzYQXqF+CZUCgoP2b2lBdLdb9akVZ760eS2d2MMn8GcEL0KknoIDSTpEPQt6/iifKEj2k9csc80jsQJB93esmzo+/8F3Ua5COtqMw+SWFL4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725929435; c=relaxed/simple;
	bh=SgTfVa9VrIdE68tL2771uGr7FBr7irxt3PPsjMd13Wo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ByDVgRppmrjSMZDJ3eRw/puT+YUn8TS8sNwd2AAnnt0ZJyezBM0bs8qyUlRztVhvUBcoQdOh+uD9rxf/SC+VrDVBC/aamuLdB3r7mi8GnE28U2L28VM11ZvUUczxcwqL6pRHEr1FVNyWwT6GX2C6FZDFNEWKmSXB5ORSQDjHLQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urC6A89n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B0BC4CEC5;
	Tue, 10 Sep 2024 00:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725929435;
	bh=SgTfVa9VrIdE68tL2771uGr7FBr7irxt3PPsjMd13Wo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=urC6A89nqMILmYKyvUR6dVIyugjCthNL6sNr9ykTKO2a1E6wt8UjC9y6osNLgMJiP
	 0F5sAFamU6mK4hJmMvj7AIxHyfSOXzZ15Ec9DE6qPk7qzWyCUDz3JUD06aW2YA2zFP
	 sdjb8BQ7HBdZPigjZ/7jhmEP4tVKirI5zvNT4yzW2eE7ng8V77m1VcN4QcH75Ty3Tl
	 XUm8xlcr8onIckyiddseZ2WWK3E+xYMH8ADr1LQ1eF9enq0g1rkP7WfjM1BnRbZc9G
	 Sw0erLJ5vTJ4SfpAIzDWiHPyqokkA0KGeFVUzW1uqw1A4F3wxLnpki86c7gKYSNfRE
	 pvMkPjc4dmuGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D003806654;
	Tue, 10 Sep 2024 00:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ibm: emac: Use __iomem annotation for
 emac_[xg]aht_base
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172592943627.3971140.14027293465341792576.git-patchwork-notify@kernel.org>
Date: Tue, 10 Sep 2024 00:50:36 +0000
References: <20240906-emac-iomem-v1-1-207cc4f3fed0@kernel.org>
In-Reply-To: <20240906-emac-iomem-v1-1-207cc4f3fed0@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, rosenp@gmail.com, andrew@lunn.ch, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 06 Sep 2024 08:36:09 +0100 you wrote:
> dev->emacp contains an __iomem pointer and values derived
> from it are used as __iomem pointers. So use this annotation
> in the return type for helpers that derive pointers from dev->emacp.
> 
> Flagged by Sparse as:
> 
> .../core.c:444:36: warning: incorrect type in argument 1 (different address spaces)
> .../core.c:444:36:    expected unsigned int volatile [noderef] [usertype] __iomem *addr
> .../core.c:444:36:    got unsigned int [usertype] *
> .../core.c: note: in included file:
> .../core.h:416:25: warning: cast removes address space '__iomem' of expression
> 
> [...]

Here is the summary with links:
  - [net-next] net: ibm: emac: Use __iomem annotation for emac_[xg]aht_base
    https://git.kernel.org/netdev/net-next/c/5aa3b55bb312

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



