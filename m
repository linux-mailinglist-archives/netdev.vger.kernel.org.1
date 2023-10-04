Return-Path: <netdev+bounces-37924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BCE7B7D26
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 12:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 396EF1F221F6
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 10:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C012F748F;
	Wed,  4 Oct 2023 10:30:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11B64400
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 10:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1F4DC433CA;
	Wed,  4 Oct 2023 10:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696415427;
	bh=vWWx1nO4RAxL6LqobAB889h4SVOJTDGvABoerwGt/Jc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VaV4uiYllnOcFw+0XXonrEp/laZm55jnRkC07xo01eJSEKEZc6rk2eet4t0By3OOe
	 EvPR6x4Q7NIpyIqaaCIAjXaXcacbiD57s9fIKPmPcgWwjpGMubmSjSD8luyaLdNiRG
	 l9fgw0nvdSXr1yFr6zAKD7kocml+GoH6i2E1fDSD5Olvusqx87ZDkPTE9btkah6GW/
	 chGvvL6xtDkiA6ptnIS1ykrM+J9szvP2Z/N4sxHryijDl01ObsF4zbjh0Y4O7nnn64
	 MShyYlp+EmAq8PhB0EN/U8crXfLWiTK8qbeC0o0CDLT9fxH607jgqE+0b8IhF24d2s
	 fXApE57lIvqbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9EF2EE632D8;
	Wed,  4 Oct 2023 10:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/9] bnxt_en: hwmon and SRIOV updates
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169641542764.13675.10570244634679139922.git-patchwork-notify@kernel.org>
Date: Wed, 04 Oct 2023 10:30:27 +0000
References: <20230927035734.42816-1-michael.chan@broadcom.com>
In-Reply-To: <20230927035734.42816-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, gospo@broadcom.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 26 Sep 2023 20:57:25 -0700 you wrote:
> The first 7 patches are v2 of the hwmon patches posted about 6 weeks ago
> on Aug 14.  The last 2 patches are SRIOV related updates.
> 
> Link to v1 hwmon patches:
> https://lore.kernel.org/netdev/20230815045658.80494-11-michael.chan@broadcom.com/
> 
> Kalesh AP (6):
>   bnxt_en: Enhance hwmon temperature reporting
>   bnxt_en: Move hwmon functions into a dedicated file
>   bnxt_en: Modify the driver to use hwmon_device_register_with_info
>   bnxt_en: Expose threshold temperatures through hwmon
>   bnxt_en: Use non-standard attribute to expose shutdown temperature
>   bnxt_en: Event handler for Thermal event
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/9] bnxt_en: Update firmware interface to 1.10.2.171
    https://git.kernel.org/netdev/net-next/c/754fbf604ff6
  - [net-next,v2,2/9] bnxt_en: Enhance hwmon temperature reporting
    https://git.kernel.org/netdev/net-next/c/6ad71984aa6b
  - [net-next,v2,3/9] bnxt_en: Move hwmon functions into a dedicated file
    https://git.kernel.org/netdev/net-next/c/a47f3b3992aa
  - [net-next,v2,4/9] bnxt_en: Modify the driver to use hwmon_device_register_with_info
    https://git.kernel.org/netdev/net-next/c/847da8b1178c
  - [net-next,v2,5/9] bnxt_en: Expose threshold temperatures through hwmon
    https://git.kernel.org/netdev/net-next/c/cd13244f19eb
  - [net-next,v2,6/9] bnxt_en: Use non-standard attribute to expose shutdown temperature
    https://git.kernel.org/netdev/net-next/c/3d9cf962067b
  - [net-next,v2,7/9] bnxt_en: Event handler for Thermal event
    https://git.kernel.org/netdev/net-next/c/a19b4801457b
  - [net-next,v2,8/9] bnxt_en: Support QOS and TPID settings for the SRIOV VLAN
    https://git.kernel.org/netdev/net-next/c/e76d44fe7227
  - [net-next,v2,9/9] bnxt_en: Update VNIC resource calculation for VFs
    https://git.kernel.org/netdev/net-next/c/cbdbf0aa41ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



