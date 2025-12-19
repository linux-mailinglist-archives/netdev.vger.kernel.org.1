Return-Path: <netdev+bounces-245508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A773BCCF57F
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 11:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25E813058852
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 10:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DCB23EA84;
	Fri, 19 Dec 2025 10:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmfKabR/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C897411CAF;
	Fri, 19 Dec 2025 10:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766139439; cv=none; b=V+LkkxOfLQSuJKZsHU2h/GvsfckvJuLz6OdtStGvRLnprhOmnE92Z/nKn/y1TjLHAr8nvpsYKEt1bg7Go9ZkI7b6HbYlOn7SinJlGQ2bXglt60o1LVFVav6Z2NWR9h/8MlIIXpyHGn8orzZwFvwFZU7K6VpPTH2kV8dwREm7v8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766139439; c=relaxed/simple;
	bh=jGxMsFigQHCTO4wwAYWrxv0UqHgu1wXa5CxnJfbJt+8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HznceDVg8HtVL7uMoFHhJoWqSj+qxaBK0RKBBugHnB7tEKW6rh2NeZD59eDtbBOPnzDe/ef4a0NX+/M5h5Lyf2E1p12r9MOeAh6B0oWHnzCgXC3oo4egvLFw9x/WLhdNK3b2DeHZ3n0uq1StHVrlMeGVAdBHsLYG9EQQfiJkZMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmfKabR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A32EC4CEF1;
	Fri, 19 Dec 2025 10:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766139439;
	bh=jGxMsFigQHCTO4wwAYWrxv0UqHgu1wXa5CxnJfbJt+8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QmfKabR/Eocw6gUxM/g9C1M3Guy8EL/XCGvVV1JIZiNYNXGokPkeLf4OYaDp/qGX0
	 IXF6BqpbfzaEfexOZNKnL6uFGc4OAqalN0OgCP/a5aGILEwQxwt+JqBouPW8Pd2BDC
	 gnd4rkpow4SQmNvNP9q4VuFeidxK7G8B80Ux8pno62DEQVwGwEZgWgui1FAB0bjUFv
	 fjoKu381kwlxiGt0Ho1H8PZsJsUofecwjs3JH6+95diB37EeqalRgKlxZO3T2skXpS
	 MXeATsH6/b5MgCAh599vZAr45Y/v1SIJ0LelKULbgp86Eopiu6ejgcZWW6VYtCRRLu
	 HFRk3hskTqBfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78F20380AA5F;
	Fri, 19 Dec 2025 10:14:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] Networking for v6.19-rc2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176613924829.3734330.6844145049673147691.git-patchwork-notify@kernel.org>
Date: Fri, 19 Dec 2025 10:14:08 +0000
References: <20251218174841.265968-1-pabeni@redhat.com>
In-Reply-To: <20251218174841.265968-1-pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Thu, 18 Dec 2025 18:48:41 +0100 you wrote:
> Hi Linus!
> 
> The following changes since commit 8f7aa3d3c7323f4ca2768a9e74ebbe359c4f8f88:
> 
>   Merge tag 'net-next-6.19' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2025-12-03 17:24:33 -0800)
> 
> are available in the Git repository at:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] Networking for v6.19-rc2
    https://git.kernel.org/netdev/net/c/7b8e9264f55a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



