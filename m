Return-Path: <netdev+bounces-183886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D77CA92B50
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECBB89215F5
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 18:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DE025C70F;
	Thu, 17 Apr 2025 18:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YB4PZ0OW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3846625B67A;
	Thu, 17 Apr 2025 18:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744916204; cv=none; b=lZ2Tjnc2Qp2o2St+kKL9fYPd+qqSgvqzcWuC0+xQt+ozaGYTLlwJ6PCHxdMfjtTp8mDCGGRTCwjl+/dv+SbNBQ/mEhS7u/Zui9bLWpcwPvTcYYSCHP+f+ke8d1oDUwtGDB7czg/jDHcDlcAYavsKJ1Pg7aV1NDRtvKkuacsAgj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744916204; c=relaxed/simple;
	bh=sBV3YKbHTgZ5kMam3MeiqpUnxl97wpHFAF4m6EngynY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WG7U/mnmkvrb3AOz1DYnhbAYCnY3H/2WyXQ66/wMUVliHwyZSuHO1hnd+47QzvlHnhQnWLdproH4ZIkvQR3zP2KS9Pk88r4o+o27KKMnNAKTNMWLxa4sFJcf0xlsoHa1zzcJgT27wOr6ggP3R2jyBB/waPqPwqBDN/H0mRVnMn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YB4PZ0OW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA7FC4CEE7;
	Thu, 17 Apr 2025 18:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744916204;
	bh=sBV3YKbHTgZ5kMam3MeiqpUnxl97wpHFAF4m6EngynY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YB4PZ0OWk2LVPVdn0xpEjFHtTakzc5CkSJ3VIFN7TuLoADaLhWMzL8ssO3od9tEF6
	 r9DG0jL0lwH1EbvIrLy3JIvifn6/b8Rfh2+ZQi+cTjNPDoxHU1RY4tkSHGN8sj6Stv
	 IhK5EwoiMqLejRKazPOqrNivzxAVCtOu+0kMhMSo5pdHGmx44eZnbR2Q9qLu4GvEY3
	 exWKkNAGz2ftM+93WqA3xbcDBH+E6KC0cLvySAhcY7n5xHdpKRALrbn4kO63f9YS4B
	 DORGTUazHYFH8TAuj+ToH/G5cvTPPIMg0wUCilanxV0MUL9CGzcHrNudUhXK3dh8vZ
	 KuoP+h9N7W9rw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713B9380AAEB;
	Thu, 17 Apr 2025 18:57:23 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.15-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250417170059.4012070-1-kuba@kernel.org>
References: <20250417170059.4012070-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250417170059.4012070-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.15-rc3
X-PR-Tracked-Commit-Id: 1b66124135f5f8640bd540fadda4b20cdd23114b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5c6891b2c5b54bf58069966296917da46cda6f2
Message-Id: <174491624196.4184086.9690868834295128246.pr-tracker-bot@kernel.org>
Date: Thu, 17 Apr 2025 18:57:21 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 17 Apr 2025 10:00:59 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.15-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5c6891b2c5b54bf58069966296917da46cda6f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

