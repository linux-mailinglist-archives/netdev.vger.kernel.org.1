Return-Path: <netdev+bounces-249668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B887D1C165
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 03:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 446413042FFA
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 02:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A832F25F5;
	Wed, 14 Jan 2026 02:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8Aaq2vL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923381DEFE8;
	Wed, 14 Jan 2026 02:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768356214; cv=none; b=DzwwamUtK5fia4xPmzaoDuVDyqLgXJS6sQIVd3NIvz0gYHy1wMFhfJihVA9CElbU2mI39uJjjJkqD8JHM/wTeOXXu0h/3Iy5IZi+N1GwXqmgAKXAIF87ePmYrBersrTO+vDX95gvqf01OHNOycObp9l/HyyLpNXB5dhYtHMUt58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768356214; c=relaxed/simple;
	bh=hRQB1UN035LGpCXnb57AA7CPA5AyZY/97oE7Q2wvHuI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V+aDlSlP9XgcNO/UGR5V4CJytPwXGk26fRPa34h/VBTFkDmwBVkk26xXSfxbIUJnHd3Uu6BRPPaPHqlI2qmMBLcBblsgbLAczLAmPuLG2QrKP8WX7DcLcc45egVw3R4TNnI664Bd4aQWhjQNpKMCD85tEPHZ/UzeIJAOogLGwhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8Aaq2vL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD31C19423;
	Wed, 14 Jan 2026 02:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768356214;
	bh=hRQB1UN035LGpCXnb57AA7CPA5AyZY/97oE7Q2wvHuI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P8Aaq2vLfvBCFvWYCvXZPfBKz5IvuI5O14UCjAIjtsdzpqAETY93FKMgA2kmlKLbr
	 FL/uV1BmVPLQnExKN2UG6pqU/+SFP+wGGdtHobf/jcItzMn1q/uub1Ol5uT+jsGE/y
	 ZkI9W27CeVT1MQ+6E6fjU+iqsIDodgfadkwhetCRqZ34ZDODja4+DdbDcTYB2tv5Ha
	 CHMAd/NeekBZJccQSKSZ5vQLncW3lVjMx0ds0d6wWY6rZVGSlsQEk3iiNRDsP/fhPP
	 L2YqmbILzTOpc8TLR87PEfBGi0xTGFuug0JyQrpEFx0CL5slmjt+Ywra7HeeqpbSkE
	 kJyKlX2PLxZuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78AA63808200;
	Wed, 14 Jan 2026 02:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools/net/ynl: suppress jobserver warning in
 ynltool version detection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176835600729.2552644.984597436881960695.git-patchwork-notify@kernel.org>
Date: Wed, 14 Jan 2026 02:00:07 +0000
References: <20260112-ynl-make-fix-v1-1-c399e76925ad@meta.com>
In-Reply-To: <20260112-ynl-make-fix-v1-1-c399e76925ad@meta.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bobbyeshleman@meta.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Jan 2026 19:56:31 -0800 you wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> When building ynltool with parallel make (-jN), a warning is emitted:
> 
>   make[1]: warning: jobserver unavailable: using -j1.
>   Add '+' to parent make rule.
> 
> [...]

Here is the summary with links:
  - [net-next] tools/net/ynl: suppress jobserver warning in ynltool version detection
    https://git.kernel.org/netdev/net-next/c/69cb6ca52da0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



