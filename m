Return-Path: <netdev+bounces-170384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6458CA48717
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 18:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F34188A891
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 17:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762D91E5212;
	Thu, 27 Feb 2025 17:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+utVVHB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1741DE3B7;
	Thu, 27 Feb 2025 17:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740678866; cv=none; b=mAIBWjoIk0oNe0jY65SCu94Tan7S3fATs83+8k1LuxAJvQe31qWDuJOM0M+53lGc9E1CEU+y5zK0J08CMSxV/iRvUZ+Xi69eTlcbixpD4HFYKOLn4F/U/Qvcgu4AZwf1180ygAkuqf+W04tsbMlokQfQQNfrptHKJZGVlGmxkSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740678866; c=relaxed/simple;
	bh=sjiruddTM+0KHHDeHF/Zcxixh1+e9jsEzQqvgV39YAA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VyiqvCRhDpFj3BFE+/62gNc5EvbPKm9zyH6LL1VHo+tpUvziL1A6SsIjUVGs1a1HzWMNjq30e2/eyvIYIN6kfAMZbjBBWQ9qltRL1c8vHRNCBn1S8d7rqKm/gFVQIDZ4hL9n9Vg+iz6Z56+3zjg1kUhohQCpEPfhPpd4mA8Mu04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+utVVHB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD0BC4CEDD;
	Thu, 27 Feb 2025 17:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740678866;
	bh=sjiruddTM+0KHHDeHF/Zcxixh1+e9jsEzQqvgV39YAA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=L+utVVHBQ+q5kvAf33Q3vXRTMbBbdLPjvvSP5aLP7LEN4gD1WreYqgG8B3t/N3Vql
	 022tFNqjmEFDSGC08eUynzeYW5bljhn1IhSeTHgVRLa0mdPFYrx7ZO6Po6in6c3Q3Z
	 l3Tp5Ha82zPQx1aRlmS1YIsNxq1R2yEIH666/kn606+zg7g85OH56Hm7OheRjHsLcO
	 NdxUOQE8XXaqqh8MvIwBbeyPAJjBJQd2ExnGW9kAV4Cva96+pJILW5aZ2QTsyE5FPS
	 AdnCnaJBvrYrmwG3eE1paBZkfBW+ijn4TnicCQtejl9GWOjcnSqK/EhV7lkqPpMag8
	 rCEPKcthFHbtw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7121F380AACB;
	Thu, 27 Feb 2025 17:54:59 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.14-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250227164103.3599252-1-kuba@kernel.org>
References: <20250227164103.3599252-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250227164103.3599252-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.14-rc5
X-PR-Tracked-Commit-Id: 54e1b4becf5e220be03db4e1be773c1310e8cbbd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1e15510b71c99c6e49134d756df91069f7d18141
Message-Id: <174067889796.1513849.9683426548092311035.pr-tracker-bot@kernel.org>
Date: Thu, 27 Feb 2025 17:54:57 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 27 Feb 2025 08:41:03 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.14-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1e15510b71c99c6e49134d756df91069f7d18141

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

