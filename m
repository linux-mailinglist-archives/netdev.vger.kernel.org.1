Return-Path: <netdev+bounces-141767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 858B39BC31E
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 03:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48630282988
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 02:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BA6137C2A;
	Tue,  5 Nov 2024 02:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNHsfwka"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0A41339A4;
	Tue,  5 Nov 2024 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730773229; cv=none; b=Qv1wky166dGoCGqxxADlzIGaqpZIc/Z0n3Q0xz1A/ASUWnK/9vSoGfNtePw2qd46Dp/vrl/lijmZOVG8xEs7dglXCXyKAF8H2JRoVPnK9TtUMAavgf+riDY+S2NINptVn27NV+HQzasJ8nRDrH3riTDaWiO5t7OqJWWu2ozo2Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730773229; c=relaxed/simple;
	bh=8Z6YC6/gad8Z6uPzOYdCzmq8GJLLc4rArpcGZT6FKdc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZxwZtrjlc1YfyFhbRrN+6k8RF8pS+eBf5G9H2O4H5otp8zldEr03SldPCK0a4w0BJ6RoYanLWYkXzg/JdmGz92eSEyulMhb3j3bM26oquY7uSPm6uBGKRcCj5SjupznJFbOSKnQuB4Vnx/x0bsW71SWFd5J64LLRo17Wew7NrS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNHsfwka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4FCC4CED2;
	Tue,  5 Nov 2024 02:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730773228;
	bh=8Z6YC6/gad8Z6uPzOYdCzmq8GJLLc4rArpcGZT6FKdc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WNHsfwkaEldwRtWnIvemZXjl8G5MIMA7TkgKWAZJCSMj25eMaGXUeWu2mSDaNDSIS
	 lsnaDTeNCQGJtrHwnl3xXJ7GSwwmlh6hrl1B8n6OC1+Zssqo8fPSi6ft5brdfFRAhW
	 KbH67hZ6P84eh683W6g4xW4S3voM3TVMsP0uuQp/EV27D5lO/RKFqfimH4nZV2V/Tt
	 JwDIK45x4XCBUIifs3dBqhLc1g0jbkINUMpSViXcBt5nBRSrvyYiFWGgPGYbaredBn
	 ueX/r643mi3yhEF93I7Kc8mlxnvJGSn3TIe17mcLoWdxcfue4EqiRT6lAc+2SEHEUy
	 SGZ41+qHbmEHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD1B3809A80;
	Tue,  5 Nov 2024 02:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: tcp: replace the document for "lsndtime" in
 tcp_sock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173077323749.89867.14034672284365562278.git-patchwork-notify@kernel.org>
Date: Tue, 05 Nov 2024 02:20:37 +0000
References: <20241104070041.64302-1-dongml2@chinatelecom.cn>
In-Reply-To: <20241104070041.64302-1-dongml2@chinatelecom.cn>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: kuba@kernel.org, edumazet@google.com, dsahern@kernel.org,
 lixiaoyan@google.com, weiwan@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dongml2@chinatelecom.cn

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  4 Nov 2024 15:00:41 +0800 you wrote:
> Commit d5fed5addb2b ("tcp: reorganize tcp_sock fast path variables")
> moved the fields around and misplaced the documentation for "lsndtime".
> So, let's replace it in the proper place.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v2:
> - remove the "Fixes" tag in the commit log
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: tcp: replace the document for "lsndtime" in tcp_sock
    https://git.kernel.org/netdev/net-next/c/0a2cdeeae9dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



