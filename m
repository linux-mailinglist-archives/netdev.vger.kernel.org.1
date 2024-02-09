Return-Path: <netdev+bounces-70669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B33AE84FF24
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 22:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4951C1F22129
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 21:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E35C1B942;
	Fri,  9 Feb 2024 21:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BABzSS+M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D73107AA
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 21:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707515429; cv=none; b=RdtTogLdzCyx6aZgGRny0yZGHtZLer9jHNIWaKOMlX65ygg0DmdqSZR39iKe4su1QFAblfN7KlQMS+uanlSxutTaN60RhHOX0VTuiWgrJ9JXwXRw2bhPjCn6+eTyKmW+jkitQ+mecBQAMAEGuCnSNrbQae5Jv19kHHNp6aGGJqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707515429; c=relaxed/simple;
	bh=03lC8i+ra2NA7MTF0LiIswaD96S0/RucClJQaRZ5JyU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gbBGxIkijwwm0nrUcsR2K1QyMeCCTX45U2h5xi4skLYv159f3nzFCWKUNbrhQVU09J8OiorK7amUf/OekGbH8vO6jUTAQkvQVhoP2Xg5/w2sm+gAYXlS813Ia+2Vr301y3GGfV8bQenCOUIuQBBdd1XjsB6uF9oarR6Cq4hKuBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BABzSS+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF591C43390;
	Fri,  9 Feb 2024 21:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707515428;
	bh=03lC8i+ra2NA7MTF0LiIswaD96S0/RucClJQaRZ5JyU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BABzSS+Mxrw8JfzlpC05tZALLK7pkiIx1Q9Tk3JP21iNK8Vyq97WGoTKMVeue76mD
	 fLCtCYvd48R0RH+XxcdeClIxejwL/QRmDUyg1qgvQMY1dI8BVrCKpIZsiMUQtrTCNC
	 adejSbHErxG78r8nTrk1tYp5ZVACu1h5DnhDzCFNI50FikchFjbQX54wyJQeys497h
	 qyABhi3aCNYrW8VBQbD/7vJ8NyAIiSxQDqcvFH8ajhEHadEKMyfggXjKHvonxhuFkW
	 LpaEz0N0MehNN+26Vi9lD+qNdCs2T6EvgeoGTq1Crsf37SXlvQVbV3aYSK2jfKKNMU
	 bzVcYGsi1+X1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ABD4CE2F312;
	Fri,  9 Feb 2024 21:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: atlantic: convert EEE handling to use
 linkmode bitmaps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170751542870.4610.14226771093605575811.git-patchwork-notify@kernel.org>
Date: Fri, 09 Feb 2024 21:50:28 +0000
References: <c5a61d57-d2b0-427f-93b3-fcf7721165f3@gmail.com>
In-Reply-To: <c5a61d57-d2b0-427f-93b3-fcf7721165f3@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: pabeni@redhat.com, edumazet@google.com, kuba@kernel.org,
 davem@davemloft.net, andrew@lunn.ch, linux@armlinux.org.uk,
 irusskikh@marvell.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 7 Feb 2024 17:41:19 +0100 you wrote:
> Convert EEE handling to use linkmode bitmaps. This prepares for
> removing the legacy bitmaps from struct ethtool_keee.
> No functional change intended.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: atlantic: convert EEE handling to use linkmode bitmaps
    https://git.kernel.org/netdev/net-next/c/32b803334f0b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



