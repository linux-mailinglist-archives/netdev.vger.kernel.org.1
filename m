Return-Path: <netdev+bounces-140152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D95B29B563D
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 00:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C4D283AC0
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 23:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A2E20C019;
	Tue, 29 Oct 2024 23:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEopQIhK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF1D20C015;
	Tue, 29 Oct 2024 23:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730242826; cv=none; b=gmj1ERkpeObYFLs+2yXZERAdgQ+DjVZVdY5ltPl/WCbZfZu4p+VEtobiL6eFHNuhjsnVbFi0FUwPLuIEbVE772D+o/wA7N4s/p/ko99olQXBJzwEJBYo2lKZvvqbibPJB9pbhKJ6qqEQJAY7Eplzh+PcMDkA38p6mtKDSNfcNbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730242826; c=relaxed/simple;
	bh=duJPDuBAFLwDjusrbcjn+FPgdxj/aGJ7QPgdsR4UibA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F0R35vuQxpJP39nXA8S0x+CtH//PIQDzvMK5e+5Ja5WuxeAXkLPPTbnAIh7iNqZ95O5CvU2zWE/fmrlf2DaC1qKoCdcOXbQYLhI4QJgnxPTbWCncIqZR4YB6ebhRdJ5XSRLiskC+FWfYzQYMoZUkQrsOEQpUYLhv0hbksnXJJHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEopQIhK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4ED5C4CEE6;
	Tue, 29 Oct 2024 23:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730242825;
	bh=duJPDuBAFLwDjusrbcjn+FPgdxj/aGJ7QPgdsR4UibA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QEopQIhK5uG3JFMzj7e1nWaO4R0i9LfPW98i1C5FN1Ctgb/472qMZdDBWJpPDuxaH
	 1Lwcy7eYugXVoRnSVM4qpFvR9CSGOzAjMZTYPkpt4O0Ki/xyKMB777HeCjXBqJYMUg
	 63zwXIs5FojIWfo1crYBRMZ4LZUlGWzV3liaF2D6QXEMhzlDVjejk74ZuGR7Dcm7if
	 U9fkJAy9AgQS//hOrVU8kdL3wAqQ0JtLUPYOY0uWRPt7ICZBLG3W4z2hpYi2lxbJyH
	 7MOJrXtu2GWOSZd9BooyN0cF5kVP5WSYuDg39Lg3ZzNWl7efGWrbmxjhhjHfPhy3nF
	 sj9G5g1LN/CZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBB7380AC00;
	Tue, 29 Oct 2024 23:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ibmvnic: use ethtool string helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173024283324.846516.868225407370186564.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 23:00:33 +0000
References: <20241022203240.391648-1-rosenp@gmail.com>
In-Reply-To: <20241022203240.391648-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com,
 haren@linux.ibm.com, ricklind@linux.ibm.com, nnac123@linux.ibm.com,
 tlfalcon@linux.ibm.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Oct 2024 13:32:40 -0700 you wrote:
> They are the prefered way to copy ethtool strings.
> 
> Avoids manually incrementing the data pointer.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/ibm/ibmvnic.c | 30 +++++++++---------------------
>  1 file changed, 9 insertions(+), 21 deletions(-)

Here is the summary with links:
  - [net-next] ibmvnic: use ethtool string helpers
    https://git.kernel.org/netdev/net-next/c/89abb6b3bd7b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



