Return-Path: <netdev+bounces-140832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE869B8694
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 00:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AEAD1C222B8
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 23:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564BF1E571B;
	Thu, 31 Oct 2024 23:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gov8hTH9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED891E47BC;
	Thu, 31 Oct 2024 23:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730415804; cv=none; b=L1iBS43Z8RMqE6EvPIH8UYR/kks/6bEDW5qc6y9FVEyoumdIihfo4sB+fN4fycveQn5zS6N4AFBVvpf8yxziMHFRi0WgY831FLkeg8uW55D5on0KdCt2dcGsjfX8vWEq5sW4ESl1XLUIU4ZwicK4poBYQpQILU5gguxQ5y3yr54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730415804; c=relaxed/simple;
	bh=Q7VmlL8x2IQAiiRMu3bsnDBoaFjg0O2WHqVJfKrxeo8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=W3yE/SI4OIJXW9IfuaEh5QY60AKQpT50U73KedX9bFMljbjRj0FV8imlozrkgOXUneYcQ4yklF9fIZl/Zc+CCDkqzxqlxsGO25seKu2+PfEb7a0tRahLyjzm9vckdu5Vd00jDaMFB/tulrwIyEU7zX1ClOc3Y3N/E8LkfossmCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gov8hTH9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01646C4CEC3;
	Thu, 31 Oct 2024 23:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730415804;
	bh=Q7VmlL8x2IQAiiRMu3bsnDBoaFjg0O2WHqVJfKrxeo8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gov8hTH9TSxUoX/AGIui67hT4+4qPmkYWQuConW3rZhSa/n8GRFfBuNfC5QDLZYxm
	 WS9nl3zzSqR4lb3sJAkUjtGKN7a8viHuNqVWXRwseAhIQaiaOA5dovRw+DlROZN6pe
	 9D+3Rv1ZuG6bIC/1X0MqQM4/8qftwYwZbiXK7S7p+xpXL+zzQNdb+3/EkJGnm4xMCa
	 kDWiyisksSE4cG6yCRd9ECCdy0Q2mp7O0wWpTOSG8qGgahIdlNJg1inu9Xm8RtZX4g
	 25W5IfICrSK3sO3YVnhRZ5Z9dyHiBGbqGx/6Gsjy2QCEPDNhEm4TPRWjjDEVWYCC8b
	 pjDve9ECInr5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E72380AC02;
	Thu, 31 Oct 2024 23:03:33 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.12-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241031141748.160214-1-pabeni@redhat.com>
References: <20241031141748.160214-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241031141748.160214-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.12-rc6
X-PR-Tracked-Commit-Id: 50ae879de107ca2fe2ca99180f6ba95770f32a62
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90602c251cda8a1e526efb250f28c1ea3f87cd78
Message-Id: <173041581170.2114557.15895995326087684060.pr-tracker-bot@kernel.org>
Date: Thu, 31 Oct 2024 23:03:31 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 31 Oct 2024 15:17:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.12-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90602c251cda8a1e526efb250f28c1ea3f87cd78

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

