Return-Path: <netdev+bounces-16207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A97F74BCFD
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 11:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06BC51C20F38
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 09:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE89546B3;
	Sat,  8 Jul 2023 09:13:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E28A3236
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 09:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4C07C433C9;
	Sat,  8 Jul 2023 09:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688807593;
	bh=GGjTgtQP0hOP9lcT9kmtL8KMc4PAiy+kzsOIS8VRKfE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VGl6gadFOPGy25lLvgossAMbSTORsXB97esuqHDqXxq86D95vDHEkv3hbd3kDIUhL
	 IhwfcToE/GdfEMV+Cy3w31RhkyXh/7wyHIGto9Egdhue2bV+CFrXOLCBST52ASw81J
	 JlNiYrTF9XpV/BwN1pa8GiDRZRz4XA7NzCWItO0tB7PcnbJwltIEOf2mzqdhE3YDWv
	 Bvl3WsA/oQYZ7PwYch1TL3vO3Jph1ECJOLgZGQJ2SGBUdPt/PyhWYedR2tWR+ueUX3
	 kgdOEFoSh126iUp5GWYKDWaACujtFjyg1T8oE7B7YQidFnVp4nthVXJ6Fi5v4q9+/0
	 q4KEAo3+vZ2pg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3409C59A4C;
	Sat,  8 Jul 2023 09:13:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/3] s390/ism: Fixes to client handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168880759372.30427.17818463512353318914.git-patchwork-notify@kernel.org>
Date: Sat, 08 Jul 2023 09:13:13 +0000
References: <20230707105622.3332261-1-schnelle@linux.ibm.com>
In-Reply-To: <20230707105622.3332261-1-schnelle@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: pabeni@redhat.com, wintera@linux.ibm.com, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, raspl@linux.ibm.com, davem@davemloft.net,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  7 Jul 2023 12:56:19 +0200 you wrote:
> Hi networking developers,
> 
> This is v2 of the patch previously titled "s390/ism: Detangle ISM client
> IRQ and event forwarding". As suggested by Paolo Abeni I split the patch
> up. While doing so I noticed another problem that was fixed by this patch
> concerning the way the workqueues access the client structs. This means the
> second patch turning the workqueues into simple direct calls also fixes
> a problem. Finally I split off a third patch just for fixing
> ism_unregister_client()s error path.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/3] s390/ism: Fix locking for forwarding of IRQs and events to clients
    https://git.kernel.org/netdev/net/c/6b5c13b591d7
  - [net,v2,2/3] s390/ism: Fix and simplify add()/remove() callback handling
    https://git.kernel.org/netdev/net/c/76631ffa2fd2
  - [net,v2,3/3] s390/ism: Do not unregister clients with registered DMBs
    https://git.kernel.org/netdev/net/c/266deeea34ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



