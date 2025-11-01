Return-Path: <netdev+bounces-234806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 76575C27536
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 02:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20F464E1756
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 01:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396D42264D9;
	Sat,  1 Nov 2025 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrtJeJ4Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7F31F5EA;
	Sat,  1 Nov 2025 01:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761960031; cv=none; b=uBxuHJ2XdDC9S6jh+sApiCsBbArq45HrkyEumUopJPKJEXM7fCYPaZXfnZ+FLHyjXamRFRaczynGEc07NxO6jc+2elPsKPRukGMbBobMwjs/slHn6jfaBPXe4Xooxss2Aw1GrM3NR1dEUMcGN2HBFttgI34b7GjEZTRYcs+tuoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761960031; c=relaxed/simple;
	bh=eXAytnhMDlCPHwQy4MoLj3OmHmssZHr1/L8mn2NuHbc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RIXOoUXmpAg0jG9Tn/GrhpvX/mEhKx1aFLbpuO7yE6NupskPOXw7l6SVWlDjIMfjYNZL4PqVYriTRjzpMnkfIcHgpS4waDlrHsGPFUkzWP/nBH6NKMantW5CcWxEpZJZ4tXqVckGHmUmVhWrmGOfrj8fUWUoumdw0aYvyGqI6SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrtJeJ4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81796C4CEE7;
	Sat,  1 Nov 2025 01:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761960030;
	bh=eXAytnhMDlCPHwQy4MoLj3OmHmssZHr1/L8mn2NuHbc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nrtJeJ4Qelpr+qXtmfjtrkJ1ZVB6gycYCyw6GBMCQUO87sVHvwQs7lTsVRgwyJY/n
	 Omn1e5kYU2bpkOZc9PWCW6aEEuohXFgfL6H+61GnZ48au5FHhEtHX08vjuvkn6mACU
	 uscqm8VgFZ2l6yIg+/h+ONyxpJdDyz+0tUOJf2wH3kHjyxhGQ9jDifh3bsjv+CMYZy
	 SgMYKDh+lijYIXym5hmmz2MRf92xXl8YpVAizBvn8A6cfO5k0mwyDC+6fopT4QeZ0v
	 DlxHrDHvxGBSfsHsf6sRZOdB94FJUp/Eny7JVKzBNSW511tRA5jG2OCPmquG7L9EiA
	 uA41gSo3+iKLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD7C3809A00;
	Sat,  1 Nov 2025 01:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] Documentation: ARCnet: Update obsolete
 contact
 info
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176196000651.686644.2911267178715301004.git-patchwork-notify@kernel.org>
Date: Sat, 01 Nov 2025 01:20:06 +0000
References: <20251028014451.10521-2-bagasdotme@gmail.com>
In-Reply-To: <20251028014451.10521-2-bagasdotme@gmail.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 m.grzeschik@pengutronix.de, apenwarr@worldvisions.ca, rdunlap@infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Oct 2025 08:44:52 +0700 you wrote:
> ARCnet docs states that inquiries on the subsystem should be emailed to
> Avery Pennarun <apenwarr@worldvisions.ca>, for whom has been in CREDITS
> since the beginning of kernel git history and her email address is
> unreachable (bounce). The subsystem is now maintained by Michael
> Grzeschik since c38f6ac74c9980 ("MAINTAINERS: add arcnet and take
> maintainership").
> 
> [...]

Here is the summary with links:
  - [net-next,v3] Documentation: ARCnet: Update obsolete contact info
    https://git.kernel.org/netdev/net-next/c/01cc760632b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



