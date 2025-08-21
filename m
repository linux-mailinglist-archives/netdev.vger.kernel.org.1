Return-Path: <netdev+bounces-215751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C55BB301E3
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 20:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F17FA4E570A
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 18:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAA92FB62F;
	Thu, 21 Aug 2025 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atC7rdDP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77012E62B3;
	Thu, 21 Aug 2025 18:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755800434; cv=none; b=VaNbCZUg1CGoKVSvaO9lXX5hul7jX2Wypg/Whelplt7RHw8YiTxZu3at5G2cWq66LPKReRkqFYDi05sWqX26tvdpiNgTDdiuo6vsi2pLgYO1d4hcFhZVGl9uPreTelz7BY8A2VIlknTYYTPo1dNmEBKQHNkjt21HROjaRKlZhoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755800434; c=relaxed/simple;
	bh=4hrLo4L+G1zUcmSSW/67SSpyLfiydKVmvlj+/64Owh4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WFKDPM5vE4Glh0LtrFiN0EFkSUTEWw75A+TIEZBZkhzEyTFbW+/B3/TTpBhP6/7Ir4sTapiDKkUQuc4CTkutL56loMx7y+h5XSdyA3EHFRj1yCTk4DdhJNXJEPjzVrgWuL92czCWf7NdHA/Qju/zvXToCoCQTpCBEAhmFVojkHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atC7rdDP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C351FC4CEEB;
	Thu, 21 Aug 2025 18:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755800433;
	bh=4hrLo4L+G1zUcmSSW/67SSpyLfiydKVmvlj+/64Owh4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=atC7rdDP5tN+XGRGhesealtEJXcd6suasB+wttw0wuUaZPkkf+r/OZQCPhSAG1daa
	 YG6YZGbDHyA9LhSiUkAYtN+l5tuRmYmY4JE6OpVErlNIroPZIpHOpB1lon3Ni10DKD
	 DznyP+q083OCHmCDzT+J1wsEt5XdUQ5K3gai5y8g8CUfNl05+dJSrOLsM8kt1x5xxH
	 EY1nod4JbwytuybapeUXSlJYv2cJG41fxVpwG83EOX0oNGsqiDS7XwdOdr59G2aPjz
	 zbbqwZpTwnTfYhfgifgJQQY3XYVTM7fwGpGVkaxN0hgtoNS1XELUF5dBSfkpG3ZZNA
	 mDy+n7uVJsi6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3405F383BF5B;
	Thu, 21 Aug 2025 18:20:44 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.17-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250821171641.2435897-1-kuba@kernel.org>
References: <20250821171641.2435897-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250821171641.2435897-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.17-rc3
X-PR-Tracked-Commit-Id: 91a79b792204313153e1bdbbe5acbfc28903b3a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6439a0e64c355d2e375bd094f365d56ce81faba3
Message-Id: <175580044275.1140263.17914941560586894452.pr-tracker-bot@kernel.org>
Date: Thu, 21 Aug 2025 18:20:42 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Aug 2025 10:16:41 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.17-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6439a0e64c355d2e375bd094f365d56ce81faba3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

