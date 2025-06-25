Return-Path: <netdev+bounces-200888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C069DAE73CE
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 02:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7DB63B3113
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 00:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0325A4642D;
	Wed, 25 Jun 2025 00:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkXr4r7u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A372B9A5;
	Wed, 25 Jun 2025 00:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750811379; cv=none; b=CWtmQ9MsDrqdzSuq2LqH4YUZtrmQADZ/DvDtsaYOSA7rhM3ydUS/bPYsSj9CzlG3vv1GrqWFqfOabXcfGWuQcXHXER3RgH0Bw3lZnuMatfz0x5B1FNKHYkVFCtNWXT1DHUiIQyZtT9y5kEl09n4n7cgKtxNsUIFYOOO632BRS9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750811379; c=relaxed/simple;
	bh=pJ37KolkwCNerdU7MSR40O97S9rxQ/NXaJ9jQ6rgByM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=phVnw+BmUJgSAcAbsrY+Uw0DKmHXPSpibcpSv7whZNNTjXOGSGZu5fCkJC70yjpuFrsR5mhOUtyKnhWCL7SQvBImFT9RfEArLn3d37YGWpxfPf8erKRlWr8wiDVtebfBVdmxL42Oi3WRgNAw30U8U5TOwnD0+TT4KnZHLHyqFrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkXr4r7u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3472EC4CEE3;
	Wed, 25 Jun 2025 00:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750811378;
	bh=pJ37KolkwCNerdU7MSR40O97S9rxQ/NXaJ9jQ6rgByM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AkXr4r7uUky4zCTGBFkF+Aq6pxR8bnJeL+0b6iDggdMFCI4a/05qvczThiypY1/i/
	 T1ZFGAatnDNBPWILcpIzERXAb5mkd1B8eo7rb9fMsr7DVwWcuhxIC/b5l61VDGWfgh
	 awhJ7ER7M86FRF3OXuXCitE+/3JGyJ+q59ZPCkGYuzs34Rosf0u4AtKb1rKIUdCV59
	 oHxN5T9zVOFB/TD0DWk0CE0+BjxCZHPPQz6Y1xZ6feJ62Ffe5YU6c1FfeQhkzJ/yI5
	 Oo0wsUvN4G8OBAxbLJeovlLm8dIuMngKZu8K7dxg+tzBpof4lMDTlJX9X5wYWULHFS
	 yRK7gYvKR6jRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E3E39FEB73;
	Wed, 25 Jun 2025 00:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vsock/uapi: fix linux/vm_sockets.h userspace
 compilation
 errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175081140500.4083218.18258927815615257832.git-patchwork-notify@kernel.org>
Date: Wed, 25 Jun 2025 00:30:05 +0000
References: <20250623100053.40979-1-sgarzare@redhat.com>
In-Reply-To: <20250623100053.40979-1-sgarzare@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, acking@vmware.com, georgezhang@vmware.com,
 kuba@kernel.org, edumazet@google.com, horms@kernel.org,
 virtualization@lists.linux.dev, pabeni@redhat.com, dtor@vmware.com,
 linux-kernel@vger.kernel.org, davem@davemloft.net, daan.j.demeyer@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Jun 2025 12:00:53 +0200 you wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> If a userspace application just include <linux/vm_sockets.h> will fail
> to build with the following errors:
> 
>     /usr/include/linux/vm_sockets.h:182:39: error: invalid application of ‘sizeof’ to incomplete type ‘struct sockaddr’
>       182 |         unsigned char svm_zero[sizeof(struct sockaddr) -
>           |                                       ^~~~~~
>     /usr/include/linux/vm_sockets.h:183:39: error: ‘sa_family_t’ undeclared here (not in a function)
>       183 |                                sizeof(sa_family_t) -
>           |
> 
> [...]

Here is the summary with links:
  - [net] vsock/uapi: fix linux/vm_sockets.h userspace compilation errors
    https://git.kernel.org/netdev/net/c/22bbc1dcd0d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



