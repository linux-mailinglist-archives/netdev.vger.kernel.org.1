Return-Path: <netdev+bounces-214926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7C8B2BEF1
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 12:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0F423B8ACE
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 10:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D170322552;
	Tue, 19 Aug 2025 10:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujulMw9a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549D6322547;
	Tue, 19 Aug 2025 10:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755599396; cv=none; b=G6RHfeowsokb/8XJJPA1Ea7Uy9ugqPQjiBC0LeBqM1H1JRJzj2ZdWGtVrDaPM7fIRdC3d24veNLuSv4QPwMW7QzeThmxZAgCdFaNUptG4cuOo50O1CNfUo9QeQkX2TYqwrOCYwVUi5FNqQ5cxHdWOiNZcrgtakjykvnwrTNKhMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755599396; c=relaxed/simple;
	bh=chtVlqNA4W8+qeCTam+hfj759O2lJY4TyQIcnPBGzm4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M0X7KvNbPEEWEORUDPAELpis1BVYgt9xWp7hna0mXe32jh8nFZYHoHN0Ux2nCkjLAT6ZGeD9iHZqUSZKUAvq8Rcw3rAoeU5yUOtFZso5q2Z+rk/GtWpaxAlSFc0mU7PrOPl2hgDXDuRf+pnXvSNQH0o8pHgF+N+IlzzgpiKohmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujulMw9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF81BC4CEF1;
	Tue, 19 Aug 2025 10:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755599395;
	bh=chtVlqNA4W8+qeCTam+hfj759O2lJY4TyQIcnPBGzm4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ujulMw9aIo6V05WVmJvWf4Y7efZVrsOouPH9VFwvuSlPtOPNfJzDrUgyFoPCGb9Q6
	 2kdzAUiJspHn8dGtGgzMgBLaPiNLZwMR+zeKFODSKEoteuBHJVFr4ZfsWtpQR4/uFA
	 qPYlFVUkC2+QdMPCot6cmDpmPvLxwlHAkAqBpGKc6Rm96B43puFmB2SddyG9iV6PCp
	 Y37kCGXFlOEFZzOPYpqDAE5FjOtZhFG/G5Oxihz5WIXU9mJ1YnevaZBRDL7vzfzlNt
	 w393AYHzcs2mSvJcbNQjOz3l2SfA8ANnI+qPgRLMBf4jXUz4Ei+4HzWJYz+/aF1QV+
	 zUpt73nFMj7Nw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD53383BF58;
	Tue, 19 Aug 2025 10:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ti: icssg-prueth: Fix HSR and switch offload
 Enablement during firwmare reload.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175559940576.3486708.2946674599045363041.git-patchwork-notify@kernel.org>
Date: Tue, 19 Aug 2025 10:30:05 +0000
References: <20250814105106.1491871-1-danishanwar@ti.com>
In-Reply-To: <20250814105106.1491871-1-danishanwar@ti.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, m-malladi@ti.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, srk@ti.com, vigneshr@ti.com, rogerq@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 14 Aug 2025 16:21:06 +0530 you wrote:
> To enable HSR / Switch offload, certain configurations are needed.
> Currently they are done inside icssg_change_mode(). This function only
> gets called if we move from one mode to another without bringing the
> links up / down.
> 
> Once in HSR / Switch mode, if we bring the links down and bring it back
> up again. The callback sequence is,
> 
> [...]

Here is the summary with links:
  - [net] net: ti: icssg-prueth: Fix HSR and switch offload Enablement during firwmare reload.
    https://git.kernel.org/netdev/net/c/01792bc3e5bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



