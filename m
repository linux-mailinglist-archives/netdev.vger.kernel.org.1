Return-Path: <netdev+bounces-101175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F688FDA1F
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 01:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BAB42838FD
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 23:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B220415F402;
	Wed,  5 Jun 2024 23:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0V99Rfl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899C72AE7F;
	Wed,  5 Jun 2024 23:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717628434; cv=none; b=CACwqdyAA/wYy+xGqQqoyUvyIP0FJZXEj7OCpmp1KbQtOIg/SSfOP1CfJph6PzU7KQ54h8Gry9O/Oxk5PGddI5+KsLkWxIZriijfq3slB68wBCThIZ6f5N3gZFHNp6nzeBNaOfOZlA7CKR0645WBDhhdWA/gnJNmAezIdjZ3u/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717628434; c=relaxed/simple;
	bh=ys29AEGN9uxjRgj/gkWHJXNJ6X/W127GxKx1D0A7x8g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UoFD5+dzFq+G4+SMyV8vHMbHiZGKi0ynlbJ1u3QhKBOGVfeNZ/O0rvINF7iSe/qOGmTxoia2XUy2QbYI8bC2IZsx7fm/9Join60hG9bk64nn+u7SXaKCs32dMDQel96M+bn+EnicJ55G2rmrh1Wb+X9u4NPVyA7lvmklzQBpRr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0V99Rfl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B640C4AF07;
	Wed,  5 Jun 2024 23:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717628434;
	bh=ys29AEGN9uxjRgj/gkWHJXNJ6X/W127GxKx1D0A7x8g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J0V99RflyizU0HCTYjaujZPlESm6zu7Ck7LKCuT/xSFk9fo23Ug9PCWKiBh4Ps7RZ
	 c7EdiWlr2ysLBRGF4wqsuVvdISJFkZ1rSgvl7vq6lue9xw7pYb9YBhJ503tcTrPu0/
	 Gqw9tGsZCVvGRrw2EUZ8+2IGdympm/lJCkuh9xuiR4UfDTMztd53tJfzkskkSVv0Xi
	 ZPqp/hcyyGgvt8/wBB/4TnHjmz7kB6Wxek7/v08hKCGJ3iMNebVersi8XpHSt3V+MK
	 wIQntM1ivpXInb24/0+za0zH+C2Vb5grg3fRBxvN2FV5TLEdUpsxYihqmEpRVaIw5c
	 G8+o5hyq3E4Kg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16DBAD3E998;
	Wed,  5 Jun 2024 23:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/4] vmxnet3: upgrade to version 9
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171762843408.9199.15628895489607695720.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 23:00:34 +0000
References: <20240531193050.4132-1-ronak.doshi@broadcom.com>
In-Reply-To: <20240531193050.4132-1-ronak.doshi@broadcom.com>
To: Ronak Doshi <ronak.doshi@broadcom.com>
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 31 May 2024 12:30:45 -0700 you wrote:
> vmxnet3 emulation has recently added timestamping feature which allows the
> hypervisor (ESXi) to calculate latency from guest virtual NIC driver to all
> the way up to the physical NIC. This patch series extends vmxnet3 driver
> to leverage these new feature.
> 
> Compatibility is maintained using existing vmxnet3 versioning mechanism as
> follows:
> - new features added to vmxnet3 emulation are associated with new vmxnet3
>    version viz. vmxnet3 version 9.
> - emulation advertises all the versions it supports to the driver.
> - during initialization, vmxnet3 driver picks the highest version number
> supported by both the emulation and the driver and configures emulation
> to run at that version.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/4] vmxnet3: prepare for version 9 changes
    https://git.kernel.org/netdev/net-next/c/4978478a6888
  - [v2,net-next,2/4] vmxnet3: add latency measurement support in vmxnet3
    https://git.kernel.org/netdev/net-next/c/4c22fad70256
  - [v2,net-next,3/4] vmxnet3: add command to allow disabling of offloads
    https://git.kernel.org/netdev/net-next/c/2e5010fd0c43
  - [v2,net-next,4/4] vmxnet3: update to version 9
    https://git.kernel.org/netdev/net-next/c/63587234d42a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



