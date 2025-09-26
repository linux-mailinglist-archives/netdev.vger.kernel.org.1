Return-Path: <netdev+bounces-226760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2485FBA4CD2
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 20:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607E0188B0D0
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 18:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9308713C914;
	Fri, 26 Sep 2025 18:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6syQtr/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3706ADD
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 18:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758909623; cv=none; b=K5Ex9kJ1xxGRuZG2tZ3hOGShd9BnNNubT2F3IkfEsH5fTBlb9r7il7Gr3cvPMPEE9op6XRe44BTW7C8ishHXJNbLq4vWi3qiCLg2rd1KVWXbzzSdBsP3xuX7waBHsiVbgzu9FqV8m31Kn253ZeilN150hSLadEqL7JmNQvXp1qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758909623; c=relaxed/simple;
	bh=Hi62dTOp/TjAX7K1qZMYjQvze9+uPKwIE3etvjLJq2E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=akGTq1KMXMPvtzWmk10aN6NZ8ntyny1ehcYNI1BqRN6Fk83Kyee5uchpWNoHwIP6DJLrYoqYbJaMK47agkV94JLFvCbiob/KLdhiXdE7d0a3EX3gMLQ1QDTLjmuSpLoAUH7+DPGDLVNtrKShTgKRfSFefLDO2yk6oY01oeskG2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6syQtr/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E382AC4CEF4;
	Fri, 26 Sep 2025 18:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758909620;
	bh=Hi62dTOp/TjAX7K1qZMYjQvze9+uPKwIE3etvjLJq2E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c6syQtr/lhAa2635Ed4nLhW2dvdMxllQJiUmwEAGL5L0WBMhLUFFzo+3PdeureCCP
	 vlPcx3RruD5CtuJweur8M4Lliw7+pOC1igyjT/KQm6o9CqscvLbN1Lj3HC5UwrS2OC
	 Ar8jXVQBGKio5z29Gthx1Bz1sB3WO0ADrB4dKNMZG95Yv1PDtxpXyNkQN26niqxEkU
	 /R1IlN22e+Iz0zKswduih26tFC8FisorrRhkbktqmmpMpPxDG1YjR6iCjjKjMEJZRR
	 OCKe+WxDJbzSedFDhivx3DRGlyBinClWFnv0IWK0tBryEYxYPFxDnhO+4jYw19dYPx
	 4NP79CY9WZ1ng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CB939D0C3F;
	Fri, 26 Sep 2025 18:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] man8: tc: fix incorrect long FORMAT
 identifier
 for json
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175890961625.9507.3194273249780059434.git-patchwork-notify@kernel.org>
Date: Fri, 26 Sep 2025 18:00:16 +0000
References: <20250925111250.61576-1-lieuwerooijakkers@gmail.com>
In-Reply-To: <20250925111250.61576-1-lieuwerooijakkers@gmail.com>
To: Lieuwe Rooijakkers <lieuwerooijakkers@gmail.com>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Thu, 25 Sep 2025 13:12:41 +0200 you wrote:
> Signed-off-by: Lieuwe Rooijakkers <lieuwerooijakkers@gmail.com>
> ---
> This will fix the man page for the tc command, the FORMAT specificer had the long form for the JSON
> format specified as -jjson instead of -json.
> 
>  man/man8/tc.8 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [iproute2-next] man8: tc: fix incorrect long FORMAT identifier for json
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=9b6fc48fdc08

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



