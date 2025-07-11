Return-Path: <netdev+bounces-206187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7B3B01F51
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 16:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9288A3B0670
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 14:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1172527990C;
	Fri, 11 Jul 2025 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgcQEcui"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ECB1FBE8A
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244797; cv=none; b=pTONWgHlPIN69y0BwRvwFibXj3bOBDnPgzDmmSoOmj1qb1qHqUvE7gjZTpUq0iFFjuzc/DVayiJT4D41WTXhiadi1aGRCg3zKSx9Zu6iLjqwQU68pdE2zuZtC9myMCs/ZTb7Fku7C55+mVFXLTgooh62nSkqJ+PKUuv/nPqsCWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244797; c=relaxed/simple;
	bh=EA5bRwDOCkbgdOZN3hYdlGQYT7+ijl7e6nGW7rd/+s4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OuXOdda4jLPr0ReoAP8As6v/zFAaB4j6/sqikewgRy3v6R/LQ6qNOc7/ju347KNvGYe+Fatpib6w6PNBnLwBVQWbyhjDyLNwoZ0i7ShU1RhvjZzOsoMyRhAHYtKcKrUdq170ZhkbFr7LyeP6TaylwWi1QcBwu4NcTSe64sz4XUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgcQEcui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABC6C4CEED;
	Fri, 11 Jul 2025 14:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752244796;
	bh=EA5bRwDOCkbgdOZN3hYdlGQYT7+ijl7e6nGW7rd/+s4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dgcQEcuiaNSW/Z414alXc5jgeDwTjAK5CbdfSeFzds8dcPCwYgP0ohtipKcPnHzE/
	 XnyW22xaeUVlFW/CpkMnxgDBldNA6TdeGZW1XzBJShQEbS+YAiumNBMxSWhZWCmnWB
	 O+Z6yofQp69DQXFIEe1UpGCVYKPBjzSPC1uEjV2HWZhqq2Q0uQYOtFMMtD7P7BuTea
	 VHhSLAa7VyrYQ/Cds7LfBDj1lWUntd0dqGigazvE21We1WiBLu/fCOW7VFNFjyfvPi
	 9+iZb5ghE7JXLmUv2nbPYUIu161ScDWfnCrcHHiUOipwnA8C7dDXw8tQkaD737cx//
	 vUUW6RXU0UxBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD64383B275;
	Fri, 11 Jul 2025 14:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] bnxt_en: 3 bug fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175224481876.2294782.8874851157248112232.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 14:40:18 +0000
References: <20250710213938.1959625-1-michael.chan@broadcom.com>
In-Reply-To: <20250710213938.1959625-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Jul 2025 14:39:35 -0700 you wrote:
> The first one fixes a possible failure when setting DCB ETS.  The
> second one fixes the ethtool coredump (-W 2) not containing all the FW
> traces.  The third one fixes the DMA unmap length when transmitting
> XDP_REDIRECT packets.
> 
> Shravya KN (1):
>   bnxt_en: Fix DCB ETS validation
> 
> [...]

Here is the summary with links:
  - [net,1/3] bnxt_en: Fix DCB ETS validation
    https://git.kernel.org/netdev/net/c/b74c2a2e9cc4
  - [net,2/3] bnxt_en: Flush FW trace before copying to the coredump
    https://git.kernel.org/netdev/net/c/100c08c89d17
  - [net,3/3] bnxt_en: Set DMA unmap len correctly for XDP_REDIRECT
    https://git.kernel.org/netdev/net/c/3cdf199d4755

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



