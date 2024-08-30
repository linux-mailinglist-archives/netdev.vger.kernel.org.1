Return-Path: <netdev+bounces-123797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B6B9668D1
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 20:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB9B1F24185
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 18:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF951BC063;
	Fri, 30 Aug 2024 18:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHs/O6kO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D7A1BBBC0;
	Fri, 30 Aug 2024 18:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725042028; cv=none; b=FgikBMUgQUcfe4Uo0VjOJG0ZHkDMm8oxhynSn3S55oYrEO0QxV6x6jFejOndzV/CKZmU8EgBY+XBlujyx13PciKqA2yRFZQXfFaODYGtTjGZD6mGsTpRzRdiXnqNPyXkRnfoy4hgu2v6sf7eXN82B8rb/IsoSeTYVU7ryM/ST7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725042028; c=relaxed/simple;
	bh=1yXwHZ8yhuJpiRhLARtZgOVIwcOcmD8arCpQDuOTth8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JUNkSjFzTrerBOrXykByfjdI/bhOjt1jc/1QEXxOAYJ1266JMmYL6wXOQdjtWAr8uYp02wJ36HdXjEWnXbI+UONOt2oLVhe9GdhINrjnOvOJz9Y7o7OAKk3rvJMchMhmLiyr8S9Qf6POdJC56UiiF7WzDDqQL/nLob7DKslDmN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHs/O6kO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29100C4CEC7;
	Fri, 30 Aug 2024 18:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725042028;
	bh=1yXwHZ8yhuJpiRhLARtZgOVIwcOcmD8arCpQDuOTth8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aHs/O6kOKnecW5iTgfL22V6EhhlkZv6J5WDeZicVg06e0MN97X25ywFTUu/24YMAK
	 diOUC0UNqGaCsMtF+zfQDWOapXQBTfmLd8UacfR5N/JQUNOxU2fhAp7AWIo04BLPdL
	 npWyE/qvxr+d3AfPK0DwSMuIEK/7J7pWersDhqrzVS/+W6lXHaiOyTOFZ7ACNu1pQD
	 28jNN7AH5lUHv3eNmtp4Jf7beoIj5L9b0+vEwjxdPNdZyCbOKaMUMta7zDFdF2xNmW
	 d8FmwFMWpNwZp6+XnIjgQSZtdywX6sR0Wh5/9+9wFNgr/b14gjqCA0YQwAHD7v93xV
	 PewVpG0r+1hIg==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE88C3809A81;
	Fri, 30 Aug 2024 18:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] nfp: Convert to use ERR_CAST()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172504202970.2677701.1080277774127927988.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 18:20:29 +0000
References: <20240829072538.33195-1-shenlichuan@vivo.com>
In-Reply-To: <20240829072538.33195-1-shenlichuan@vivo.com>
To: Shen Lichuan <shenlichuan@vivo.com>
Cc: louis.peens@corigine.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, kuba@kernel.org, oss-drivers@corigine.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 29 Aug 2024 15:25:38 +0800 you wrote:
> Use ERR_CAST() as it is designed for casting an error pointer to
> another type.
> 
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
> ---
>  drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [v1,net-next] nfp: Convert to use ERR_CAST()
    https://git.kernel.org/netdev/net-next/c/f24f966feb62

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



