Return-Path: <netdev+bounces-192521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BED8CAC032E
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 05:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F97E4A86DD
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 03:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFEE190664;
	Thu, 22 May 2025 03:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHoOGTSH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B2818FDBE;
	Thu, 22 May 2025 03:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747885813; cv=none; b=p7oegy2bDnB44cix6hq+eA4ThaTn4zGQhwMfIeZT3A9+d6Esf2Lc5/xhW1cNa08OAUAIy9SG1hpgjf5c5RaBz8GMLKD4Zv1OmOIxOxzwPBJfss+yVqQ+93zQmSZngMr/R2JH6CUcWtYWmUudVhDV6oEiw0BMT3Fgiu5ZubfTwGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747885813; c=relaxed/simple;
	bh=5bmRQ5FWNcUrlmbzVqI8v3MehweThc2e0m1Ovg3RPZs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dxVqribmwLSOx/1CKUEkH5xpgT/x8QMebpT5lZP/U4urE7i8GXS9dcO8ii7qCd6BQiDDv2Fub2pywparjysdkQw1o/GJcMJsPQFxCqmr0iiON8moiF9aNpq+WojlQd8C/vK50cpJpbTyKK86oUSxUwug23OROA6ixXaka6KTRdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHoOGTSH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B127C4CEEB;
	Thu, 22 May 2025 03:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747885813;
	bh=5bmRQ5FWNcUrlmbzVqI8v3MehweThc2e0m1Ovg3RPZs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DHoOGTSH9vaMJSq1yh6/IBTgib7TuOaJXeKERupx0OBwsBBbFUcR1zHNaXvSkKqqt
	 XQvqGerceT0EE3F9T4/JC2lMNt1Ps5ooP9W4CY9hU+YDWw0XdYYukpf5F4akirDmp+
	 dkTFcbKsG9+oOe6nyjyaQovAUGg2ZDGiyYfgrTch7OoX9teFTbb39E4eFnbsSWKRkO
	 hDeFVzVFlXSSR8gKYBpn3mD/ET6Q77NIFRx3h0MtJ26gGAAZkKpyU5lfTEWIXzHS3t
	 J/IzsRmAqWxlZcnY6YrqQZ3RNa3sHzCSbW6j/06QdYeTBksUNKzIKx6plRQUXg2g02
	 lK+FkStTgiqeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FFC380AA7C;
	Thu, 22 May 2025 03:50:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v17 0/1] net: hinic3: Add a driver for Huawei 3rd gen
 NIC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174788584899.2369658.3358222992773503494.git-patchwork-notify@kernel.org>
Date: Thu, 22 May 2025 03:50:48 +0000
References: <cover.1747736586.git.gur.stavi@huawei.com>
In-Reply-To: <cover.1747736586.git.gur.stavi@huawei.com>
To: Gur Stavi <gur.stavi@huawei.com>
Cc: gongfan1@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, andrew+netdev@lunn.ch, linux-doc@vger.kernel.org,
 corbet@lwn.net, helgaas@kernel.org, luosifu@huawei.com, guoxin09@huawei.com,
 shenchenyang1@hisilicon.com, zhoushuai28@huawei.com, wulike1@huawei.com,
 shijing34@huawei.com, meny.yossefi@huawei.com, lee@trager.us,
 mpe@ellerman.id.au, sumang@marvell.com, przemyslaw.kitszel@intel.com,
 jdamato@fastly.com, christophe.jaillet@wanadoo.fr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 May 2025 13:26:58 +0300 you wrote:
> This is the 1/3 patch of the patch-set described below.
> 
> The patch-set contains driver for Huawei's 3rd generation HiNIC
> Ethernet device that will be available in the future.
> 
> This is an SRIOV device, designed for data centers.
> Initially, the driver only supports VFs.
> 
> [...]

Here is the summary with links:
  - [net-next,v17,1/1] hinic3: module initialization and tx/rx logic
    https://git.kernel.org/netdev/net-next/c/17fcb3dc12bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



