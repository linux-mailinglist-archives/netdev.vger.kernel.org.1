Return-Path: <netdev+bounces-178472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C894BA771B4
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 02:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81FD83AC088
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 00:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0F9770FE;
	Tue,  1 Apr 2025 00:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ex3yR04s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77CA70830;
	Tue,  1 Apr 2025 00:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743466216; cv=none; b=P0ltuK0J1StUMo9bq87JAwlqxpJHNjPYYWpu7Ea62z79qg46Bx95EiL2ysy9zAxqSQBu46ieMJNZkY3cLvSoRF1N5wzitQTEzWB6TkFwpYJL0zJldy1AuxzAEXQI7ToYZoEJWieNcUcZafGDbKgi1uxJ45jERh5Mt5xHNWoDxZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743466216; c=relaxed/simple;
	bh=m+3g28N2wpxxMt369w3Y4pYfOAKgthUh76+bPArrHV8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QxJoon6FPzv+eJ2Mg+AlYCnWRkTzEryr5Vyw7RQpWcR4G9vxBQLW7elWnI2Om9WGlo/SMN2KKNuo5xULIhe0xVdJ8ZH3FU2eKnGPtUQTyPQQYVA7XbTQ+2k1p1RHv1HJU9LS7ckuBa5Qo0qxjHpZY/XduWBAxYYQdE1Jpa7nDEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ex3yR04s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C9AC4CEE3;
	Tue,  1 Apr 2025 00:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743466215;
	bh=m+3g28N2wpxxMt369w3Y4pYfOAKgthUh76+bPArrHV8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ex3yR04slp8u3G8DivtgV/oOx0qemgieWg8B42KwvRFBl8RJR9EPnxE3col6bHX+U
	 ds4AjCnQnqriaZ/0erNf7uv9AT8fPMxkLVBpVmTG0BZoHb0Mx9vD7QK4FGZB0GLn5h
	 U7jfmpfbjLIrvrB9Ey2X+fWGvQnqtVZnKpWDnGMfiXR2SvlXgy9IiWUQUpI67LvCZ+
	 0OsM8TAtYsUMd3hA+5/LjRlUxiPAJuTsqdAFcI6UZGHIgJMDmzwyUErvaWQlUfSlv4
	 RvD3Jvxl3NOSEh0AVpBbMpONWMzqYaCrcPJQmvEfwA40oso/PQumamR1AI2XVrS2UW
	 LjAb3dpl6k+ww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A50380AA7A;
	Tue,  1 Apr 2025 00:10:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH] octeontx2-af: Fix mbox INTR handler when num VFs > 64
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174346625174.178192.8436151483529175926.git-patchwork-notify@kernel.org>
Date: Tue, 01 Apr 2025 00:10:51 +0000
References: <20250327091441.1284-1-gakula@marvell.com>
In-Reply-To: <20250327091441.1284-1-gakula@marvell.com>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
 tduszynski@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Mar 2025 14:44:41 +0530 you wrote:
> When number of RVU VFs > 64, the vfs value passed to "rvu_queue_work"
> function is incorrect. Due to which mbox workqueue entries for
> VFs 0 to 63 never gets added to workqueue.
> 
> Fixes: 9bdc47a6e328 ("octeontx2-af: Mbox communication support btw AF and it's VFs")
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: Fix mbox INTR handler when num VFs > 64
    https://git.kernel.org/netdev/net/c/0fdba88a2115

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



