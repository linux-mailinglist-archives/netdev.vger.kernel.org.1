Return-Path: <netdev+bounces-111788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 889969329D1
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 17:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 131CEB216FF
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 15:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC1D19DF7B;
	Tue, 16 Jul 2024 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8sllzqy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3621E861;
	Tue, 16 Jul 2024 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721142033; cv=none; b=DbX5sZvfqQcdWZeTtmFu584ViFBH1eSkwt3CHaXeiCwzLpqSkcxMfiGl5KaEmil641Z7gI8q6UVKmcYh6uk/qhvRkEnsDV0X6X6a2biW//E1npciasWvhkLkY6SR7fpW9AKsJYrJ2eh3YgWS8+XcMDsnZ6WBWIP1d2HnCj3edOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721142033; c=relaxed/simple;
	bh=FeiFYy9THrb7N4QDM9ks7jrXubXqyWHCRCwbJ7CCbcc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HZeklliQWNYEBP0NEdOOeXzqUMDMd2O/rK2ZDMqoFchEXRw30qUGGWyog835hFfr4DMZ4pS4F1SEnU0XVtc8t2m9o/JciVEv5qvTAcL0hm+CC5g3heB+w682r2+nxm+phBTods4CWbvLW/GsE/bapMQVV9fTnkpFIoYaPg6pSb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8sllzqy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87897C4AF10;
	Tue, 16 Jul 2024 15:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721142032;
	bh=FeiFYy9THrb7N4QDM9ks7jrXubXqyWHCRCwbJ7CCbcc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s8sllzqy6U0Axeqyvtp4Mf86ItkVGdrMSZIZ7GETGbsKtYdtXl12Y8L9rbnjUcp7i
	 neNiG5FTFFOzmUUo2EUxawFnhLD6tLNfIILaQ9nCFhZO+RTJsFMBPuNphhUd0a+7F+
	 ZdLJHOZymUNNZkOSedJUQqBVaEVin1b/4p1jK4GhDvevC8rXiR4+knqr6mmcuz2ST6
	 bjRgMxvaxOLKR0vNO1bxJirKpBB4cPAbcobsx7OQPYslKZst2ZnsTiQTgSLFLzCmS6
	 MAlZl2fSq5v/Bh6WejkQfm5VW6Fhec+RF609XBD1kTsRKl2k0PzgTVJDslZSF1T36s
	 yqwTlBmz8sAUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6FFFEC43335;
	Tue, 16 Jul 2024 15:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net/ipv4/tcp_cong: Replace strncpy() with strscpy()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172114203245.4794.1156267862455806802.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jul 2024 15:00:32 +0000
References: <20240714041111.it.918-kees@kernel.org>
In-Reply-To: <20240714041111.it.918-kees@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 13 Jul 2024 21:11:15 -0700 you wrote:
> Replace the deprecated[1] uses of strncpy() in tcp_ca_get_name_by_key()
> and tcp_get_default_congestion_control(). The callers use the results as
> standard C strings (via nla_put_string() and proc handlers respectively),
> so trailing padding is not needed.
> 
> Since passing the destination buffer arguments decays it to a pointer,
> the size can't be trivially determined by the compiler. ca->name is
> the same length in both cases, so strscpy() won't fail (when ca->name
> is NUL-terminated). Include the length explicitly instead of using the
> 2-argument strscpy().
> 
> [...]

Here is the summary with links:
  - [v2] net/ipv4/tcp_cong: Replace strncpy() with strscpy()
    https://git.kernel.org/netdev/net-next/c/a3bfc095060b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



