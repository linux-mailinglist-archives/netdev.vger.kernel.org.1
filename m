Return-Path: <netdev+bounces-189033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BB3AAFF7A
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 17:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1963AACFE
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 15:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA2B202C2D;
	Thu,  8 May 2025 15:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npIFmjOF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9791C84D3;
	Thu,  8 May 2025 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746719175; cv=none; b=bzOHow0wAy1Ccni6aZdNf3mF8LY8rZASiiwphTAz2kAa6GbKCoDtheFjDxXMpYc0cwADWw1fDO3ej24NfACCiHGXMA8+xedr8woxEMaJtKLVivRivc2YeFEJMr54MMgdK3IopwRWPiVVHwlgAZ+5UgZbLi839cBjdEpHwOkSpDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746719175; c=relaxed/simple;
	bh=4WaJvCV6xeKS3CkSM9i09ZXYupOurO/XyWA7cc0swlA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KABLUlhfz0J0yTqjMxljSW+hPuRsYKY/3jumizXw0E7bJc8Q5AHNrYAVUKOQfEX8aWesYXy6KmCz5DNBgOP872vwtCK6SImXPQ0zTmr5e8UGIbxPoZP3SivLnylWMSNYeieHxE6mmGXkKjILdJZ5FYxl6xUYfZ/9vjeCSI+EHyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npIFmjOF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C464FC4CEED;
	Thu,  8 May 2025 15:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746719174;
	bh=4WaJvCV6xeKS3CkSM9i09ZXYupOurO/XyWA7cc0swlA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=npIFmjOFhWxrkQcIN5sQ4aBabOETHeiLhqscN1dSHZ/04GquTACQ+TwYSYHa0NLRs
	 E9FZxyHPdIj48TeXKAej3OX+qIeFrNE9U3xFojq7Z2EmXpfSa2VrGXN8GvKjp0bQ5w
	 ygxLQ95OklYUGWeitBV/oeEuv6U6NXMJn/2cbyUPXPBD+ML9OriopoO4kO2lGrrNqt
	 mRXoMOCzksdTpZ9su6X0aAqG62u6GnsWywS9JoRrIDbud4dTrsOo+VJSUyUiPF9eUX
	 Qfu2ASuq1zke0mMvf+87rI+DL+RP/o13zpC1iq5BAuBw/xRm5UP12GdBtXd2Mvbutc
	 qk5hUxmsO4dvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE030380AA70;
	Thu,  8 May 2025 15:46:54 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.15-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250508133106.37026-1-pabeni@redhat.com>
References: <20250508133106.37026-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250508133106.37026-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.15-rc6
X-PR-Tracked-Commit-Id: 3c44b2d615e6ee08d650c2864fdc4e68493eac0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c89c1b655c0b06823f4ee8b055140d8628fc4da
Message-Id: <174671921310.2957681.9131930593450476912.pr-tracker-bot@kernel.org>
Date: Thu, 08 May 2025 15:46:53 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  8 May 2025 15:31:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.15-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c89c1b655c0b06823f4ee8b055140d8628fc4da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

