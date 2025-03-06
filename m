Return-Path: <netdev+bounces-172604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEA8A557D7
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 21:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE0A188EBE4
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F19527702C;
	Thu,  6 Mar 2025 20:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXXdxCuq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F772063EB;
	Thu,  6 Mar 2025 20:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294313; cv=none; b=uCbbWwMI6MCXtiEqq8Fr3A6pW7y/Fm2myLSXh2Xngjx9yinpIgHWsDdHd0EVRqeZUFnJjYuQcbzZbEP5UQgT84yoa1bs+eVMk8pbY7XGc+P+zWPh3o8eDxBiej/2Jhw4D7psVX9ug4bnoT2HMgj+A+uSycpS9lU0Mp8qtN6wR+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294313; c=relaxed/simple;
	bh=27FmnUDxdKzAvJPxSzkvfHQkr7AeJ3kU8gN1CgO9WDc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=R+XESREliU4BdgPyfYVmkvuokhxJOFwsNMKqSsUwbo0Pnl3qvb1uBSPTLzMnVD0XTrv0vwVSMsVxG3Y94umfQKJ8IW6weKio+GFwQeS9qdp8JAuGtDVtwEJZ6V02nWL4huuFlLtnbIYwuR48tp5zEJMQ+Q+n+WxCqd4FGdots/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXXdxCuq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AD9C4CEE5;
	Thu,  6 Mar 2025 20:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741294313;
	bh=27FmnUDxdKzAvJPxSzkvfHQkr7AeJ3kU8gN1CgO9WDc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NXXdxCuqnXCSJJAoevb3fKzRMmE54w8b3KrGCvCKFduihvtFiwD3DbfB2jZrRgyQs
	 8NYmeu8B0LDN+QAhZPFH02A+kbnREYccsYwwriksxi03EoZdRGc3kR8g082W9bSjzl
	 ujkN1UiwqZsrJWiQSjpY1+v2WeMCy4VXcQKy845dFrCFNU1IzqTaXe4SQeUM6b4ii3
	 ans7eBJtFglQnOvwr48pmdWjsCnQX9U32xZ7zgfsknIywFcmu8mqmuN6zO14ktHZEU
	 To3O8gL45qDZmL2qo5mZDcE33QBj/zuBn8cMF5xVkDt7U+cu3dm4f+FPAolSK6D5e3
	 s/TmQ4mG5Iqdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0D4380CEE6;
	Thu,  6 Mar 2025 20:52:27 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.14-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250306122340.27248-1-pabeni@redhat.com>
References: <20250306122340.27248-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250306122340.27248-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.14-rc6
X-PR-Tracked-Commit-Id: 5da15a9c11c1c47ef573e6805b60a7d8a1687a2a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f315296c92fd4b7716bdea17f727ab431891dc3b
Message-Id: <174129434631.1773792.6650173037785598650.pr-tracker-bot@kernel.org>
Date: Thu, 06 Mar 2025 20:52:26 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  6 Mar 2025 13:23:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.14-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f315296c92fd4b7716bdea17f727ab431891dc3b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

