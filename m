Return-Path: <netdev+bounces-150946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 152AF9EC25B
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 03:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDBCC2847BF
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 02:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988151FDE11;
	Wed, 11 Dec 2024 02:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgOZ+xit"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F851FCF68
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 02:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733884821; cv=none; b=sKeo1XA5wSAD27d4VhGlk12D4/NoWAnhgYKDe1sOLtb2rDPFalCpHsKk0WGLJ+5ZuV668S3zfCRAEvuB0YojChLLygrgOoLmT73Z3OwlrFcNlBT9cY5KBh7cG/1bGcU0aUuL4PSMkEcggEGp9+yQToX6UK5u8/2mXnfwz9FmfyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733884821; c=relaxed/simple;
	bh=QhIyE5+cWXzDZfFq9ae1FEUk+Ljig84qLcMfApSj/pE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LsG9PO8YX2OBmxIHi5//BuG5BIY1S8/Da1tL/faxlINp6gPcaUcL1Q/6Q5oYArdMwGHGT4j1Q9SYdP0s1BSkupTQHodc7Ycw6xWaukTsMm7RaY8EPvzjBlNPp2tSy7a7V2dd5LkieD87IHb3w1yfR5U5FI0VmTDHD9mkPySEcPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgOZ+xit; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B59C4CEDF;
	Wed, 11 Dec 2024 02:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733884818;
	bh=QhIyE5+cWXzDZfFq9ae1FEUk+Ljig84qLcMfApSj/pE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dgOZ+xit3KlG52p/cDgrxvNhNW9DeVjcXF0EZFr3TO2E8IiQqv2zOoV3jz3pmUJ/l
	 gJZXz/iFi2c9XCJbFCUmJQY8vFdU9vIsByh5c1OJR4Gxhk8FzvMYgCn5xqi+dBbK2k
	 5NDf7gDk0DxEk8JPV4UV7kVmCDoOGgnLrX3MPqbcfO6/X4pSiAdNc8HqJGB1LysOwG
	 AnDWzyvHnJnHplLSiw6jpQcTNRdv+uCz5U8Mk/am6eNzHvFyJeC38FFBWHPgpPd8S+
	 s4xXi/JK0NXREdxwStnR5hxAuzKVRTUI7nRQ9ffBCAb/5wYE6CFN5uk68MSSZ7xDJ0
	 o0nco6leL7WrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB10C380A954;
	Wed, 11 Dec 2024 02:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] Documentation: networking: Add a caveat to
 nexthop_compat_mode sysctl
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173388483476.1093253.6837492627677564205.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 02:40:34 +0000
References: <b575e32399ccacd09079b2a218255164535123bd.1733740749.git.petrm@nvidia.com>
In-Reply-To: <b575e32399ccacd09079b2a218255164535123bd.1733740749.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org, corbet@lwn.net,
 dsahern@kernel.org, przemyslaw.kitszel@intel.com, mlxsw@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 9 Dec 2024 12:05:31 +0100 you wrote:
> net.ipv4.nexthop_compat_mode was added when nexthop objects were added to
> provide the view of nexthop objects through the usual lens of the route
> UAPI. As nexthop objects evolved, the information provided through this
> lens became incomplete. For example, details of resilient nexthop groups
> are obviously omitted.
> 
> Now that 16-bit nexthop group weights are a thing, the 8-bit UAPI cannot
> convey the >8-bit weight accurately. Instead of inventing workarounds for
> an obsolete interface, just document the expectations of inaccuracy.
> 
> [...]

Here is the summary with links:
  - [net] Documentation: networking: Add a caveat to nexthop_compat_mode sysctl
    https://git.kernel.org/netdev/net/c/bbe4b41259a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



