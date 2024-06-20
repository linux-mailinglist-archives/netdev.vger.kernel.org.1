Return-Path: <netdev+bounces-105327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79686910752
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 16:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FB551F22C6E
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663F01AD4B8;
	Thu, 20 Jun 2024 14:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcF2U25X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F981AD4B5
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718892031; cv=none; b=DTs+kHt7BsVeGMFawJUc1EG1jMSyK625aPi7ohOCV/NsPuPzCyHlTON8UsCF/Zsnpm3BhQTsuUf6qBLmrmlqy0PQD9GhFMR1cQMqdarYPIwglJn7tD1Qd0CTChjQ7LW2vUUqzngf3mkFJP4lM9Fr2rDdNSMDHfkgl8dBV1KMXOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718892031; c=relaxed/simple;
	bh=TO+Ag1fxEbhGJHesLRCOGNERhwTN80MZkl/yfgDdWbo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CFfNeM20H616QJH0q3PkUz38qti1AnORV+eumXKuL7h1Pg1Lq+ePHgh16/91Wmr/vilEmiUZn879b48UuFlubRsS0W0zsPcpy4qZuuhHXJ4oTByU81X5xeqPwd+CDfSFgLz9G92hAiiptdAvjrfOek27BWdjowCAuQTNMUAqr0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcF2U25X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0BA9C4AF08;
	Thu, 20 Jun 2024 14:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718892030;
	bh=TO+Ag1fxEbhGJHesLRCOGNERhwTN80MZkl/yfgDdWbo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AcF2U25XzmhmvZtLBTu2SgPXfbLQhcobb/26nq3Zn+R7yBBFdubtzSjcs55zrXa8B
	 KS76HGlMachdzBP21VuapUdWg+LgzZs2y2BBFQE3EEpoMDgdB6kcexlw1VjmugUScw
	 EsP3REynuAyZ4j2SW+KHMdx8ZmKJQMAuPTJP5S0SqvLFoxkCC1S/UzLNbJNv+adZIE
	 xoLFrXgnKHWLVmN8vgTWwB5/lwykjlrUJx1ZDe/KMJRDhMiFMmRhbnxiXqhUUXBEH8
	 3rWCxsqBd3TQHr34BYpQ7RUj1LXLmccYH1xTrih9D2lU92a2juGzU303nxAD9FBC/M
	 f+ltDAXU2AYwg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A99D8E7C4C6;
	Thu, 20 Jun 2024 14:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] bnxt_en: Bug fixes for net
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171889203068.16820.3797428560736928318.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jun 2024 14:00:30 +0000
References: <20240618215313.29631-1-michael.chan@broadcom.com>
In-Reply-To: <20240618215313.29631-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Jun 2024 14:53:10 -0700 you wrote:
> The first firmware interface update is needed by the second patch to
> limit the number of TSO segments on the 5760X chips.  The third patch
> fixes the TX error path for PTP packets.
> 
> Michael Chan (2):
>   bnxt_en: Update firmware interface to 1.10.3.44
>   bnxt_en: Set TSO max segs on devices with limits
> 
> [...]

Here is the summary with links:
  - [net,1/3] bnxt_en: Update firmware interface to 1.10.3.44
    https://git.kernel.org/netdev/net/c/8ad04409921f
  - [net,2/3] bnxt_en: Set TSO max segs on devices with limits
    https://git.kernel.org/netdev/net/c/b7bfcb4c7ce4
  - [net,3/3] bnxt_en: Restore PTP tx_avail count in case of skb_pad() error
    https://git.kernel.org/netdev/net/c/1e7962114c10

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



