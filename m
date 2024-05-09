Return-Path: <netdev+bounces-94767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC108C0988
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 04:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3061C21621
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 02:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B5F13D263;
	Thu,  9 May 2024 02:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdzQ0vm4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D442D13D25C
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715220031; cv=none; b=qa8sb8bu+NYU+0T/pZuSiMrqdMhGbCtoRRldrQKdqsIkpBmVTrisNzhBrA7/PZy6V+bb3Tba/26yATZPOxXAhdLZWb0bJR1/swHKrtc/meH2tyvs6ictJueIhJHfBDj14qPkDZx9e7b+mQ3nsJ8yaP8Tp2JWVv5sAuiRp8SbWlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715220031; c=relaxed/simple;
	bh=6vc3ClCmB4/2kvFf3y2oeC4uDe8ATPuoF9KK8CkNFu0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FtiOe3b8SgUH/IdFDAwDxDgn4YBz38pWu9Sv8dk5RJWEWjw9INdi4o+5GDDgcOGYKkLLQa39+60SYYyE8BWGu8DmpsbBAu3ZvXbcBxlm82ZouWe418h4D/lcZyp4yXw62XM9uRh+UqG1Cy/84XCfyPY3B0zrOaoPi97EXAr4wbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdzQ0vm4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68B7EC4AF08;
	Thu,  9 May 2024 02:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715220031;
	bh=6vc3ClCmB4/2kvFf3y2oeC4uDe8ATPuoF9KK8CkNFu0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GdzQ0vm4kyUp4SsJfqynMP4UpJcbeAijv4CbDL42j7aZt9uEAz2RfCDV2TmQffyJA
	 Di0X16cO80E671/HwjTCO4qpWkxLnCQaIXR2IdsXoxpbbcQLnN9/tnakKh5e0AS/fx
	 5v+nlKzCqTO56IQCc1Ry2ZiVhCTEomoULiYiuXcrHuK3OihZpuGoZYzT1tYKrGy57g
	 XnnhEJmZsMunnIruo4Eh7gMe55b/FZxTVl1J7hOn7Eqmq52vXB0p/TuTetBecUxRPR
	 g5/7d1tPNkmYqE05oBqqX5ZDC3M3+ZV1M0nZks6TlADzhHqaliSikV5yNwkI78a0Tl
	 iIpjS5MaCVOoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5EFFDC43330;
	Thu,  9 May 2024 02:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: annotate data-races around dev->if_port
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171522003138.32544.7624793111333078694.git-patchwork-notify@kernel.org>
Date: Thu, 09 May 2024 02:00:31 +0000
References: <20240507184144.1230469-1-edumazet@google.com>
In-Reply-To: <20240507184144.1230469-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 kuniyu@amazon.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 May 2024 18:41:44 +0000 you wrote:
> Various ndo_set_config() methods can change dev->if_port
> 
> dev->if_port is going to be read locklessly from
> rtnl_fill_link_ifmap().
> 
> Add corresponding WRITE_ONCE() on writer sides.
> 
> [...]

Here is the summary with links:
  - [net-next] net: annotate data-races around dev->if_port
    https://git.kernel.org/netdev/net-next/c/8d8b1a422c46

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



