Return-Path: <netdev+bounces-83481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC358926EF
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 23:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9021C21176
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 22:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57E013AD14;
	Fri, 29 Mar 2024 22:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kqxd8pos"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB3D1E4AF
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 22:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711752630; cv=none; b=YBqEcBjjNhl7fazIqqhbMoArYnhY8LHCmrUGr/hF1E1LAce7I6CZNP5C9MATecyWlgClGG8uy+03Tw2cp3AvUzv7mVj7+/1A+D8GVYxMN7cjJpQSNHazIgrMU8Jqf3+n94yKZ/MG+W4IWi/q+Trc7zQoCYhf6wRib4z/cmyMufs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711752630; c=relaxed/simple;
	bh=0xSrbhVRLFmUIcaZIqos1lUTkOMkyEF9gIl/OPckFsk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nojUvpr24C4sGn9OzFaSUiUJrprlikgPajC0beX4AF7/ccrWT+o0b1uceMpPuxCCxA+apRDCQEgx6pwkQhVNiPpMl5y+RnlbOuAEzBhLPMtdMzyS5IH+g29Qxss2TMAA5DJsPyd0HWDjdQ57JW2lcBVmiU/tJXEdm4zWA1X7PCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kqxd8pos; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2ADF2C433F1;
	Fri, 29 Mar 2024 22:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711752630;
	bh=0xSrbhVRLFmUIcaZIqos1lUTkOMkyEF9gIl/OPckFsk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Kqxd8posCZJyZO5qNG/T9o2zwIRX5vMUgUrUvdG1vpkbeA2+bFGiF6b9qqHSP8G7o
	 +zqPA14VnCGTptHWKfAzlpaAHJMl5/SiMklgGDBrP3DoPm14hLOE0YJOv78fY0/H/J
	 HIhLfsQsHRRA3DafiN0WHVELi9Hla4tpMnW8CDAPJ4EqTqtBHpUpKmAayfuzSWaptz
	 PYZ3oR73n6eMMANn9fyMTNtAH+X4szsVXgzjrGDGY/sPRLdthRtN01Zmbu0lbjuT16
	 ztnO2rJnkWytR5WTwb2MNNm7pRt+6rpmsy32ADs82ShtXPlJyBqOlFIzyWq9vuBULD
	 5asYRlpqG8mJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1975ED84BAA;
	Fri, 29 Mar 2024 22:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/8] tcp: Fix bind() regression and more tests.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171175263009.1693.14920822225221802493.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 22:50:30 +0000
References: <20240326204251.51301-1-kuniyu@amazon.com>
In-Reply-To: <20240326204251.51301-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, joannelkoong@gmail.com,
 wujianguo106@163.com, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 Mar 2024 13:42:43 -0700 you wrote:
> bhash2 has not been well tested for IPV6_V6ONLY option.
> 
> This series fixes two regression around IPV6_V6ONLY, one of which
> has been there since bhash2 introduction, and another is introduced
> by a recent change.
> 
> Also, this series adds as many tests as possible to catch regression
> easily.  The baseline is 28044fc1d495~ which is pre-bhash2 commit.
> 
> [...]

Here is the summary with links:
  - [v2,net,1/8] tcp: Fix bind() regression for v6-only wildcard and v4-mapped-v6 non-wildcard addresses.
    https://git.kernel.org/netdev/net/c/ea111449501e
  - [v2,net,2/8] tcp: Fix bind() regression for v6-only wildcard and v4(-mapped-v6) non-wildcard addresses.
    https://git.kernel.org/netdev/net/c/d91ef1e1b55f
  - [v2,net,3/8] selftest: tcp: Make bind() selftest flexible.
    https://git.kernel.org/netdev/net/c/c48baf567ded
  - [v2,net,4/8] selftest: tcp: Define the reverse order bind() tests explicitly.
    https://git.kernel.org/netdev/net/c/6f9bc755c021
  - [v2,net,5/8] selftest: tcp: Add v4-v4 and v6-v6 bind() conflict tests.
    https://git.kernel.org/netdev/net/c/5e9e9afdb504
  - [v2,net,6/8] selftest: tcp: Add more bind() calls.
    https://git.kernel.org/netdev/net/c/f40742c22a6e
  - [v2,net,7/8] selftest: tcp: Add bind() tests for IPV6_V6ONLY.
    https://git.kernel.org/netdev/net/c/d37f2f72c91f
  - [v2,net,8/8] selftest: tcp: Add bind() tests for SO_REUSEADDR/SO_REUSEPORT.
    https://git.kernel.org/netdev/net/c/7679f0968d01

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



