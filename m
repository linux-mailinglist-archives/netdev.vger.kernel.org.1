Return-Path: <netdev+bounces-75327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E418B869857
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 15:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0D9295358
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 14:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790BA14601A;
	Tue, 27 Feb 2024 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6nz47N2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A46146015
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709044230; cv=none; b=QzBxmOB+FDx/5C13OT1hk9sPYPWwNOdZRFjprDycn1sTz+ySjDeBuBdSGwyUmWKZxjndiBL6DEgtfwHj3NtIgwbmRCSjt03aSKUR8i30Kgt+WhZPNozZIcZBCKd0YqD0y0uvpFUuxh4wxFTNGaj++qqY4SfNCsTHMeeDVBgKsyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709044230; c=relaxed/simple;
	bh=9hy4t1uTUCAtrCsdhwWURrfmMbI108NzneEpoThK2jk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=leXlwIktcEM3yHiVf1yWLmAcc7xfgcgPmoptQNcSYKRn8ceuTXIAB1CEoUIFhPkOCga5+uqvSpUQ1vQVQIaisJGdcGlWE4SqRdpnXmmdgjgfnnGl0RIgDrD8ZpjBJIVQXIyXc/wDwLp1t5rtkCVZPKEJWUK++A6OxYvH0dpsFzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6nz47N2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19CD5C43390;
	Tue, 27 Feb 2024 14:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709044230;
	bh=9hy4t1uTUCAtrCsdhwWURrfmMbI108NzneEpoThK2jk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S6nz47N23Frrd62WXNEIIVa8PXJpM7uB1ss2hcTlVCnohXSHA88KMEL8ri5tdMfPE
	 u977mB1Gh05P06SI/O0/4mUJjeAjaaHXe/g+B0CeUjOqgNQgG/imJXBukUcSwi408B
	 zdpSCOusCQv4/JcZoivhYk1tn/1DRUqkqw4I6rHdT2Asr9YAeCye5afovt8Bk/6AZL
	 lnIbZc+h4LQi33fyiUnMG4a8jyZyHdIHiurvg4oQUSe0s8BmVQHC+dz0hG+V++VLXr
	 aQhpC1KQavF3rcFmy4gercP92DIoJLvuKHnh0LaOwMitMcTPRCA4XNWYvn2lmMPAg7
	 t+bK7FRulP3iQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F1BAFD88FB4;
	Tue, 27 Feb 2024 14:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: netdevsim: be less selective for FW for
 the devlink test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170904422998.32001.8138779407658340257.git-patchwork-notify@kernel.org>
Date: Tue, 27 Feb 2024 14:30:29 +0000
References: <20240224050658.930272-1-kuba@kernel.org>
In-Reply-To: <20240224050658.930272-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 23 Feb 2024 21:06:58 -0800 you wrote:
> Commit 6151ff9c7521 ("selftests: netdevsim: use suitable existing dummy
> file for flash test") introduced a nice trick to the devlink flashing
> test. Instead of user having to create a file under /lib/firmware
> we just pick the first one that already exists.
> 
> Sadly, in AWS Linux there are no files directly under /lib/firmware,
> only in subdirectories. Don't limit the search to -maxdepth 1.
> We can use the %P print format to get the correct path for files
> inside subdirectories:
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: netdevsim: be less selective for FW for the devlink test
    https://git.kernel.org/netdev/net-next/c/b819a8481a19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



