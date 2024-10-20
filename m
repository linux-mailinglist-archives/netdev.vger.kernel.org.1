Return-Path: <netdev+bounces-137301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D64449A54FA
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 18:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97CC4282183
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 16:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C3E194C90;
	Sun, 20 Oct 2024 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEgobtrm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B810A194C8B;
	Sun, 20 Oct 2024 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729440632; cv=none; b=cLRv4LIk2g2Os5Duqk1mH28TLltYIUk2sImrdq6DZUWbcJPPJ29KaCuqXtVWo8+5v+/OfrAKLcHqc3H3SHamiidoGFTgxIvBKbP2tFyWWYq1+PLxsGtJbfgMcTTmwHTXFigIqUHaspwFBHhLivpP86bnHd467rUulwW3EQOk++8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729440632; c=relaxed/simple;
	bh=yVnx+HBkj75nJ2rVa/9IkwF7i2jMk/szxhnsQUAI/LQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E7P1VYjnJhItbUkXYdOo1nuYphBKQKEtPT/cuffUeKpOvRvO/Grq3SqUyucNpY68FDBt9xERhnDo4kqhlK2JS6Q3TpuzUj9DHertux8muKpejUTgNuWdfofKOHlpp2zRwoaJHqMwFJ3zo+KY1o25fh41JcclleyckJZtJXxWdtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEgobtrm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522D2C4CEE8;
	Sun, 20 Oct 2024 16:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729440632;
	bh=yVnx+HBkj75nJ2rVa/9IkwF7i2jMk/szxhnsQUAI/LQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rEgobtrmkHZhYwC+8y4NXg2T7oNO98xodNId7K4rp+V+ARVRRsdcYBVIbr94U4JZw
	 27gRUpRaGbTRCHv3WsLActqFMhxMHa6O2fxB+k52vKcjE+kfBh33ncT3pydhwZ3ZrN
	 L8Vt4SM6cArTIq8+Hgw2XbinOazE6TchEwd4olwPpfvKerQKs5SQfkPNyElC/IgTr+
	 qn4P9ptIC66qo15xWS89QlSRwPtSiE1mOrAIicrnL+Zg4HVgxMfgK20HMT09wdaZ4d
	 MJaB7/y2e0BDLnr5CknixlyPlhAUzUDigzo8+84JT9jir1ZMrYYXkAzE2KtjYMFOFX
	 3pjptWuSHn+Kw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B9C3805CC0;
	Sun, 20 Oct 2024 16:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v2] net: ftgmac100: correct the phy interface of NC-SI mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172944063800.3604255.8776132775945938229.git-patchwork-notify@kernel.org>
Date: Sun, 20 Oct 2024 16:10:38 +0000
References: <20241018053331.1900100-1-jacky_chou@aspeedtech.com>
In-Reply-To: <20241018053331.1900100-1-jacky_chou@aspeedtech.com>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, u.kleine-koenig@baylibre.com, jacob.e.keller@intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Andrew Lunn <andrew@lunn.ch>:

On Fri, 18 Oct 2024 13:33:31 +0800 you wrote:
> In NC-SI specification, NC-SI is using RMII, not MII.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
> v2:
>   - Correct the subject
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: ftgmac100: correct the phy interface of NC-SI mode
    https://git.kernel.org/netdev/net-next/c/906c68657850

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



