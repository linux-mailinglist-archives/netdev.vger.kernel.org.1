Return-Path: <netdev+bounces-99615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CCC8D57C4
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 03:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7611F24B9B
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 01:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9124B848D;
	Fri, 31 May 2024 01:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPo44rHM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7675234
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 01:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717119033; cv=none; b=oqNd/3A6JcLJ3IFFcC4kKZcVi8wuvGK+tiqJ2+iiXg6VAFUQhGMkFPdDynOI21RHbtsoi8/SqbSrYIir9u274j7CTMuAefrZE609+yItaQcz/r4vS8ORFRE8nrgZbSQ5N28WgahyZ6DVXpR47MXP3+mO7/NqB0rv1liuhEdtDm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717119033; c=relaxed/simple;
	bh=S6HMeJxlmeXPMLhgNx8QBpnY6OZZaO7mFYFvhZWNdCI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MPU2nOMhys7exr9rNQehw2TxTVMaEpThvX3B5j07yt4q5N4IStGUxnwiiaLuXpW+ORU/pqGzcT5R11DVjmSpg+WC6HSREQrY4Kl7FEwUNIUX96VxUMq55fYxrtBaJUbYPt5mrBlZdtL+/gCM4MJMi3yYh4MlsfCeu+g84+1baVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPo44rHM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C071C4AF08;
	Fri, 31 May 2024 01:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717119033;
	bh=S6HMeJxlmeXPMLhgNx8QBpnY6OZZaO7mFYFvhZWNdCI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IPo44rHMRw69Iy4jHpRrwQnPe2Yg++cO/ismJLag3Kk+5Y3ESvOK4QNpe4WgfhrxM
	 hk6o/rTcpnCM3Pir6ztbNuJv+q/Yic6DleTh6Jvre4BS034vOg2cMduky21h0pdeaG
	 of+rwax/pQ88LdjpKzbq5tCn8fewRwJxu2mXwvmLWfuACTFUT3ylIilGR7e23y2qfD
	 3YqI+EEcJCUi77PHSGJXvw9yqsaGwtk8J7qpC96Oc6xZgOx831IW/fgi5FzbiSCz2u
	 5OieopM9zIPgXX7F5u6TkooBMvK2dluKYC88jtLRBRlyKl6ezQBsel5vhsJE8RakcW
	 4Rxks8sxwNkQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8BDAC3276C;
	Fri, 31 May 2024 01:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: fjes: correct TRACE_INCLUDE_PATH
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171711903295.12927.8801867288122729954.git-patchwork-notify@kernel.org>
Date: Fri, 31 May 2024 01:30:32 +0000
References: <20240529023322.3467755-1-kuba@kernel.org>
In-Reply-To: <20240529023322.3467755-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 May 2024 19:33:22 -0700 you wrote:
> A comment in define_trace.h clearly states:
> 
>  TRACE_INCLUDE_PATH if the path is something other than core kernel
>                                                            vvvvvvvvvvvvvv
>  include/trace then this macro can define the path to use. Note, the path
>  is relative to define_trace.h, not the file including it. Full path names
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  for out of tree modules must be used.
> 
> [...]

Here is the summary with links:
  - [net-next] net: fjes: correct TRACE_INCLUDE_PATH
    https://git.kernel.org/netdev/net-next/c/57e3c5af2bef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



