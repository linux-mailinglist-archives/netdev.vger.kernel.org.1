Return-Path: <netdev+bounces-26991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F38F2779C60
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 03:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0799281DFD
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 01:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8F2EDD;
	Sat, 12 Aug 2023 01:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3536610EE
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 01:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0AC1C433C9;
	Sat, 12 Aug 2023 01:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691805022;
	bh=ysoHYj+KZaxlSNAKflnuGhG1OWXzEAypWEPI1ZJHcjk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZEHGs0X7jv4gVnW1sdAWB6l2HKmDSlWf/SZGUl+PSaCA+nmNb/LGlQ7UpD3OnOhA3
	 sPijIcrMqYvZrid0UvVDXYLPT/h/lg6EVA9pWJOsKsQrLisd0i8lEEYiVMXVmf9nP0
	 2pxMcVFw2whF04SubVi1NACZ340yL6O+dRNxAeLgIDpa+IACUk+PSRd4C3B/gDgL5P
	 UuNMXXbxgJxTEOP0F5aScGJref8QgidTreFGL7eOUb26R2BiIzqUlrxpDniOdp8mD1
	 mmNleM0kItEYMTgreRlvtnFZF6ZfLLjNxkKZ/p4Id4YiIoEzbhMxHvBzf3iQu/f9Ho
	 C3ut/w9WgaSkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E88DC395C5;
	Sat, 12 Aug 2023 01:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] ethernet: ldmvsw: mark ldmvsw_open() static
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169180502257.32437.12168332345794994475.git-patchwork-notify@kernel.org>
Date: Sat, 12 Aug 2023 01:50:22 +0000
References: <20230810122528.1220434-1-arnd@kernel.org>
In-Reply-To: <20230810122528.1220434-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, arnd@arndb.de, geoff@infradead.org, petrm@nvidia.com,
 piotr.raczynski@intel.com, wsa+renesas@sang-engineering.com, windhl@126.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Aug 2023 14:25:15 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The function is exported for no reason and should just be static:
> 
> drivers/net/ethernet/sun/ldmvsw.c:127:5: error: no previous prototype for 'ldmvsw_open' [-Werror=missing-prototypes]
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> [...]

Here is the summary with links:
  - [1/2] ethernet: ldmvsw: mark ldmvsw_open() static
    https://git.kernel.org/netdev/net-next/c/ea6f782fe584
  - [2/2] ethernet: atarilance: mark init function static
    https://git.kernel.org/netdev/net-next/c/7191c140faa2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



