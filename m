Return-Path: <netdev+bounces-206224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3ADEB022FB
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 19:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 380B61CC1D1E
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 17:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D1C2F365C;
	Fri, 11 Jul 2025 17:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaAQoE7f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317292F3656;
	Fri, 11 Jul 2025 17:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255844; cv=none; b=BzUKuDxrkk8SESQBspM4KbomfCUAYVUJqrwLq1oe8kVooLcuBNLuOz4zYCUOc5R3v2pGr/2/D0BQpjcOHkPB47Kh3Xx2ebPAExFg3FmSgHFjeJsYihKAN7839R8SJPFhM2X1GzPsZ8CGIduHh4zDx4PhAxmK+Zc8Cuq8VUe3lK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255844; c=relaxed/simple;
	bh=PoGyJEGedF8P+yMJzOV0znpfsGhMs3ojPCsJSA3gkM4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FzHlIOQWhrNgiA9xblRrenvIDgXLq1g8JVtdIqsonQEXU+ySbxoegjOj8g60DKc8v1bz4l7slQbiPqMghuz535PvRmrz2PiUhCyiALTC8VYBUmpm+Lisngd1EoJ086jGwyUKh6H6nN5i1jNZmpVaVjA5Vpur+bAdbx0Bf4yA0/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaAQoE7f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2F7C4CEF6;
	Fri, 11 Jul 2025 17:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752255844;
	bh=PoGyJEGedF8P+yMJzOV0znpfsGhMs3ojPCsJSA3gkM4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZaAQoE7fMOz/IazXHxRrjYAiaSi+auobXQG4fQIB5GZyBFhV56yslM13tqcFoPm5b
	 1pCBMxfvtlfObk9IOtGL/0zFeXz0WlHeU8pVp9AJhDIEvFw54faQASXv7tpkjvN1G/
	 ACgF5MoFvq5tI7sbrFFlQMxZeYXawqKe5gZMa/iWQGwavkVtghH/eagmz2RqHvYn+t
	 UxiROpF8OV5thG82e2qbW4N8YX3iy9GOtYsFyi68jNg374D37arENWdh4gLxagKRhj
	 q9+F8QaZ9GUuURaBHXlZ7o6ezUszVuW0VVp1l4szPSk4ecU77HTdSzRId2VYYStqRG
	 lXIUapjTXkF4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E33383B275;
	Fri, 11 Jul 2025 17:44:27 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.16-rc6 (follow up)
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250711151002.3228710-1-kuba@kernel.org>
References: <20250711151002.3228710-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250711151002.3228710-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.16-rc6-2
X-PR-Tracked-Commit-Id: a215b5723922f8099078478122f02100e489cb80
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c7979c3917fa1326dae3607e1c6a04c12057b194
Message-Id: <175225586583.2350666.10793872825985508473.pr-tracker-bot@kernel.org>
Date: Fri, 11 Jul 2025 17:44:25 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 11 Jul 2025 08:10:02 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.16-rc6-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c7979c3917fa1326dae3607e1c6a04c12057b194

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

