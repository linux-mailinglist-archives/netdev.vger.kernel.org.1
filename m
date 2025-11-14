Return-Path: <netdev+bounces-238553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 49765C5AEFD
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 02:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6990F4E4CE0
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 01:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F083126463A;
	Fri, 14 Nov 2025 01:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXAsZrq9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C760B254B19;
	Fri, 14 Nov 2025 01:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763084443; cv=none; b=oiGvvivEEFBUQ3YAAQtJc4t4vBYM1mH896C46bCwfypSwuB2v/IUfNvOmucAcFyoluGCgCosOrXUUAi42ARL5FE1x6p9T9Y/OsXTY0/a7avH5KeOaowJr8zaqPrz0yySI2y8uDVd953BD+6V2MoD/lL03zLsETdYt2fsu2Ykb6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763084443; c=relaxed/simple;
	bh=kxwgXyAkhNpr7CN3LlRJyNmi9v4uzjHVESQFFA/Y5b8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HQ8cf0d8Lr25g+1DWPx85sqcyo3BWL6fBLezNfVMZqzK2ym9HeUk4+RwbkxEO1rf7m4QPP/xJ6Con4s2QFGdgBcG16RX8YE3YiugMP9Lj3lRfPTXa5Z7xYZN9tTfAyfGRSn64T1MfchMxnzlYxGdJFxao5HvYje3f8QK+ETSZMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXAsZrq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D6FC4CEF5;
	Fri, 14 Nov 2025 01:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763084443;
	bh=kxwgXyAkhNpr7CN3LlRJyNmi9v4uzjHVESQFFA/Y5b8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XXAsZrq996thj2AJdHymkjyD8mni2gwZt49x01zQ+cqLlsocQyq68GicJhkChdYL5
	 tttvfB8hlPfSnNPbHRsNsqz176HCN9AgdbMwpBFaO541lb3wtVxJAEjX0K1+NWt467
	 vnc4/Gbtzvy8MXtqWSU3ZF38/3Hvki23iDPfMUPaTzBQsFCaegHnN5E/TPG40ius7E
	 1delt45EsraHeAie4ZavzXDszq9UmTOoX+ZKeICPTeKLgjKsfNo1E9r8hF/m0kC6Vz
	 rhB5oBE5N8fTp5XrtSQHJRSPInzmdyzXhJr3JS5bzaf6bjLXgFG+y59VEWPYe4RfLv
	 6/ZNH9iQ+Q1KA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BF73A55F84;
	Fri, 14 Nov 2025 01:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/1] net: core: prevent NULL deref in
 generic_hwtstamp_ioctl_lower()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176308441001.1078849.11021806068052949473.git-patchwork-notify@kernel.org>
Date: Fri, 14 Nov 2025 01:40:10 +0000
References: <20251111173652.749159-1-r772577952@gmail.com>
In-Reply-To: <20251111173652.749159-1-r772577952@gmail.com>
To: Jiaming Zhang <r772577952@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kory.maincent@bootlin.com, kuniyu@google.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 sdf@fomichev.me, syzkaller@googlegroups.com, vladimir.oltean@nxp.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Nov 2025 01:36:51 +0800 you wrote:
> Hi Jakub,
> 
> Sorry for the late response. I have updated the patch, NULL check
> is moved from get/set caller to generic_hwstamp_ioctl_lower().
> 
> Please let me know if any change is needed :)
> 
> [...]

Here is the summary with links:
  - [v4,1/1] net: core: prevent NULL deref in generic_hwtstamp_ioctl_lower()
    https://git.kernel.org/netdev/net/c/f796a8dec9be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



