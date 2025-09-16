Return-Path: <netdev+bounces-223783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAA5B7E078
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28CD3A12E4
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270C72D372D;
	Tue, 16 Sep 2025 23:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHu9tAeY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025852D0C69
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 23:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066006; cv=none; b=mOOTJ1ycgk61E6HNSceWlKwuZrFewODwYEbDKAoBhUMQNS9tZjsJJL0ix0qWu376GGLMU4mtTl7RkTJUabbuKvJnQ0i3Fyhj/RzkS2H1lb62wJGiPoioR/VpnYljYaYnp39Ru3CKsQ6wVVQqBJl/dJgGb/3i5Jlo0Rvs5k5BXM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066006; c=relaxed/simple;
	bh=ik12/MtUkrR3otIo9jopSJxQAx31McpLb5sqTh3Z/ws=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n99Vab8KIXdJpWgJyvWC9R+7qz5E6h70UYjYgTdwuMdAXEtDmyD+IxrKpZj2q5DTQMvk1rGVIixVWPfuD2om+Cu+ALTDtU4O0bkj3x7pUiZ6RUcKNl6PoCTUJmU6HpvkfuIvZUTVdnM6vpwkycSDQynvxHO4JNGnPXZFwESXG0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHu9tAeY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3F6C4CEFB;
	Tue, 16 Sep 2025 23:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758066004;
	bh=ik12/MtUkrR3otIo9jopSJxQAx31McpLb5sqTh3Z/ws=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SHu9tAeY86r56w8Yf9hFL1KmPmT0w5OPwmE05ZcAZXN+XoQqvpwZAf1HiqLcEpWI2
	 qKEKKCo3muv5Zvv975+C1RycQ06qAIb7V0kuID60sFhOkzio6y9zO5UvPEy2PYQNpq
	 Q2LOAkgb3XLFveUgSuK8leKpzh3Nqj846+CokAT0QfzXUvFScoKMQBTb6LNeHTuX0H
	 8CcHrQxtpnFKtToJDMy3XmkmvQ/mj4H1p+cPgajh8LyfNRgkgs3I/CCDR4+YScyv6b
	 2sR4tYB12+SRrjI5ovT7aqiFhnshLQNt/tVwldCqL8/ytqxz2PlR+0kzjnhkzYBmvs
	 WPt4Veisa8dww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE3FC39D0C1B;
	Tue, 16 Sep 2025 23:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] doc/netlink: Fix typos in operation attributes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175806600550.1401398.6501656421906951342.git-patchwork-notify@kernel.org>
Date: Tue, 16 Sep 2025 23:40:05 +0000
References: <20250913140515.1132886-1-one-d-wide@protonmail.com>
In-Reply-To: <20250913140515.1132886-1-one-d-wide@protonmail.com>
To: Remy D. Farley <one-d-wide@protonmail.com>
Cc: donald.hunter@gmail.com, kuba@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 13 Sep 2025 14:05:28 +0000 you wrote:
> I'm trying to generate Rust bindings for netlink using the yaml spec.
> 
> It looks like there's a typo in conntrack spec: attribute set conntrack-attrs
> defines attributes "counters-{orig,reply}" (plural), while get operation
> references "counter-{orig,reply}" (singular). The latter should be fixed, as it
> denotes multiple counters (packet and byte). The corresonding C define is
> CTA_COUNTERS_ORIG.
> 
> [...]

Here is the summary with links:
  - doc/netlink: Fix typos in operation attributes
    https://git.kernel.org/netdev/net/c/109f8b51543d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



