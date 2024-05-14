Return-Path: <netdev+bounces-96261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCA08C4BFF
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 07:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A9BB1C20BC0
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 05:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6115617BD9;
	Tue, 14 May 2024 05:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ou3OrZqP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D33214A96
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 05:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715664630; cv=none; b=uvetZr2C0dcq1+1hya6ljNhbgiCZtT3JND+lEAmz5PIpHfsKSh6ER5t39FrKFDDfORrdokOCW7vg4uT5ecwtv54yVk9eWxlGWWuAG/jKqaPOd7bbZ5GIOjUZpxmN3jOBNirmQHyqObvr3EHi01QCvkRsLYwsTa43uQjE/rHDZiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715664630; c=relaxed/simple;
	bh=kGzzDknXgqZRpw08G7aGjE8Ux7w302ohX9V/BbnOQZM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WbDEuL8yO3FztDbLEpgAxRbTin7TYH0vb0Vkg1xfOy7SzgyDx9ZpvGzsJi4aypv/xHeSoALvjYagtz6tiWfTlYFwsZH+PhdfqdA1dzPIKjY1Qix9yGLnlk/umoO4yOgHXT0AKRuh2ImMQtKFbUHHDretFEL9FOt131PL/ZTdyKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ou3OrZqP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0D0CC32786;
	Tue, 14 May 2024 05:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715664629;
	bh=kGzzDknXgqZRpw08G7aGjE8Ux7w302ohX9V/BbnOQZM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ou3OrZqPnwnWlmu4Nf0A11WYhMrQ9P1o0s3Nbjgke5m5oQYOq7yCSmS7ptNnsyGUv
	 eVKLKQiml5MSiGfgF+w9PqaOPe6hVL2GaFLK9ORYOvFjaijhGWEUi6iLZ5OK9wN+4K
	 f5nw+GpYzlFmRkS7tLp3AbrKVFx4bcwHN0AQ+2NcIiwQ+p4IW+0B2vQ1V0xBJ/2bpw
	 kuI40LDE6ZNv38tnzksvyNKKAFtSSYNfsZjaHr0Vu2QU0EC2DHwxykRVhEWJBnYh/+
	 1asVj+GceR5IrOYXtK854Vg73UeKIqciZj3/upiDjB8Tt/ga7KfpjujeyhBPoRJ+aV
	 1x9AGi+mMdJNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C212AC433F2;
	Tue, 14 May 2024 05:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 iproute2] bridge/vlan.c: bridge/vlan.c: fix build with gcc
 14 on musl systems
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171566462879.15721.11797098361423504270.git-patchwork-notify@kernel.org>
Date: Tue, 14 May 2024 05:30:28 +0000
References: <20240510143613.1531283-1-gabifalk@gmx.com>
In-Reply-To: <20240510143613.1531283-1-gabifalk@gmx.com>
To: Gabi Falk <gabifalk@gmx.com>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Fri, 10 May 2024 14:36:12 +0000 you wrote:
> On glibc based systems the definition of 'struct timeval' is pulled in
> with inclusion of <stdlib.h> header, but on musl based systems it
> doesn't work this way.  Missing definition triggers an
> incompatible-pointer-types error with gcc 14 (warning on previous
> versions of gcc):
> 
> ../include/json_print.h:80:30: warning: 'struct timeval' declared inside parameter list will not be visible outside of this definition or declaration
>    80 | _PRINT_FUNC(tv, const struct timeval *)
>       |                              ^~~~~~~
> ../include/json_print.h:50:37: note: in definition of macro '_PRINT_FUNC'
>    50 |                                     type value);                        \
>       |                                     ^~~~
> ../include/json_print.h:80:30: warning: 'struct timeval' declared inside parameter list will not be visible outside of this definition or declaration
>    80 | _PRINT_FUNC(tv, const struct timeval *)
>       |                              ^~~~~~~
> ../include/json_print.h:55:45: note: in definition of macro '_PRINT_FUNC'
>    55 |                                             type value)                 \
>       |                                             ^~~~
> ../include/json_print.h: In function 'print_tv':
> ../include/json_print.h:58:48: error: passing argument 5 of 'print_color_tv' from incompatible pointer type [-Wincompatible-pointer-types]
>    58 |                                                value);                  \
>       |                                                ^~~~~
>       |                                                |
>       |                                                const struct timeval *
> 
> [...]

Here is the summary with links:
  - [v2,iproute2] bridge/vlan.c: bridge/vlan.c: fix build with gcc 14 on musl systems
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=53a89bfd86ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



