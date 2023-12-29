Return-Path: <netdev+bounces-60561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA7681FDE4
	for <lists+netdev@lfdr.de>; Fri, 29 Dec 2023 08:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E9BB1C2225F
	for <lists+netdev@lfdr.de>; Fri, 29 Dec 2023 07:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E56F5688;
	Fri, 29 Dec 2023 07:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocIYDa/h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AEB8BE7;
	Fri, 29 Dec 2023 07:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6D32C433C9;
	Fri, 29 Dec 2023 07:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703836224;
	bh=7WRDhJLqdxyHqOVFPGYBQG8Dbk0NPlm/BecV7spU7So=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ocIYDa/hQZjLoo3wwtSCk8ZpvRsCvev6ND+np6FKh4ouuxI8ojV3EOee9xh2GNzb8
	 sVnI1El79AX8raMdrClF/RniAX9n5HUUwDl0hDuMrrXfvXsmzSVA+ovG/684+Nds0q
	 WJivs60l49Sq2s3qYLrhRG5q+NZprYxHlZV88pRsPQQajy4/tmUwVeZtcmhVLhJYkI
	 HjWCBnp3ocgarRn9Q2AVaN2n3XVJxWG1wQANO0AY7idfCw9rVhuaTbQ2TBhwwMuc3N
	 X1Mp93EMWuxq+ZEx/kEfpI07Mub1lvY7wdhDXJVIsvvn3yRyC8on50aEtxisdLG5zc
	 joTq7Fm5eyvGw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD66FE333D8;
	Fri, 29 Dec 2023 07:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] iucv: make iucv_bus const
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170383622477.2430.3049394181290219600.git-patchwork-notify@kernel.org>
Date: Fri, 29 Dec 2023 07:50:24 +0000
References: <2023122017-shelf-cadet-309c@gregkh>
In-Reply-To: <2023122017-shelf-cadet-309c@gregkh>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: wintera@linux.ibm.com, wenjia@linux.ibm.com, linux-kernel@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 20 Dec 2023 08:41:18 +0100 you wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the iucv_bus variable to be a constant structure as well, placing
> it into read-only memory which can not be modified at runtime.
> 
> Cc: Wenjia Zhang <wenjia@linux.ibm.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: linux-s390@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Acked-by: Alexandra Winter <wintera@linux.ibm.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> [...]

Here is the summary with links:
  - [v2] iucv: make iucv_bus const
    https://git.kernel.org/netdev/net-next/c/f732ba4ac9f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



