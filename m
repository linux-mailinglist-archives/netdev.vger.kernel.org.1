Return-Path: <netdev+bounces-274548-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBmCOyZuzmnxngYAu9opvQ
	(envelope-from <netdev+bounces-274548-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:24:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E314E389A5D
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 200323058BCE
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 13:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFE92F6918;
	Thu,  2 Apr 2026 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBPMJ4aK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01A22D3ED1
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775136033; cv=none; b=Y2ezpUbVk5R0aDaamQomcbsvDYK0Bja0iEQIMJFiN9t74KCuqVuwGaTNY2kjlhR+I2J4FLprYvyI7xGIZVx44V7oAkuPbwv0HqrXuh3KtsPMbat10T9OiTgMBIqB697mXZtV6w9bb4xOW2XR3ZHGBEsGv5kOOYY2n60CY9PNTS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775136033; c=relaxed/simple;
	bh=bdM5CpBSGBUjea2E0M0inYXAS7dXwzD2DrU4yvZg14g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DC8fXDY/iDBNFVjPYBdN+bY9geLvIn3wCxt1VbeOknfOrUj3ziSVAhK03nw3yHUkCPdYbc+ZCiZJnQGZOv+yLVi1i6pf5LCLdgjhZKQQ2uXWkZZJ5iL/qH+/EfVD2AB9AuRqhJ8iFc/1oeDIWWnKzlxK0bS2cscBHr/tgN1qvKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBPMJ4aK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A345C116C6;
	Thu,  2 Apr 2026 13:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775136032;
	bh=bdM5CpBSGBUjea2E0M0inYXAS7dXwzD2DrU4yvZg14g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LBPMJ4aKdUI5AFsTq8Jerr5MFJ0I7h5UqvC/VIkXr/u2gA++PjVmemeLAg1r7OYto
	 wVUfkBU0DMWIiFG4wjjTq8G9zge/ZBFOKBPTGDN8JI4/cL6TuCiSyCxIhCaURdVKiZ
	 nUSXg6t0FF0bN++7wPOGZe5Wj5EtXR8rHRpDtwdqPEDogopv2mrA7mws3N7cnfnFqn
	 9nors6N0UjocQo+nX9S5KH7fahpyIVSlj1CrOegvjjmvV/J32RNhykormoFOkRGK/b
	 E46PbUbDJ1AJ9bvAhs74MX+a6ul2BsDgNNwpaE6xhhdpzBbPUw1s7O3Py/qQjnSoQM
	 P6F6PizKqsJzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDC23809A05;
	Thu,  2 Apr 2026 13:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: airoha: Set REG_RX_CPU_IDX() once in
 airoha_qdma_fill_rx_queue()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177513601478.26443.18083192170217288880.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 13:20:14 +0000
References: 
 <20260331-airoha-cpu-idx-out-off-loop-v1-1-75c66b428f50@kernel.org>
In-Reply-To: 
 <20260331-airoha-cpu-idx-out-off-loop-v1-1-75c66b428f50@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274548-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E314E389A5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 31 Mar 2026 12:33:24 +0200 you wrote:
> It is not necessary to update REG_RX_CPU_IDX register for each iteration
> of the descriptor loop in airoha_qdma_fill_rx_queue routine.
> Move REG_RX_CPU_IDX configuration out of the descriptor loop and rely on
> the last queue head value updated in the descriptor loop.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: airoha: Set REG_RX_CPU_IDX() once in airoha_qdma_fill_rx_queue()
    https://git.kernel.org/netdev/net-next/c/269389ba5398

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



