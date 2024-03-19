Return-Path: <netdev+bounces-80552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0927E87FC79
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 12:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D4331F21630
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 11:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C638657892;
	Tue, 19 Mar 2024 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rE013n94"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02BA5474B
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710846029; cv=none; b=o/KjIC6q55nXNsFpWigZZzHErs05pvaIVK/dOyw63IyRIgQOE7iqoMvLJy810jLumpoRKl7ymSgwmOT5aHFKyHRJNyMr2wYlOSqjUW+3qZFFRdafylQx0X2VoClQAzlDdK4BPFzjx0SipBHIAO8YqUxAto5ofZEGuB6k7VodwQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710846029; c=relaxed/simple;
	bh=ZF5saz7b61b0NrVO1a61XY9lk5b98nULd+pGq5FxjFU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LT0o1Nv0VY5BrN44HlorZbHeGprDtIJOc7gTWXVhIB2HA6I72F99uleJdfOzf1cnaQI5lCML3Lc4nq89KQXeb3O6VxoJtTpPkLdHn6Emj1IjYPi54KvvtnGErBzJfCEtf/VHkpkgUiNi6cL0aJS0YCwQe3PfHqHtVsVlkaztJe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rE013n94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 130B4C433C7;
	Tue, 19 Mar 2024 11:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710846029;
	bh=ZF5saz7b61b0NrVO1a61XY9lk5b98nULd+pGq5FxjFU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rE013n94JzztyRE0O9JFThpSoQZrHZ+0jad6GxwZtq5emQURBfJrrCVkcAfucQJsF
	 xmiQRg9TumyfO19Tj+rab1IhQydALX4KVOEfdgluSgYXV3Gd0zeoOhJS7w2aWmkqGI
	 /q3VAZZcELGzOK8zwhxfaRYq91Hr93eKt2Lvdm2gGNJ3aNNeaKEYj7gzz4UzOPDv5M
	 kE9ms4aBn1WJzirUxVEKgcTQbtnYHPx2TCcT78gnVby9GDjCpH1K1I5v+X/i2qLGFo
	 BoYnpma+dF6ghb3G8q5CwpqOg5Ij6Saxl/p9m1rDypEoA+wX8ejvk6457bZR9CsCp/
	 TBLmKuMkmfdgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8ABAD982E0;
	Tue, 19 Mar 2024 11:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tools: ynl: add header guards for nlctrl
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171084602894.23994.8987250591163412589.git-patchwork-notify@kernel.org>
Date: Tue, 19 Mar 2024 11:00:28 +0000
References: <20240315002108.523232-1-kuba@kernel.org>
In-Reply-To: <20240315002108.523232-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us, chuck.lever@oracle.com,
 donald.hunter@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 14 Mar 2024 17:21:08 -0700 you wrote:
> I "extracted" YNL C into a GitHub repo to make it easier
> to use in other projects: https://github.com/linux-netdev/ynl-c
> 
> GitHub actions use Ubuntu by default, and the kernel headers
> there are missing f329a0ebeaba ("genetlink: correct uAPI defines").
> Add the direct include workaround for nlctrl.
> 
> [...]

Here is the summary with links:
  - [net] tools: ynl: add header guards for nlctrl
    https://git.kernel.org/netdev/net/c/9966e329d675

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



