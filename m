Return-Path: <netdev+bounces-181344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B42E0A84931
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 18:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89F4C1889010
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 16:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AEA1DF258;
	Thu, 10 Apr 2025 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOPekOJf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5674690;
	Thu, 10 Apr 2025 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744301040; cv=none; b=aruTqcxszNVBi1wnMRDoP0yBYsK0jIsMRiieVtVgish2oQBa+YjhlaA9sS+2iVG6Ij0XkAVyZirlLGIp3bDYZtJpHEQHQ0s5LvG8uZ79BD3ffQa3uJVaCQYsDjVq3i9xoWOfSJKl8aOHvoydvIynBtuDmfnnjxWiFNHLcY4xVG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744301040; c=relaxed/simple;
	bh=I1beNjHy+HkegQQF763EXHaxDcifyNlrbMva4AvIias=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uF5EdOhaVdshk+DG76nsag3x4ZQfKXuQ1fzF1C2lwfS5c/7TW1g/UTkkMs8K/2WCJXNSUd8atrzSJH/mpIf+KZWkfca5CuUhKBcZ0MthwLYmwOs6GOXKU8V6T1XQkBqunG5ONNCsl8/po67bfaBa+wE5yp8S/eyh7sujgufclVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOPekOJf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36585C4CEDD;
	Thu, 10 Apr 2025 16:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744301040;
	bh=I1beNjHy+HkegQQF763EXHaxDcifyNlrbMva4AvIias=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lOPekOJficqXxFBBanj7Dv0bLWnWFWjT8dpeGDF04WZi7gWOu8Q/NU/fxuX6qU6k+
	 BZSBLsRDR4lR0tcvWfQHK5skyph6bLO5ht5CyxVo1rfcrUmM1B9iENBXTVJMAii/SG
	 i//72Thi01WNPSl8A2evUQ/PjQmtiByhOii8jBqR+CRTLdI3jQE35UpCw+s4/7gGE3
	 D+6b3LRlfonMxjXBWmzFSZCkeWaPVlgdIZgRtOVhaiRx1Le+/rJUT+9JPl4j6r8dqp
	 36+5ZJKYZRhq7LhM9S1SWPyWvKsuflBE3sAurEbPIv3yG46Z/6QStn4V4ROXQh7qKo
	 NPKz7bCEdDuYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB094380CEF4;
	Thu, 10 Apr 2025 16:04:38 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.15-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250410141831.46694-1-pabeni@redhat.com>
References: <20250410141831.46694-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250410141831.46694-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.15-rc2
X-PR-Tracked-Commit-Id: eaa517b77e63442260640d875f824d1111ca6569
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab59a8605604f71bbbc16077270dc3f39648b7fc
Message-Id: <174430107749.3733248.15022802028936610477.pr-tracker-bot@kernel.org>
Date: Thu, 10 Apr 2025 16:04:37 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 10 Apr 2025 16:18:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.15-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab59a8605604f71bbbc16077270dc3f39648b7fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

