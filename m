Return-Path: <netdev+bounces-224192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FD9B82247
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 00:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F171B1C217C1
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 22:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BAA30E0C6;
	Wed, 17 Sep 2025 22:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCubOdOv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F31C30CDA6
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 22:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758147623; cv=none; b=CY8uYNw9dBlF3kQMfsCrEJJw9PfY3StBNqdSarwh6nv3ebSt9Vp8J5XsxCRyLetha5eJOjklF3K7UbsKE3BNl40gXxUhf6dni2dzbyjUokGqPkHMAC5ShbJmPaHsou8/q/NgBOnQPIk8ckmPOOVGMTVgAuEcPYpvn/PDgFtnWm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758147623; c=relaxed/simple;
	bh=h3oJLbH+JDwAk0rXa/uvZaMd1QUh/HgY9EfIs+4oC38=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eZuFhvtUExb6OUm1J5vLLfxEZfzeK0kuGoC8HWtnZpFQG41mP6wap8O5aB1Yghlo8EZ+sJO28fv7v8MtRQvtfIl7tAbqM8HMoZfFsrOL6UBcQqQMEaDqIrvImy6rflDsPvCucCooG7B1C1tF6D9Jc0YnQgtxbKO19I3k7EM2vzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCubOdOv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38CADC4CEE7;
	Wed, 17 Sep 2025 22:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758147623;
	bh=h3oJLbH+JDwAk0rXa/uvZaMd1QUh/HgY9EfIs+4oC38=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QCubOdOv6iQfscOHA9zR2RuV9NHEr2VCNL233mAcG73rqVZMGblkAm8GlNnS0z0O7
	 bfaof0IkefKaoJ6istX/ILTsjHWMWvlFJQUFUQ3q8Il8Kwcr57cGRQ11crU2ACJLXd
	 Qz5pBxFVlZ7mbyCrivs3rL4iaGHE5tuX1xemjqYwuvsTUntFgZgmaZKuvmMuT0gmKT
	 d4v+mGTHXH+FBjlPgq4XG7DwsdGEQZ2wXpZdxJjWTga4Z2tGCSnwqsd1NYvr+FsIVv
	 ixW3imzK5gQL2ees/QXESH1SY60vQBZHLOIg1BFWF2U9qlGcyRhujzmUjZV6e7AjU9
	 +IlnEEKCuq16A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF3739D0C3D;
	Wed, 17 Sep 2025 22:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl-gen: support uint in multi-attr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175814762349.2168096.2066347081469257572.git-patchwork-notify@kernel.org>
Date: Wed, 17 Sep 2025 22:20:23 +0000
References: <20250916170431.1526726-1-kuba@kernel.org>
In-Reply-To: <20250916170431.1526726-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, jacob.e.keller@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Sep 2025 10:04:31 -0700 you wrote:
> The ethtool FEC histogram series run into a build issue with
> type: uint + multi-attr: True. Auto scalars use 64b types,
> we need to convert them explicitly when rendering the types.
> 
> No current spec needs this, and the ethtool FEC histogram
> doesn't need this either any more, so not posting as a fix.
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl-gen: support uint in multi-attr
    https://git.kernel.org/netdev/net-next/c/4436b2b324ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



