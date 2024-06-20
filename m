Return-Path: <netdev+bounces-105095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B667690FA4B
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 02:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 528FA1F2228D
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 00:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DC2D51A;
	Thu, 20 Jun 2024 00:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hl1q3dtS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD28C6FCC;
	Thu, 20 Jun 2024 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718843428; cv=none; b=dWHDekRYiqbPffeRSxMgLuQEc50cbi9MtvshyyixknrMrOxXSJKfN6j1Y0qxDP5r8h1yt7CyED63TQXYWYKwaIjeObyQLsbMH3+Ka8jEnS48kqasvE5JUqTfr8Z6obVVKv49kpkk4B/HB1E1AHwLGHT7gnk81yZFLcRmhmexpJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718843428; c=relaxed/simple;
	bh=iJI2/XoTwnwLfJH7NVEwHYz1dtuhiHTokmR/vQuK2gI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nSzDzCF17krJIGl6MnZemowA7xOhhepnApPYsnz6HQOMEO2SH1SPsaNAh+fSZ78G2DE8bbbfi+SQ+xs6baHO0j1/gufNaGIgC8aHWQj6ZPVaewTwaYlYYyam7O5o/VsghDKdO1u6C0hhnfrKbdEGngyEiz18uqwA1FCewYaabdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hl1q3dtS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F9F6C4AF15;
	Thu, 20 Jun 2024 00:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718843428;
	bh=iJI2/XoTwnwLfJH7NVEwHYz1dtuhiHTokmR/vQuK2gI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hl1q3dtSDaiyTs5dabxzUTb98pv21ymE+H7zEBEWiIDJ2Rt6/nKgZxbGd3CSayItQ
	 our7PGxgcRz7GqKXLig6RPqeaV653AICOyUdonte+kEF8fbS+jaoK/y8xlk0QE0zG4
	 J08QifHxuekerhLxJo1GlObRvvLcGyMaE6Yk+ev6mQnwRJhsSTygIKY3X5qwcZobnn
	 ONnw09jCFrFEjSg0cnmm6MSn400wh/q/lpifsjT+mrQjJNP5TmS6SHpzUSKN//XtFi
	 s+f2NhJUh5oqJ8x17BfYOHBmMmicDbGW2ZhWrcUNK6ny/sV30zH2tC9WYfVwnXxRVZ
	 0n8pqsWAgXu0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21BC8E7C4C6;
	Thu, 20 Jun 2024 00:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: arcnet: com20020-isa: add missing
 MODULE_DESCRIPTION() macro
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171884342813.23279.2393622021304357673.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jun 2024 00:30:28 +0000
References: <20240618-md-m68k-drivers-net-arcnet-v1-1-90e42bc58102@quicinc.com>
In-Reply-To: <20240618-md-m68k-drivers-net-arcnet-v1-1-90e42bc58102@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: m.grzeschik@pengutronix.de, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Jun 2024 09:53:44 -0700 you wrote:
> With ARCH=m68k, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/com20020-isa.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: arcnet: com20020-isa: add missing MODULE_DESCRIPTION() macro
    https://git.kernel.org/netdev/net-next/c/e6fed01554fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



