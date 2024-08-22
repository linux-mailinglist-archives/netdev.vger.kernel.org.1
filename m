Return-Path: <netdev+bounces-120778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79B195A959
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 03:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34BD628380E
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 01:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDEF79F2;
	Thu, 22 Aug 2024 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRHoQjI/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0C39461
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289029; cv=none; b=e3n4Ll+RZCvUujnLEs0Fx7Qy+PhQSio3kJ2bLCAqtPZV+AoGiCu4vJ0Wy1T32F5IR4wT1q+Ocw7Z3GIQf96O8gLTMTlyHD8Joi0HfQNS5P6bNMEo3Zf21Gr69RMXe8z6vS9EJav+cqEvhZrD8z9EXbVYK5mx3S7OSFkP8/ckvik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289029; c=relaxed/simple;
	bh=2im7gXt6wSPk8zhI0OASBVqhgQGgPsT9u4EEUYijHjA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ru30pLu5Ywgv+ysC9ktNY0ZKShA3YPrFWlWMbf6QqoksFEv16mGmLqMZUntNIAZANalRZXvOd0ab86wTIerDXtaQro/3Rm4oHbGQfK+Z6HGMfGSW4j13lvm5Bb7NyPT3Jx6dKY25DlnMOxLaZxL9h140jHs5ysRATI2UxZ15D68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRHoQjI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33D4C32781;
	Thu, 22 Aug 2024 01:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724289028;
	bh=2im7gXt6wSPk8zhI0OASBVqhgQGgPsT9u4EEUYijHjA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LRHoQjI/aCnFg4sgiu4Oiv8qhuqPL+9hvgcXgpGHtY7o0W4jO/et50b4cOeM+nDtX
	 WWze8S05+Eo/pajCaSlKXOwGy+E6kjQxuPkbSJD1yuFw3ca8pBrdgAeglYGS3v/sFr
	 jj+GdrhMr3w9NN4pmQ5R5e0ODF+aaT0/KfwVxSfaNE8670iatB0KuPqaf0502L3pSE
	 8dKlo0uv53lc9Neu8BzzhDKmkZpDO5Y5SB02aoNb+193wpZzGs+a6qFkr14oRwdXkc
	 2Tleq0oB4h8voFe43KDLoGdZ/4m+AXlGNkaRqxkRyAX0VXOpb4I0yQ4+7WMTFIJbz0
	 NwRhzqp7rTKHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD383804CAB;
	Thu, 22 Aug 2024 01:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates
 2024-08-20 (ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172428902849.1877102.12384594563801386182.git-patchwork-notify@kernel.org>
Date: Thu, 22 Aug 2024 01:10:28 +0000
References: <20240820215620.1245310-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240820215620.1245310-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue, 20 Aug 2024 14:56:14 -0700 you wrote:
> This series contains updates to ice driver only.
> 
> Maciej fixes issues with Rx data path on architectures with
> PAGE_SIZE >= 8192; correcting page reuse usage and calculations for
> last offset and truesize.
> 
> Michal corrects assignment of devlink port number to use PF id.
> 
> [...]

Here is the summary with links:
  - [net,1/4] ice: fix page reuse when PAGE_SIZE is over 8k
    https://git.kernel.org/netdev/net/c/50b2143356e8
  - [net,2/4] ice: fix ICE_LAST_OFFSET formula
    https://git.kernel.org/netdev/net/c/b966ad832942
  - [net,3/4] ice: fix truesize operations for PAGE_SIZE >= 8192
    https://git.kernel.org/netdev/net/c/d53d4dcce69b
  - [net,4/4] ice: use internal pf id instead of function number
    https://git.kernel.org/netdev/net/c/503ab6ee40fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



