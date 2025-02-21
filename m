Return-Path: <netdev+bounces-168693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E3DA4034F
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 00:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68DD9189E8A0
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 23:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D430205AC4;
	Fri, 21 Feb 2025 23:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iof8DAg2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F79C204C0E;
	Fri, 21 Feb 2025 23:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740179401; cv=none; b=PWkQzG9MFEW1AssZnoI69X3LduireLVQPXIGTqv3i7eglQe8K8K9E7DGVuJ+fmZiMl42LCrnjMuzFC+0pxGe+Xek1whDIsjVRWmjGW6z/QSYGxgfq3dOSJDcGPoLyJ17br6RsumNfRe+KuQblQVG2b8fz7pgyUgbyKykUJv5REw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740179401; c=relaxed/simple;
	bh=iyuxnVnQuTrsFsc4O1vreET7eNP3Ti4uW2MASu5/uBA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OKzAYjD7cEfeUinm2JbFt3fqyjgSZ1LvY9uisAtTslVDw+/gsZSHD5MC5PHITj6gxNi+fFfM950RKEeKwXM+eOHoktVgdZ26dIytL+6zDVhKcbfrJDZxQJe/X8eJeFO1WgToKhQ2j90lCy+tpoztUoU5G5pstb7dSpVshmgUAEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iof8DAg2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99D9C4CEE4;
	Fri, 21 Feb 2025 23:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740179400;
	bh=iyuxnVnQuTrsFsc4O1vreET7eNP3Ti4uW2MASu5/uBA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iof8DAg2CtvyT75sTZTtDIwImyHTetW5e3Z+W4u4TEKFOwHUIYo3+smnE8eyyEij4
	 86JavVnifYd3aGrS8+obehtw1YtTIYvqIDOm0UbtAwlojEmt8j7/LhEwsFusWtTvWO
	 dyJcu8RzQfQCg+/qwXBJHpUoGQKzWkU1qgQg5T8Z21eh+t26+ugMijCPSOUNNt6BLf
	 01eh9iZvq+cX2et40zkn44HcRVGj37b+dHLL8n46tS77H/UH7PLOFPBsPY335ki9GY
	 XzjhHOGedD1PSalKVuKbkekA91P4cnTJtBALZeWlumjaHeE44rnDrNIRsJgpK62JV4
	 kFB6tAZIOD94A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF38380CEEC;
	Fri, 21 Feb 2025 23:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] rxrpc, afs: Miscellaneous fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174017943176.2232673.6967417998548585164.git-patchwork-notify@kernel.org>
Date: Fri, 21 Feb 2025 23:10:31 +0000
References: <20250218192250.296870-1-dhowells@redhat.com>
In-Reply-To: <20250218192250.296870-1-dhowells@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Feb 2025 19:22:43 +0000 you wrote:
> Here are some miscellaneous fixes for rxrpc and afs:
> 
>  (1) In the rxperf test server, make it correctly receive and decode the
>      terminal magic cookie.
> 
>  (2) In rxrpc, get rid of the peer->mtu_lock as it is not only redundant,
>      it now causes a lockdep complaint.
> 
> [...]

Here is the summary with links:
  - [net,1/5] rxrpc: rxperf: Fix missing decoding of terminal magic cookie
    https://git.kernel.org/netdev/net/c/c34d999ca314
  - [net,2/5] rxrpc: peer->mtu_lock is redundant
    https://git.kernel.org/netdev/net/c/833fefa07444
  - [net,3/5] rxrpc: Fix locking issues with the peer record hash
    https://git.kernel.org/netdev/net/c/71f5409176f4
  - [net,4/5] afs: Fix the server_list to unuse a displaced server rather than putting it
    https://git.kernel.org/netdev/net/c/add117e48df4
  - [net,5/5] afs: Give an afs_server object a ref on the afs_cell object it points to
    https://git.kernel.org/netdev/net/c/1f0fc3374f33

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



