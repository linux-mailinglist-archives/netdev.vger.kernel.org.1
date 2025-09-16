Return-Path: <netdev+bounces-223317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37017B58B4F
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 03:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7C381B27935
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 01:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0DA21254D;
	Tue, 16 Sep 2025 01:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdSjEaxG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5961F542E;
	Tue, 16 Sep 2025 01:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757986815; cv=none; b=gAb4bpeZ5haa7YFpa4b9rcfOZUDwII3nOOgm38vKkcJBX9/1U2kqegVL5r0MUhwLs1MFr5nWoBk9UHfQ2BhPvWzqAjiSv83CWawZ9tRTMDrWPzzsF6HdMlM/hy+xHKNNitF7v4lSctl+LgOp/QjZNI+ujOANICedk/216GYV9J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757986815; c=relaxed/simple;
	bh=XEkpR8NWRQZ1eWEHnM8hYiYezDkGF/Zxa6o+qN2kpZg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ek/YsrHFbxPPTqwzeCJM2OojOMILmH9Ph8hTzO6Cjacofvj28Zj5gGxxEOCk8S8ZfZ5CSIZMdGYKvVKJ2DbkzAvgmLUr4N177okbqA9CroKbo+cWZ72M6Ig12e3orbBu+kjf8F4qB6VU4sm6qahJJRAv7C0WWZIxXe1Gnezqfzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdSjEaxG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B54C4CEF1;
	Tue, 16 Sep 2025 01:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757986814;
	bh=XEkpR8NWRQZ1eWEHnM8hYiYezDkGF/Zxa6o+qN2kpZg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SdSjEaxGaLSLA1gG8WFngzR0Os6PDV02sI70IHhG5he4Ws+E4VBxm0Uo8UqjXiOog
	 XHXk+4FMpBJqbTsOEoeWVGM9Qsi2Gd+QdGfoWnxOZhhjxTxSnzFr/+OSUFtIyYgNuk
	 dGLH7RYVOfylunbwvXw1pZt2GtqNewfN6OGCqmr+odBhoqTKWOAZ4WiO14xR2jt9oa
	 CKfJ7+doivHCKENnseF5HKeoW4Tqa+E4H1FpVghKgBOxXyAgf85O8zSmzGtZJ6D/2Y
	 +vvsjTrEeQiFo8foWhPRF7NZtBuPUYYQRlSALvI/YB6qWzCFsKe5VPKzKxteZATRBp
	 FYdSFfFPGeBQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE00039D0C17;
	Tue, 16 Sep 2025 01:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] tools: ynl: rst: display attribute-set
 doc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175798681550.561918.14633148960106754244.git-patchwork-notify@kernel.org>
Date: Tue, 16 Sep 2025 01:40:15 +0000
References: <20250913-net-next-ynl-attr-doc-rst-v3-0-4f06420d87db@kernel.org>
In-Reply-To: <20250913-net-next-ynl-attr-doc-rst-v3-0-4f06420d87db@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: corbet@lwn.net, donald.hunter@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, jiri@resnulli.us, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, chuck.lever@oracle.com,
 jacob.e.keller@intel.com, fw@strlen.de, idosch@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 13 Sep 2025 15:29:50 +0200 you wrote:
> Some attribute-set have a documentation (doc:), but they are not
> displayed in the RST / HTML version. This series adds the missing
> parsing of these 'doc' fields.
> 
> While at it, it also fixes how the 'doc' fields are declared on multiple
> lines.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] tools: ynl: rst: display attribute-set doc
    https://git.kernel.org/netdev/net-next/c/a51126424f75
  - [net-next,v3,2/3] netlink: specs: team: avoid mangling multilines doc
    https://git.kernel.org/netdev/net-next/c/515c0ead788f
  - [net-next,v3,3/3] netlink: specs: explicitly declare block scalar strings
    https://git.kernel.org/netdev/net-next/c/12e74931ee97

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



