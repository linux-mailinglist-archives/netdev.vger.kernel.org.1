Return-Path: <netdev+bounces-86811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A008A05B6
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 04:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0910B1C21E57
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 02:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AAD626DD;
	Thu, 11 Apr 2024 02:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8bbmzux"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9886215F
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 02:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712800836; cv=none; b=clOy/8MZAUkITgwvoV0kfyCxt/CxWpdM3G3zobL+Mh5YiRp531IsZmt1RrsuDfuKeMvZaLugR2scm73Px1j8UB2KEZaDQknghp5xmXXMQ3gSH37h3PmGpDiZ9Jb6613NatLmln0HF3azr+sINGDxk7zi8jTSX0RCqZFn8TpbFFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712800836; c=relaxed/simple;
	bh=6gnx++g1IleqIogVWlz5BB7v5zBarNdK0Vxh3WS43Mw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Uus7M4YJ83tU4hnKxD5+s28gjEPXccJ5TawR8hk2loX9BgtlOptNCkF2d/aMHnEkkn8qzt7AjdbD5OIv7tD8nweUXLGvJnqjLM2uJfmsxMFGJwAMHPK9zhYaRGWIlgyysYu2oCxGLnj5+lmfYP8s5HirLgMnOWwqRzILRHfE8OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8bbmzux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AED3FC43399;
	Thu, 11 Apr 2024 02:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712800835;
	bh=6gnx++g1IleqIogVWlz5BB7v5zBarNdK0Vxh3WS43Mw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i8bbmzuxj1F7OM2G6LOjY+hMIo31OR8p3OPW62saS7zdWBdDFHx/02eq6+UBhrXr3
	 M0VJLUd9Z9zgkSB7TuYJ2UvaDq2oSiKNDUanJUk+1LB5Pvy3Q5ood2bvphqDyDqpPU
	 kiZnHm5NdS93/nRZ/8YojOArk00VMiVGewuMU5ubq9iOEbq9OK7Fb0fZdPQEEe7hMT
	 vWtzNNwUa0MqyQ6XrNx+bJTQ2vPXjSsZtVePqrn+pH1k7L8XN+tRpLmu94lLIPnPee
	 nhcpwHusTjVJRmMOhZYacmgIPr4XjYEqc1VkaGMyYVWNqfQu2KQFirmd9047c3XZGL
	 pVDam9bf/LCkA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A4817C395F6;
	Thu, 11 Apr 2024 02:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: tweak tcp_sock_write_txrx size assertion
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171280083567.2701.9901992509841799932.git-patchwork-notify@kernel.org>
Date: Thu, 11 Apr 2024 02:00:35 +0000
References: <20240409140914.4105429-1-edumazet@google.com>
In-Reply-To: <20240409140914.4105429-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, lkp@intel.com,
 vladimir.oltean@nxp.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Apr 2024 14:09:14 +0000 you wrote:
> I forgot 32bit arches might have 64bit alignment for u64
> fields.
> 
> tcp_sock_write_txrx group does not contain pointers,
> but two u64 fields. It is possible that on 32bit kernel,
> a 32bit hole is before tp->tcp_clock_cache.
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: tweak tcp_sock_write_txrx size assertion
    https://git.kernel.org/netdev/net-next/c/9b9fd45869e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



