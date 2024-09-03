Return-Path: <netdev+bounces-124433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 258ED9697D1
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 10:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D593C28A036
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 08:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799091C768B;
	Tue,  3 Sep 2024 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMBoGxK6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFB31C7662;
	Tue,  3 Sep 2024 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725353430; cv=none; b=ImAhtJX83LOOT1jEabuHmps1zeE9/KGfHPD67oVISup05a1oe5/qQN0aR0lDdeZcycezc5DURKcvZuiPxOQAr1INZlb65ZGIx4iO+SGXs7kVDOoS3syVZTt2/awVbfFL3EyL85KtH1DuNk686Etw9644uUcQS8mzdg6HzhUTOCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725353430; c=relaxed/simple;
	bh=4mHd+JzrSWsn4wEgnwlHfHRfgWpiCwtBiy0CiLviTPk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SHJ3fllW8avIoGv7VoEkjnvd0Y0ErQwda2YnJrhBSSEGJRiuK1/7BkSvPNrjl/u/wQxzAVZc1jluaFe5s7ceBhfcMMdm9dSBCcFWeThHe1lkxlwb5cZb5tVP0IzWsTlLvvgwlbEANvaFEjh7xdka5helryyrESh9VTh1wW8I0FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMBoGxK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C814AC4CEC4;
	Tue,  3 Sep 2024 08:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725353429;
	bh=4mHd+JzrSWsn4wEgnwlHfHRfgWpiCwtBiy0CiLviTPk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vMBoGxK6j0nkdX9OOM//zNsGdDak1KCLeU/I695WRXHz8zcuvDBlFkoN+stS1/9/+
	 E/8P8BAF8TtjRHOhAnUC+hxyTV4CiN7+GakZRVVUOTv40bYUtbQOOqzNaenrOipvAq
	 3z81aOj2tygq3G3kgyhkFcc40/MZp9K6nsjPTn2YihgwEakuC7lJIppIiayEuk5UBS
	 YaFiYi1Cutg2t7EsNx11ELYrr5FnAB90U3UHRQ5pL+/gxS5u7RPtXSR9VZaA09Bmda
	 r+zdvbDSPP4sgcamOICrtcsXLRp1S8dt6i0UYFmC8u3k7kmrTzyfuu6noinrHXByP3
	 /txQKl5/iV+2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE363805D82;
	Tue,  3 Sep 2024 08:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: dsa: vsc73xx: implement FDB operations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172535343050.216623.17080034162332629200.git-patchwork-notify@kernel.org>
Date: Tue, 03 Sep 2024 08:50:30 +0000
References: <20240827123938.582789-1-paweldembicki@gmail.com>
In-Reply-To: <20240827123938.582789-1-paweldembicki@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 27 Aug 2024 14:39:38 +0200 you wrote:
> This commit introduces implementations of three functions:
> .port_fdb_dump
> .port_fdb_add
> .port_fdb_del
> 
> The FDB database organization is the same as in other old Vitesse chips:
> It has 2048 rows and 4 columns (buckets). The row index is calculated by
> the hash function 'vsc73xx_calc_hash' and the FDB entry must be placed
> exactly into row[hash]. The chip selects the bucket number by itself.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: dsa: vsc73xx: implement FDB operations
    https://git.kernel.org/netdev/net-next/c/075e3d30e4a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



