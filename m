Return-Path: <netdev+bounces-242392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F49C90139
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 21:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E8511352402
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 20:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5586430CD93;
	Thu, 27 Nov 2025 20:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlDD9Z37"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D29D30C60A;
	Thu, 27 Nov 2025 20:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764273936; cv=none; b=b4JMQ+Ow05NoLdbyopGl+JCXQk8bhtAyN0SntrdNgEt895Otr/SgLeV3TglVR4z2WRttAstA80oDUIDLatKf7YWeJphJXDGDJBjvsfUAM8kEmE5lqkeVMPajEpfD2PZrKgv/MY9+4tf96QWoBOzy9T1hjP33dJSAqux8D9wCtlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764273936; c=relaxed/simple;
	bh=3lGiFfcqdHFfg+BJlwthCUrnN10mGWjPK04DgQ8ZVmw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BB15TVKBG/LQT7AXpl/Ktv5aHwxkCnkOZQX7p7h0uxzYmfKgc7rL/xMY/XlVjG3aNO+RahcyrmOdWZsRre2oTROtxzxY5zXgOP2Gk2SIaARcRkKruAzn1ks+8IMViycg5uIGu8vxosHQVF4VgZByNR+HNvqKE0PwadnHW8POjDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlDD9Z37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE36C4CEFB;
	Thu, 27 Nov 2025 20:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764273936;
	bh=3lGiFfcqdHFfg+BJlwthCUrnN10mGWjPK04DgQ8ZVmw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RlDD9Z376KAuX/FJaP0U61QzzzhUKOD7xt/fMY4Gipz7fXsAfUuIqkKyKYxLi3POH
	 d84ZSy87ymh6H0SR5fJE24i2Im/09k4osChghp4S7Ai78SZhjCCxnT1nCgtH6XfDp3
	 Cw7PtuxZAprFpxrjSFnP/3Daee2d+gaWMPryeESZfrUtHh1Qtss+/f8pHnncaTv3c5
	 cVP8DGRNLg2CcjT12BnkHkHvDVSAi97x56d7LiCFaBlfcM1ck1XsZJJtvRauTmSps5
	 s54eKohIjBS5A3IyFXksSIGjKw8xyLJ24gBqMaB61TrjvMPraGj57PnvXqU1ofej8z
	 l/DcBOqpFgarw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5AA03808204;
	Thu, 27 Nov 2025 20:02:39 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.18-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251127143830.279720-1-pabeni@redhat.com>
References: <20251127143830.279720-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251127143830.279720-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.18-rc8
X-PR-Tracked-Commit-Id: f07f4ea53e22429c84b20832fa098b5ecc0d4e35
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1f5e808aa63af61ec0d6a14909056d6668813e86
Message-Id: <176427375842.20489.15172072246081700238.pr-tracker-bot@kernel.org>
Date: Thu, 27 Nov 2025 20:02:38 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 27 Nov 2025 15:38:30 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.18-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1f5e808aa63af61ec0d6a14909056d6668813e86

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

