Return-Path: <netdev+bounces-249252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED977D16471
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 03:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8761F301FF51
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 02:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2B915624B;
	Tue, 13 Jan 2026 02:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlSAIBe9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC49E55A
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 02:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768271431; cv=none; b=ZdbOuYODh1E1xeWHPVrY+L+SjcesorgIy4bzSkaYPMBtfAhpve+dN1GJ3JjMBvTxa97eHkqx9IQ25dqG2XQlJyUZNjsur5eHC7VIogb+p7NXw6yb8Crzxk5yepwqESUO0s39Of1D2KuicqjZiyqK155+cioTXj7Z8rfPP5NFvHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768271431; c=relaxed/simple;
	bh=uCrHT4RBYNmeBZpoN9d9RytY6JlLQ4reuhvBL0KHnAY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GljJAUx+W64SPClQXvy4qHN+ZJWopsRFEtU5QAoct8yu1Vr871yFE0JFxchVqczyYRB+EnmOJuWcs1MxuM9pq/+ncK/aTjidbaA1gI+a9mtOTYH2DORLGe87T+gojcpbghr3ysRkk+uhEo4zBjhjFZsHKziktzQCMO4D5KMx1Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlSAIBe9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4430CC116D0;
	Tue, 13 Jan 2026 02:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768271431;
	bh=uCrHT4RBYNmeBZpoN9d9RytY6JlLQ4reuhvBL0KHnAY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XlSAIBe9AI+jC05Qnn7YX4w3DJq2Xy3FUA9CxohZYG69hZ58vqvaMN0NVWBclYgv1
	 VVR2S5L8+iyL0uYFEA9aKeci5chAXFr3AShlrpMI7seTPZl4yQu+W+NZCDo57BCEQk
	 hV8pS9LOy28ElracB/P419jWsLvf8Vw3hKwicgYP5KL2z70SyzDnS6Ok3Nwk4WlB14
	 7OTB6tysJmjecdmg/m1Mi7z/YZSU+fgfYolN8WJqKPQ/wsgrejL/CVHmuv43ddZyaA
	 HRiiQIo7ucSX8TTgGQauU+D8QVR3wHX28SjOznjlPdKeIoAvYLK9JWSVCfKBaMJRhm
	 cqAyt37GJd84g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B5C4380CFDE;
	Tue, 13 Jan 2026 02:27:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/7] tools: ynl: cli: improve the help and doc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176827122479.1606835.12758392924343782670.git-patchwork-notify@kernel.org>
Date: Tue, 13 Jan 2026 02:27:04 +0000
References: <20260110233142.3921386-1-kuba@kernel.org>
In-Reply-To: <20260110233142.3921386-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me,
 donald.hunter@gmail.com, gal@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 10 Jan 2026 15:31:35 -0800 you wrote:
> I had some time on the plane to LPC, so here are improvements
> to the --help and --list-attrs handling of YNL CLI which seem
> in order given growing use of YNL as a real CLI tool.
> 
> v2:
>  - patch 2: remove unnecessary isatty() check
> v1: https://lore.kernel.org/20260109211756.3342477-1-kuba@kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/7] tools: ynl: cli: introduce formatting for attr names in --list-attrs
    https://git.kernel.org/netdev/net-next/c/21eb90fb5fbc
  - [net-next,v2,2/7] tools: ynl: cli: wrap the doc text if it's long
    https://git.kernel.org/netdev/net-next/c/101a7d57d518
  - [net-next,v2,3/7] tools: ynl: cli: improve --help
    https://git.kernel.org/netdev/net-next/c/1b7fbf62ad8b
  - [net-next,v2,4/7] tools: ynl: cli: add --doc as alias to --list-attrs
    https://git.kernel.org/netdev/net-next/c/aca1fe235c10
  - [net-next,v2,5/7] tools: ynl: cli: factor out --list-attrs / --doc handling
    https://git.kernel.org/netdev/net-next/c/45b99bb464eb
  - [net-next,v2,6/7] tools: ynl: cli: extract the event/notify handling in --list-attrs
    https://git.kernel.org/netdev/net-next/c/6ccc421b1461
  - [net-next,v2,7/7] tools: ynl: cli: print reply in combined format if possible
    https://git.kernel.org/netdev/net-next/c/60411adedf70

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



