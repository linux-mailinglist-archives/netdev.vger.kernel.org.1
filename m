Return-Path: <netdev+bounces-40643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BDD7C81D3
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 11:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A20BB20AD3
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 09:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F9210A31;
	Fri, 13 Oct 2023 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBMsi6z5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C29010A11;
	Fri, 13 Oct 2023 09:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6489C433CC;
	Fri, 13 Oct 2023 09:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697188827;
	bh=mWSyMxKE2quLVklS4mF6hrQjoWiFg+m/8c7WZjyz05c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZBMsi6z5ugLc/m4ZfrcPjuRlAq/WDH8OHESEVG/keyMetuwRPb4Y25hoGULUtP24q
	 U0RkDrzqWj9J5BEqVL1ShLw59PZH8CxAil/T5xNXPD7diLv61HKomoDYvMZIUz/n82
	 7m4XeP0r09bfnJ5LwELHQPTAL15J2twGrmmrNo2uDomaPmzr6yaIswIbA9xBIllUkK
	 e5gbOw8wyIHCbZsJMefXtbfWNcn4iyC38P0ZUs1rUMbjfhEgJLIhqoORG72Jrh5uOm
	 l7D/J2apOnFQHBs6HdAB6xnskaoi4Tow01Qhb6IcVhKvP92MYSfEl2ya+bHK+nJe89
	 Mq1Gybze/rekA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B497E1F66C;
	Fri, 13 Oct 2023 09:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ibmvnic: replace deprecated strncpy with strscpy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169718882756.6212.2338041860471845995.git-patchwork-notify@kernel.org>
Date: Fri, 13 Oct 2023 09:20:27 +0000
References: <20231009-strncpy-drivers-net-ethernet-ibm-ibmvnic-c-v1-1-712866f16754@google.com>
In-Reply-To: <20231009-strncpy-drivers-net-ethernet-ibm-ibmvnic-c-v1-1-712866f16754@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
 haren@linux.ibm.com, ricklind@linux.ibm.com, nnac123@linux.ibm.com,
 danymadden@us.ibm.com, tlfalcon@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 09 Oct 2023 23:19:57 +0000 you wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> NUL-padding is not required as the buffer is already memset to 0:
> |       memset(adapter->fw_version, 0, 32);
> 
> [...]

Here is the summary with links:
  - ibmvnic: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/431acee06923

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



