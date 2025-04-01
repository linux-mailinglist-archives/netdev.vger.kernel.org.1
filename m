Return-Path: <netdev+bounces-178471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0F7A771AF
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 02:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 254157A460B
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 00:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE3A3595D;
	Tue,  1 Apr 2025 00:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWROXs7W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3D7249EB;
	Tue,  1 Apr 2025 00:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743466214; cv=none; b=sFa2HLbxpYRex+y1cj+fCfLCV0noN1JHGTF0e0XN5/n5hcPJDIFq8N6gkEG0LUCPZ42aAQMlWRIahpPYc+E3U+Y7JSR0JvuetQvTl8JT5aqUafftxHMnW7S5YrYeYleqtYDemB9h8FmpcvujUq4/LTiQgtWKjbVgRoIrWJnrMx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743466214; c=relaxed/simple;
	bh=lTcTE/LTZtpys54JpnfKYjr833Iiem9m8Zf36ycFxvI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KDNF6XlHJ5Eku2GlyRtFCmVFvmife/vuFUZbwhM/PN1nntR09+KGBPtEQLf5jCaz77ZkYFTylhiWvsigR0Kl9+BEFWS9/P8tDuM6XFacp4r3K71l3I81BQjGskO4cKV7E6tQQALZH7l81x/mD9hU68v7XJT1jIJ2bIGwCQ/AHdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWROXs7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53FAC4CEE5;
	Tue,  1 Apr 2025 00:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743466213;
	bh=lTcTE/LTZtpys54JpnfKYjr833Iiem9m8Zf36ycFxvI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aWROXs7WN/ydk50CGW1sVp+7lD3XE+c4mOveCojDmbZav8RBIBYG00giPZvFsLPoM
	 r/RCtSYZKdMI1FUPdMfEm2QwOi62epksiwbmCLDj9udmrEn9yG/gMzUc63T9B5rZDX
	 gNBoMH0qF6E4CZ3WqGMvowuCJ0Geu0vj7d7NxR8qbGyJQEaCj5NR6ldC6/1nZZPBhT
	 2IRiqRtqA/acHoAiHULqYA5b86crd9rmC1XXnJMMS6AHE8R2SF6crqA4Bozv6E6DIB
	 L2zgJt/o8wTzviMZSJBULEgx5JpSL02BFQyDTjJ4QlH3YPyG6KwBjhroKQT+9g4lkl
	 kG/iwv/KKPo5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADAE0380AA7A;
	Tue,  1 Apr 2025 00:10:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bnxt_en: bring back rtnl lock in bnxt_shutdown
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174346625025.178192.2418191535450916154.git-patchwork-notify@kernel.org>
Date: Tue, 01 Apr 2025 00:10:50 +0000
References: <20250328174216.3513079-1-sdf@fomichev.me>
In-Reply-To: <20250328174216.3513079-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch,
 ap420073@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Mar 2025 10:42:16 -0700 you wrote:
> Taehee reports missing rtnl from bnxt_shutdown path:
> 
> inetdev_event (./include/linux/inetdevice.h:256 net/ipv4/devinet.c:1585)
> notifier_call_chain (kernel/notifier.c:85)
> __dev_close_many (net/core/dev.c:1732 (discriminator 3))
> kernel/locking/mutex.c:713 kernel/locking/mutex.c:732)
> dev_close_many (net/core/dev.c:1786)
> netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
> bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
> pci_device_shutdown (drivers/pci/pci-driver.c:511)
> device_shutdown (drivers/base/core.c:4820)
> kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
> 
> [...]

Here is the summary with links:
  - [net] bnxt_en: bring back rtnl lock in bnxt_shutdown
    https://git.kernel.org/netdev/net/c/dd07df9ff3d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



