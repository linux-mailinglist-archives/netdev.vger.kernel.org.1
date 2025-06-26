Return-Path: <netdev+bounces-201643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 632D7AEA361
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 18:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C5AC7B2E4F
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 16:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCBD20C00C;
	Thu, 26 Jun 2025 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lq/h/XS9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6664F20B207;
	Thu, 26 Jun 2025 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750954832; cv=none; b=V2XewOQlyoQDJfZhVI7bQS+AxqIpE3k8b0zMqSS55tVe0rdlI/SnxxnnG1sEB8+++3kxFLDXkEErGnaQj6FHYQrflRGYzovY+gSgfT3kkOrVMIQjFcB1/9AWB1ftHol2Zl7b/iX3Yer75GvKJnUs7y7BjmEd+yjx/e9SrIQkpfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750954832; c=relaxed/simple;
	bh=dtGpMKmdp40C/94Lg5E+8X5d6Z5rYPQYA2a26J0GvgY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ubap/T2qDIVe6juKYENe8zdN9kGgLwhfhlPdGdNxqaZSy+IhsHZz1xiIaJyJuUbs7O7E7137toIxoCtQbVBfhkeghr94nH13uhifnWaXkEJMdW3WjmyCeg0G8GgTYeJP+Is6vM2AaXQ9yX+yHt8F331MxbrRI7f68KifNBAPZPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lq/h/XS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26A9C4CEEB;
	Thu, 26 Jun 2025 16:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750954832;
	bh=dtGpMKmdp40C/94Lg5E+8X5d6Z5rYPQYA2a26J0GvgY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Lq/h/XS9Yr3Ufj/9bwuxdRAad2cg0gwaMtLuLirU9H7EQcZ/Q0RJOkRIonFesVFQL
	 LnxNJ3xB1C3lajjqDtZuEQGRp9hyPQIxm46ITnentqmHtxTR19iZxFE1M0kbDWLczK
	 bqeNPe9SjMXTuYTJFeRMFUpRad/FyKHL59+wGs5gzS/xwQEzuujtcLtKl39WhBDENy
	 yQ2I4DULM0tQRBjR1xStHrDbeDdmJ35G5rkNvRX4ecnjgVt9khtC4Zs107fkbhexxa
	 wL/Ey0yw6AClr9matTPXfk+yo18uuMcVJ3bUQVh7sYuxioyDquse1Cugo01S0hNHi6
	 /g6lGgadRKdMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713893A40FCB;
	Thu, 26 Jun 2025 16:20:59 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.16-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250626103302.22358-1-pabeni@redhat.com>
References: <20250626103302.22358-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250626103302.22358-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.16-rc4
X-PR-Tracked-Commit-Id: 85720e04d9af0b77f8092b12a06661a8d459d4a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e34a79b96ab9d49ed8b605fee11099cf3efbb428
Message-Id: <175095485799.1258398.7448097687128685370.pr-tracker-bot@kernel.org>
Date: Thu, 26 Jun 2025 16:20:57 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 26 Jun 2025 12:33:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.16-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e34a79b96ab9d49ed8b605fee11099cf3efbb428

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

