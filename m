Return-Path: <netdev+bounces-131830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 654D898FAB0
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 01:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E0F31C218D3
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 23:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DD21CCB21;
	Thu,  3 Oct 2024 23:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mI8BUXqZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6161B186E3D;
	Thu,  3 Oct 2024 23:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727998830; cv=none; b=lCo1ZzWmzyxSzdUDMABmSwLPnNBG9YFx+YknniXhsumHWM+Sm8rGgvzRVq7VSyxEmwUnNBwIiAaNlS095iH9fZBUUA6mZMaf48W9lpPWJK50k5MXDMHJxH9ytPV9IqWNYZ0qqQRpwM9ZQNipMXBbBQGA+1M/QoWyzXFfj2sRvhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727998830; c=relaxed/simple;
	bh=zVZVjUKwWmy8wagdQANWGdYz209m0lxLhYaTaCBEHMQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SyonjZ6TGuRiowaRFk0FV9d578qcD2wMEBtlC///O2IixrWrBxNsEpI/VuK/zo+nm3Q0oKMHsoWMftTmnJhtZc7PXNSH7TQibmf4vlbDlqQp0QQLOuv6MpD3gNztkQr3u3o83MgmJD52RfUrWDH5QL44zxTNiEUVDkVSm1XcdvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mI8BUXqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C576EC4CEC5;
	Thu,  3 Oct 2024 23:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727998829;
	bh=zVZVjUKwWmy8wagdQANWGdYz209m0lxLhYaTaCBEHMQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mI8BUXqZAsl94swu2Na4yOSkFRW+rIHSzMdr+OOCtzysZY7xK4NB37clhkGrRoxh5
	 F5iTlNhZjJwtYoMByl3WwiLkBo2YCKs1DTW5vdT12GLA/O98FAjYXZHdko5AYEcKtb
	 6FqXNIUtnd4TOgoSiH7tiUeJMCwqXtKDJ8kku6ifEu0k3Htr46NCeImz54M5HsmbTn
	 +XN/6M2ds4ywQ/PVyYwfsTJnDvbgMYMfL9u8J6r60kQlWSQIF78frKsXWelzLq62vA
	 Vpjv8DqlOg9tqFbIePYcuhZaxc2eMRq3ipYJFGJQXCduLVlGH/w1pfOJnkcV91J/9p
	 Qwm5070zZRonA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F033803263;
	Thu,  3 Oct 2024 23:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] rxrpc: Miscellaneous fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172799883325.2030473.10709152930569519748.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 23:40:33 +0000
References: <20241001132702.3122709-1-dhowells@redhat.com>
In-Reply-To: <20241001132702.3122709-1-dhowells@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  1 Oct 2024 14:26:57 +0100 you wrote:
> Here some miscellaneous fixes for AF_RXRPC:
> 
>  (1) Fix a race in the I/O thread vs UDP socket setup.
> 
>  (2) Fix an uninitialised variable.
> 
> David
> 
> [...]

Here is the summary with links:
  - [net,1/2] rxrpc: Fix a race between socket set up and I/O thread creation
    https://git.kernel.org/netdev/net/c/bc212465326e
  - [net,2/2] rxrpc: Fix uninitialised variable in rxrpc_send_data()
    https://git.kernel.org/netdev/net/c/7a310f8d7dfe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



