Return-Path: <netdev+bounces-157471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5676FA0A61E
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 22:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51972188A0B0
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 21:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC251B982E;
	Sat, 11 Jan 2025 21:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKuhullK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140961B87F0
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 21:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736630410; cv=none; b=HUhVh9SytvNc0DU5u0/e21D5w/BzyihsQwTVoWeJxy+JWEoFqHK3an7cPS4upXonw/+Iwf8NGkQuq9qWdmXzVhazv7neXfAREEQ0TLKChVuCGeMA6978qR0dLpx0QKrEHLlT2Lvx9ES0XQl1BiPGLwO1gKBqLut1ov9hrUQW1ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736630410; c=relaxed/simple;
	bh=d+CjSnWYenwUHwQ3HAhXwdYz3H2sh3KOtK+AFQLc9Gs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iIzIY6xCtrfUlrKni84QVP/aCMLCEUaC4vth7ZMOm0g+mhi9+6BvXQnvZPi4PxQqDxKKjxkfG8KIO5DxJUaxKzi4ZiEfKTGchv2MPx1B4TbcoQ1NPy/7e3vFUAs1tO5kU3zySuHfsqcwYteEU7CA2vRFD3B+EvLxafZuNEttL5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKuhullK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE65C4CED2;
	Sat, 11 Jan 2025 21:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736630409;
	bh=d+CjSnWYenwUHwQ3HAhXwdYz3H2sh3KOtK+AFQLc9Gs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LKuhullKPphx1ny0+ac63nI5jTOPOCf7LO5GCh71ih+T7THXUBcMl1Q48NjtN2D5L
	 aBGpfuySR3at8Wx0mDQQjfR0wwpwJ0Z04hwGYIg+VE644gHHflwj/Y+Ei/I4/3lGkb
	 C9CDvR/A91LC3vsbRGtIJ6jcwB6adDuBhmmgLYvXupS38X0T52Ix2rICvTxSMpOLgw
	 pfW3diLLygbO8LW6Qnj/YfyRyyWnofQvSzvsBbJjVwwhOk6HX7T/z5QUAGS00KkEFd
	 M4PsUyarW1nh0Ez+p3GPZo4y7WMjVuvpOnY0kGEipulf+SS8A3FGOHGXQbZWBSeZfc
	 c9RjHZQnAm6eA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB242380AA54;
	Sat, 11 Jan 2025 21:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: airoha: Fix channel configuration for ETS
 Qdisc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173663043176.2451513.12890809036064265655.git-patchwork-notify@kernel.org>
Date: Sat, 11 Jan 2025 21:20:31 +0000
References: <20250107-airoha-ets-fix-chan-v1-1-97f66ed3a068@kernel.org>
In-Reply-To: <20250107-airoha-ets-fix-chan-v1-1-97f66ed3a068@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: nbd@nbd.name, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 07 Jan 2025 23:26:28 +0100 you wrote:
> Limit ETS QoS channel to AIROHA_NUM_QOS_CHANNELS in
> airoha_tc_setup_qdisc_ets() in order to align the configured channel to
> the value set in airoha_dev_select_queue().
> 
> Fixes: 20bf7d07c956 ("net: airoha: Add sched ETS offload support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: airoha: Fix channel configuration for ETS Qdisc
    https://git.kernel.org/netdev/net-next/c/7d0da8f86234

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



