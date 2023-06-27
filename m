Return-Path: <netdev+bounces-14313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22BB740180
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 18:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E391A1C20B5B
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 16:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1FD1308A;
	Tue, 27 Jun 2023 16:40:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A74413067
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 16:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8C4DC433D9;
	Tue, 27 Jun 2023 16:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687884023;
	bh=9sAKz/w99GQ7YaxV0Q2pQyQWA0CCuy4epW7pYlNrcJ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qdOdNu5v7lgA2oM3N7WmUAdKduOrp9BBV4LJInL/tHXk8wPWLixQnTxL/jCBPt8Q9
	 3NOUKul8flcOJHlmHQMbmaygOykHV18tiDFnZjLznTVQmN28gSkOBlqh0NuZ7rsBLh
	 in8a2nOY4OtQOm1gfSVY9vr6g7cA1AaRM1WidGuarKNVyFbyZ0T4SSlzU9pLl1DHs9
	 Oecf6UdlR/S32u29GQ05JrUcLq89r4LLqEh57bYl//+m94NjP2RgeCs7YqFYCmhNjq
	 Kwl501DbU01Tlx1vEjgokVmpszknMuObmkz+8zAVtRJe0glVzPKF1lWEXomnnZ3W2W
	 gtJVz+f73GQ6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8BE10C64457;
	Tue, 27 Jun 2023 16:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] phylink: ReST-ify the phylink_pcs_neg_mode() kdoc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168788402356.21860.7572149702440920426.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jun 2023 16:40:23 +0000
References: <20230626214640.3142252-1-kuba@kernel.org>
In-Reply-To: <20230626214640.3142252-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, sfr@canb.auug.org.au, linux@armlinux.org.uk,
 linux-doc@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Jun 2023 14:46:40 -0700 you wrote:
> Stephen reports warnings when rendering phylink kdocs as HTML:
> 
>   include/linux/phylink.h:110: ERROR: Unexpected indentation.
>   include/linux/phylink.h:111: WARNING: Block quote ends without a blank line; unexpected unindent.
>   include/linux/phylink.h:614: WARNING: Inline literal start-string without end-string.
>   include/linux/phylink.h:644: WARNING: Inline literal start-string without end-string.
> 
> [...]

Here is the summary with links:
  - [net-next] phylink: ReST-ify the phylink_pcs_neg_mode() kdoc
    https://git.kernel.org/netdev/net-next/c/1a3f6fc430ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



