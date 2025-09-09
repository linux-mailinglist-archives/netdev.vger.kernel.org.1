Return-Path: <netdev+bounces-221020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23964B49E68
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 03:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03E8D7A9C8B
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 00:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE96219A8A;
	Tue,  9 Sep 2025 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfyN31+r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B791A1AA1D2
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757379608; cv=none; b=krKjmZ+zC4HFABpz0hUHefWz1/XbZWhNBVjSEhq9fHhwg79kZRzv7KJ1CrmnS9IkssTqbWtGXlJW89LHE/pT1MC4KI0SZv/V/c3PQeclFephLLWWWC+FSOt3tZqNp+C4Loh6oZkltD2cBx4kMxTZWNsUDJBjarBTOAdu3wEa2HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757379608; c=relaxed/simple;
	bh=Mg5IXjdCk71xFFqEH8eeO7+1a0x/JDcbE45m4ylLwow=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uqpRbGgiw6kayDAClkkus1KHXV6du8HoOOrRQoo1fe88gdz8/QAemqaYWvnber4KXZuA8MDaU1CPkCMBga/IlRKilBY6PavpSDB4OYTY4VCuBaHDKlpdTPPWtYVdK34YstXMxWUupoNG5+uakE8OLoy5gEvxhujJUq7uGJFcGso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfyN31+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532CDC4CEF1;
	Tue,  9 Sep 2025 01:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757379608;
	bh=Mg5IXjdCk71xFFqEH8eeO7+1a0x/JDcbE45m4ylLwow=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YfyN31+rlVksq6aBCl9fCKQejeYoiycozBoz5/VRtNFaXxxNVe3fhl2phWQLLi0dN
	 av3E31T/jKu7uj4aSMxKDwyr2PiN2mr6jd2ed8fEKbgimTRoFIYcZe8fJw2ib/6iIV
	 xXwQT89KwS2+c8EZ3yFSeWiziILHJNVh34k4FAdPSfcC0g7MBIm5TLRz0CqSjjxrr2
	 0w0S0Jf/2Ee8aD5C1Xg2/Z+OQO3RE64LW8+9Fb763iD0+j4qrI3ocFLaz7fZpbB3as
	 3Wqzd3Np1oJJmXvZofizpRRbfJmCrp0h4dy21i1o7XZ9qnJYcjK/4qosejaQ671GSx
	 ebYivSnVTJAdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAB9D383BF69;
	Tue,  9 Sep 2025 01:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ixgbe: fix typo in function comment for
 ixgbe_get_num_per_func()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175737961174.101810.14221689011233600458.git-patchwork-notify@kernel.org>
Date: Tue, 09 Sep 2025 01:00:11 +0000
References: <20250905163353.3031910-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250905163353.3031910-1-alok.a.tiwari@oracle.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  5 Sep 2025 09:33:49 -0700 you wrote:
> Correct a typo in the comment where "PH" was used instead of "PF".
> The function returns the number of resources per PF or 0 if no PFs
> are available.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] ixgbe: fix typo in function comment for ixgbe_get_num_per_func()
    https://git.kernel.org/netdev/net-next/c/abcf9f662bc7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



