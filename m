Return-Path: <netdev+bounces-107435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0E591AF76
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 21:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C8A1F21A80
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 19:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63BE19AD6D;
	Thu, 27 Jun 2024 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMPmD6Jo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7C01E4A4;
	Thu, 27 Jun 2024 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719515428; cv=none; b=XVU6QEsWFH+K+Ya6xkCZ+wXhIBerbyoMUUzPP1Y1C4HKUtL7JcV1g6kjvILh4ksrCqnTpnulZObpQcy4hGEtSSqA2heeNImKe3hkklQJPZuCk3EHkps+xurFkGdfKJtDP125YTdnqVj29hfJbBum3tc3ldVRsrvJeuKYq99oaVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719515428; c=relaxed/simple;
	bh=qfy8lFyoB/C/R/LH7+ilh1HZPWWF34bCY9PBCEOT/VQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cU6jrhcP6D0sGa89MIeiU+jeaHGm30LWfEMptRuxvIlGrQuO0BWGO6WBoOUVG6jdzN16B+v4PkMr9jolFjQg6wegB4NqCpxDnGYXjSx4k6ImW+GRLvaJrTN2fYkQfY08I45XA+WwsYMRY9mQCYhvEWKnGfFzt3k+AgWCBYYvHLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMPmD6Jo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14579C2BD10;
	Thu, 27 Jun 2024 19:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719515428;
	bh=qfy8lFyoB/C/R/LH7+ilh1HZPWWF34bCY9PBCEOT/VQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LMPmD6JopuNdbwvV31kqy+kkJIer4z3XoW5DEgtz8U/eDlaANTE+aXIMYZbMwmTqb
	 rlda8Db8ymw/fy4pPPpzxfsUgAf3IUE0DyOFpAXGe3VimQbNfiruL/xePi+8w/sU4f
	 f5F8RA8ljANttCPX7Eay3AfMzr91/ANBHfQwuZAQM7J25YCEmOAChUNsHThw2p0rEy
	 C9yiwlZauPIENS4Mzgh0vdGglrrwP0PzlxFea5HOG7d5pu1ElLZblhdKtkwmO0rHi6
	 bEwI10Eb29z/kxMZ6ECLjVkjgE8oDvkEwqdlc1h9VWExHEmv4Z2iL969zXgGBeeZRv
	 XXX055ivFNC3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 049BFC43335;
	Thu, 27 Jun 2024 19:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-2024-06-27
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171951542801.5140.13903874476521335100.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jun 2024 19:10:28 +0000
References: <20240627083627.15312-3-johannes@sipsolutions.net>
In-Reply-To: <20240627083627.15312-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Jun 2024 10:31:50 +0200 you wrote:
> Hi,
> 
> So you probably heard Larry Finger passed away, he will
> be missed. Others have written more about him elsewhere,
> Kalle has updated the MAINTAINERS/CREDITS files for him.
> 
> Other than that, just a few small fixes, really the only
> one likely to matter in practice is the fix from Russell,
> for those who use the TI chip in AP mode.
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-2024-06-27
    https://git.kernel.org/netdev/net/c/ffb7aa9fedad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



