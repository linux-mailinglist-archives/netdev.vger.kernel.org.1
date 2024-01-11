Return-Path: <netdev+bounces-63118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6BC82B417
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 18:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03F09B23C0E
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 17:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39DE51C4C;
	Thu, 11 Jan 2024 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNxrVUKz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A81E51C33
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 17:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEF34C433F1;
	Thu, 11 Jan 2024 17:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704994227;
	bh=5dtLtUj+pWWXQtcfdm/n2g2U+ihJXWy7+Q8oXM55yWg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QNxrVUKzglDM54Zuz/Qse7tjQT+JAj9wJ1uaZuR4ZdCSDFhs3hCAf0QP00xVlKPYr
	 iP20tSv8EJ5ltBbgge+DgdduYaunUANmVuMrhbLCdWLLLwdoIJQaTmiM7Kra7vrAz9
	 j200Iv2f4NPvhi4N81XjnEtQ7TWWn7RfjYEpUfnreA/Z0ekawBtAtiknIrOK0XxUUX
	 pFq3QzfSlOxqdlgQDQaJrFqClMBkL20is8UwN6gva3QLalZXFUhovmdrwA63klAJIv
	 nJlqr0rEWyfWPux4ocKMXsCEGLW624w40RXUhT+biMzDhTl7xQe6eJYaL7lUivPsuD
	 nb5hS6+eXb3JA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4E9DD8C96E;
	Thu, 11 Jan 2024 17:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2 0/2] Fix typos in two error messages
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170499422686.16240.15466600665607630798.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jan 2024 17:30:26 +0000
References: <cover.1704813773.git.aclaudi@redhat.com>
In-Reply-To: <cover.1704813773.git.aclaudi@redhat.com>
To: Andrea Claudi <aclaudi@redhat.com>
Cc: netdev@vger.kernel.org, hadi@cyberus.ca, stephen@networkplumber.org,
 dsahern@gmail.com

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Tue,  9 Jan 2024 16:33:52 +0100 you wrote:
> Fix spelling for "cannot" in two different places.
> 
> Andrea Claudi (2):
>   iplink_xstats: spelling fix in error message
>   genl: ctrl.c: spelling fix in error message
> 
>  genl/ctrl.c        | 2 +-
>  ip/iplink_xstats.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [iproute2,1/2] iplink_xstats: spelling fix in error message
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=ba0d6e6d7dac
  - [iproute2,2/2] genl: ctrl.c: spelling fix in error message
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=05a4fc72587f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



