Return-Path: <netdev+bounces-83147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B9989108B
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 02:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209BE1F22EDD
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 01:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776CC182CC;
	Fri, 29 Mar 2024 01:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZDm/4TC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5417217C77
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 01:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677030; cv=none; b=ZOJTc9+YUqg6TmEmEiYFddNty1xnN0KvQVRfjGjnBFlKEj8ZM8QoPDmOUOnKc5Bjl/4mIAjdWE2I8VzYWg+E+NYd7+7mouzcSYyxwUWJX7kEFYPclo28o1vVRQF0VBlpfQ/fF/YsjZmzMeTP0leJMto3uqaywE5K1nSP0lb+RfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677030; c=relaxed/simple;
	bh=ap0PVWIliadH4ZIeGDNB3KKtc6mR0S75nueR6hPUdi4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q5oZmk+3pITi3ClhDtuN3pnFHjiMFgvsiH+S1PCqRjLx/cHSCpDvRc4ZIVMRGsiMUfZ8P1ZlJPneJ3qEgf43cdIuQoJIQJV+aZnHTwo8t1LKCbkohxFlY1Oe69IvB0IbzNuQOzjc1wSJgoyOY1FB0syxy2PYwFZPcGmA7JYCg04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZDm/4TC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0C04C43399;
	Fri, 29 Mar 2024 01:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711677029;
	bh=ap0PVWIliadH4ZIeGDNB3KKtc6mR0S75nueR6hPUdi4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YZDm/4TCxHA5TpGxUW9SmmiE3WYEYj617GNw2WIctuBxRW7LXWP2hmW3uwQTjw61q
	 WAqpsnYw/9oPh9C3NGHBdT9u/MM56TstmU4B6oxnTvoP3I+51w4KRn591554YxKxy7
	 fFZzuO0yQcACYjsjXN12Xgkomw8jelSO5ui+WhGYohX1dGEUNGtlvvnvZmU0kLFpO5
	 ApsNMjz9WjgzEE0yl7DvX0d5oPN+VeWEyu/6xT+OkNlrqbj7ScXOAzEze7OiKnJ/pe
	 Z2tbMO+GIOqTLpNKM7Rehug8tgpyYPfQejqAQf4qKTSQeSgROn9u0N7/BHBVapcZZP
	 lWsVt8Mdxq4og==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C5324D2D0EB;
	Fri, 29 Mar 2024 01:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] gve: Add counter adminq_get_ptype_map_cnt to stats
 report
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171167702980.13430.10029110887654546188.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 01:50:29 +0000
References: <20240325223308.618671-1-jfraker@google.com>
In-Reply-To: <20240325223308.618671-1-jfraker@google.com>
To: John Fraker <jfraker@google.com>
Cc: netdev@vger.kernel.org, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 Mar 2024 15:33:08 -0700 you wrote:
> This counter counts the number of times get_ptype_map is executed on the
> admin queue, and was previously missing from the stats report.
> 
> Signed-off-by: John Fraker <jfraker@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve_ethtool.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] gve: Add counter adminq_get_ptype_map_cnt to stats report
    https://git.kernel.org/netdev/net-next/c/3bcbc67be1b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



