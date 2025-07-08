Return-Path: <netdev+bounces-205068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DFDAFD041
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 18:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106A23B237E
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3842E5B07;
	Tue,  8 Jul 2025 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpgOmFU7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192291E412A
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 16:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990997; cv=none; b=WDUsQ5PF+BjvACZEl0JZIJeZr3NH1owMbq/C/SRYDeVPuUsXYaph9rIpOeW585O5UMBGDHRaHWDelGqfv7O4x/qW5Ne6NOXsYrxrPrLGEMURCLi6EuPUKcnXnMSXf2K6ICzS2IPw68IDQvoEFxTQP0ybmcyJq1Go3aSOr4r8D2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990997; c=relaxed/simple;
	bh=4J02pTv3gBrtFQI81poru44nWk8EMJVXASSB0YL5PIw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sey9BJZllGBHECbe5C4ypfizJZD3fsbKXKNPAV6KYtkRvTgUHwf4M3+EAoOAHoD3DD/AJcWNpB5VmE+DY8HJ7B1LA7Hdn//8/IqvJH8cA9D/UdIGHLrykBJ9sA1EH7AcZDfi5+larFa2SK+vSltTvTjAqZonuEf3REilGQFtLsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpgOmFU7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95798C4CEED;
	Tue,  8 Jul 2025 16:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751990996;
	bh=4J02pTv3gBrtFQI81poru44nWk8EMJVXASSB0YL5PIw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SpgOmFU7D6p9nE9lGpXlPYQnibDfW9IiiOkjSOFK3UsvG7oVX32gPa64ISKaJpxem
	 mArKB0IXnKXk3rkr42U8d/gYW570EVUXKBbrcrvUsANLKdFn032E3+TmgxgI69iaAr
	 vMp6IRSwWLiXcWYrE6juUc/4EpLnXVwQnl3IJEwiSlhe5ruyV853XWGtaaMcu7arJq
	 qRxi92Pc+cM1k55/Zkv4ZD6Yh4zvGNbGD+eAZCK5k9ZzhCuVsYeSazBL/cHvLXxJem
	 mv53neHC3/cwviaRLV9etLWTheXsaO2WqyP82bGwTB7KkdBU+jEvqMpv0RsJhvMEmu
	 S+YKdvSOVM16Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD2E380DBEE;
	Tue,  8 Jul 2025 16:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] tcp: update the outdated ref
 draft-ietf-tcpm-rack
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175199101924.4122127.6824306188582846442.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 16:10:19 +0000
References: <20250705163647.301231-1-guoxin0309@gmail.com>
In-Reply-To: <20250705163647.301231-1-guoxin0309@gmail.com>
To: Xin Guo <guoxin0309@gmail.com>
Cc: ncardwell@google.com, edumazet@google.com, davem@davemloft.net,
 dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  6 Jul 2025 00:36:47 +0800 you wrote:
> As RACK-TLP was published as a standards-track RFC8985,
> so the outdated ref draft-ietf-tcpm-rack need to be updated.
> 
> Signed-off-by: Xin Guo <guoxin0309@gmail.com>
> ---
> v1:including the other two ref draft-ietf-tcpm-rack
> 
> [...]

Here is the summary with links:
  - [net-next,v1] tcp: update the outdated ref draft-ietf-tcpm-rack
    https://git.kernel.org/netdev/net-next/c/19c066f94066

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



