Return-Path: <netdev+bounces-190348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEE4AB6669
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 10:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8062B16AC2A
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 08:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D211321D5BB;
	Wed, 14 May 2025 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPvA4XwK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DD5202F9A;
	Wed, 14 May 2025 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747212595; cv=none; b=eyHyt/6nxFFv2liUcOxHVF1JeaVWqU5w2y/L52LCMhKXi6ZmPfIfrFUx3fzoUa/cdPswZP8No9GrZWIOUBkU7D8My68yCCw3wGT0JVe2MeMXFkf2Isz2JgfuEpqbi4EXsqS5Ib9gl977dwAQay1pNgsEQsX/hxqWyrSLfosvtP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747212595; c=relaxed/simple;
	bh=IfhkhBM4JN5KmVYQaN4ITHZuJMrYU0PNMBAapg9fZEw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BmojF3JuBTf4jgEfdHqIQVF2CtI7XsMr5dF8B+MUlIeZp1maQ402My3Zgbxj3Ob4mZhrkjSMFtTvQwM5/dVdKqmF84ILJw9i6O8j/JwNPO/nyxf0Yj0xxRnz7ficVQ1pgNFL4p6cinzpLk1A38MmRoFQCpndRQ08//MbsAjo6ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPvA4XwK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C128C4CEE9;
	Wed, 14 May 2025 08:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747212595;
	bh=IfhkhBM4JN5KmVYQaN4ITHZuJMrYU0PNMBAapg9fZEw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lPvA4XwK7v+ysXnOfP1A7lekmup99ScilwdWlGB4YwiARcJ/+z5JkX+iWggks9VEE
	 R7oTY5xBpyvbiFT52BObaGl3ZN+oO3DN6UEovBTyMRUm+3sB+IOZ6zkPHK38dS094d
	 qFbPMZ4GaUfzPxsNxEAcYHcbaIQoNG8bG1HT6kjn8KtDOCQw6bqnvC2/qQSUHQHNz6
	 IzovE2p+6dBV2xjhPrD+QTOioftznawA2XI7dercA5GYYNbSYF2iEP5o+CyQKCoBkp
	 BNgmy2UoigcaoELcavkrqRSPh8zLo7h4Hj8Bdy1AKIfjkGYIGzbZ9WT3BmP8SVjsrr
	 Joojgi1sKkeuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCD1380AA66;
	Wed, 14 May 2025 08:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: enetc: fix implicit declaration of function
 FIELD_PREP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174721263252.1942803.15556777037257928109.git-patchwork-notify@kernel.org>
Date: Wed, 14 May 2025 08:50:32 +0000
References: <20250512061701.3545085-1-wei.fang@nxp.com>
In-Reply-To: <20250512061701.3545085-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 12 May 2025 14:17:01 +0800 you wrote:
> The kernel test robot reported the following error:
> 
> drivers/net/ethernet/freescale/enetc/ntmp.c: In function 'ntmp_fill_request_hdr':
> drivers/net/ethernet/freescale/enetc/ntmp.c:203:38: error: implicit
> declaration of function 'FIELD_PREP' [-Wimplicit-function-declaration]
> 203 |         cbd->req_hdr.access_method = FIELD_PREP(NTMP_ACCESS_METHOD,
>     |                                      ^~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [net-next] net: enetc: fix implicit declaration of function FIELD_PREP
    https://git.kernel.org/netdev/net-next/c/664bf117a308

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



