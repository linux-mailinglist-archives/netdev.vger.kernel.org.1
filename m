Return-Path: <netdev+bounces-95294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6B28C1D31
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 05:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D38F3B2216E
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 03:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20F8149DE7;
	Fri, 10 May 2024 03:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wa0Akm7t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C658149C56;
	Fri, 10 May 2024 03:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715313029; cv=none; b=ba+FqkA7mmCxYUmBfQOvxArJRW/Qt10yxRcGwxDQMXTmER3pCfdb8r7sx8F01guBDzjjqx2l7iqDWCvUS4VS2ABGaBEHGhNfY8OZfhAenl47+CH41S/DoCXL9QghkdiKCouToEvfsU/sq2v+XTaNmDzkL7l6/d/zF6/HnoNgcIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715313029; c=relaxed/simple;
	bh=C1NpNQNzHoIUVzTEPwGGLtvW9WG1e3A/c3cr3VQ/BlI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DmyoZ8v4Sxl42PS0qJRC+IhYOQ26AX7syGCFCqlth947/9gW/9EacIxOluumqcSQv2ryvm6K0I2ErY/iv1rXasLIFNngdi6O5UgAQy4speGdg9vLioxEnBwoD09+IdILSZlkWrjj3La5yw7AszfkGwr1/+NiQCZ+2c8noCG15IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wa0Akm7t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2190CC4AF07;
	Fri, 10 May 2024 03:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715313029;
	bh=C1NpNQNzHoIUVzTEPwGGLtvW9WG1e3A/c3cr3VQ/BlI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Wa0Akm7tRiiLzSJW9Gt/FsJpB7FcPyqSN5zrM9K7bpTZA8OJlGk2tM/xOJ4QMAJ8p
	 4LZM19YvUxOgNyBw5KbkCsl051sU14iuRqB++OcIcSDVDYCe8VgJJHv3kk9K1NTmkG
	 gmQlPHsI1LUjNNLRhZ/P7UyPjTUy4GcqqUpElMFnicSlOH5ToUZk2WovEKQ9maDWRR
	 l+CQAOPYsSkVZLfAiu55Wz6QvkAzYfXj4Qgb5/Wf4SUvwr/up+ppW28SngnlInjlcP
	 z5w5JjXnYdvYsfnqbXP8S4cM7nW0T1v79/gxMDD+/qebCiyB5Vftq30osCgvXJICmQ
	 +R3houJRtgCKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16C26C433F2;
	Fri, 10 May 2024 03:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net/sched: adjust device watchdog timer to detect stopped
 queue at right time
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171531302908.29493.4828668571674176286.git-patchwork-notify@kernel.org>
Date: Fri, 10 May 2024 03:50:29 +0000
References: <20240508133617.4424-1-praveen.kannoju@oracle.com>
In-Reply-To: <20240508133617.4424-1-praveen.kannoju@oracle.com>
To: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 rajesh.sivaramasubramaniom@oracle.com, rama.nichanamatlu@oracle.com,
 manjunath.b.patil@oracle.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 May 2024 19:06:17 +0530 you wrote:
> Applications are sensitive to long network latency, particularly
> heartbeat monitoring ones. Longer the tx timeout recovery higher the
> risk with such applications on a production machines. This patch
> remedies, yet honoring device set tx timeout.
> 
> Modify watchdog next timeout to be shorter than the device specified.
> Compute the next timeout be equal to device watchdog timeout less the
> how long ago queue stop had been done. At next watchdog timeout tx
> timeout handler is called into if still in stopped state. Either called
> or not called, restore the watchdog timeout back to device specified.
> 
> [...]

Here is the summary with links:
  - [v3] net/sched: adjust device watchdog timer to detect stopped queue at right time
    https://git.kernel.org/netdev/net-next/c/33fb988b6705

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



