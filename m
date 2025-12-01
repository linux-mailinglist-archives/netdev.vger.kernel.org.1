Return-Path: <netdev+bounces-243056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F3BC98F21
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 21:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DF20A345053
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 20:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57E526B74A;
	Mon,  1 Dec 2025 20:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSdmWilS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1802690EC;
	Mon,  1 Dec 2025 20:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764619394; cv=none; b=clcuum6qWd71nl66dOFFPJVs7bpNc3Ex+NxA/SE/hhKY3VtzxVwu+OpcGMm6X/0Szm2JkebDaij7JjGfTUcglomIHZIwLIfIZ2sWdNtzfgY2CGfdE4ARwxk5ZTQaMK+aQHyOdDYE2SdJF4ATl0x1nA6ufSEbB3gCxnx3vb5+CHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764619394; c=relaxed/simple;
	bh=zHnQ3chVyuroLaH4riIs+G3BrbfWr/05Sqp3NMVu/fk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eKZr1E4hGpzAGRR1Cep6CU31hAXZdQM+0F/37N+i3mvZ2oTclCciHO70sE5pAjkRD32RnDD/9MI+EM02t7TlN58BZR8qQplq3Zs+X+IexUQ/vNPq/cUq3ojeC3QGfoFogosARy5XQQpSW+ylKoTgEcCGlt1x/vSqNozIbcsz19I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSdmWilS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4253AC116C6;
	Mon,  1 Dec 2025 20:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764619393;
	bh=zHnQ3chVyuroLaH4riIs+G3BrbfWr/05Sqp3NMVu/fk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HSdmWilSAF3MLa3S5Jk/PG5YdXpT1fU5+bWlEb3HKzpWAxwilg7kMHH+oX+qeVNAV
	 NuU1UzbH82bPaWlgJDxNTYR5V3/V8AGSMfVqe9SOmoMMFqaNbbrEKdPUrOZrfflCcB
	 /xwF4Riqkfy6evrAaPct4bBw28KqFAlzK2b4Z3unvWh/UDxx2AIDj3O4+GGpZmNFgO
	 gjZCqE6aGc8I9YdIxa5GYl37QTBWoMVh11ncFNUelzukzvioXdLlnZLCdIdjr+382m
	 FJjX/qgmldnqGVSk5/k829KWjqWbr6g2CX7a8fk/AV6uXCo+JB6IgeTxVY4Ovrhb2D
	 5Cjd0hGMQZc1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 787DC381196A;
	Mon,  1 Dec 2025 20:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] ynl: samples: Fix spelling mistake "failedq" ->
 "failed"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176461921302.2515760.15026787498303072378.git-patchwork-notify@kernel.org>
Date: Mon, 01 Dec 2025 20:00:13 +0000
References: <20251128173802.318520-1-colin.i.king@gmail.com>
In-Reply-To: <20251128173802.318520-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: donald.hunter@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Nov 2025 17:38:02 +0000 you wrote:
> There is a spelling mistake in an error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  tools/net/ynl/samples/tc-filter-add.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [next] ynl: samples: Fix spelling mistake "failedq" -> "failed"
    https://git.kernel.org/netdev/net-next/c/7adf0efb41fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



