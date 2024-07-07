Return-Path: <netdev+bounces-109687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D09579298EA
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 18:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC821C20C5C
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 16:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819303D3A9;
	Sun,  7 Jul 2024 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osANAnuw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB402BD1E
	for <netdev@vger.kernel.org>; Sun,  7 Jul 2024 16:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720371030; cv=none; b=DZhFfJvUB+rHPlN1woE/03qdJ6L08mlZS8LkVt+ONuaWamQAEFaH/0UhErPhOTwuws4haz4qhX/qHfd4EZUyE1e6ZsoRZziwSxE0KrEaZ/kKfIT5PIuLsneA64QhreLh9CQ8Ny1ELHnKMB8st3j+d/oyX1PWvL6AJgvt+7sU/rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720371030; c=relaxed/simple;
	bh=pth/yXc5alJ8Ebd8NogPXXRR/DWF31glie57ePLXOws=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e5qqsn0aDvvIPNxIdZOdbdLzu38Ut+ZFCw+xBkhJ3oN8Y89vDwTWYEx4gWgWmhGGcoxl0MTukGEfNVnNLThgX4mkgVNKkD8z98t6J1X6quDNPoizYPwD7EuKg6IEyxTU2tM7qR11RSQ9WwVbzH8oiZs4+ddeZLAvhSdHUkSGJUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osANAnuw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C07F5C4AF07;
	Sun,  7 Jul 2024 16:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720371029;
	bh=pth/yXc5alJ8Ebd8NogPXXRR/DWF31glie57ePLXOws=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=osANAnuw92yafYaCN8WgHj/NUtnyHOOGWAl3XwfXNl158qBbalv8TVy1Yy48pYoN2
	 BTt+Jzg5sswm9OWs3uyYLu7uoRKCjnb5UAo9eTG1BVPGDskvjZQspKtfHgbwtmF3mK
	 L8NG7uE4nAp9PufgHMchaQ1QeJ/i41BdqPtyUbERrzg8F/UbwcnGV+ORLVm0AHNaIQ
	 9CY2CvWyFfG0TuuOjt7AI//smg4GR0BZvbkZJHAgZPMpZpnUwGVkOVkwA8jvM+RMt4
	 45TABB0ooY70lTbIO2GDL7EdSw54T8aS3NwFqq24KLQ6RXLE6dQt/03npyDjuXTYpd
	 RhtgoyAwGeYrg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD65CC43446;
	Sun,  7 Jul 2024 16:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next 0/3] minor improvements to makefile, devlink
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172037102970.5410.14923207218000674494.git-patchwork-notify@kernel.org>
Date: Sun, 07 Jul 2024 16:50:29 +0000
References: <20240703131521.60284-1-przemyslaw.kitszel@intel.com>
In-Reply-To: <20240703131521.60284-1-przemyslaw.kitszel@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: stephen@networkplumber.org, dsahern@kernel.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, lukasz.czapnik@intel.com

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed,  3 Jul 2024 15:15:18 +0200 you wrote:
> Three minor improvements: better error messages from devlink app,
> fix to one example in the man page of devlink-resource,
> and better build experience for single-app focused devs.
> 
> Przemek Kitszel (3):
>   man: devlink-resource: add missing words in the example
>   devlink: print missing params even if an unknown one is present
>   Makefile: support building from subdirectories
> 
> [...]

Here is the summary with links:
  - [iproute2-next,1/3] man: devlink-resource: add missing words in the example
    (no matching commit)
  - [iproute2-next,2/3] devlink: print missing params even if an unknown one is present
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=77241a525bdc
  - [iproute2-next,3/3] Makefile: support building from subdirectories
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



