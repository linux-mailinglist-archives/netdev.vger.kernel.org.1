Return-Path: <netdev+bounces-163327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3E8A29ECC
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 03:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B837D3A7E97
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 02:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8973C13D8A3;
	Thu,  6 Feb 2025 02:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzkbqaXd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1B513CA93;
	Thu,  6 Feb 2025 02:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738809005; cv=none; b=S7YcY2thumOJvgLq2Ptjxzva+MXbKbB1ioNN2uE7mePwziEG5t5GD30Cwk0+yT3exkQL2ajON968JfCeAqzeD+mqAJN+BPnD+/mH0MOiI3tT4t7b4tSipK1tNbuayrU4wU6P5UjANUgr/Yla4Y5IHtKQdpK2lySCOWsYDouHYKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738809005; c=relaxed/simple;
	bh=GsiWg255+oQli3R2cw8dchDOAynRzKekhfvI2X34Xm0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BbtHGr9/gka2amMIUbklGC8JlisYE8OcCD2Z4PovOucZZqMvKf5Tyt9MD4ICN3dxooftyJf6/RLwwo0S3tO0CzRKblGOniCMRaN8C+uoGBuK209gWYkrdX9TDrfxIVyRP2grueDJtXR+mLKodJ6X/dcDSQQc5AChQFRJ6BB/c+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzkbqaXd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244DCC4CED1;
	Thu,  6 Feb 2025 02:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738809005;
	bh=GsiWg255+oQli3R2cw8dchDOAynRzKekhfvI2X34Xm0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VzkbqaXd53htU4S+7T5KL67kPkupTG7UfP7oeDekEBsZA06M2utlHuUwtpBO42Dq7
	 3MROnBcpdOkDSBF6zZcscYHYV0SSASWUvQCcL80ZellI09p1faJmqAr+UEPChRsC0s
	 b7CMij3xj3GY+OmUm72AsB5T9x/s5MotnyuBJE8BipKZEJ3ukouGE3zAJEhFe2zi37
	 WLLYp8P84GZMrQlbJCwpILwYckKKmUPIzq+UmT1yM/ziEDrPtKjWrSXF3NLbC8WCjg
	 pUj8hBjOC4QQnR4/xVVgJ1bh0qo0PcMCBnJ5ZQwwmRsSF+HoHTJc/QUyShV4aN3ml0
	 f/yc45GIp42uA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0B0380AAD0;
	Thu,  6 Feb 2025 02:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2][next] cxgb4: Avoid a -Wflex-array-member-not-at-end
 warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173880903266.977176.16088517272942602170.git-patchwork-notify@kernel.org>
Date: Thu, 06 Feb 2025 02:30:32 +0000
References: <Z6GBZ4brXYffLkt_@kspp>
In-Reply-To: <Z6GBZ4brXYffLkt_@kspp>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: bharat@chelsio.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 4 Feb 2025 13:24:31 +1030 you wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Move the conflicting declaration to the end of the structure. Notice
> that `struct ethtool_dump` is a flexible structure --a structure that
> contains a flexible-array member.
> 
> [...]

Here is the summary with links:
  - [v2,next] cxgb4: Avoid a -Wflex-array-member-not-at-end warning
    https://git.kernel.org/netdev/net-next/c/863257c29fe9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



