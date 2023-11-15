Return-Path: <netdev+bounces-47890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED747EBC7C
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 05:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90EF1C20A32
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 04:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7422265C;
	Wed, 15 Nov 2023 04:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fx5X1DEZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5797180C
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 04:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA74AC433C9;
	Wed, 15 Nov 2023 04:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700020825;
	bh=E729oEFS23OgRRnSBOtsjFlpklq/fWND1XFtTohuimI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fx5X1DEZ1oZxnHqUuUxZZNR7/2Kv9m1PvH6cvlmB9TgLh1pp9W5AJngW/c9iQFGLW
	 3/fGdJcxz0qt7yZMjWDOnomwWbuMylD9v/dEOHaPsyrFrd1EX+PTjbjTJb/av+HV12
	 /5Bh2V3TyUwCqvIcgUjSdvUIGrDA943/gsP043EYbO/rNXKGCUIt4e7Aul7QXHkISa
	 2F0b+n0jfRi9oPBY5G17O/7Bo0aK/3oa3og8WUzb8LBcdorzk9O7fwpTviaNjEwhLb
	 fhDSNRXNDsxAciif6jOjWv9rPhdT4H48ukzIxhJxEY2pBNcwwqqN5v90Y1BpEX7y4P
	 Uc9NRgxQfJeag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2A7CE1F670;
	Wed, 15 Nov 2023 04:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] net: stmmac: fix rx budget limit check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170002082579.14036.12947220513761250043.git-patchwork-notify@kernel.org>
Date: Wed, 15 Nov 2023 04:00:25 +0000
References: <d9486296c3b6b12ab3a0515fcd47d56447a07bfc.1699897370.git.baruch@tkos.co.il>
In-Reply-To: <d9486296c3b6b12ab3a0515fcd47d56447a07bfc.1699897370.git.baruch@tkos.co.il>
To: Baruch Siach <baruch@tkos.co.il>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Nov 2023 19:42:49 +0200 you wrote:
> The while loop condition verifies 'count < limit'. Neither value change
> before the 'count >= limit' check. As is this check is dead code. But
> code inspection reveals a code path that modifies 'count' and then goto
> 'drain_data' and back to 'read_again'. So there is a need to verify
> count value sanity after 'read_again'.
> 
> Move 'read_again' up to fix the count limit check.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: stmmac: fix rx budget limit check
    https://git.kernel.org/netdev/net/c/fa02de9e7588
  - [net,2/2] net: stmmac: avoid rx queue overrun
    https://git.kernel.org/netdev/net/c/b6cb4541853c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



