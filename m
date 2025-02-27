Return-Path: <netdev+bounces-170088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 630E5A473E5
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 05:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2AC188BEB9
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 04:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BCE1EB5CC;
	Thu, 27 Feb 2025 04:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIkDN2Ux"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1A4BE65;
	Thu, 27 Feb 2025 04:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740628804; cv=none; b=vFudqiH/P4mJt1OjuFtf1vjkiXleasg4qRsfITLLXfbCGBiMbzJecUjgiVfxYjncKUQSm9alRYtgDHm4VvlR8iG1rCQGPDgqEAMIljTbKdjBVlcIHffwSgnVry+QhVQiFqd+ZXdS1EMxU2t7jbDtbqfTNl0YNUjlRbVm7kJ7bXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740628804; c=relaxed/simple;
	bh=68mSty9VX6udrXOuMxWDec+7emoXAQ1FjDWyUxfk/OY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E8CSwLAi265pjdOHQcvcqryWhehTLHBE8SQw+VIStAwdjhof1T4/y2vLViUfWw7AKxwyL1Ow2tJSt0lx9UZPdtELtMNJ7HzXhoRTcjSixmiprgasLZxGY3BGDIaiRzaQQOJVNBPtugZwfEu1HX02UnrCAK2ni0X4HXTgSpNxGi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIkDN2Ux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1233EC4CEDD;
	Thu, 27 Feb 2025 04:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740628804;
	bh=68mSty9VX6udrXOuMxWDec+7emoXAQ1FjDWyUxfk/OY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mIkDN2UxWvV2XThAuaoq7iokroCRxny5Bt/VFQQBeCpU3DGa1xTPfwqP/+feiHZYf
	 HZVuRON4Rjy0VJm4H7DVvq7y7xjX0lqRX/vF/oRV2nVUViYwdvr6HmDcQ1FcIe1bYl
	 OnUFg+86IzvFiLMIhSlE2gWQys/mHlDVCPUVQ+KEeosuVyAK7BlzFL0Lm2cDA38yYf
	 gx4ygzjraOLNqB3dRvYO1EW4Vrel9RFDDAs634/wrEzbnJvmkJMMlUySodwpkthwBC
	 7ODf5mpTtFNdVbGu2OowSJfl7yHYMQ+LF0MqVOo1zGEFsNH/KSDeqIkttF0v/At15z
	 Uw+SquOvA29kQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 346A4380CFE6;
	Thu, 27 Feb 2025 04:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net-next] bonding: report duplicate MAC address in all
 situations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174062883599.960972.8510053469556402775.git-patchwork-notify@kernel.org>
Date: Thu, 27 Feb 2025 04:00:35 +0000
References: <20250225033914.18617-1-liuhangbin@gmail.com>
In-Reply-To: <20250225033914.18617-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 razor@blackwall.org, horms@kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Feb 2025 03:39:14 +0000 you wrote:
> Normally, a bond uses the MAC address of the first added slave as the bond’s
> MAC address. And the bond will set active slave’s MAC address to bond’s
> address if fail_over_mac is set to none (0) or follow (2).
> 
> When the first slave is removed, the bond will still use the removed slave’s
> MAC address, which can lead to a duplicate MAC address and potentially cause
> issues with the switch. To avoid confusion, let's warn the user in all
> situations, including when fail_over_mac is set to 2 or not in active-backup
> mode.
> 
> [...]

Here is the summary with links:
  - [PATCHv2,net-next] bonding: report duplicate MAC address in all situations
    https://git.kernel.org/netdev/net-next/c/28d68d396a1c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



