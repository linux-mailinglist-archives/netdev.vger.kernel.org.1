Return-Path: <netdev+bounces-110057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B3292AC1A
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 00:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 365A91C222B6
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 22:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040F8152517;
	Mon,  8 Jul 2024 22:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKUa4O7I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32B514F9E9
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 22:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720477833; cv=none; b=tPQ31HPGis9RGMnFWjiU3KaRD6QPu82IwDM02bSHukpCvYksOTq+VFQF4WzN8Z/2CvKucFoRw1OANBohd6+vHXnV8yXAQBOz6Oih7TnygbcJgJqVJ+zCgdKuGJLcncr64/xv2QmD9wSZXW4FD+6zM40oalWvxJxolJFwo6HEfAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720477833; c=relaxed/simple;
	bh=xYZS8qYQT3/Sjr07lZ3XQdhKVJH0iYUZtYazBGnrhzg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Txky35G1WEPkCGkmeJruIUbKWMF0obNtr8s7AzSIGVa2m1OXK2Ts4yLnx7OqbvHRa2fkqFJODCYf/1Ajukur9sxVBdfaMUer5lfOXw7j/r3jZS4zFmq2dg6+tOAbFEqnw25Ega4I+DhDcjAOJpCPzzreG9vjV90QhrGdMs34WZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKUa4O7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C588C4AF10;
	Mon,  8 Jul 2024 22:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720477833;
	bh=xYZS8qYQT3/Sjr07lZ3XQdhKVJH0iYUZtYazBGnrhzg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RKUa4O7I+bVm76OpRvDrvHUVXgVGhyVNyhRKfCpjbGoGLPNb3y54OBHSWocbUJDoC
	 LUbk8wIgkAKh0KJ0Gynf6THFqKN+oR3wY2ZwWPBozvl5Seo8fA81hbOE7kI0XI8NDp
	 nezi0F26y2amZXKhG0tOEjCgSkl8rSq/pQgO3HxE0zPfNpUfEQiZ/+/6x/cld9TCbq
	 7aDlj+qcLGfFCC4KnJXW8RcHZifYOu4Njg4+xMNvDJVmQXSWrIo0mfLA8D7p85EbeJ
	 uUnvEmyZcmhkyWfrju1UP+1NuysWBWM777ZqcfCTaarOiHnorvHRYokogWO7gnuJ71
	 oiTKEzDrTeE9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F941DF3714;
	Mon,  8 Jul 2024 22:30:33 +0000 (UTC)
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
 <172047783338.17442.9067699938088808843.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jul 2024 22:30:33 +0000
References: <20240703131521.60284-1-przemyslaw.kitszel@intel.com>
In-Reply-To: <20240703131521.60284-1-przemyslaw.kitszel@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: stephen@networkplumber.org, dsahern@kernel.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, lukasz.czapnik@intel.com

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

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
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=830f490e92df
  - [iproute2-next,2/3] devlink: print missing params even if an unknown one is present
    (no matching commit)
  - [iproute2-next,3/3] Makefile: support building from subdirectories
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



