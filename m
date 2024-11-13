Return-Path: <netdev+bounces-144292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6429C674C
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 03:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3047B284F30
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 02:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE646136E37;
	Wed, 13 Nov 2024 02:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l72KhY82"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8351343ABC;
	Wed, 13 Nov 2024 02:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731465021; cv=none; b=VE3m2UvWVnD9isdBw533k531WPUJZyIrUs9Y2EQZ+pb+2mB6vdYFwQf8k9WPHhPLs7sx0/MB2XbYXxl5LmabzW3zevS2P3byKxTP1AZoxelCrf7C6FNVdWiPe6KwEfQhq+pnohyC/sZau+QNCiFJOWuGOS0mjvdrX4EDGd3HB9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731465021; c=relaxed/simple;
	bh=49moNG9P+rj4xeHUnJUKaf4TtX4sA3rNzGpIDb67uv8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GMh0YwZd6IlUFZIjYQ/tgUijS8SpQDxTkSYEftPyFsrwzQNA5JFTSCzh1n6ltfwcO8QFhNBsYAjHKUDCfEiaY4AjKOHncmo0eBUETnDcChrgZUSPbMFDJKyHkpOHTMIxjyILD8ChDFUy7E84Y1xMAs3IuKVY54W3xgc8GpJ7xuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l72KhY82; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0042CC4CECD;
	Wed, 13 Nov 2024 02:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731465020;
	bh=49moNG9P+rj4xeHUnJUKaf4TtX4sA3rNzGpIDb67uv8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l72KhY82dYi/wI4RVKFjG1TlssMvXS3tU1onxddNSQ1Id4ytFsidxetsSgagDzdFa
	 BS3/o59ATzsrOguv8xFdTU+FltozjXh8Z1Nh2XhlOYUc9tbFLQtRpUVvERtdqSNFA8
	 1WtMQXgY0RnhDWQU5gVCDjzBD+78OWJKiyA24UeJ9X1jlz/jLZ6PoSa5CVg0av4P5g
	 CVpjXTs/NNxqV5qG96iH4kgLHmIr54TMmlOAFPXdaTN+6Bi9TbNKNLO7OCX5QdYzBx
	 D/Hmb1LglivDXJO4WvnSPOjJ1xSurwXJBSjn6VKo6UiayDNPmGpm58FjOcnh39XGw4
	 8Pgw3U1Ohjgsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 716753809A80;
	Wed, 13 Nov 2024 02:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2024-11-12
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173146503025.759199.17593635651077808238.git-patchwork-notify@kernel.org>
Date: Wed, 13 Nov 2024 02:30:30 +0000
References: <20241112175326.930800-1-luiz.dentz@gmail.com>
In-Reply-To: <20241112175326.930800-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Nov 2024 12:53:26 -0500 you wrote:
> The following changes since commit 20bbe5b802494444791beaf2c6b9597fcc67ff49:
> 
>   Merge branch 'virtio-vsock-fix-memory-leaks' (2024-11-12 12:16:55 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-11-12
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2024-11-12
    https://git.kernel.org/netdev/net/c/e707e366f355

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



