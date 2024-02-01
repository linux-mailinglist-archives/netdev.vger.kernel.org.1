Return-Path: <netdev+bounces-67746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65637844D9D
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 01:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2064A28F093
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 00:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E66372;
	Thu,  1 Feb 2024 00:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7f0vBpP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD90184
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 00:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706746225; cv=none; b=PfKxtgYieu4eqDwIcAbUft98geaqYaYVqpeiX8cq7fVnYs4o8Q6r1duryQacySXk4PQCq76tJF9enVufb+OUgyUmMUV+gPuRg86y2MHhWOTepaDZBcgX55nUTwF2iV/iFfIEvooFYB6lBCTfzaqqEIf1FZmOfjY///a9uDK7PnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706746225; c=relaxed/simple;
	bh=oUwgQllIveGvw3jSh50dqKHf2YsQ2L46fCnnRBo7RfI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pUXd6naF+csaYWBN1wK1bPFrm7opcJoE7cJ0oEaGrsHQV5oMz/l30z5DDVaDgE7RpgjC/E9Kbl2YbbH86udN2someTk7cmFtdbdnfxGtG+XsSlJ7swQsQHlScql8FTZTMBdzNBav5pCdFfR/5JI+yiIwDNPOSXGW7xRpr34Eo98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7f0vBpP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7BA93C43390;
	Thu,  1 Feb 2024 00:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706746224;
	bh=oUwgQllIveGvw3jSh50dqKHf2YsQ2L46fCnnRBo7RfI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f7f0vBpPl+eefrUVNy604JK6ip8o6RijBUhBZlWKG0ORXf804KvpIOEoxNtchEbOz
	 v7U1Q6DGkRZeFFQCkFIIaTObYcqaV7/tkjV2s3FRAo659zO5JpYXv8huBvY1AjeGvs
	 THJsRbSbiWyM85k6dSGa75CdhV6yFX8XAtYGWp3xpTIVALorcG+qtfruv0wldb7CnM
	 QiO7K0/FajK07OSfC2qq21mRgkz1bleHORyX1qg1iFxoPaxkhWUQl/V2SVQ/Wm+c/3
	 pgAB2UQwyOLygabxSD91E9fudACSO0Bf6yqogjrvOKIWelX7/dtOmM0mVyyeqJOIfe
	 4sDKl35HmzsGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 580ABC4166F;
	Thu,  1 Feb 2024 00:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ip: remove non-existent amt subcommand from usage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170674622435.5414.5096091905930057925.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 00:10:24 +0000
References: <20240127164508.14394-1-yedaya.ka@gmail.com>
In-Reply-To: <20240127164508.14394-1-yedaya.ka@gmail.com>
To: Yedaya Katsman <yedaya.ka@gmail.com>
Cc: netdev@vger.kernel.org, ap420073@gmail.com, dsahern@gmail.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Sat, 27 Jan 2024 18:45:08 +0200 you wrote:
> Commit 6e15d27aae94 ("ip: add AMT support") added "amt" to the list
> of "first level" commands list, which isn't correct, as it isn't present
> in the cmds list. remove it from the usage help.
> 
> Fixes: 6e15d27aae94 ("ip: add AMT support")
> Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>
> 
> [...]

Here is the summary with links:
  - ip: remove non-existent amt subcommand from usage
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=327741c6e8ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



