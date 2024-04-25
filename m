Return-Path: <netdev+bounces-91440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDB38B28FF
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 21:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE4D21C21115
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 19:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06D21514FE;
	Thu, 25 Apr 2024 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWR5EvXJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7632135A;
	Thu, 25 Apr 2024 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714072968; cv=none; b=E+Eo3qIzZH/Z6a9ZhFfTThBocppz0p58MsAYKnvUn0F1D+gGNhQ/PmGnKHcNYj4XzVal5yy1vZiP+732K+qn/1OEC2RTml4R2QoM8kPc12AGJm0siAI6fM22ZnEyGuwkufjmzX1VV5OPZBb9PQi7VtYVpQr5ci3ajkYbEHcFugw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714072968; c=relaxed/simple;
	bh=ly2U3FsQ3oo2corGnFD/pMUYIGReX5Du/wLky8NQP+w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JuHdKP2nLNMeSUTZg1u0aSANXUUxB4E+Z3oq7YJL9VcjbMRVM7lQ0aVAAbytfRAozjUwyrci/OBmLwiZF6WXfxEc1ibKE0NJkjeeGsCRO0HQL+kStibAzScP2gSsVvJ/fhzpMgZAO0RAqtofk7dnEdF27TMKSmIpqg+I3w2xQdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWR5EvXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F12CC113CC;
	Thu, 25 Apr 2024 19:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714072968;
	bh=ly2U3FsQ3oo2corGnFD/pMUYIGReX5Du/wLky8NQP+w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bWR5EvXJyEUmapvfE3uQ/u16nQWsWRFqJykiSyp/mOeWM/EHajaeDdpcJx7eQP7DT
	 eA+PID7KMfocEK2wZ3UZMq24nH75G5S9r4zGCWBJJONtxjtI61eZdmDGtguiLXW5zi
	 yaQ1EeKZhzN5Sx1rpe5lp3YKEOTLDMbAYo+fpUNEPeyhz9ll6mv9W9S/tL/QKGCJSQ
	 eFtYS4HjIgYlx7CagsQ3SQluJvRI4f477P1yWYV3EJv5KDsnxR0ouezQSKFAciJgT9
	 C4e1wn8xZvnsEtEqMz6qOv5S/bt/UDEG97MjuPsCPa1TwZIRSmNd7V/i3aFXp93dLv
	 SKuy36nbzc7Mw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96F44C43614;
	Thu, 25 Apr 2024 19:22:48 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.9-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240425172516.2251761-1-kuba@kernel.org>
References: <20240425172516.2251761-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240425172516.2251761-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.9-rc6
X-PR-Tracked-Commit-Id: e8baa63f8789d34b5c2e61f36ab60d693b65b1dc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 52afb15e9d9a021ab6eec923a087ec9f518cb713
Message-Id: <171407296861.14238.5610119400350919202.pr-tracker-bot@kernel.org>
Date: Thu, 25 Apr 2024 19:22:48 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 25 Apr 2024 10:25:16 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.9-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/52afb15e9d9a021ab6eec923a087ec9f518cb713

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

