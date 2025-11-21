Return-Path: <netdev+bounces-240624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E48C7705A
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 03:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 38630352C5C
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 02:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA1A26ED5C;
	Fri, 21 Nov 2025 02:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeSowuwf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F3D25EFAE
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 02:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763692848; cv=none; b=tKha7JoguK2Jadei31oZdi5rvgQUcpo3FHoUrHxZNIEXrhI/saCUWlGDvoTQgItc/zg2M/yhEvCRBv9bxnt8FQS50thiKxSz/A1uR6CXi6XlEOhDjufz4PWquRr1PRVvYIjHt3YS0u+NAVIvwV/rC18AoTiR3byCu+I3w85aFzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763692848; c=relaxed/simple;
	bh=wvy7vG54ay50VLt5YwsCqfaZFYbFYhS359b2uX0UA64=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kMl/1ns6jjAGUHQfRWRH4fF/b/89ua6Ss5WZ7k0OEAFF7DV1f7WGhEcfoTuZOkF3CX0O2D5SZVfmVjNSCyhErGXF97hlDofKxQ06QiPdBUGsO8T+GqGMNkqx8EglZLaKjJkxm6zHZ5ebrvG6PhXwtvSY3p41tJsDDNhvtiweMII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeSowuwf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7607C4CEF1;
	Fri, 21 Nov 2025 02:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763692848;
	bh=wvy7vG54ay50VLt5YwsCqfaZFYbFYhS359b2uX0UA64=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WeSowuwf93dpL2t1DFw09DHDMjKBkbOGHALccqwAWfwlGIulldLR/yKMZRs8jgfd2
	 amYnqNOZoJIEY4MO2DkAeDWl3FlFKyWcJA2JxXX+YhJcNJE782AKA+RJV+ROPZ2meH
	 TrDetWWFki4FSSI6sgEfTCtPWVfpS1bHyaIMbnfqt3+NAJRjVZsjC32CUaT8s8KKxF
	 qNHBEKiJnVlygZ2uFT946eDW8+FMPIBom/CsagfNWUY5RnRpkcw1apuW1zO5e6HlXd
	 PdK+m5KiF/roZnM/9H8fWFTyiFr8MdtCzYp5V8VPEMKQ4HOI31G0+feF1zs8UNu04h
	 wByomIbTYVUTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D253A41003;
	Fri, 21 Nov 2025 02:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/1] Add tc filter example
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176369281300.1867628.5837310870541891115.git-patchwork-notify@kernel.org>
Date: Fri, 21 Nov 2025 02:40:13 +0000
References: <20251119203618.263780-1-zahari.doychev@linux.com>
In-Reply-To: <20251119203618.263780-1-zahari.doychev@linux.com>
To: Zahari Doychev <zahari.doychev@linux.com>
Cc: donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 jacob.e.keller@intel.com, ast@fiberby.net, matttbe@kernel.org,
 netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, johannes@sipsolutions.net

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Nov 2025 21:36:17 +0100 you wrote:
> The patch in this series introduces an example tool that
> creates, shows and deletes flower filter with two VLAN actions.
> The example inserts a dummy action at index 0 to work around the
> tc actions array oddity.
> 
> ---
> v4:
> - Fix tc-filter-add return error codes.
> 
> [...]

Here is the summary with links:
  - [v4,1/1] ynl: samples: add tc filter example
    https://git.kernel.org/netdev/net-next/c/8b4e023d79b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



