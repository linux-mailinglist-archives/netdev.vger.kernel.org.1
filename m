Return-Path: <netdev+bounces-176504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB090A6A905
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 15:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F39884EDE
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 14:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC061E3DF7;
	Thu, 20 Mar 2025 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/9E01bF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9201E2845
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742482198; cv=none; b=dM5wQSRi1Gwc4q/dJVRsaZyeSJKgwa9jmqjKHFIuF758n16XgFCHc8A71i1qqU1N39j2xe9SNL/xI3Sg1RAD9qlydUDo4T8CAECIfB7WS8GBMOy8u1JfseoxG/qKGG7zRUhxvP8N2hRIU/ks4ryDxqNddfYfjeYXdIIcPRfA/kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742482198; c=relaxed/simple;
	bh=nclCvtPjp+bVvCl2moDMyXmZsWcmuCFcaAiLNBre3Eg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fkotLx11KU6gdokyMX5Fazqk30kxXyXiKichkOVL3Ye3TgDBHfEXngeoT5I1frE8brQjZOHM3sBV1hvzpaK2oZSpybd7x8txnL2XhVz9pHaIATp1mcisd9F0yAuxwNLJ+S9PX7L3e0/EQ7efib+Hc8xMlcBfsKvYZhXoM0XwD84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/9E01bF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F79AC4CEE8;
	Thu, 20 Mar 2025 14:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742482198;
	bh=nclCvtPjp+bVvCl2moDMyXmZsWcmuCFcaAiLNBre3Eg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B/9E01bF/hS6rFYHDmuXbK4DbCaRvVGJzX6v45jgwCAGCuUbfpy3OpR0wR47LTqFT
	 qunHi1T2XzLoNPK7OvfRMGXiBbOGQIMMQu8Jjo9lthSh4SIw9T3AaUEWJ1fIn5RZTy
	 /heSSTBjkfSppiMdx3TjzLU7gNR0cQj0i3gg2d/cePI8khT/QdL56PgmRz7DISsDxB
	 805pLaKQ56qWBi6h9xfvbDuhFUrEf8PATG+P+BFyeDaYqclbfALyObBBrDAsdEbrJz
	 IuTZ8V9ZlhNuJxd2PfHDLUV0u2oJ5JgNHJhodZ9v4vX50yMCf9J380GdMz/PpelaVI
	 n+BiIEOGia2Dw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFF73806654;
	Thu, 20 Mar 2025 14:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] xfrm: fix tunnel mode TX datapath in packet offload mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174248223427.1795325.9057916434131404700.git-patchwork-notify@kernel.org>
Date: Thu, 20 Mar 2025 14:50:34 +0000
References: <20250319065513.987135-2-steffen.klassert@secunet.com>
In-Reply-To: <20250319065513.987135-2-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Wed, 19 Mar 2025 07:55:12 +0100 you wrote:
> From: Alexandre Cassen <acassen@corp.free.fr>
> 
> Packets that match the output xfrm policy are delivered to the netstack.
> In IPsec packet mode for tunnel mode, the HW is responsible for building
> the hard header and outer IP header. In such a situation, the inner
> header may refer to a network that is not directly reachable by the host,
> resulting in a failed neighbor resolution. The packet is then dropped.
> xfrm policy defines the netdevice to use for xmit so we can send packets
> directly to it.
> 
> [...]

Here is the summary with links:
  - [1/2] xfrm: fix tunnel mode TX datapath in packet offload mode
    https://git.kernel.org/netdev/net/c/5eddd76ec2fd
  - [2/2] xfrm_output: Force software GSO only in tunnel mode
    https://git.kernel.org/netdev/net/c/0aae2867aa60

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



