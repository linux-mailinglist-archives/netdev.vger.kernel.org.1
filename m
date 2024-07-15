Return-Path: <netdev+bounces-111550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D28931832
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 18:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62D01C21625
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 16:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7189D2C181;
	Mon, 15 Jul 2024 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVycYxkf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449E8225DA;
	Mon, 15 Jul 2024 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721059830; cv=none; b=WaVllX5zmtJC4kWQIJoFc89GkriuiG0eJg2Vam1Q/ucB9cmeWklf+GM+YeaXZJVi+moRZdVUrJy5S3cd+2OvRHh0PxKpZj7PCowEha+O/FWdUindBOrQ2UYChp/P1oFd69KbvyTVD8zDXSKe0kLVoDSP3jtvzQYxwjXUUChIHJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721059830; c=relaxed/simple;
	bh=LyNXYzNr6Q8Th5sTEyTcyTqmDktxjmjEskFBkjyywCo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m/mv3Yct2Q7GxKj8n8vvPG+swnfjt/VZom1K4ukkCYwszW/rBI6f753YgFu4ko/QzaEiTmLsq7CXovnyiD84lg/m4Vupa6MEr8hFzfoANeBqyTiYqjt0XiVjqpvZseWIu5qtjBp9TuSBSuD64pL0xGhrRZ4QJh4zG2MmeCU26QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVycYxkf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE782C4AF0E;
	Mon, 15 Jul 2024 16:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721059829;
	bh=LyNXYzNr6Q8Th5sTEyTcyTqmDktxjmjEskFBkjyywCo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HVycYxkfsr8UHToYentAq/TRX+vihZM/Be/pA3uj6K26lFACboq7VVERfSx5jVREW
	 hADNXsOTUAPZO9FoHzo+r8A4AtftDl/yU7g5dsE1+6W8gqqK6RY6TX19aBauHnV3UN
	 4sLk+fOMJXOKP+rHZfJeIhTUhrdrzvXOyl86iyyiYoBLc8iDmx4dMiKYg6ulgoGUr+
	 i1SJB/dZ4c9d6F2mKNBQZW5qX2O8YevFXMks0pMyfc1MQ9QH5F2oz4DVb0Gi6Lm27F
	 Xhya1fQ444qDpstdRJcaA3biKe5h+AvIOpblFXL7oOsbuKKDRY/BCCOheUllzrzCWq
	 ce72ilwpyDlXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3C25C433E9;
	Mon, 15 Jul 2024 16:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] llc: Constify struct llc_sap_state_trans
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172105982979.6134.15213982854904740211.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jul 2024 16:10:29 +0000
References: <9d17587639195ee94b74ff06a11ef97d1833ee52.1720973710.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <9d17587639195ee94b74ff06a11ef97d1833ee52.1720973710.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 14 Jul 2024 18:15:20 +0200 you wrote:
> 'struct llc_sap_state_trans' are not modified in this driver.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
> 
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>     339	    456	     24	    819	    333	net/llc/llc_s_st.o
> 
> [...]

Here is the summary with links:
  - llc: Constify struct llc_sap_state_trans
    https://git.kernel.org/netdev/net-next/c/0970bf676f86

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



