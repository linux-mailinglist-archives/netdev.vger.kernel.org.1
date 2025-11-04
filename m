Return-Path: <netdev+bounces-235339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C41CC2EC00
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 02:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69A2F4E4A9B
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 01:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB541E1C1A;
	Tue,  4 Nov 2025 01:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieavUMMf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7B41D5174;
	Tue,  4 Nov 2025 01:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762219840; cv=none; b=h8zMo/ZWyWhnwHvD5QrAysxloU3o7b/xxynjgedgybhYBCKfe0iLJC99oij/xwk+YOdiDoXc31Nwje5uxmUaYCvYt5TIG9FcEEyQdcgTUZq1NBaBx1THsV3lze/bUT4IkzoYbzLLQ6lRTV5dVSWY8UpnVVAqRG370tpSj3Y8S6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762219840; c=relaxed/simple;
	bh=4OwAu4AjL3KVjURZeUJ+75f0A/QIgJ35Jui27bfTihw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hbOV9EebVuyyJ257GEv7vpmirD3dpnrcdXuTFWML5gE+IiAgJZjctdU17wfK3V1W0ZvPXXMQsiM/h3TkbyDgsS/RPOMEa2X6RGeJ4kw16QHwHLjD8hvgq/GvTWU2U+kv9TUs0OV11t8DYTM9yX6g0zCyOcm6WRBXdf8VwLCZUyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieavUMMf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25AE5C4CEFD;
	Tue,  4 Nov 2025 01:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762219840;
	bh=4OwAu4AjL3KVjURZeUJ+75f0A/QIgJ35Jui27bfTihw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ieavUMMfyizrolmeVvlC+dt3/GP2WOzbz7HdWbKVppNfJlkrOS/PhBn5lXQ2dFRmL
	 4QGLa6LozHPegyN2si9iB3adsEjSyVcngeLxFCRRKPseXdmnJkBZlbXaTaeHWweF0f
	 ZQqjytCpZPRVl2plDPJ3t1uBWagHMwXyoRQxsnvTaGldGy/xqUXYAZjDsBhfj4n69Z
	 Q1Jn9X7v+FAD8N2Tertebct2OPIRyV+jWuc8yXD0rdApgj1h+d6oPCmuht9bOAeqBj
	 YRrjvc9NMH83T5iq0KdBSgk+CPNeLBOUiAaHS2br0NYk/Gp5YO0dJpPoaiqA1f+gJI
	 yH5LwwT7/JCdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE653809A8A;
	Tue,  4 Nov 2025 01:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] net: dsa: yt921x: Fix spelling mistake "stucked" ->
 "stuck"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176221981424.2281445.11835643244520389770.git-patchwork-notify@kernel.org>
Date: Tue, 04 Nov 2025 01:30:14 +0000
References: <20251101183446.32134-1-colin.i.king@gmail.com>
In-Reply-To: <20251101183446.32134-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: mmyangfl@gmail.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  1 Nov 2025 18:34:46 +0000 you wrote:
> There is a spelling mistake in a dev_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/dsa/yt921x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [next] net: dsa: yt921x: Fix spelling mistake "stucked" -> "stuck"
    https://git.kernel.org/netdev/net-next/c/22795871edea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



