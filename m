Return-Path: <netdev+bounces-153459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC3B9F81D2
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 18:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 798FA165B94
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 17:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C0119993B;
	Thu, 19 Dec 2024 17:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daWB4LX6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8507155757;
	Thu, 19 Dec 2024 17:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734629169; cv=none; b=uzfIEr8e/1Qx1SGva0RXgGeRpFasu539A9gq/Z2gSmOCLm9bJoQSncg0NMitj8WwqdeLlhtgDEyKEiS4yRby5Amvb0UzsNHv7S+YlgloPf5mKjuCu6I1Q9Mj7iIUrPdGVU6jWF1+IuSL7BLHnx4JuKhPD6N+Rthw62EpjsD2Wyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734629169; c=relaxed/simple;
	bh=4x0nHju7+elgdsO/T94eXgK32PWhD8gwSNIKAwTP2PA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Cm7KTX6pxwMIqKnPOAundfnz6S5vrCdg6+KwipQlOfnKw+LjsIz67+dFqZDlq/JhYYE3qdcqx07ndyi/cHz0YXpVCXpFuRWWYUrei3r4VtuR667z7xr55m2PvqsHOeHwO5/sPgYcmhIeZAYfpoBWTAoVARFRo3F803TiTks4tQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daWB4LX6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7ABC4CECE;
	Thu, 19 Dec 2024 17:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734629169;
	bh=4x0nHju7+elgdsO/T94eXgK32PWhD8gwSNIKAwTP2PA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=daWB4LX6tplRCJQW3yeTxfnJUivIhIOhkyXTzA+drkehG+7SdPSlhvjibcV+ONKTN
	 Xa6wPGPXO7o/5Loq5etkyi0/y4xhTqSSmd4G6te8BYM1rbpYRvE+10QCXihcuta94N
	 vJ89C20eGzEyuSH21Lf4dzC7RFG3xZRwDvOvyQ7FRX3fvKa7ctFKdtXQpLxW15KHPn
	 zA7tdnpl5JYqxnpiTnexb3CXIUTaBi8HHB/DAnnOCVA7nG2DXumKRjDEhOdosm0NSR
	 bilYDq7nMeolhBLYWeUwdCB5eDNlgU83ZIQFXmqLG2h8IEd65sVzqc4vLss4/pMd8Z
	 mP3WxP+hEqVkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712043806656;
	Thu, 19 Dec 2024 17:26:28 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.13-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241219124011.23689-1-pabeni@redhat.com>
References: <20241219124011.23689-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241219124011.23689-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.13-rc4
X-PR-Tracked-Commit-Id: ce1219c3f76bb131d095e90521506d3c6ccfa086
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8faabc041a001140564f718dabe37753e88b37fa
Message-Id: <173462918699.2326610.9594884558119783456.pr-tracker-bot@kernel.org>
Date: Thu, 19 Dec 2024 17:26:26 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 19 Dec 2024 13:40:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.13-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8faabc041a001140564f718dabe37753e88b37fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

