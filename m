Return-Path: <netdev+bounces-152787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 947FB9F5C83
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 03:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1A2516908E
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 02:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B691D6EB7C;
	Wed, 18 Dec 2024 02:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWvSDSbm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704035336D
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 02:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734487217; cv=none; b=pJoASyXYjHXXgm03RBPxXbo2L0j9jGqmdDf5okEWOY1gFQ7z76Js3GrqkeSKz2DNzCPrVLMXVHOl+ETlttGGcpJC504ItBI4zahn8CcafVF3AJv8Vukd91mJQ8Om/PDaoh2Kztt8wa6EqSye+35dzFuw4kWLE32scl8CcrKwOtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734487217; c=relaxed/simple;
	bh=KT0fYllvA3KbR60PMq63QylsL7EftHdRFFZSiwDvGB8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gQZXeM9ytM7+hufw7jW83iat/ibgic91mkwIMX5fRZMvlypIfJUefhrluz45RgFYqP302vUd8Jg4TrlJpi/7ryD6FXpblEiM/SOWjwwodBULvKeiuTFb3lZBrB6sMl9u5fVXPSaVKWeWSkXQ5LiH0YI/O1feHbgg0SCz8N4dnhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWvSDSbm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6222C4CED3;
	Wed, 18 Dec 2024 02:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734487215;
	bh=KT0fYllvA3KbR60PMq63QylsL7EftHdRFFZSiwDvGB8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nWvSDSbmvr4UDElEnL8fJ0BMWV11WE6qAkmxBVFa31nZ90BFO6i6TZI0QlD22FJ+1
	 mjdCEz+bdzlMhFDhwL3MWq4I0DneHG7LaAg3dQ33VZs+jdSg7ItL7dTUKzmLxuaqhi
	 kWNTDLJxeU2pvLu4JN7xJd3Esl/3CQYR6t4OwcdAr3U5qeyIAQGJW5gZ2BcBxx2GVv
	 VTlyc7BD61lgwpve7izXrnhQ3ieUVcKDYwBacFshiWnhuWGgVvt4J1Jcku2b4TvgDi
	 Nhp1ZZ+x1X+qlEoIF5jHW0DIwnU4ncesL9ibPfsNJ3apWWr6NlvKyiFrYGW0jivG+J
	 4xvDi8PgEeNuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 81BE53806657;
	Wed, 18 Dec 2024 02:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: page_pool: rename page_pool_is_last_ref()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173448723324.1148670.10386119885340908217.git-patchwork-notify@kernel.org>
Date: Wed, 18 Dec 2024 02:00:33 +0000
References: <20241215212938.99210-1-kuba@kernel.org>
In-Reply-To: <20241215212938.99210-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, aleksander.lobakin@intel.com, ilias.apalodimas@linaro.org,
 hawk@kernel.org, asml.silence@gmail.com, almasrymina@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 15 Dec 2024 13:29:38 -0800 you wrote:
> page_pool_is_last_ref() releases a reference while the name,
> to me at least, suggests it just checks if the refcount is 1.
> The semantics of the function are the same as those of
> atomic_dec_and_test() and refcount_dec_and_test(), so just
> use the _and_test() suffix.
> 
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: page_pool: rename page_pool_is_last_ref()
    https://git.kernel.org/netdev/net-next/c/d3c9510dc900

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



