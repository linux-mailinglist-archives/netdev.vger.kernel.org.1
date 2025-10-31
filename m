Return-Path: <netdev+bounces-234751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0E7C26D34
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 20:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B551A225EE
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 19:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAB5315772;
	Fri, 31 Oct 2025 19:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGfNznsi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB0F2FDC29;
	Fri, 31 Oct 2025 19:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761940237; cv=none; b=fW/VTa6sZ3cqHXY+8VYFjCxVm+u/MUKgfgXBlz5DDim8nuMc5m1b9X184S9bzmFvs8jruF8gV2FK3ECtL88Qh0ovzVf3NT7IyI/tK42RthgI8NPbPrSPqQN6nyEdn9w49eCigfFMF7ozvMV+RikkIYGPqyoe/hETVnuDx/FvRQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761940237; c=relaxed/simple;
	bh=eT8QXRHOo7iIwxd5VToUWvH42mgEJKnN5q2AXWdRfVQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iGScTFdCK0e7d1FqlP/3c9G0r7KvgRZFezsZ9IB7F1jzNTwb4RXXUtgqJFmQW7faEvvBVRHNGb5R7S9kMdpViBM03UhB9plNhEp/14NcJsByNkB2k0ueuEnaYI7skO4mALH+U3AFZ3ZdPxeT30VKCyvpR5Mb4boIEPAXIjL0Iyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGfNznsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66BA6C4CEE7;
	Fri, 31 Oct 2025 19:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761940236;
	bh=eT8QXRHOo7iIwxd5VToUWvH42mgEJKnN5q2AXWdRfVQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tGfNznsiNnkR5t1aUQNwc6xNU0oMW2DCU/dB9RAwQk4pvWYLqfCNuz7VTDrMRg8KB
	 dT5YZcJ8nAxdiMkg0NXnIk27MTTWmcpU1Iy/72kAD05dnX6jUh1nVozqUfYYKWw17g
	 0fS5XyN6Wybu8hMiFirtZXEJ+8hW1V8yAPrB1g8XMymexnpVB8Pz8PYVCN25MODKJ5
	 8pdfIeQpPeu5V+fSBfi4mIgn4c7gmdF0UZZlM+v2dT8HfpHMYNPiZdvsEIokrvF7+4
	 QJESOf01Z7N8GgDAyqnsrF03gHqNThCcGJWnWqb22a3ULOP1yHATl9wmh0Bfw5Qzvv
	 fOYJS9DjSpgfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD003809A00;
	Fri, 31 Oct 2025 19:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-10-31
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176194021251.620269.13809650718943764430.git-patchwork-notify@kernel.org>
Date: Fri, 31 Oct 2025 19:50:12 +0000
References: <20251031170959.590470-1-luiz.dentz@gmail.com>
In-Reply-To: <20251031170959.590470-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 31 Oct 2025 13:09:59 -0400 you wrote:
> The following changes since commit e5763491237ffee22d9b554febc2d00669f81dee:
> 
>   Merge tag 'net-6.18-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-10-30 18:35:35 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-10-31
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-10-31
    https://git.kernel.org/netdev/net/c/284987ab6c97

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



