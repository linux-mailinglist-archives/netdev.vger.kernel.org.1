Return-Path: <netdev+bounces-234800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A30AC274FB
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 01:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA15D188F1B1
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 00:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A79D2080C0;
	Sat,  1 Nov 2025 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNHOZEC7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AB5203710
	for <netdev@vger.kernel.org>; Sat,  1 Nov 2025 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761958234; cv=none; b=bNETvnDLhr3m9HVCoyjKp9XihHZs9sKo1WH11vuy+95Ivu8MoVxOAKlvq4fVaOfXBa2fsPnnrhdVxwZkKKI3Ks3zYJrNOjG7f0iMlMPKWVoGn/zK4WB6SfjqK37YiDCo6DfkstZeSzDoUrZ6n9a3tgNb20rg6sgjruPj/RoZGvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761958234; c=relaxed/simple;
	bh=f3ux9fUlaccbTYtgsM+uGR1UbGtPEvrskQhlEXKsLRs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WiD+dxen/E6J3vOqrSjp7IOfwZEMEWHxqtfoS8OHuprbONEV7MQgZq1Xzl5qm10BSosJBYpGDhL59PYcRc1+1jzyj7EkbHdgSUlta6QP8YrUhrVdDYevKos0tXCTJDNPwy0ecLMnXEu+BhNSAwsXgfH9oIuak4FEwlrFm/pCY4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNHOZEC7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A75C4CEFD;
	Sat,  1 Nov 2025 00:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761958234;
	bh=f3ux9fUlaccbTYtgsM+uGR1UbGtPEvrskQhlEXKsLRs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UNHOZEC74en9mg1xU3x3At0sSMY/LIeUnRmJUaQpEwHWh5noAtMFAzDGPRwhTh97d
	 /LE1dawEd2j0oZAENVD9CwGd9Q4GFKsGq78Dd67gTCrF6jwqtNXz3I+e+dmWrzuvyk
	 V/LLxJHT2Hej57T95as4TE/J7mBCI69A6S+tpqj0Ey9VTSytoe28v3WkmkdmqI5myq
	 odRivMytWtSDM/C05F5kqkzFIo51Mm14u/ZiTavj3wAxX4BQFqEiAE4fNFo+8KD6aX
	 4Ibkfu426nUhMcHLuBrrPOYT8U4D5TWXMXSLWUCb28F+49nBjkFShFhX6Q28jEv6Wl
	 alFU6lSJZqgmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E1C3809A00;
	Sat,  1 Nov 2025 00:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net] net: vlan: sync VLAN features with lower device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176195820999.682052.17726977426774995723.git-patchwork-notify@kernel.org>
Date: Sat, 01 Nov 2025 00:50:09 +0000
References: <20251030073539.133779-1-liuhangbin@gmail.com>
In-Reply-To: <20251030073539.133779-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me,
 linux@treblig.org, dongchenchen2@huawei.com, oscmaes92@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Oct 2025 07:35:39 +0000 you wrote:
> After registering a VLAN device and setting its feature flags, we need to
> synchronize the VLAN features with the lower device. For example, the VLAN
> device does not have the NETIF_F_LRO flag, it should be synchronized with
> the lower device based on the NETIF_F_UPPER_DISABLES definition.
> 
> As the dev->vlan_features has changed, we need to call
> netdev_update_features(). The caller must run after netdev_upper_dev_link()
> links the lower devices, so this patch adds the netdev_update_features()
> call in register_vlan_dev().
> 
> [...]

Here is the summary with links:
  - [PATCHv2,net] net: vlan: sync VLAN features with lower device
    https://git.kernel.org/netdev/net/c/c211f5d7cbd5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



