Return-Path: <netdev+bounces-131834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A3C98FB07
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 01:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AA351F21E35
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 23:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BE8147C91;
	Thu,  3 Oct 2024 23:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbM8UT1L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B1184D2C;
	Thu,  3 Oct 2024 23:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727999429; cv=none; b=IfVG+aiw7v4KMfUPEfOrklOZAILG9fha51Wx2Xa1CJ1ngp/krkWl7QAbIfBe8Fngo3sI8nKV6vkrTyRNCsXOKYl0jJtIefkSBJJG5L9cYFOETdsSAWaUQx9WqCbXgJaQkwAA/8SAoFJ+5Mj4JHDDOVgdXVXf0xnBYkZiFTKfkHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727999429; c=relaxed/simple;
	bh=wy+UsmPWY50RKNKrL5H6NF5SPqj25LKY3GIka/edtl0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HsZdbykiiOEhpp4vku00Zm2d//sGep6M05nMoOSi8T6NZRtQ9e54D8qN9bN7r7ojwVAqoewGIfgE7HnuQcKzzBwpkJDR5Me2iMwerXb/TOCC1+yXdMIvH+zEMD4UGsY5FsPHUEzYt6DDJYYHI1zwtTp8po5/g+R3SPGexhLH6zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbM8UT1L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17259C4CEC5;
	Thu,  3 Oct 2024 23:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727999429;
	bh=wy+UsmPWY50RKNKrL5H6NF5SPqj25LKY3GIka/edtl0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BbM8UT1LUFsQ7Yu0dx4/koTrqiV1s8lUv+TzTusb7B+HtsuYOoW+c0mpGgZB+Vkcu
	 UAqZlYM9s8z/h1COlUF/rXL+RYOyIt+vtarH9GyQQVGOqswN7G+/c34K5GKFStPeKF
	 9ZQzaVvfhermOiJdacUsCS+KTyFv3LD+wu8La+LiN4/06vDeXkLChKp0m/J+FEYgcI
	 /IwzCJtepO4e/053/5ESXhQD5FJMd4R2cpMaEVsJC8LDgOdHBZTMkLEe8ZrsnIpkxI
	 kKj38KMClfp7wfFmadZ41tnUuuVkG7Hh3+otRe/D27IBBZI/JEZNuOzDULYQEaokoO
	 u+Z5yh4a1IrXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1ED3803263;
	Thu,  3 Oct 2024 23:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Documentation: networking/tcp_ao: typo and grammar fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172799943253.2033569.4276582649340427839.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 23:50:32 +0000
References: <20240929005001.370991-1-leocstone@gmail.com>
In-Reply-To: <20240929005001.370991-1-leocstone@gmail.com>
To: Leo Stone <leocstone@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, corbet@lwn.net, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, anupnewsmail@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 28 Sep 2024 17:49:34 -0700 you wrote:
> Fix multiple grammatical issues and add a missing period to improve
> readability.
> 
> Signed-off-by: Leo Stone <leocstone@gmail.com>
> ---
>  Documentation/networking/tcp_ao.rst | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Here is the summary with links:
  - Documentation: networking/tcp_ao: typo and grammar fixes
    https://git.kernel.org/netdev/net/c/2d7a098b9dbe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



