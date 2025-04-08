Return-Path: <netdev+bounces-180510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5470A8194B
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 01:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C88C1BA3B67
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 23:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B8B2571C3;
	Tue,  8 Apr 2025 23:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoEPvS1b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E95A2571BB;
	Tue,  8 Apr 2025 23:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744154651; cv=none; b=mIHj+HWQElQN9GJXGBoIlr9YWYKHHsv3cuenRR3N0gKbhEY9u3g1RKI8m3QYOXrb/ASitGMEzTtAkp42Q+l/6xtsAyZJ6iwGuyb1EpzpRxdgx7WEXrZKGIfmfzrEVPkYn0fhmc30A5A8BL/lvjhoCtKLQ69hI00RextLefXbknY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744154651; c=relaxed/simple;
	bh=Qy6cyizhfjXtzq23ZhFZmp3g7QFVAgmNniCoDQLejrQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QD7eTdcvR1jJ09oNIoqY8HPM5v6W8kUj9EK1upjA4yxPWvDUZIqYqa9b4IUT3O5tINAdY4xvnuk+DdzuzV0d0shn4OPMBhGPGpAw5W0VH6Pjbb6gcyOL7P21h1X89548YvT0lscBwl09lZFygSUwvLyEIZc+yWbm4woLNRuJpZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoEPvS1b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488AEC4CEE5;
	Tue,  8 Apr 2025 23:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744154651;
	bh=Qy6cyizhfjXtzq23ZhFZmp3g7QFVAgmNniCoDQLejrQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RoEPvS1bCIKQaInRAQq1OboLo59dDpr3Fo9DRP9jgxVIM3UCcilXw4j6mwrOMFkvb
	 qUmq1nbNmHKYSF5C/LeXWdOrRONQmpFktFw5/hEWwj4amaLFrmHg0istNeup4/DpMD
	 YA+j/w3XZ6H0X2crfrr2EzlQYfdMGG+LP815beE7SW8WAnS02ncedAZ8oxm9M0XG4R
	 cSpxNpdU4I9KJiP6ybGzQ6BaehzfznstH/u6LIyTbSfqCZ12zo7rr31fyA4dR389Z9
	 YTO04OflijdIBM3NsQGZPysDZ3N9Ew50VEBYv3zeyfSAKSCYlAKM/7D1eyzPowYsy/
	 9ITLo0RkUtQOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD7A38111D4;
	Tue,  8 Apr 2025 23:24:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: tc-testing: Pre-load IFE action and its
 submodules
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174415468874.2216423.644766518239978716.git-patchwork-notify@kernel.org>
Date: Tue, 08 Apr 2025 23:24:48 +0000
References: <20250407215656.2535990-1-victor@mojatatu.com>
In-Reply-To: <20250407215656.2535990-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, shuah@kernel.org,
 pctammela@mojatatu.com, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Apr 2025 18:56:56 -0300 you wrote:
> Recently we had some issues in parallel TDC where some of IFE tests are
> failing due to some of IFE's submodules (like act_meta_skbtcindex and
> act_meta_skbprio) taking too long to load [1]. To avoid that issue,
> pre-load IFE and all its submodules before running any of the tests in
> tdc.sh
> 
> [1] https://lore.kernel.org/netdev/e909b2a0-244e-4141-9fa9-1b7d96ab7d71@mojatatu.com/T/#u
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: tc-testing: Pre-load IFE action and its submodules
    https://git.kernel.org/netdev/net-next/c/5ac40e6b5b0b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



