Return-Path: <netdev+bounces-66096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D05C883D3CB
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 05:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690791F2ADEE
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 04:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0042479DF;
	Fri, 26 Jan 2024 04:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Er8fQwCz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5E51119B
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 04:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706244624; cv=none; b=lkbwMy4052qMvB/GZUpHO+wqIKRkJKZoIHRKT2UOYAKnviHKOLzgStLNJWgkacggQ1FWONFw3Qwuh067Pbu4UX1QREMBG+gvbEZxUoFl3To8CA0I2/4vR4e1hzikta0I79V2Vd6izvF31UMsk5UFF60KDq5CJZw8FQqFGVyjPGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706244624; c=relaxed/simple;
	bh=SYuIjyuF1PCju4KWmNcD9oNqQxoPtMB+yc4LTt/6kCQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J4WNy8okNLrKRv3WSi1jjCAWfM4ok0O5l4qBGRIL8u6nriyTWHWlipkmsqZ9zK4mxZtttu1KGI2kCu24Yzs2BIdnv7M97HmXAJ5DBgPyksZE6XfI5avlsSw47YvQg8Yhr70jIUB+6iDrA6ETGJvBXnmj6txqCBVRMT1TBJIloE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Er8fQwCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62FB6C43390;
	Fri, 26 Jan 2024 04:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706244624;
	bh=SYuIjyuF1PCju4KWmNcD9oNqQxoPtMB+yc4LTt/6kCQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Er8fQwCzcdHZHy9Ua/WBZ7w2aMUFYJd1+a3Iyx+wzl9iGv/FYXtb3/D3WUt84DpdM
	 T2S5XPoq6RFy7rdQ+SChOMaRLZolWRQOn/CRtZptCXcfIHzQE8msHFg7izJi15qp5a
	 wicdwc2NW913Na8+btA+R4HM+sN+xex89thweBigYd7/3qvkaQeEgGstpV58WSW/Kt
	 PL5bmDFIxo5SyR37aQDirmcN7EJ92TNstZMXWRW8c1DjxK215N0iTBEnX7oB4Cf6kB
	 bPAjDJ5zW7besQcLMSII35NTRBUcTQLij05oXfjI3UDX1WMbNLIeJSQajZmfOQPwM7
	 usvdUCkn8d8Jw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A3C8D8C961;
	Fri, 26 Jan 2024 04:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] spelling fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170624462430.3487.3420115219572700641.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jan 2024 04:50:24 +0000
References: <20240126005000.171350-1-stephen@networkplumber.org>
In-Reply-To: <20240126005000.171350-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Thu, 25 Jan 2024 16:49:48 -0800 you wrote:
> Use codespell and ispell to fix some spelling errors
> in comments and README's.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  devlink/devlink.c   | 2 +-
>  examples/bpf/README | 2 +-
>  lib/json_print.c    | 2 +-
>  lib/utils.c         | 2 +-
>  rdma/rdma.h         | 2 +-
>  tc/em_canid.c       | 2 +-
>  tc/m_gact.c         | 2 +-
>  tc/q_htb.c          | 2 +-
>  tipc/README         | 4 ++--
>  9 files changed, 10 insertions(+), 10 deletions(-)

Here is the summary with links:
  - [iproute2] spelling fixes
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=0c3400cc8f57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



