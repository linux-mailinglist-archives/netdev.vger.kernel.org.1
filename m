Return-Path: <netdev+bounces-262055-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCpyAPVXomlm2AQAu9opvQ
	(envelope-from <netdev+bounces-262055-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 03:50:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1EE1C0076
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 03:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E5633062672
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 02:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E0633ADAE;
	Sat, 28 Feb 2026 02:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkAQzIMR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F1533D6EA;
	Sat, 28 Feb 2026 02:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772247011; cv=none; b=eJpVfAEsr8lMwQydNBNNUKAHv2iiw1f92Agw4F4RX752EHzMJi+wFckLuIWH3QhLOZKfrSwaSFf9pfjAlNw00i97BwlSl9V8h+Oiy1cgfeAv8df0NpmrrFLIkQN3UbexQvfgSoBu5ykaG5tAJnB4HGvRPV8+EnAKaV61vqsODKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772247011; c=relaxed/simple;
	bh=YFCDTXqu+rdhmgSl/brixRAljHEqsiMrOla/ZyzeDLA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XxwAlnsmuY5uaitCn595zmiLRtI7XD85ECGiBAVIssTUuBSBlwpK7OQIdJWyv1fY7Y9iimyV6LnqFSv+BW+/FimLROGFV8N08RYq9BVTYnZjKLsZBJHUOT059zQkHe16ijK5XLk6Tf11RXPB1MfQrIWR7W70XC2PEAdw1Fw/1g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkAQzIMR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839C4C116C6;
	Sat, 28 Feb 2026 02:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772247010;
	bh=YFCDTXqu+rdhmgSl/brixRAljHEqsiMrOla/ZyzeDLA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qkAQzIMRvRIusJtux8TGilwkUWH7gJGUbb9+D6qpej3yulb3eOcsgCfAT6lFPQp/M
	 XB6WQTM/7kEprJJG9zDde/wKQaQPjEQA0imOMEwuhpu60PjEmhqBWcXrM/naE+YKhd
	 194Q+Iz1NfQsABAdFgxy/1QkSZ8HUrDjCwZb3NxaV5mKIC0XmCowlBs6Fu82XWfvzD
	 hpU4LEY4PTDuKnGx1iuNCgf6XYQoZIsVqEu8t3D/FDz5Pcp18mXKA4h3eBEGhqh0ua
	 7l/Nb2DRSWEsAKcFugE7vgNpQhE0c3ZoDLESKhAJd9GWEC3ehCineVz6FZLQV7M7Kh
	 hl9MbF0efIZXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE6539EF96C;
	Sat, 28 Feb 2026 02:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] vmxnet3: Suppress page allocation warning for massive
 Rx
 Data ring
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177224701379.2846847.10608754934612408646.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 02:50:13 +0000
References: <20260226163121.4045808-1-atomlin@atomlin.com>
In-Reply-To: <20260226163121.4045808-1-atomlin@atomlin.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: ronak.doshi@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, da.anzani@gmail.com, sean@ashe.io,
 mproche@gmail.com, chjohnst@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262055-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com,ashe.io];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF1EE1C0076
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Feb 2026 11:31:21 -0500 you wrote:
> The vmxnet3 driver supports an Rx Data ring (rx-mini) to optimise the
> processing of small packets. The size of this ring's DMA-coherent memory
> allocation is determined by the product of the primary Rx ring size and
> the data ring descriptor size:
> 
>     sz = rq->rx_ring[0].size * rq->data_ring.desc_size;
> 
> [...]

Here is the summary with links:
  - [v2] vmxnet3: Suppress page allocation warning for massive Rx Data ring
    https://git.kernel.org/netdev/net-next/c/c31770c49348

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



