Return-Path: <netdev+bounces-176588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E39A6AF31
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 21:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A37F917D67B
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 20:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31212227B94;
	Thu, 20 Mar 2025 20:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZC8b8bVS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CCC1EB5EA;
	Thu, 20 Mar 2025 20:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742502618; cv=none; b=kp6wRKUxnSe0IRZhH0ApAGCN5jQJGyaC/y3vEJvjVVM4byfpdA+jdhuLJmv8fBUpUsIW/YA58IisPubgI1/FjA/lZRwSSJAdeQNexh2puSJOJiw48CZv7m8PvQzkueaopypUPCziEYFKbZXJMD9GIttvPvvOCaTQOoiWeLyB64g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742502618; c=relaxed/simple;
	bh=Us8Zqy+aP8jNCZBVuqDtX8IHuRySyW+R8T0JM+Eq/CA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AlRrMda6luz6mnwZDyMLtP9qP4ozZtfQHeDn+l9D2ItzsxbeO1met9LhhmyA0SsKHbnI+Aes2iMDpiid5WUCmLNOBqBDSOqG8uqBnddAWLu5t6lQM8C30OvKYOVQqqDs5f3MAeG1IcQUBohAFfnkkxlDB+t1UItz6/s7c3DwMHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZC8b8bVS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6436DC4CEDD;
	Thu, 20 Mar 2025 20:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742502617;
	bh=Us8Zqy+aP8jNCZBVuqDtX8IHuRySyW+R8T0JM+Eq/CA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZC8b8bVSWIRQXWDTRUwVpO5BMk2JtK9zdhgXaQ0TjFHz0J/f2o4xnON81X9K3gOkj
	 IxpL/LOn1WELetRDlwE+SkQLCanCjIaTN5Vizivr9mwUtow1VDMigQjJKd1vYuxqMH
	 m4b+7h9IV2MUyweAxgMryTw8IEXD53PN2TKJN83AtarRmEzhtzlMNqzvNgUpC75HPd
	 EZREcO+IJ4nehDn/8M6WIyf8YO/L9E/cxbu2vGTKkBqT5w5b5CnA+8nLk12BNPfetM
	 wvLMqMm/A4ji29/zqVBjMyZ6K/fLpHKGDbHhPqdlDgsUr6v11IV04XDZXOJr+oSJuh
	 2Pm39LWK7RcGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710D63806654;
	Thu, 20 Mar 2025 20:30:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] Networking for v6.14-rc8
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174250265327.1901036.4769888839023934720.git-patchwork-notify@kernel.org>
Date: Thu, 20 Mar 2025 20:30:53 +0000
References: <20250320155513.82476-1-pabeni@redhat.com>
In-Reply-To: <20250320155513.82476-1-pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Thu, 20 Mar 2025 16:55:13 +0100 you wrote:
> Hi Linus!
> 
> The following changes since commit 4003c9e78778e93188a09d6043a74f7154449d43:
> 
>   Merge tag 'net-6.14-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-03-13 07:58:48 -1000)
> 
> are available in the Git repository at:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] Networking for v6.14-rc8
    https://git.kernel.org/netdev/net/c/5fc319360819

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



