Return-Path: <netdev+bounces-89851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1688B8ABE74
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 05:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EC082810F5
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 03:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D326B17E9;
	Sun, 21 Apr 2024 03:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vK3BeeVz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD22338C
	for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 03:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713669027; cv=none; b=MKIJAAImDB0cEHQkhrkL+HZnBYf3/pIBqsB0gGX5Z0sZJtfFzp25mTqoJjuzBFIMAL3wjSh5knX6a0GssLwW4G9uNpPDaueNP/G18REcWVT6AdO1bfDi8vOequJIIlnUfv5WRGGYRnaZmWFPs0TvNepdKrtXGSu68USlkRd41ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713669027; c=relaxed/simple;
	bh=ircFYc4kIlkRbj/zm9NBrQ2aQvD9SNZgzN634lMoxYY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GMWR2C6Zj/HkUbNDCAva39oftG+nLlKOnitAJ1SxpPh4hAmcY9fU6jumqoL6zlLcxN6REFm4uWVRIOz96wzwJkKY3m1etf0erpBuygMveOvK1QIeidkMxEIUK3T6Q5HXtE65/3/pi1YF0BqKaPjMivXJDfifTId+MdKqI5fw7/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vK3BeeVz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B3DAC113CC;
	Sun, 21 Apr 2024 03:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713669027;
	bh=ircFYc4kIlkRbj/zm9NBrQ2aQvD9SNZgzN634lMoxYY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vK3BeeVzXvp23KjrMx57RjE3ilYCjlLkJS5KOBVDefzmwCV99D6fKsVaV3lLqiB9j
	 Av85QdANpu1KTyduhnpxJ5lh3Wa1ftQ0WjCFiRSSaH0PkvCfdKV/KD4vRINmp9JmUZ
	 2H08RPkDgNCYr04e8HXd3YkABvm42BLR/2J/R3NZ0vOeENJv/4uMOo4WoD5e5r2FdH
	 Gnl7Cp4MnXkvNPGdrai02g8lPhLuQYa+qa/cDR2lVhhaTpvNnHjkBkIe9AsLe9OMmd
	 0pk9W33YTRTjQvYEWtUVdUH3+5Z6vfPWF4WJCmqemxYjQT14LHliNHhvgLZs8/h52I
	 xXmo/Z1A05CpA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32EC4C43616;
	Sun, 21 Apr 2024 03:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] man: fix doc, ip link does support "change"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171366902720.17190.8973003011969913650.git-patchwork-notify@kernel.org>
Date: Sun, 21 Apr 2024 03:10:27 +0000
References: <20240416013214.3131696-1-chenjiayunju@gmail.com>
In-Reply-To: <20240416013214.3131696-1-chenjiayunju@gmail.com>
To: Jiayun Chen <chenjiayunju@gmail.com>
Cc: netdev@vger.kernel.org, shemminger@osdl.org, jiayunchen@smail.nju.edu.cn

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Tue, 16 Apr 2024 09:32:15 +0800 you wrote:
> From: Jiayun Chen <jiayunchen@smail.nju.edu.cn>
> 
> ip link does support "change".
> 
> if (matches(*argv, "set") == 0 ||
>     matches(*argv, "change") == 0)
>     return iplink_modify(RTM_NEWLINK, 0,
>                  argc-1, argv+1);
> 
> [...]

Here is the summary with links:
  - man: fix doc, ip link does support "change"
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=11543416d9bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



