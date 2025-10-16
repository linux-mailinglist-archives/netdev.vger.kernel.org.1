Return-Path: <netdev+bounces-230161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DC1BE4CE9
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 19:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA21B19C1252
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 17:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A47216605;
	Thu, 16 Oct 2025 17:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPCvG9oi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015D93346BA;
	Thu, 16 Oct 2025 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760635057; cv=none; b=EDvHs5u1qOebGiRE9bXp5Jt7c7Hahrj0MumpL8NFinUIgD+4OQVqTnCXqoiQvaWYXjRFTbjIWLe3sD9l3lpJD4beDqE5kZ/nG1ITbZpt/FfM4KdTMLS9Q645Rc02WpbR+CcD05WqTwB1cWOWsUce7qhFt2k+TT8AGrBLwaodSEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760635057; c=relaxed/simple;
	bh=bAw5Vwi1O/L5gr53AGhPFekj4RxGYL/VkVy01Lhm5yQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DhvhKCOXxG3ygRAGbot61qhiL9x17U6CejALujJn4cVrwtVGitaJKOh/+QSV+C03v4H193DTjHWvItqGlVajfDID6heEFWED4grECdVOcLvLYpN1W2LnoTHvH+VIdeJXl1SJ2rqUDhRAvb5lFAQjEwZHDgK/YhqsqO6hw2ZfAeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPCvG9oi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8248EC4CEF1;
	Thu, 16 Oct 2025 17:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760635056;
	bh=bAw5Vwi1O/L5gr53AGhPFekj4RxGYL/VkVy01Lhm5yQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uPCvG9oiMq3az4xSrov+9rmwNURfoiI0NnBQGb846NIEbu/WrDn3fsEYWaMlUHsWT
	 XZO/6xa8DlY4NiXrY8pLzwXxcYHgABhDOCLtgWdaolcY3yRk7ctBXZd4Gm3vyY1M/J
	 FwhTeXr2AVCv0GSr/NEzdU1p/mS5xYTY32SXVo64qf7iGfZ1Pv664ulAn4yILCjn2z
	 2C7fU0zKjzBkwxzW9h33oMda8cBse+KhFduw4ImonzdPd44W3fmX17p2c2mU22/0S1
	 GNgnsqrY5ZYOto5/dUToPO85txRcHVZvOe2RsKcOOlwzz0ni/P2dBZhWtRWMTCJmLJ
	 M/b8dTcEWqU7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0D9383BF62;
	Thu, 16 Oct 2025 17:17:21 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.18-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251016150328.32601-1-pabeni@redhat.com>
References: <20251016150328.32601-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251016150328.32601-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.18-rc2
X-PR-Tracked-Commit-Id: 6de1dec1c166c7f7324ce52ccfdf43e2fa743b19
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 634ec1fc7982efeeeeed4a7688b0004827b43a21
Message-Id: <176063504046.1828004.6913652083427884732.pr-tracker-bot@kernel.org>
Date: Thu, 16 Oct 2025 17:17:20 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 16 Oct 2025 17:03:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.18-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/634ec1fc7982efeeeeed4a7688b0004827b43a21

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

