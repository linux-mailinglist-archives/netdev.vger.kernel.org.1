Return-Path: <netdev+bounces-144662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CA89C810F
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 03:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD24284ADA
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 02:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0046A1EF0B5;
	Thu, 14 Nov 2024 02:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGhtg1lv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD03A1EE037;
	Thu, 14 Nov 2024 02:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731552635; cv=none; b=WWchB9ozF0i1HcUAiOMDuZ+inXGdF5FJ9Bm6Wg1dGS8cpu4ZTMB5xCZTe0eKbXnIMg8Z8MHPumJR6NUCWUS2GWfToTH7bMhk4dr70oISKxYVdThRsQn3xU4DXPkFzZAfmEAi++VjNIMzyaFaK5qNh282T4+BmfM9PuxXgBVkEW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731552635; c=relaxed/simple;
	bh=mzx0dfeln3w+y9OgYJ1SVzPH4BhxS2KrQiBl4aLTqQI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t+hQyJjBE6krdPyZjyNiw+sEB0zmR5heolSPcfXPiblnK9KaQMc9WDu8zEa0xomOuJy+GOcODK23p+RkS2AJjcUl0ZHcgNDk0TuClO4xCde+BhlzjZVuEBD0SiLFZnpLuegLeQHy5YHBnomjAw2nTIz2olZK7T4fhcbkpHOWvWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGhtg1lv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A073C4CEC3;
	Thu, 14 Nov 2024 02:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731552635;
	bh=mzx0dfeln3w+y9OgYJ1SVzPH4BhxS2KrQiBl4aLTqQI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iGhtg1lv1R/WjRThTM6aZNrMylY7ygEtyefyw2KP7wmB+wR53pBbuBTUItdquGqjC
	 eRa0OwO2UT8GDwWiS0AHAAMJihPPUKr4E+QokLPrpbR2EC6GQ4nsrOYcDmpmQtDa/x
	 eFdjx9YXyOa7CrEu6Uypys6AzkC9s2zt/eDWRLhH0oAhsgc6aqiPwGTjUk0gMQ3KEx
	 GkBzgpe2C9urhlhjEk2uAu8B0sdhJq21FMlzerDHg2mPORGrXEnCTPZfQI3ccSC4C/
	 FjGh7C3uh27IRc+yKT2zU2j0Y4wEiR9QQgfz4UhNXNhfagi5ohRfT7AttzNAsr7scf
	 XYQGWTaLr44bQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD2A3809A80;
	Thu, 14 Nov 2024 02:50:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ynl: samples: Fix the wrong format specifier
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173155264575.1461768.4456600595770386405.git-patchwork-notify@kernel.org>
Date: Thu, 14 Nov 2024 02:50:45 +0000
References: <20241113011142.290474-1-luoyifan@cmss.chinamobile.com>
In-Reply-To: <20241113011142.290474-1-luoyifan@cmss.chinamobile.com>
To: Luo Yifan <luoyifan@cmss.chinamobile.com>
Cc: kuba@kernel.org, donald.hunter@gmail.com, davem@davemloft.net,
 edumazet@google.com, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 sfr@canb.auug.org.au, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Nov 2024 09:11:42 +0800 you wrote:
> Make a minor change to eliminate a static checker warning. The type
> of s->ifc is unsigned int, so the correct format specifier should be
> %u instead of %d.
> 
> Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
> ---
>  tools/net/ynl/samples/page-pool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] ynl: samples: Fix the wrong format specifier
    https://git.kernel.org/netdev/net-next/c/a8c300ccd2e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



