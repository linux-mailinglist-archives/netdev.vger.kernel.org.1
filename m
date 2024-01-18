Return-Path: <netdev+bounces-64255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFE2831EDA
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 19:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0BBE1C20C58
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 18:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49962D60E;
	Thu, 18 Jan 2024 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SA6GaiMe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7632D608
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705600828; cv=none; b=gAWx7VhXia2NTykN8XcS8m1b/fb2qbQTMTts2WcA0foVv9IEldktiPhxVuVxrocDR9uc+3P+1cs4ETvvJyUSmsHIxobJjXXLR1aGYf5kvpwb+FlsVZs+wuxy3Gya16Ie0SHT2blctZLrX1cc4q6e9BecUXKhH6lvDvZaTsjPN/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705600828; c=relaxed/simple;
	bh=rAcq0tMeIpsPq/nSiRX9MTPJ2LcdTKw8cB5YhhRL1nQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pVjfrj8ZTnBTUEP3XbjocDMihc0PnaT4Jo4yYOvjq6pH1Bwnp5kb8FaP3DrZ8KnjWsSrhh0Ln6DcG8meJ4wKtt/obqO9t6yYGN9M8cyLOF2UecgQ1Z/TYutnhrFUGrRhryU6+3WtpuxptLzyG++Wm0LC7zi1bMzwal2oOBbApzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SA6GaiMe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D637C43399;
	Thu, 18 Jan 2024 18:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705600828;
	bh=rAcq0tMeIpsPq/nSiRX9MTPJ2LcdTKw8cB5YhhRL1nQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SA6GaiMesFzITYf1V2FspcC4qNwgAWPn/45Tjrsx7TnSWAKGQc88hm2CDUgeeYpS1
	 STv4eEnkKPSJFbqn5o9PTVBtwm1aCvhT69U9gE3kqwTxNiBA1GIzFp4gAGKPsDrR84
	 lm0PUBPA26JJc1Xp3A704LZd+LbzYlw819iMd5QA0Sz4xdDfC2zFBlLcMYuL4SWCzf
	 ZVleYNM0BMwWp5wkb6XVSbHqkQOBUcs0gY4CFD5+6pWgsR+QXKHUjM8qqyDWc5zGWG
	 4SFNxOr6lrUUu0BJPGPZTZrxfzSr9T6rADIZOyaTtwqJqkyj/scJkruRZjnDZNU5FM
	 BjMEm1kZvtcZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17265D8C97A;
	Thu, 18 Jan 2024 18:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] i40e: Include types.h to some headers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170560082809.5819.7901962173523145524.git-patchwork-notify@kernel.org>
Date: Thu, 18 Jan 2024 18:00:28 +0000
References: <20240117172534.3555162-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240117172534.3555162-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, ivecera@redhat.com,
 micron10@gmail.com, jesse.brandeburg@intel.com, horms@kernel.org,
 arpanax.arland@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Jan 2024 09:25:32 -0800 you wrote:
> Commit 56df345917c0 ("i40e: Remove circular header dependencies and fix
> headers") redistributed a number of includes from one large header file
> to the locations they were needed. In some environments, types.h is not
> included and causing compile issues. The driver should not rely on
> implicit inclusion from other locations; explicitly include it to these
> files.
> 
> [...]

Here is the summary with links:
  - [net] i40e: Include types.h to some headers
    https://git.kernel.org/netdev/net/c/9cfd3b502153

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



