Return-Path: <netdev+bounces-70507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC12084F50D
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 13:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FFDB287AB0
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 12:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385B02E401;
	Fri,  9 Feb 2024 12:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ng2USo1Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11461286AF
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707480631; cv=none; b=ZY4iAYIBKACTBgGpQe0j1oNXJGXITYZ2f4zU4RbCtTKVFuEBZ0qSaXy+PWGJXOzhxsqMUlTfU4Lp76GySadiwA/Hs/mPyKvDSjkzD2IKisgK2C6tZme/FlbGj8Y5+iXMcq6BNUmXI13tIWDiPfLyc2O2D5qSOSQ3RWawaAIazD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707480631; c=relaxed/simple;
	bh=uEdtgI+WOxzOl+sijkvYYENDmVAidSrqHAc+q6ZWThM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u0iMmL8T9LJEvDvauNveaaREYbGeGfEVHgM4a29ey+usu9kUBVZdmdwiMiTQEAawdn/NUSgTd+SOT0TZoZBsiMyWP1aBt9rh9KW8J3S9ZeJFRmGXjeqV76pkvYwHky5kk8/VehzGYBlD61XvMKRTDyBx0XmOvXR/v5UxuLh6OwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ng2USo1Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 719F5C43390;
	Fri,  9 Feb 2024 12:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707480630;
	bh=uEdtgI+WOxzOl+sijkvYYENDmVAidSrqHAc+q6ZWThM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ng2USo1YlsHQicDZDdrtq2DJaofGCcHzua65xihqnpHdol+2Vn6j6wV05OP9mt70J
	 GydrR4EBJYm243iu7d/AFoJ2yq/FD7Vkc9itpvERMrydrw0Wr5alp7MINAobMyLvoC
	 EgcqZFpQWWOoSuDGQCVe1I9Ykq1BeHVXeMIkE5PvCBjsc4V9O+Z447D5NDAeP3CpHe
	 JaMZzudqe+59YcEna0YhwPODykujbJPRpF/c2EGfFS7EGx9zwiXH+dEqBAxL8a2AE+
	 oFD66gqM4f4BU0zWj9oY2ouNa8+bIRGwfx+pxxIQnaSkyaxKZxDDyiowgNHX1r1RhX
	 BeC1YtMQFf6AA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B057C395F1;
	Fri,  9 Feb 2024 12:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v9 0/4] net: wwan: t7xx: Add fastboot interface
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170748063030.8084.1581614963314743317.git-patchwork-notify@kernel.org>
Date: Fri, 09 Feb 2024 12:10:30 +0000
References: <MEYP282MB26974AACDBA0A16649D6F094BB472@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <MEYP282MB26974AACDBA0A16649D6F094BB472@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
To: Jinjian Song <songjinjian@hotmail.com>
Cc: netdev@vger.kernel.org, alan.zhang1@fibocom.com, angel.huang@fibocom.com,
 chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 danielwinkler@google.com, davem@davemloft.net, edumazet@google.com,
 felix.yan@fibocom.com, freddy.lin@fibocom.com, haijun.liu@mediatek.com,
 jinjian.song@fibocom.com, joey.zhao@fibocom.com, johannes@sipsolutions.net,
 kuba@kernel.org, letitia.tsai@hp.com, linux-kernel@vger.kernel.com,
 liuqf@fibocom.com, loic.poulain@linaro.org, m.chetan.kumar@linux.intel.com,
 nmarupaka@google.com, pabeni@redhat.com, pin-hao.huang@hp.com,
 ricardo.martinez@linux.intel.com, ryazanov.s.a@gmail.com, vsankar@lenovo.com,
 zhangrc@fibocom.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  5 Feb 2024 18:22:26 +0800 you wrote:
> From: Jinjian Song <jinjian.song@fibocom.com>
> 
> Add support for t7xx WWAN device firmware flashing & coredump collection
> using fastboot interface.
> 
> Using fastboot protocol command through /dev/wwan0fastboot0 WWAN port to
> support firmware flashing and coredump collection, userspace get device
> mode from /sys/bus/pci/devices/${bdf}/t7xx_mode.
> 
> [...]

Here is the summary with links:
  - [net-next,v9,1/4] wwan: core: Add WWAN fastboot port type
    https://git.kernel.org/netdev/net-next/c/e3caf184107a
  - [net-next,v9,2/4] net: wwan: t7xx: Add sysfs attribute for device state machine
    https://git.kernel.org/netdev/net-next/c/409c38d4f156
  - [net-next,v9,3/4] net: wwan: t7xx: Infrastructure for early port configuration
    https://git.kernel.org/netdev/net-next/c/d27553c14f06
  - [net-next,v9,4/4] net: wwan: t7xx: Add fastboot WWAN port
    https://git.kernel.org/netdev/net-next/c/2dac6381c3da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



