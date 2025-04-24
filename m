Return-Path: <netdev+bounces-185659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8BDA9B3FF
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 18:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56BD34C1D46
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 16:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4449E28B506;
	Thu, 24 Apr 2025 16:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MT+8RRFJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E29528A3F9;
	Thu, 24 Apr 2025 16:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745512103; cv=none; b=lxs8EeufXHYYotz+lDpZkNhjVWrB3OPzUEPIwA901JmXY8xfR4O3EppHs5kwYYJdBLxGNQ0ImRQdXCaUb4sipj5YVdocOKQTp46a+nL2mCPC/vc9/YND5b8WSb/yPhFFBZ+R4Tts3WUXlTMVveGXeCxcidS3DhzeXQzvsjT9E9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745512103; c=relaxed/simple;
	bh=4WMCh8NBjTaV4M9SrxgBR1w7kMq66hiK3n4SxDFcays=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NN2ztNO4K0mGsf3qmFbyRpOe4VyyTnRS0O3xV8VejU4fYHAWcW/ybA2QWrP44RAYz4ztqan8COA+be3LZHj6bFKcNcMfzpxlJclb479BGQDzlJk8gi9vJltpc7pNrVt7zIIEETcLhKPhaKqALPDh5BX9gcIy24xfDF4kXmqZpPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MT+8RRFJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C17C4CEE3;
	Thu, 24 Apr 2025 16:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745512103;
	bh=4WMCh8NBjTaV4M9SrxgBR1w7kMq66hiK3n4SxDFcays=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MT+8RRFJhGiStu13+mgI26NCoXCcaqcfM4rNGgqbPmm7w9ucVu6o0fSSyms3bU0q5
	 3VPfY5hlS5DP3lAMLhitZhpBA3apLf3/2NT3ywCfNZBhgoGbxZPW4Cs7Qp4610itEg
	 T+owoa648SpOn8vFxqCW/6Adv2Z3OYoZn6BYVmR9cvdFxCTeNbmEav1GqphB5SQKx5
	 PlasxjaVJPXoPKLg+iq1CmW+F2Fijkq5Ge+iN758elfvdZR2pLoiBasYg7Dfybotmz
	 avcENAfUf40s5FWIG2QJ34T8js66hZ1Jap/aFvaqz/HFTWAqYseMJO+6CTGCnTeyWb
	 j7PzkiP7q6w5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BD64A380CFD9;
	Thu, 24 Apr 2025 16:29:02 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.15-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250424110659.163332-1-pabeni@redhat.com>
References: <20250424110659.163332-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250424110659.163332-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.15-rc4
X-PR-Tracked-Commit-Id: cc0dec3f659d19805fcaf8822204137c9f27a912
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e72e9e6933071fbbb3076811d3a0cc20e8720a5b
Message-Id: <174551214157.3411799.2593289565638624789.pr-tracker-bot@kernel.org>
Date: Thu, 24 Apr 2025 16:29:01 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 24 Apr 2025 13:06:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.15-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e72e9e6933071fbbb3076811d3a0cc20e8720a5b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

