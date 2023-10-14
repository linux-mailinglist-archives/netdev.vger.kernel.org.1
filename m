Return-Path: <netdev+bounces-40918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AD77C91C8
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 02:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED372282EE6
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 00:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE5965F;
	Sat, 14 Oct 2023 00:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8KXxVtr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA051112;
	Sat, 14 Oct 2023 00:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11923C433C9;
	Sat, 14 Oct 2023 00:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697243427;
	bh=Sc9W8OXHyJj8/6hKSufokis8j739xxmwqoZ1WCdjwMk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J8KXxVtrPaVulk18GB8r/MCiIiuCxJAfaHYW6cHQOBFBElp38dTD2UAx4Y+zbRY+y
	 4QDfBmQHKU//BRjsrUKwnE8WlaaWnZuJUS0iN71yCZiaDRKsuJSTS5fAcs5FDVOD0a
	 /3OiS1E4hJwfrCe29FFLGT2NCjf+H8yBr3o4iZ+1o3PPnTOnil99sYUy4C0NUv01mX
	 M77Ev0rfyf/MWlZFf/Sg4cTVZuNYMDBT5ROJtvHUdCwhOv8kQ5XsgCQIlKEgxBccPu
	 Ecrs0JgTWn7Ow/8iaectUD7ALrZJ/u9dnwt5RlkiJ7zkABYTreN7bW7j7G4HoOZSZ5
	 dOWnTKZxpKvcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E337FE1F66B;
	Sat, 14 Oct 2023 00:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/mlx4_core: replace deprecated strncpy with strscpy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169724342692.24435.15302817559300342474.git-patchwork-notify@kernel.org>
Date: Sat, 14 Oct 2023 00:30:26 +0000
References: <20231011-strncpy-drivers-net-ethernet-mellanox-mlx4-fw-c-v1-1-4d7b5d34c933@google.com>
In-Reply-To: <20231011-strncpy-drivers-net-ethernet-mellanox-mlx4-fw-c-v1-1-4d7b5d34c933@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: tariqt@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Oct 2023 21:04:37 +0000 you wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect `dst` to be NUL-terminated based on its use with format
> strings:
> |       mlx4_dbg(dev, "Reporting Driver Version to FW: %s\n", dst);
> 
> [...]

Here is the summary with links:
  - net/mlx4_core: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/88fca39b660b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



