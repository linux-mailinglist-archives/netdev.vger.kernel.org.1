Return-Path: <netdev+bounces-134036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEF6997B1E
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 05:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE334282FAF
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 03:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DFF1917C0;
	Thu, 10 Oct 2024 03:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXPOjSUp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCB618FDC5;
	Thu, 10 Oct 2024 03:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728529835; cv=none; b=KZGCIf5nF7rr9nrwuFGC9ok7Hyaji9+gjRy2eOeUpQVZG1aIaC1Fyk33onWy63vARFBBu8IxYqk4+M031ymycAumi6TLPoLk4m5Qt+0RIwenEj7kJq3ovhLiJlmUQ4mZwuL1mB9NtWhWgTZdlPs5cD/u18kz234BYFa2UVuLw0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728529835; c=relaxed/simple;
	bh=8Ci5zNUcKA9NA43M1XW8pQhIgCu8C1M9ht8lYmp7vdM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Eqz/frsV8VpBj6J6Kfyz6r6z7ad0gWvpq26PV1fwBSZAoF6f9jhuUlgFZ1YTGTrqLm1peMCG78Hh+guLxU9B9zyDKNgLl7Z7FgfUismuvh4FMtFWck5NrbL50HL4giQ9n1MpAkrh6tLa7oMzeoHJmKqrCmUGHaqGlQ05+W918+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXPOjSUp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF384C4CEC3;
	Thu, 10 Oct 2024 03:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728529834;
	bh=8Ci5zNUcKA9NA43M1XW8pQhIgCu8C1M9ht8lYmp7vdM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DXPOjSUpZbdXVe1vhA3dwchNkVKXCY6r00A1mJx7mDqx1Nj7N/PgWpaqwp1GJl3Pj
	 LM0Z8RrYS3iNzLNe+cjWerdE2/f9W8MGfY0/mn5H16EocgNdhgr+6rue/4efhbkqIG
	 Twjb9JjoNU613Kc6acFKrLUllsb92WsQntacYsQHl/Dduep0GLbSoghX+4rO5ksGD4
	 88ybWeX2gHka+xr3vu3cDh77NoES7WwxfTjvDq4shzk1Tmb4p/+74gCYC5K6MMq8e8
	 +/DDJeHHlpx7vsx42HjvX70osodt3zOnQFbYY3/VBciComBwisUKlMT2OEi11eb0tx
	 qIB0GKHP+++uA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EB03806644;
	Thu, 10 Oct 2024 03:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] Fix misspelling of "accept*" in net
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172852983923.1551072.5298388677604048288.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 03:10:39 +0000
References: <20241008162756.22618-2-green@qrator.net>
In-Reply-To: <20241008162756.22618-2-green@qrator.net>
To: Alexander Zubkov <green@qrator.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 linux@treblig.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Oct 2024 18:27:57 +0200 you wrote:
> Several files have "accept*" misspelled as "accpet*" in the comments.
> Fix all such occurrences.
> 
> Signed-off-by: Alexander Zubkov <green@qrator.net>
> ---
>  drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c | 4 ++--
>  drivers/net/ethernet/natsemi/ns83820.c                        | 2 +-
>  include/uapi/linux/udp.h                                      | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [net-next] Fix misspelling of "accept*" in net
    https://git.kernel.org/netdev/net-next/c/80c549cd1ab0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



