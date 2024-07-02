Return-Path: <netdev+bounces-108505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E4A923FFA
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 16:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64AFD285341
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 14:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398AD1BA06A;
	Tue,  2 Jul 2024 14:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jY7Gmmn9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F8F1BA065
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719929432; cv=none; b=EBUunP2v9YIbM/TQ5iXGQEAuzj9X1sv2yfjDQXz/JvznzrGpLbWvzeMgdL45UAbi7Q7dMoIXiMJPm42isQ3qs1F7wOYpsbZiNRYw4O8BEmYYMvsq/WH2bFIbTI4LvRymGyoOUbVc9iTWyKZ2C06sX06wn/MptJ3X/VUVHYF2qQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719929432; c=relaxed/simple;
	bh=iFB6a1FYVA3qmxPrh7scR/N1jWP9+t1z2RJc/YAYWXE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n1vxWWwdr1Q2I9cpqLYd7u3fNsn3pfmOCvcwfQKG9fFNLV1RqcVOEqx0XtPXwQmQ5r5QvplANUhpgFhR3zFAt1T0SAPyNijt0Rzw05GS4NwiA2FB7NO6XXPFvv4P84RPZiKzJW7BLYuFCOKEsinHrUrfkkg7X2gwhHgg4RhDKh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jY7Gmmn9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96EE5C4AF07;
	Tue,  2 Jul 2024 14:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719929431;
	bh=iFB6a1FYVA3qmxPrh7scR/N1jWP9+t1z2RJc/YAYWXE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jY7Gmmn9725CxsAr9DRy4DHNmEhBFf32Ipb77rlwMKPew7zZOWb4KLd3freyRmPXS
	 Ru5+m4WNUsnnxdGc7u20+qGA9TBCr6JrmqAvKFHi212EVd5H7uPs+GcqjOZMkdtwu1
	 lwIz7EVK0dSrcPvhVWGeUP1Eawqp3RoJKiMSfnsaFeNokutErNpFhmca596Sr0bkzg
	 XPOTlIwCRxSh+OeACAIZTcr7oT+3xJVuzGEc0Xp0NIEDVdBrK5/d+AS3ey8l/wZi8l
	 P3DqAUvOdP8d+eVtMzmu/Pq7URZq40ctm9a+ckIqgQQCg5mYUVTqcJ6/ufyFxm5L2G
	 PjS7FkVn93NZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89F1CCF3B95;
	Tue,  2 Jul 2024 14:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/4] net: txgbe: fix MSI and INTx interrupts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171992943156.14973.1998223513235555414.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jul 2024 14:10:31 +0000
References: <20240701071416.8468-1-jiawenwu@trustnetic.com>
In-Reply-To: <20240701071416.8468-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew@lunn.ch, netdev@vger.kernel.org,
 przemyslaw.kitszel@intel.com, mengyuanlou@net-swift.com,
 duanqiangwen@net-swift.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  1 Jul 2024 15:14:12 +0800 you wrote:
> Fix MSI and INTx interrupts for txgbe driver.
> 
> changes in v3:
> - Add flag wx->misc_irq_domain.
> - Separate commits.
> - Detail null-defer events.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/4] net: txgbe: initialize num_q_vectors for MSI/INTx interrupts
    https://git.kernel.org/netdev/net/c/7c36711a2cd8
  - [net,v3,2/4] net: txgbe: remove separate irq request for MSI and INTx
    https://git.kernel.org/netdev/net/c/bd07a9817846
  - [net,v3,3/4] net: txgbe: add extra handle for MSI/INTx into thread irq handle
    https://git.kernel.org/netdev/net/c/1e1fa1723eb3
  - [net,v3,4/4] net: txgbe: free isb resources at the right time
    https://git.kernel.org/netdev/net/c/935124dd5883

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



