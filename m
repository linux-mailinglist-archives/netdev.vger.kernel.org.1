Return-Path: <netdev+bounces-22899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E9C769D7B
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 19:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202BD2814B6
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 17:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057C719BD0;
	Mon, 31 Jul 2023 17:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE0A19BB2
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 17:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BFBDC433C9;
	Mon, 31 Jul 2023 17:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690822823;
	bh=KwO0p4NhIoEp4lMsE+/NVJla/uPv/cqlzddEla2InPo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jEhX08it29WayZnArxLeUFNxoMqzoWKtDWuIbjZrKR+nCrdMKP5geT2K5ZcM736FZ
	 RounWOoTBJruHw3x758ZCC8WAQ9wVFmDHPT2QQTg9ybPsIZV2q1jS9YZcDCN+COIEg
	 e4xsADlxjI/5CTS6R5RwkDcx1aX1yLdQG1FvSBsPVNWkkowOrY8k6/oeRi4SpeGPrp
	 QcQJ3uWwcrcDk5xVyqGsbYUgmCFKvXhhYnoDcSLLrTmF3100fx8Rm0BWRs47BmxkrZ
	 2LIyMCrnPxSd9A2TlCU/2rjed20tGkkKzHwE3IxBy4dCWheJPtRRy9IG4p6M7EcISn
	 J2R+X91fg1uDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 221C6E96AD8;
	Mon, 31 Jul 2023 17:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v2] ip: error out if iplink does not consume all
 options
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169082282313.13444.10817239556111817211.git-patchwork-notify@kernel.org>
Date: Mon, 31 Jul 2023 17:00:23 +0000
References: <20230731161920.741479-1-kuba@kernel.org>
In-Reply-To: <20230731161920.741479-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dsahern@gmail.com, stephen@networkplumber.org, netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon, 31 Jul 2023 09:19:20 -0700 you wrote:
> dummy does not define .parse_opt, which make ip ignore all
> trailing arguments, for example:
> 
>  # ip link add type dummy a b c d e f name cheese
> 
> will work just fine (and won't call the device "cheese").
> Error out in this case with a clear error message:
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v2] ip: error out if iplink does not consume all options
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=84ffffeb0a2f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



