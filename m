Return-Path: <netdev+bounces-46003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 359737E0CFF
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 02:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C8A31C209C9
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 01:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF7710E6;
	Sat,  4 Nov 2023 01:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVVJTP2H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492727FF
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 01:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3F64C433C9;
	Sat,  4 Nov 2023 01:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699060225;
	bh=L+k4t9hWsiprRqdXcIHMWHkFSNFyQFhx1LWJXLK3yR8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TVVJTP2H60fiC6q6faEphcIUlZ22eRT9vvFYfutiNLbRuoOUSCD7d+iR4giHXax34
	 CnCAJVqMAbx//gNTVjOQeznFrkFpXYUsCg7Agn20+QGWWaouuluFynw3LW5OLe9iQM
	 Edn2de/wG/SsscDzQ0zI/UooqntgRD8VyVGOYJauejuLPmnm5ZxXAgbOg0WPpYY7t0
	 0YDijxIbVD3wFtA7/bN5tVho7x4i35IgAieuTOvv340/gHSJaOa6S1jm2w0dCM/9mc
	 2hsRsy0+XHuZfa0ycnwB4enDVO+LkeH+tZdhHcgNhbZdOJDZm3DKIqUUjo1D80O7NK
	 CadfZVzcUnK4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96F5EE00086;
	Sat,  4 Nov 2023 01:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] ss: add support for rcv_wnd and rehash
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169906022561.27075.4252385690829158342.git-patchwork-notify@kernel.org>
Date: Sat, 04 Nov 2023 01:10:25 +0000
References: <20231031111720.2871511-1-edumazet@google.com>
In-Reply-To: <20231031111720.2871511-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: dsahern@kernel.org, stephen@networkplumber.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, ncardwell@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Tue, 31 Oct 2023 11:17:20 +0000 you wrote:
> tcpi_rcv_wnd and tcpi_rehash were added in linux-6.2.
> 
> $ ss -ti
> ...
>  cubic wscale:7,7 ... minrtt:0.01 snd_wnd:65536 rcv_wnd:458496
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [iproute2] ss: add support for rcv_wnd and rehash
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=ef335508a8e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



