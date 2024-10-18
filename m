Return-Path: <netdev+bounces-136832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EA19A32E5
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 04:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 231351F24972
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 02:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E3E16A956;
	Fri, 18 Oct 2024 02:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMyOgszB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1561684A5;
	Fri, 18 Oct 2024 02:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218634; cv=none; b=tLhyRyC/zBfnN6SzaekqR6+rUs1D9UDQkq8HfgH4S5j3WFpu/Af8rcbJhPXFiaSM8gKv+RY+AEvyS39YeMFvcQpu9jJ3iU95Blx8xlkxPSMno0sXG6BphjwH20S3j/zP6lJTvH/UEQ4/F94X3Euf32uH8K4ooY9X/2CTfW827oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218634; c=relaxed/simple;
	bh=G2dxA7eNuln26z0toyzSDHedyLi6+2/h+7lBjXqDVBE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YMw3O11ppnTPG53AnFpiBxUnPBCkEM3G54NAlFgq0fGSUjnwafrm99L7Cam1Me5pKDG4lys0xj2mRIyVRtBx/i3LMlkta81x9BaUkuYfwiOFZ2YiTiwoMrpVDNzrbWUPbvBlyF6rrJBM98UR8/rcBBsVCwzzvy5AqHYMSuNDDo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMyOgszB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD1DC4CECD;
	Fri, 18 Oct 2024 02:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729218634;
	bh=G2dxA7eNuln26z0toyzSDHedyLi6+2/h+7lBjXqDVBE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pMyOgszBZ8FHCg3AWs678vOAkaI4W3l50pXdgu8tf6VBX7WCCBfXpNF3whahJkMW7
	 yo94hv0cXOtoAYoiAxbc6GI6Ydz+KT8BbSxhbVlTdj9LJo6ufN0/bZrJAOdMlExPLH
	 k+NredPwjGThyVcZ4xGYoAL61D9AruiA/knMRNYLTLJcfl61MoehVDQW9ljQXo8Uj9
	 Pgs+OqNq93Llv2WOPlmy0gzS+8toPNqzK4GDMRE0XhpkHInmO92KbQM4fpgyDRDzQR
	 kajHdKtaJ+5Tx4Fuz6RSGtM/vIn5vtGPs0ghZrfRLNG73G2KPRtKrADES2AjbNley5
	 8PSBfX1dIOgHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71E573809A8A;
	Fri, 18 Oct 2024 02:30:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/1] tg3: Increase buffer size for IRQ label
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172921863999.2663866.2502282067699380467.git-patchwork-notify@kernel.org>
Date: Fri, 18 Oct 2024 02:30:39 +0000
References: <20241016090647.691022-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241016090647.691022-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 pavan.chebbi@broadcom.com, mchan@broadcom.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Andrew Lunn <andrew@lunn.ch>:

On Wed, 16 Oct 2024 12:05:54 +0300 you wrote:
> GCC is not happy with the current code, e.g.:
> 
> .../tg3.c:11313:37: error: ‘-txrx-’ directive output may be truncated writing 6 bytes into a region of size between 1 and 16 [-Werror=format-truncation=]
> 11313 |                                  "%s-txrx-%d", tp->dev->name, irq_num);
>       |                                     ^~~~~~
> .../tg3.c:11313:34: note: using the range [-2147483648, 2147483647] for directive argument
> 11313 |                                  "%s-txrx-%d", tp->dev->name, irq_num);
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/1] tg3: Increase buffer size for IRQ label
    https://git.kernel.org/netdev/net-next/c/abb7c98b99f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



