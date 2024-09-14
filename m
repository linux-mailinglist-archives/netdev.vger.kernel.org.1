Return-Path: <netdev+bounces-128286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CF8978D52
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 06:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED0CD1C22437
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 04:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E42E1758E;
	Sat, 14 Sep 2024 04:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZ/auueq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499F52030A
	for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 04:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726288237; cv=none; b=H66/KZL5TMQlLtMtZDG8OhYc5Sp9pU141GuYaQfT7ypJUQfT9gJYpNBzMMp9h+0q4lDZXFn5SpnaAjidt0Pkq3SK3HTzUMX1zFvmt2x06D9I+nhkowywS0KaU38JdphF/EGL5vh68zlw5M5dEUl4IK9fL8vNfTK2BofswM/M9QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726288237; c=relaxed/simple;
	bh=NMUPQD005OP4C3erF/vLLTe1K2R1XxTo2ZUIURE094o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XG2/7wzaXBoJj/+jnch1CEBYI3gkI9bJXTQeXWQobzqfXbJvVQTFOLtKxc8SnTHCKisu6syp9+BidaMQ/uuflpx7iUKUXiz2lHwUi5qP1V28ZjpG1I3jFFz8LsAaxkipGP6pixy5fP5imWgQMAgXOoJRkbFXOqk/Ab1rHSd5e8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZ/auueq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97D1C4CEC0;
	Sat, 14 Sep 2024 04:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726288236;
	bh=NMUPQD005OP4C3erF/vLLTe1K2R1XxTo2ZUIURE094o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sZ/auueqVkEpP1XB6EU2etnb48PfvfuoRcRJlhI5IAP54aInQ+GVOVG1noDNUqrzh
	 6Qf8e5N9Q8e7l5iRqaysdvvuCDV/+vvlrCx2BGN4s84NDUh5N/R/xW9iiZ4fT+j97H
	 f4q/1lk3PJRtYkyqCKcbPySlIohPmFbjAZD49gDolBKUtOWVXliDbaWjDPmnJL4Db6
	 1rjUY1RzTTx8g0qUMwT+LjdN1muap5mwVV2/vz26vWkk9pnNnd2epTCCOoRvTGTFML
	 gnOxcsMutV47fA+pT5rjO+MsTdqvdVRT+pPT/LxaXDw0L0DN5Y4gPiOl4JuzcdQB2+
	 WpEVBOa3UOnug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711F23806655;
	Sat, 14 Sep 2024 04:30:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/4] enic: Report per queue stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172628823799.2458848.2882390106810000351.git-patchwork-notify@kernel.org>
Date: Sat, 14 Sep 2024 04:30:37 +0000
References: <20240912005039.10797-1-neescoba@cisco.com>
In-Reply-To: <20240912005039.10797-1-neescoba@cisco.com>
To: Nelson Escobar <neescoba@cisco.com>
Cc: netdev@vger.kernel.org, satishkh@cisco.com, johndale@cisco.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Sep 2024 17:50:35 -0700 you wrote:
> Hi,
> 
> This is V3 of a series that adds per queue stats report to enic driver.
> Per Jakub's suggestion, I've removed the stats present in qstats from the
> ethtool output.
> 
> Patch #1: Use a macro instead of static const variables for array sizes.  I
>           didn't want to add more static const variables in the next patch
>           so clean up the existing ones first.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/4] enic: Use macro instead of static const variables for array sizes
    https://git.kernel.org/netdev/net-next/c/a59571ad6dfc
  - [net-next,v3,2/4] enic: Collect per queue statistics
    https://git.kernel.org/netdev/net-next/c/f3f915099496
  - [net-next,v3,3/4] enic: Report per queue statistics in netdev qstats
    https://git.kernel.org/netdev/net-next/c/77805ddb5755
  - [net-next,v3,4/4] enic: Report some per queue statistics in ethtool
    https://git.kernel.org/netdev/net-next/c/bde04d9876c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



