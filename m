Return-Path: <netdev+bounces-149510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5079E5ECC
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 20:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E519D284353
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 19:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC2C194AF3;
	Thu,  5 Dec 2024 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbAtBIEo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050021E492;
	Thu,  5 Dec 2024 19:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733427074; cv=none; b=fcgpQsDwDMwEZ/jKQHpqDr/ZxetU58URoIoz2KmYgIxpelkkrG2S5matMohIbPTFiD4DB3Zi69ZRgUSOo/Qt5akzURXc4LliWjdX7EI+4JQ8F3+jN82Z+8YwlX4aTM5zW7U+Vxre6UryKBMecZkoj1AeSbzLjA48SuWFxvEezgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733427074; c=relaxed/simple;
	bh=8jThtlA7nQy506h/yGRGplG/q4VDyN91fgu+mTyECfs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UxpF7k9pc13moHHTHjexK2UHC++JFPua2KpuMHX9nR2q2Vu4V6dX7bQUaJzTIHrRk48L3o/RlsoBX0ls9iEQqmk0VYeTMRP1yM9y6RIgjGUisuCkAK2BrLC/X9GcQge0XlP0QyigwDcul3Z01Sil0dVioteNzvyVCeyC9qF2qO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbAtBIEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBC5C4CED1;
	Thu,  5 Dec 2024 19:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733427073;
	bh=8jThtlA7nQy506h/yGRGplG/q4VDyN91fgu+mTyECfs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CbAtBIEo5JKg6pPPXDGVZQfWB+ZOWykeCyze+R0RFzm7JBaIXZthSfGXze0NLN/7w
	 ZORoOjm3ctuyGyeZYcShiPJlHTuXsvz8fMJfcIhNeNEnfYufJGVKpkYO8feIXSQgrL
	 Q6Z5xX6znMpiAngvZi1dWngBaLlwRtgcnbOx1vI9TAXZM9tYLiB9xQiJE8dRoladSS
	 /MMncUF/FLgAgz2fvVohotnBmNnKNuAst31xclIa9szgHQHH951n9dOfEeGNNmT/3f
	 HTKq2S/qFhLdXkWAzTwlO39L7OpPnixwMjy6EFaF/psQ/oJz4VojsLJ0J86gj6NYux
	 U94lD3kfzsdzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 714D5380A951;
	Thu,  5 Dec 2024 19:31:29 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.13-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241205145605.209744-1-pabeni@redhat.com>
References: <20241205145605.209744-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241205145605.209744-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.13-rc2
X-PR-Tracked-Commit-Id: 31f1b55d5d7e531cd827419e5d71c19f24de161c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 896d8946da97332d4dc80fa1937d8dd6b1c35ad4
Message-Id: <173342708809.2035350.8498233799991096209.pr-tracker-bot@kernel.org>
Date: Thu, 05 Dec 2024 19:31:28 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  5 Dec 2024 15:56:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.13-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/896d8946da97332d4dc80fa1937d8dd6b1c35ad4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

