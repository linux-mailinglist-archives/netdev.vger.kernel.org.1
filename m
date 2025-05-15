Return-Path: <netdev+bounces-190585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B522EAB7B58
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 04:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F419806ED
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 01:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C355928751E;
	Thu, 15 May 2025 01:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KT97T3sq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9507541C71;
	Thu, 15 May 2025 01:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747274395; cv=none; b=UnHnUyXNUsyyPWERy+bYPAtGKQkXW5ryRsu9bKDiHYDs9NFAdHjiIKGla1dVbSol1jpo+06ueAH3fjaqfc3OY2y3dFzuaEpe9D1FYspra412Et4s5FH/bRGch7cT1UtfCrsiuu+f898J+D5iXK9VvgUBlUKHOOq4XfE+1CGn2MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747274395; c=relaxed/simple;
	bh=ZSaRSMY8mrF5Lr9Z0tBd7ntXVliJF47zo9znQaJcDQM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gG1N/fbvSl0XMrwlv6ibVEkBZ7xZbYJI238iC4nLpyliig87qu/6DUF4Umw1sAevPiVTmbo/DoxQNwqHIoAWw/4JRHgkAnvhY04FOlcA/uQWH4UptxSwiKN2fSqfbJCvrYzgSrxbqeKFX9nYg9YvZDEPFFpyDWI2OwqjptIvzmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KT97T3sq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4160C4CEE3;
	Thu, 15 May 2025 01:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747274395;
	bh=ZSaRSMY8mrF5Lr9Z0tBd7ntXVliJF47zo9znQaJcDQM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KT97T3sqA4Fc1SwOCkloHXWNkQt6F6fKE7R009N4JQEaQ7jSeQdmAG/uTR2LaHcEw
	 ppoFHkK9H3nYH4EoJAgw44fxIjdTnmtbn+Cr2A5GdhrX6pgNPQXj4uvsUsLkFEfGdf
	 KCqMCsw5BKmXwdvQOKoqkTSDlPSnNQEAyrvEJUTq6TPMuFf7iD1ZLdtgOQhLZAuIfW
	 Vme/+U2V+G6Qy7eyHsvm/2fqg3TYnDoStWTsRCG09sgjFXdl3z/8isB3B8KvgKjMCX
	 CYLewiLoFj2EPrjKxxigxBHYXhPgWdIuwBaiO4lA49B2l1EuNxPy34XGHxRX1jvNbj
	 3zVtLrIwhHLcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C9E380AA66;
	Thu, 15 May 2025 02:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] documentation: networking: devlink: Fix a typo in
 devlink-trap.rst
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174727443200.2577794.627412956587602762.git-patchwork-notify@kernel.org>
Date: Thu, 15 May 2025 02:00:32 +0000
References: <20250513092451.22387-1-alperyasinak1@gmail.com>
In-Reply-To: <20250513092451.22387-1-alperyasinak1@gmail.com>
To: Alper Ak <alperyasinak1@gmail.com>
Cc: kuba@kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 May 2025 12:24:51 +0300 you wrote:
> Fix a typo in the documentation: "errorrs" -> "errors".
> 
> Signed-off-by: Alper Ak <alperyasinak1@gmail.com>
> ---
>  Documentation/networking/devlink/devlink-trap.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [v3] documentation: networking: devlink: Fix a typo in devlink-trap.rst
    https://git.kernel.org/netdev/net-next/c/4abc1f14e2b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



