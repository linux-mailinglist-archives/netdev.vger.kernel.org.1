Return-Path: <netdev+bounces-180509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C7AA81949
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 01:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FBE28A4289
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 23:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE2C256C77;
	Tue,  8 Apr 2025 23:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UA31L/QZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D679D256C6E;
	Tue,  8 Apr 2025 23:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744154648; cv=none; b=Ju5TRerkYx1Q3NItShZiAKdi7NyzvIIU8TPJPApXT+6AiE1z7i/VJgdyb6rxCeCy69KHc9MnKwjbfKRl3W6Jsi6aaDJ0besAdwMVUNTFZlBrEnGRMTNEgwmTUscp6UXRwLpbVhE7rKMrUSrZH9a0LGtnvIbB48kmht9pC1xYPv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744154648; c=relaxed/simple;
	bh=zSCbXGFeh6Bwbd5wyVOlRZ8ciWcbSivLfa1CHBy/2AA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=teErodVO8KlBHanZhHxFmIojlZ92e2aRT3c4nZGVTNs+ojTxw/otytqvCY/sOX/CF8GG8a54t0PJAfcjA0Zw71csBWvi/bKb2xN43xefpHuiv+MMGu/Oi3HYoXdc0Hi1JMzTj+6THVNbLoRswlUvQuBn5G95yAn8AP+y8U7GdgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UA31L/QZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED3AC4CEE5;
	Tue,  8 Apr 2025 23:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744154648;
	bh=zSCbXGFeh6Bwbd5wyVOlRZ8ciWcbSivLfa1CHBy/2AA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UA31L/QZAwbFl8ezaNuTcPM67llZHXwPjWxUNCuzaQxMQHh44HBYMKJTRq+DO5LuI
	 6sz2yj9cLlWcbryb/WheUvyfKV3DLJ04Znc1Xm7h2sI4sz7SfeX/UrPR0qgrPBm+DB
	 r8oL1yvcXLWwXJ5KMBh0WyidtP2PdB+3SOjaOAD33RCfnDQldiSIMeo7KDsjEFx19C
	 3wxEjcmfLrK/RF+VqyzkqgzT6VRmgAZrp+S0puor4IHBOQhXZ3MOt8H31m7/hrMjAm
	 3V8Ry9z9Quq04KZ0zOK/RuIny20j0D/I43VhFFur+pM1X7C10msRaIadYTcZSl8vg5
	 qndkYG1332bpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD6138111D4;
	Tue,  8 Apr 2025 23:24:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: libwx: handle page_pool_dev_alloc_pages error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174415468553.2216423.16820728411111346548.git-patchwork-notify@kernel.org>
Date: Tue, 08 Apr 2025 23:24:45 +0000
References: <20250407184952.2111299-1-chenyuan0y@gmail.com>
In-Reply-To: <20250407184952.2111299-1-chenyuan0y@gmail.com>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: jiawenwu@trustnetic.com, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, duanqiangwen@net-swift.com, dlemoal@kernel.org,
 jdamato@fastly.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Apr 2025 13:49:52 -0500 you wrote:
> page_pool_dev_alloc_pages could return NULL. There was a WARN_ON(!page)
> but it would still proceed to use the NULL pointer and then crash.
> 
> This is similar to commit 001ba0902046
> ("net: fec: handle page_pool_dev_alloc_pages error").
> 
> This is found by our static analysis tool KNighter.
> 
> [...]

Here is the summary with links:
  - [v2] net: libwx: handle page_pool_dev_alloc_pages error
    https://git.kernel.org/netdev/net/c/7f1ff1b38a7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



