Return-Path: <netdev+bounces-157013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF0CA08BB8
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355383ABD5C
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B879920CCDB;
	Fri, 10 Jan 2025 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggbvGHWT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9E920CCDD
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500816; cv=none; b=GfPNOP2JPPy/Gg/MUghFINhzk3cUXIlMtov32QnhC8pPVieyX/mhvkMYfnA+WbLLT7uIQjDFc50eAcvLbNrYIapHeG5sJJcE4+aBn05S16Xnjse2ueGm/ycO9oCBlJ86QaxzLpidnTT5OduDodFGPcXccgm4+l5KEskM8f1qCmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500816; c=relaxed/simple;
	bh=ukywCl9BhbYufbBvgNf9SlxVVNbThZTufseuETqwSAE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QgmqSwx2SPNGqxxfFryHaFlIs2JwZd24eCj47qTdM+0j7D835gGsOh2gNtuQcdooX58YVWaaEdyLUXF/BLYCaFW7s4oN2myB/1LTb/zvaFv/FiDXH4ENbksNCBAJfEIqsj9vDTFYt6AkLjdmzcVtIuEnpPk/pkC8AR5Nnk1/lNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggbvGHWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6A9C4CED6;
	Fri, 10 Jan 2025 09:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736500816;
	bh=ukywCl9BhbYufbBvgNf9SlxVVNbThZTufseuETqwSAE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ggbvGHWT7XvabdZQufTLPtXdo/vIclvoq60fm6IdHzHsZKrIW4Yxslexqnm6VGr5y
	 PCPkufNsGA4teNin9uuAskBZWXwhEwrKz53/GOjDdDoKNGesCUInrbZRovLVFPq4lN
	 ocy/lBOzD5byevsJ661b1ZxX51kT4WV2lstZhYHIDCdtv3MYFPjSO9J3ZnP2a4ZTgE
	 Ov/lc+Ztw3oXayo7J/OzIoWgC9095/vxA5ONE6CrnsVqHIu5H3k2xSDaQrB0VUd1pm
	 fJj1wTyg+RxDBiZ60yuzOBhE9wyyBTysX4/91GmX09RG6BX4CkREHhzOhRh9kdemMi
	 QSi1PCXjGL1GA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C6F380AA4A;
	Fri, 10 Jan 2025 09:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 01/17] xfrm: config: add CONFIG_XFRM_IPTFS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173650083810.1984486.15872640792908464459.git-patchwork-notify@kernel.org>
Date: Fri, 10 Jan 2025 09:20:38 +0000
References: <20250109094321.2268124-2-steffen.klassert@secunet.com>
In-Reply-To: <20250109094321.2268124-2-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Thu, 9 Jan 2025 10:43:05 +0100 you wrote:
> From: Christian Hopps <chopps@labn.net>
> 
> Add new Kconfig option to enable IP-TFS (RFC9347) functionality.
> 
> Signed-off-by: Christian Hopps <chopps@labn.net>
> Tested-by: Antony Antony <antony.antony@secunet.com>
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> 
> [...]

Here is the summary with links:
  - [01/17] xfrm: config: add CONFIG_XFRM_IPTFS
    https://git.kernel.org/netdev/net-next/c/ffa794846bf7
  - [02/17] include: uapi: protocol number and packet structs for AGGFRAG in ESP
    https://git.kernel.org/netdev/net-next/c/64e844505bc0
  - [03/17] xfrm: netlink: add config (netlink) options
    https://git.kernel.org/netdev/net-next/c/f69eb4f65c58
  - [04/17] xfrm: add mode_cbs module functionality
    https://git.kernel.org/netdev/net-next/c/7ac64f4598b4
  - [05/17] xfrm: add generic iptfs defines and functionality
    https://git.kernel.org/netdev/net-next/c/d1716d5a44c3
  - [06/17] xfrm: iptfs: add new iptfs xfrm mode impl
    https://git.kernel.org/netdev/net-next/c/4b3faf610cc6
  - [07/17] xfrm: iptfs: add user packet (tunnel ingress) handling
    https://git.kernel.org/netdev/net-next/c/0e4fbf013fa5
  - [08/17] xfrm: iptfs: share page fragments of inner packets
    https://git.kernel.org/netdev/net-next/c/b96ba312e21c
  - [09/17] xfrm: iptfs: add fragmenting of larger than MTU user packets
    https://git.kernel.org/netdev/net-next/c/8579d342ea2b
  - [10/17] xfrm: iptfs: add basic receive packet (tunnel egress) handling
    https://git.kernel.org/netdev/net-next/c/6c82d2433671
  - [11/17] xfrm: iptfs: handle received fragmented inner packets
    https://git.kernel.org/netdev/net-next/c/075694765446
  - [12/17] xfrm: iptfs: add reusing received skb for the tunnel egress packet
    https://git.kernel.org/netdev/net-next/c/3f3339885fb3
  - [13/17] xfrm: iptfs: add skb-fragment sharing code
    https://git.kernel.org/netdev/net-next/c/5f2b6a909574
  - [14/17] xfrm: iptfs: handle reordering of received packets
    https://git.kernel.org/netdev/net-next/c/6be02e3e4f37
  - [15/17] xfrm: iptfs: add tracepoint functionality
    https://git.kernel.org/netdev/net-next/c/ed58b186c773
  - [16/17] xfrm: Support ESN context update to hardware for TX
    https://git.kernel.org/netdev/net-next/c/373b79af3a20
  - [17/17] net/mlx5e: Update TX ESN context for IPSec hardware offload
    https://git.kernel.org/netdev/net-next/c/7082a6dc84eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



