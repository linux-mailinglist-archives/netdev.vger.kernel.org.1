Return-Path: <netdev+bounces-46961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD7F7E7694
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 02:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E0EAB20BF8
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 01:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F1B643;
	Fri, 10 Nov 2023 01:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TR+AY49d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B45A46
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 01:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9A62C433C8;
	Fri, 10 Nov 2023 01:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699579823;
	bh=cOZWkG/64DBLgfdNhaBO0s9v4xd2gke4ZV0oBHqc+W0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TR+AY49dq5le1pmOp9v1CbDbjcv2gUcj0a214s9vNMEjdDqCCgGqv5rO8X080WKtr
	 urPozgQR99DAHedsERXzgKcySTgatOmpy/EL8pGw3CyX/0QIEoKl4sVe9huw7UmBKS
	 ZdhZI2hdvidAH3j87udorvOy8zR/zQrRmRv1BuUiNqnwvjIw9bwMOWyBN2QHUFQN5Z
	 /eGk1+a/1Ew8urEnG+bisY2Bd/cqAQQwmfPVoLlSuCcKATZ1MSrMvIxGWujvqFKgbn
	 pdNyAXY9EcsC4xlTIxTQ+fIyz8wdpb4t1oLfyZQA5q9sqpjuBgl99FdOMUH5nQWgZf
	 QIwwwMU+FvPLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA02FC3274C;
	Fri, 10 Nov 2023 01:30:23 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.7-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231109210013.1276858-1-kuba@kernel.org>
References: <20231109210013.1276858-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231109210013.1276858-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.7-rc1
X-PR-Tracked-Commit-Id: 83b9dda8afa4e968d9cce253f390b01c0612a2a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 89cdf9d556016a54ff6ddd62324aa5ec790c05cc
Message-Id: <169957982370.19824.17334579266254441890.pr-tracker-bot@kernel.org>
Date: Fri, 10 Nov 2023 01:30:23 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  9 Nov 2023 13:00:13 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/89cdf9d556016a54ff6ddd62324aa5ec790c05cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

