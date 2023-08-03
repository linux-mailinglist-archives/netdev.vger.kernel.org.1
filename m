Return-Path: <netdev+bounces-24222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1429F76F475
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 23:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D59771C2138E
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 21:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBEC263A1;
	Thu,  3 Aug 2023 21:10:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEB02591C
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 21:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A41A7C433C7;
	Thu,  3 Aug 2023 21:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691097006;
	bh=y7cFenNYvER0tZ2Ou9IwkALoVOmVrKbFjA08+583F14=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=awBFchzD6PhvjtchRJtA0hgBUZU2CnhikgfjgnrTn8ymtL3vZhH+rZr2IxGHU8vJN
	 4GyGdaHmJH3GczIVAZYxN+pndYI7HkbdxT8cAhwXB7hBT5DpmFxr6AlHa33PJzpF1Z
	 dnBBT2LWhbJ48JtE0Ctz9WM8BOgKUsiSIcdge6M7buwwGQEdpdPPgx3FASaLyr1Fe9
	 2hDJ9W2QHZI0I/XUlzitjjtjeL1nHBD9OKqfhwfsfTxuLX7m3/6lpmt+Fldtrb7GUo
	 9wWLuXMfGdgAmt2d+uNmfROQSkI0KA6HK/1Q7tx2O86317VBu8tTP4VbddHmzeITji
	 cR0yJtnbY/QIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C83BC3274D;
	Thu,  3 Aug 2023 21:10:06 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.5-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20230803204953.2556070-1-kuba@kernel.org>
References: <20230803204953.2556070-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230803204953.2556070-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.5-rc5
X-PR-Tracked-Commit-Id: 0765c5f293357ee43eca72e27c3547f9d99ac355
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 999f6631866e9ea81add935b9c6ebaab0579d259
Message-Id: <169109700655.24731.14940731857907752521.pr-tracker-bot@kernel.org>
Date: Thu, 03 Aug 2023 21:10:06 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  3 Aug 2023 13:49:53 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.5-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/999f6631866e9ea81add935b9c6ebaab0579d259

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

