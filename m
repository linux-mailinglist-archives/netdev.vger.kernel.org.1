Return-Path: <netdev+bounces-85971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0932789D10C
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 05:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A242857A7
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 03:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446F654BEF;
	Tue,  9 Apr 2024 03:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWx//MqQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4D154902;
	Tue,  9 Apr 2024 03:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712633428; cv=none; b=OC+f88X0G7duijsSiGbyc5CSDdTBGEe06wmubHUFcCUY1fae7ngj9ALoARmwCOSG8yfp7IZRs6ZOLiMSAKq3QAgb8dUFzp6sTaXKqnqYQKMoaMdd4wY0qw12cC30QThqd0ZaYYs/GrJjsmXxNQj9hn7Wzrcz4HUx6PGw3SKSIU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712633428; c=relaxed/simple;
	bh=IT9K8ZBAJIEBsxtEWZHP8/Co0XZaLR9maZwSDZWmjRk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hN1ci0kHx8eSPuJl+SKJTo3DHMwUtFMQRHXtGCrEOHnZgNtDG3Ulhl3dwk4l26CijFRek0en/ltjd2ZghsRZ/LVZ33XiRk3B9T8iwTJX/Ofz9eJXq2cw61wsEVT8gxri9UNheK/Yg/Fi/z5qO8SQr/Dr15LPFpAzRQN6sRYYcQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWx//MqQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DCB27C43141;
	Tue,  9 Apr 2024 03:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712633427;
	bh=IT9K8ZBAJIEBsxtEWZHP8/Co0XZaLR9maZwSDZWmjRk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TWx//MqQgAbZQ867FwtZPD/D4KLHhsyFD/HBGdv08XkF6TZeScS1yEZ3AJjTBKREO
	 xchEISXFoJRA3cgbU3l+xmfC2Kv/+MQmgqzarM7HlZFOhAy1OTAc9QHcS5rfu+KITu
	 2wRkWzEcSOlcrqf3qOwGUgS6qkGmmD6xq3qXGDHsVa1DzAVtHKcKVUS9dQpUweLPQx
	 pugoh3CUiAATMoYGUJ9KvMAduP+DR7GGj6sri664CB11m0MWwf4FHidQVV/QkVudU7
	 3cjFFi8Fv5Qi8YLH7rPqOWykToZp9TqeLH7VAocNYlTbywUTAF14y3ZmAW+g/fXQbB
	 jaz7lEEhovhvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D20BBC54BD4;
	Tue,  9 Apr 2024 03:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: air_en8811h: fix some error codes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171263342785.31710.18050007236455622800.git-patchwork-notify@kernel.org>
Date: Tue, 09 Apr 2024 03:30:27 +0000
References: <7ef2e230-dfb7-4a77-8973-9e5be1a99fc2@moroto.mountain>
In-Reply-To: <7ef2e230-dfb7-4a77-8973-9e5be1a99fc2@moroto.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: ericwouds@gmail.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 5 Apr 2024 13:08:59 +0300 you wrote:
> These error paths accidentally return "ret" which is zero/success
> instead of the correct error code.
> 
> Fixes: 71e79430117d ("net: phy: air_en8811h: Add the Airoha EN8811H PHY driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/net/phy/air_en8811h.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [net-next] net: phy: air_en8811h: fix some error codes
    https://git.kernel.org/netdev/net-next/c/87c33315af38

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



