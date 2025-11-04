Return-Path: <netdev+bounces-235415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E96AC302E4
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 10:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3356534DA78
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 09:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88743101A3;
	Tue,  4 Nov 2025 09:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o41kriMh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F29230BF58
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 09:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247433; cv=none; b=OdQiI0m/qB0wiGfSNhmR/MWFbckWcgf72HRC3JE1OGPEnyFKa7Ps53s7rNxdTHq/j7Q9PNtowSPYvC9RDBXRLf1QSSh5o/ieDh34hDZAIAEEz/C+TadQKhRoRFQuN6SXD2GpiRytkI6d8zquW1Cv0Q65hpdL0VsYhUQoKwvGRFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247433; c=relaxed/simple;
	bh=WSLinn9CxmtoXwwlTmMQs1rGE9vRd/mpGKo0nywt4rg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kqcvSYQS/WAEhWIkIi2BiNMEF4gcScUX0UWuEVcpUKoBhV4B91V/x7rWlpZ2kgyRIuGC4pwS5OR/KzWkRfb90ngQRCZZ4HnU87oURntpUZGUEuD/vYaCEeurj9zNuWdsl2Pc3pIBzIhk2bbk9YN2VIBOTeB/06S6CupCUVqZl20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o41kriMh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22112C4CEF7;
	Tue,  4 Nov 2025 09:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762247432;
	bh=WSLinn9CxmtoXwwlTmMQs1rGE9vRd/mpGKo0nywt4rg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o41kriMhIaRpvejCsew09YnNcIcvfVyVT7kH/ywNAJK/TGN7NRKNJosWnLj9Af7XH
	 iH8JzXZEb1w1E7Xq3ZI8w4VUOjZvrL+2E+VK9ve2efSEMwsEX+YiWC891BQE0LnxFx
	 2Pm2KBHooYGUQGX/z/9dSVAY02XoxWFeRxMVQEAlZs34Cp4EJpGa1xvBZGh4QWl63C
	 D6fhBymf3Xw0E78VkmPhS+Pzf10jW3fIntSKRPZw4ttX3za5zQTi/Q4c6sHma4r63b
	 bE7svR2mnIASwDbOCPNpV9Hlp8eKyJFX2J1a82rzgAN/1+2l9hGpBqjiwG11eczaMb
	 DVQnY1dvte9cA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CC1380A94C;
	Tue,  4 Nov 2025 09:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: add net cookie for net device trace events
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176224740625.2395086.6132299450268969280.git-patchwork-notify@kernel.org>
Date: Tue, 04 Nov 2025 09:10:06 +0000
References: <20251028043244.82288-1-tonghao@bamaicloud.com>
In-Reply-To: <20251028043244.82288-1-tonghao@bamaicloud.com>
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, eranbe@mellanox.com, jiri@mellanox.com,
 xiyou.wangcong@gmail.com, kuba@kernel.org, edumazet@google.com,
 horms@kernel.org, pabeni@redhat.com, idosch@idosch.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 28 Oct 2025 12:32:44 +0800 you wrote:
> In a multi-network card or container environment, this is needed in order
> to differentiate between trace events relating to net devices that exist
> in different network namespaces and share the same name.
> 
> for xmit_timeout trace events:
> [002] ..s1.  1838.311662: net_dev_xmit_timeout: dev=eth0 driver=virtio_net queue=10 net_cookie=3
> [007] ..s1.  1839.335650: net_dev_xmit_timeout: dev=eth0 driver=virtio_net queue=10 net_cookie=4100
> [007] ..s1.  1844.455659: net_dev_xmit_timeout: dev=eth0 driver=virtio_net queue=10 net_cookie=3
> [002] ..s1.  1850.087647: net_dev_xmit_timeout: dev=eth0 driver=virtio_net queue=10 net_cookie=3
> 
> [...]

Here is the summary with links:
  - [net-next] net: add net cookie for net device trace events
    https://git.kernel.org/netdev/net-next/c/27cb3de7f43a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



