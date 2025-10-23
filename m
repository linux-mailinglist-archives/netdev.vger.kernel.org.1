Return-Path: <netdev+bounces-232210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E72EC02B6A
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 19:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC48418839ED
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 17:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B2C346A10;
	Thu, 23 Oct 2025 17:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTe+fAyx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C12346797;
	Thu, 23 Oct 2025 17:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761240096; cv=none; b=aVh3m8qEo5IwY1m+eQcdarx3bpwmSeK6Ymvy/K6SJMxYDMJVovIxaDkq4GoACvOwSeFnUVQK3Mpqveg8bbomrlHioNrVgzcIOMzdbIUXCuZTn5fK2WfJWLT55WPk+98NrwM+Jv4vlpEUX20lhYkfPIIdOJ5TwjziwD8q+wWpzJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761240096; c=relaxed/simple;
	bh=zDtZeKEDR5vI2Jddz6JTBA7LY3tDDMzdK3fAKk65D7s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qdbbdHljlQaruit4qZfZAY7pG1D010FPPux6qgou59lnAkPQ+N02kD5QV83Yd51L8rKyA23lILMR+lGSdWwhmV9Ti1Z3sml4MFAvRbi8G7xgKLLt3aDFWmB1IlB+raVeC6VbW8d0N6I3AJD4jxNdLDuFhIaZz1YWd6IRgk14gAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTe+fAyx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D72C4CEFD;
	Thu, 23 Oct 2025 17:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761240095;
	bh=zDtZeKEDR5vI2Jddz6JTBA7LY3tDDMzdK3fAKk65D7s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tTe+fAyx+EJX+HFyCvKrg0NeXArQCXOqBpF88JuKmCzwiqw7wfjLyuvJVOxsbG79a
	 0Ut1CiIhbptzEb145lV+ifJ2VeaMAATDX78NS6vTjTt42USFUGeN0fVMMyuldy0cJ/
	 vctDlaPDa3MV4GQY1BeeGaQ3QESl6U1oH6WOQqWduA+GIxtzZEG/yU5b1vHuqnDw1U
	 +MeRqvjwy151qBPH5ENI9bfVVCXVkxM1vK3gEjE1EEIGxNF2gJmV50GQdRyUvLjp1+
	 vvlagejrXAhuyEqq3+I6zVqp8pXw94IdBpWc7mmZIN0kS3DL61mf2X+grQXYR1qt4r
	 ebH5slBoIappg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712D1380A94B;
	Thu, 23 Oct 2025 17:21:17 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.18-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251023150154.1295917-1-kuba@kernel.org>
References: <20251023150154.1295917-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251023150154.1295917-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.18-rc3
X-PR-Tracked-Commit-Id: cb68d1e5c51870601be9394fbb5751fc6532c78e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab431bc39741e9d9bd3102688439e1864c857a74
Message-Id: <176124007599.3177238.16340742249833388221.pr-tracker-bot@kernel.org>
Date: Thu, 23 Oct 2025 17:21:15 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 23 Oct 2025 08:01:54 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.18-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab431bc39741e9d9bd3102688439e1864c857a74

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

