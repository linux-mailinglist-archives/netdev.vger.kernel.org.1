Return-Path: <netdev+bounces-155648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9ACFA03428
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 01:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F17A1885209
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 00:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0F010A3E;
	Tue,  7 Jan 2025 00:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2dngc/9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87160EC4
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 00:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736211012; cv=none; b=TornpvqDKxTFOFFBciLf21K83PYluuZBWuIgLY3WCvwt13dt1Jq9NDuOpks2pVWu9ccAELRk/Dt1H/QKM1HRBliOH7gluk8Ba/4KSd6RWW/ZE1f+KZ5UX8WShv6IHU69pK57bcX8meN9sPWhCHEQbTZ+giuhdiaUkIccXnzP840=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736211012; c=relaxed/simple;
	bh=JCerp7UrEI9cVp77HXjw5+N9qMKKRp0hpdZ6VrAUWGk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BrnWgYVbYmTe6aM+uFEGE81YhAXymGjt7A0kbKkJ0y2q9bgxn67GIM9eiDLfMn3743NmSnIQ0dxNf/UH/LnMsQ8Wx9X3l/318krxs4xDL9z/IZKz8KeI5y1s9CghxZWrxIP4b7Jf2JuHouyH4z+AyI22QG9aI8X4IIiLNANRp1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2dngc/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E147C4CED2;
	Tue,  7 Jan 2025 00:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736211012;
	bh=JCerp7UrEI9cVp77HXjw5+N9qMKKRp0hpdZ6VrAUWGk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O2dngc/9unP+sRnNafWxZcBjfGoBqQLfBS1v+SS6FxMlC7GFZ0OOivt4mIP6VAFck
	 1MLX9aB+ebRbRJXxYQ2V/l712i8VhW6S/JUZPmBATvmSFFJqi2YEVMLJt/Ze8jS8Gj
	 5PIYgHKrNz1NWxCmoziLh4pa+ZPCblO4KYJR+or44GRS/eJVu5CZQZ4rdNVdd++hz5
	 eBrDYsC6nTqP1OlMYMnIkgHYR7YYUuqw2M88Id4TAmQ3d1f7rk2wPU5YIWG8Llgmsa
	 w+3ByFwbn24z0ML2XkDo2d9ypE9W2gi7aE8d2Kcijdj2kQpAp5tBfgtJxS9JRm8OPR
	 H1/56jgh/JyTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CF8380A97E;
	Tue,  7 Jan 2025 00:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] bnxt_en: 2 Bug fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173621103326.3663227.11281752540309826706.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jan 2025 00:50:33 +0000
References: <20250104043849.3482067-1-michael.chan@broadcom.com>
In-Reply-To: <20250104043849.3482067-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  3 Jan 2025 20:38:46 -0800 you wrote:
> The first patch fixes a potential memory leak when sending a FW
> message for the RoCE driver.  The second patch fixes the potential
> issue of DIM modifying the coalescing parameters of a ring that has
> been freed.
> 
> Kalesh AP (1):
>   bnxt_en: Fix possible memory leak when hwrm_req_replace fails
> 
> [...]

Here is the summary with links:
  - [net,1/2] bnxt_en: Fix possible memory leak when hwrm_req_replace fails
    https://git.kernel.org/netdev/net/c/c8dafb0e4398
  - [net,2/2] bnxt_en: Fix DIM shutdown
    https://git.kernel.org/netdev/net/c/40452969a506

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



