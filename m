Return-Path: <netdev+bounces-153971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8B69FA6EA
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 17:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B971887069
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 16:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAFB2D052;
	Sun, 22 Dec 2024 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsHTSKXB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACA422071
	for <netdev@vger.kernel.org>; Sun, 22 Dec 2024 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734886213; cv=none; b=WKfipLY9tp3Sg2O+zUYaOe7W8hTvxFzJyeDTwZXpjhekf8U3tc4kIS12QxmOqrfj3H3Jd1ZYhepxZN6uIXXdR8Sl+DWSm+n3L1YdJ3Sz42iv5sppuAXw6R1nI0y1hIakQeCNxAim0BJS14fI41a7LvL+4Sk8U37ODXaeLO51xZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734886213; c=relaxed/simple;
	bh=d1l8od7n0PAwJKM51AEqb+dhu78Sx0h/XVMFpK9Lbmo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R94eqWgsEYBT0orBNsNVI6XMI/IkfdRPf0kFXp+FWgwTnBalLe/bd/RvAOiFDDxSeUDX8g4VlseTpwX8S3m9VLDiU6tuZsU67+fXvs+OjG7XscICed+GApoRHu7oLbtF5lfIUW9AwWZC18whc/MKNgCxKl/GI12hmlap7IXqoEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsHTSKXB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344ECC4CECD;
	Sun, 22 Dec 2024 16:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734886213;
	bh=d1l8od7n0PAwJKM51AEqb+dhu78Sx0h/XVMFpK9Lbmo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZsHTSKXB+38AScomTCrhZYPltM6LkNPIStJtoHmWJqFHiWwPdg+pVXmKeYwu9vtxF
	 t4H6JPLQxDw/S9MTZQVZ1XmPBju3GM/QJR6pqJCOi9TuPnYNGNw5ksxMkSV0TosD5b
	 omvsd34O9nI9oU95Yw56AovU6iCieLHHmaT4QIPaIvfee/slo2cUF2x0R8dwT0oHBa
	 QOoYC91V7D45O/sfOP6wR7vPQjYkKRkxuuQJAwdDmhMWqPJwMGzB7Y1wfXNkG496Yg
	 Y/poYaWw9ijIfA7x7yY9mQXffvF/fqHlFgal5XzhK52MQiY5GSJJm+ZCSW7Q/W2sot
	 7uPzr/fuZ+5Jw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF15380A955;
	Sun, 22 Dec 2024 16:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] man: fix two small typos on xdp
 manipulations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173488623051.3368440.11472395796370172885.git-patchwork-notify@kernel.org>
Date: Sun, 22 Dec 2024 16:50:30 +0000
References: <20241220-man-v1-1-2ac51fb859e1@bootlin.com>
In-Reply-To: <20241220-man-v1-1-2ac51fb859e1@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9_=3Calexis=2Elothore=40bootlin=2Ecom=3E?=@codeaurora.org
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@gmail.com,
 thomas.petazzoni@bootlin.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Fri, 20 Dec 2024 17:56:01 +0100 you wrote:
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
> ---
>  man/man8/ip-link.8.in | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> 
> 
> [...]

Here is the summary with links:
  - [iproute2-next] man: fix two small typos on xdp manipulations
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=9861c81f5b04

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



