Return-Path: <netdev+bounces-27175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D40A77AA13
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 18:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EC651C204FC
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 16:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B36B944F;
	Sun, 13 Aug 2023 16:30:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD925BA57
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 16:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2ACE9C433C7;
	Sun, 13 Aug 2023 16:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691944221;
	bh=NejHr77MeJVlCEA9AirlydQE+wx9ogG/uCbbgIOFdco=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Sg3Syr77HpexwbxcOlVTvv6eB4Vj8rKAmqKCo+WegBDU+JA+zhvlJpZL5PQ57EvMq
	 RkV44cNp5ARTBA2aNlmA/1VQsj1jueqZfT0N8nTTgwZPx+T51VwgZGp1esl4yUumD2
	 S/wgvrRhqzOQ0dmWVliRQpXqyrWXm7HTtk0mEd9Js/OkMjgHFs3a92nkTOBsSIwTp/
	 xCJ+i/i3IZKwpDGfsNOMAtI62q7pgsRHA6ZC1DtExG6QpposCIELmwSiDFcz3lQZ48
	 /aDCw8uqfcEedQ0iz+NJAR6eXuK+b5FegjJzl1duQyoORlN0jBro+EfJD4fM2DtMkO
	 DuiekN0gMnw2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 12606C39562;
	Sun, 13 Aug 2023 16:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next 1/4] Add get_long utility and adapt get_integer
 accordingly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169194422107.10262.17944160012665410309.git-patchwork-notify@kernel.org>
Date: Sun, 13 Aug 2023 16:30:21 +0000
References: <20230808214258.975440-1-mathieu@schroetersa.ch>
In-Reply-To: <20230808214258.975440-1-mathieu@schroetersa.ch>
To: Mathieu Schroeter <mathieu@schroetersa.ch>
Cc: netdev@vger.kernel.org

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Tue,  8 Aug 2023 23:42:55 +0200 you wrote:
> Signed-off-by: Mathieu Schroeter <mathieu@schroetersa.ch>
> ---
>  include/utils.h |  1 +
>  lib/utils.c     | 13 ++++++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [iproute2-next,1/4] Add get_long utility and adapt get_integer accordingly
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=3a463c152a9a
  - [iproute2-next,2/4] Add utility to convert an unsigned int to string
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=db7fb3f19657
  - [iproute2-next,3/4] ss: change aafilter port from int to long (inode support)
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=012cb5152d05
  - [iproute2-next,4/4] ss: print unix socket "ports" as unsigned int (inode)
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=e12d0c929cf5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



