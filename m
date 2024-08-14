Return-Path: <netdev+bounces-118282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0039695125F
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 04:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1001F21872
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 02:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714922E3F2;
	Wed, 14 Aug 2024 02:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRqMbOpG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446112E3E5;
	Wed, 14 Aug 2024 02:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723602633; cv=none; b=oIvpbprA1DU/TbA2032yrRyWwL4UMrAp4aGl3PYu10FXHDNjrs/bmoV1xduZvGt3xXdQLYmmA/c2VOQ+BcCSgJFGkJzC2nPkVPjg/jJ9FxgRgXe8RfIcDw7jT+A6ZgArFChdl3TJ2ah/QXmKgP4tipCz49Hyjd6j0ScuBhlyEMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723602633; c=relaxed/simple;
	bh=pTXsDROpgeiLeVqrrcK9A3g0rJSyI9w+eE1VQDJ7JL4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sfgeOF2kS1kcAL9NGdQvgs5v7KGL6A0K/K8tWG3iObqh1eB4r9PjDI/cVd7BgMESzuYhfHm+T3Jq94crM8REHf1nROL9qErn4TOjg/Ev2T3Upd87r7zNPinqdEnNbC6U8gn2CMd4fFhIPtX1FIZi8rw6xVjSegkZdEfFwct8QBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRqMbOpG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0834C32782;
	Wed, 14 Aug 2024 02:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723602632;
	bh=pTXsDROpgeiLeVqrrcK9A3g0rJSyI9w+eE1VQDJ7JL4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CRqMbOpG0TqHIkC0Gm9TewUOtkCwBvUuUwTcMdXoPzV1muoxMFfl4MH4f4ri/fHVZ
	 5sJSY4tUnkN510eO83ALMOIStA7gpLsL3uUvoxunyPf5B8cCzvjoY+mef/8QVDFxxw
	 AFH1pS36a4L235msR0UL6uB83UfdQ33tDCpjTY8jVNSPkCNGkef1l+P+s7DlQCyZNv
	 z6Y17+na56fDGUL2GKdrKnpStuFW3uAfWCpZ4ECvZHgSnCagQbNP4dNXEbXqrN0i/J
	 +vOzuJ4VNuzqwO6GVYyVfefY3Js4KGRjhqbE2tCAt8DTY141YKHkV5v/S6viLTI3Bi
	 yBV8SePx+ontA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C0F3823327;
	Wed, 14 Aug 2024 02:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: netconsole: Constify struct config_item_type
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172360263174.1842448.3843615046791513447.git-patchwork-notify@kernel.org>
Date: Wed, 14 Aug 2024 02:30:31 +0000
References: <9c205b2b4bdb09fc9e9d2cb2f2936ec053da1b1b.1723325900.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <9c205b2b4bdb09fc9e9d2cb2f2936ec053da1b1b.1723325900.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: leitao@debian.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 10 Aug 2024 23:39:04 +0200 you wrote:
> 'struct config_item_type' is not modified in this driver.
> 
> This structure is only used with config_group_init_type_name() which takes
> a const struct config_item_type* as a 3rd argument.
> 
> This also makes things consistent with 'netconsole_target_type' witch is
> already const.
> 
> [...]

Here is the summary with links:
  - [net-next] net: netconsole: Constify struct config_item_type
    https://git.kernel.org/netdev/net-next/c/ed4290f39f41

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



