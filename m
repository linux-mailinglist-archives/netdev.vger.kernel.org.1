Return-Path: <netdev+bounces-223305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978DAB58B36
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 03:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91BCD52168F
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 01:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1271B2222AC;
	Tue, 16 Sep 2025 01:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMO4EjvN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3FB221FB2
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 01:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757986241; cv=none; b=OLaQDxuhQOj1nySHjqoIQg51dUUbVs6bAFZ5ljt6Pk8stj6Sxevz1vSJ/I6CkRa+qyJDvXYbx/ib0QH1s1NwAFVWA9c8ee/PdVUhUamnIE+eXVoU453/AugWxkGs1KWAE/bbYEEYpht3253OKmu0RE9GSjhj/WMQd9x20U1z+sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757986241; c=relaxed/simple;
	bh=/0fVPoedDebJ/PlMi9yT/nQRv8fIS9HH0sIeFetXn2U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cqsVNjAj6srL6Dq0eKn8xVVZsQtOxHVOT6nRmt2RmMr5pfkkWn0XYWxosj5MmYR2yosWPlMx7EpoHHe8GvxovsmfPYh8TjO6HenFdHe6oywsL3DUsVL77EbQp2n6eFt2rGl68LaDNpygv0dQG9G23KmTmH2ig04npifPUigadSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMO4EjvN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511DAC4CEFC;
	Tue, 16 Sep 2025 01:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757986240;
	bh=/0fVPoedDebJ/PlMi9yT/nQRv8fIS9HH0sIeFetXn2U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BMO4EjvNOKfWEMPSyQNXN8VuZQdUDrq1e0CM7u7B8TPrPLEDQ2pVUyphXhooA8tCm
	 g0lrj2fagGf8fsfK1Dx+qqzOqxUPpP0Psseg51e46aiBT7z0stvzxaS8bVqysgbqxV
	 s910mIMLZXj2FCvp5LMAj9PdjwyBPiwwNfM3hqNx+hDYRV6bgnFXAUPRchNlso0z1J
	 wnBroEzWu7SZncEaStn9tHa1zOpK8NZMQ6xJhRcCFTVCpCy/1Swh3GyfFtaA5QRLYR
	 eZh7G1BJZzwraq1c2asmYbgtFElso4kX+fyWHBxaGXwGPLYnOgYBGUnHeIrBfsjXYN
	 riai4Kfb89/Tg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD2F39D0C17;
	Tue, 16 Sep 2025 01:30:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bonding: fix standard reference typo in
 ad_select
 description
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175798624174.559370.16766476727267509750.git-patchwork-notify@kernel.org>
Date: Tue, 16 Sep 2025 01:30:41 +0000
References: <20250912133132.3920213-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250912133132.3920213-1-alok.a.tiwari@oracle.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Sep 2025 06:31:30 -0700 you wrote:
> The bonding option description for "ad_select" mistakenly referred
> to "803.ad". Update it to the correct IEEE standard "802.3ad".
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/net/bonding/bond_options.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] bonding: fix standard reference typo in ad_select description
    https://git.kernel.org/netdev/net-next/c/1bdf99fd1d82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



