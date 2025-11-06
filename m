Return-Path: <netdev+bounces-236472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EB841C3CC66
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 18:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5886C4F06C1
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 17:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8221A3431E6;
	Thu,  6 Nov 2025 17:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c84W3GkV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6442E7F22;
	Thu,  6 Nov 2025 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762449256; cv=none; b=WNkd83OScKNQc7N3M67wxhXrFLW1jTMXxCAiKvBLfoWxh1TVQZ5R4Vp6RAuPeUMoKLWnrJefT8GjkCV3w6aKYYsz88LoAyvN0GqMy2aaso+NAEtlY06V//5gV8ZjK+nUU0by7GWnfn0SprMoJWlTlHIW1EHtJibxZZddlgWyuJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762449256; c=relaxed/simple;
	bh=EqB7RdqWp9d1/ZPOg8KzZ+wKzAyj/zzi7GOHdzU1J5g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jI4xRvPkeMhGSrF8NGNwqMNqFgzb4LofU55lpgWIN+Fwjl8wa9x/rOLuiQoV1+HAsEDAWBUW3LhCH/eDOR8qvuZ42SYM73XzPPTq3O95972FmGuVFiQXD+ZQGH7W2YB/hpoc+uCG+BX7KH9bYq3+Uqxp4cWOyRdCko7jcqZK3fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c84W3GkV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3313C116B1;
	Thu,  6 Nov 2025 17:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762449254;
	bh=EqB7RdqWp9d1/ZPOg8KzZ+wKzAyj/zzi7GOHdzU1J5g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=c84W3GkVsdv1X5HNtl2JVh0RXv6i7sA1RWjgqMMFMVcRjsBHPbnQ6nTsCn+tInj3H
	 ux8RH4tiQyfLFjTGCamQRbCuGuIFwxlJhoRHTCS0k7lfXHW8Nr3RVmu87H5sGvLepa
	 UPmhaNFWm7Pen456kRg70U+6OqLpFo2C+Hz+U9XVzeoUyPG0agpv7BtkR/En0huL9O
	 gHbf6AWxjwQTA6EBZy2MpaED7m76iH2AiMcDU0ka8wbZ6YuEjwjz497bRSVb3d78C6
	 K+3qD1YRKtxsOoBD4AlEmT5IdXQIX3/7B43Gei403iSJSfx7yJDfl8GPDVnl1hMCw6
	 vAzzIukh+WRDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF8139EF956;
	Thu,  6 Nov 2025 17:13:48 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.18-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251106163413.4144149-1-kuba@kernel.org>
References: <20251106163413.4144149-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251106163413.4144149-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.18-rc5
X-PR-Tracked-Commit-Id: 3534e03e0ec2e00908765549828a69df5ebefb91
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c2c2ccfd4ba72718266a56f3ecc34c989cb5b7a0
Message-Id: <176244922759.295084.13837638295083326105.pr-tracker-bot@kernel.org>
Date: Thu, 06 Nov 2025 17:13:47 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  6 Nov 2025 08:34:13 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.18-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c2c2ccfd4ba72718266a56f3ecc34c989cb5b7a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

