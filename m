Return-Path: <netdev+bounces-107102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B86F919D29
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 04:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B624B2234E
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 02:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159517484;
	Thu, 27 Jun 2024 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5pKpMv/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A3B6FC6
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719454231; cv=none; b=nUB0BO/iFclrkz2+NewWjWwVU2QUScb5Tnt5AJiU/Cpi9CCKrxIAzMO8a94AVajYow6wd7tS+ZigUFMSB4XwUI0tcphOwlP7v+sctfyx1r8m5ZuN8eFyGDDUp5vt9Dt7QTfXEt1FU8cloGhSaoORzzU3No8GnBLg35pcMkpfPIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719454231; c=relaxed/simple;
	bh=cv7BSQQHwO4+cPMR5b5tQUzrm8c49mXXzZPRLefSrNk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MRLUxp+ibt9PHPXsxiRmsDf9OiywllwFdsPAKvUQL3W8ujcl1kw1B5FVhtAiarXAwJiV+wPhXVrDYjdVaaJThWcPdtSwarK9H6+MfUQzdj0PA4dpUqpRVr6b3wFJhhwqkOWQATGpAuiAqClpDU2kvAupfTnbDt4jm2bhfz/Og+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5pKpMv/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B62A7C4AF0A;
	Thu, 27 Jun 2024 02:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719454230;
	bh=cv7BSQQHwO4+cPMR5b5tQUzrm8c49mXXzZPRLefSrNk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W5pKpMv/3jCWx6iPdRc4v65NRJGFqvJQEk2k2XEVh7OKOmYAK0yuV7PZBTnvjjcBY
	 KCmGOXXFoyrZ4gpzBUSgAru3G1Oshk3X4J9JWz/MBHxOzFeE4zWWOPf+JWNz18cDVK
	 B5Ni7CxFj7vMoq85+cF7I/Y70vuY+QTeSrVonZy1K7O8yxOXy/wdG5+2M6V+0hIuuG
	 XZWPcdJYpIoOrGK01V/V/+15b+LqDGRPUKJ/Pf5enYaBkiBpcS0PoyvdJX/ZHwVZ15
	 CLJ4njCBvoPz9CRBjQ67Pw3JecqdHmhPxExLXzHfP98eySnA2atEoYNMS91nk7xB0e
	 lUHLMCSM2buGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA1E7C433A2;
	Thu, 27 Jun 2024 02:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/4] selftests: drv-net: rss_ctx: add tests for
 RSS contexts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171945423069.12118.12803113471439449544.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jun 2024 02:10:30 +0000
References: <20240626012456.2326192-1-kuba@kernel.org>
In-Reply-To: <20240626012456.2326192-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, willemdebruijn.kernel@gmail.com, ecree.xilinx@gmail.com,
 dw@davidwei.uk, przemyslaw.kitszel@intel.com, michael.chan@broadcom.com,
 andrew.gospodarek@broadcom.com, leitao@debian.org, petrm@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Jun 2024 18:24:52 -0700 you wrote:
> Add a few tests exercising RSS context API.
> In addition to basic sanity checks, tests add RSS contexts,
> n-tuple rule to direct traffic to them (based on dst port),
> and qstats to make sure traffic landed where we expected.
> 
> v2 adds a test for removing contexts out of order. When testing
> bnxt - either the new test or running more tests after the overlap
> test makes the device act strangely. To the point where it may start
> giving out ntuple IDs of 0 for all rules..
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/4] selftests: drv-net: try to check if port is in use
    https://git.kernel.org/netdev/net-next/c/8b8fe280155d
  - [net-next,v3,2/4] selftests: drv-net: add helper to wait for HW stats to sync
    https://git.kernel.org/netdev/net-next/c/af8e51644a70
  - [net-next,v3,3/4] selftests: drv-net: add ability to wait for at least N packets to load gen
    https://git.kernel.org/netdev/net-next/c/94fecaa6dcd0
  - [net-next,v3,4/4] selftests: drv-net: rss_ctx: add tests for RSS configuration and contexts
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



