Return-Path: <netdev+bounces-268870-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KGHAcYeuml8RwIAu9opvQ
	(envelope-from <netdev+bounces-268870-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 04:40:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC3A2B58AC
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 04:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC531300F10C
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 03:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD37335BDB;
	Wed, 18 Mar 2026 03:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXIHu+hM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABC2243376;
	Wed, 18 Mar 2026 03:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773805242; cv=none; b=fHufBUEfGDaXWNp/nBYW2w7nf3B0ZzOT41ikAEDTaRRcBDiN6vEcyQH/r21CNfJApnHlJJAHZmbK6jvxUFGMoMtVecgredQzBnjK7cFnABmEpJ751X/uUSywcw1hLxHJ7S7SxE9pxyDhaSMQqHtTEYWGpFOnA6xy2GAq9ksUYTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773805242; c=relaxed/simple;
	bh=ci1TLeG+Q5wv5yzhht4iMsaCcAqoSh8bQP++IRr5860=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OghNdGxNLUlkBwO5cjQfnfaUUiDc5yhiUrmpNXEBlJJpb6yiJH1TFt8NCDQYcTFAy9UA4eu7YDgRfPBAtCRvyBSm1oiz7oc5o55CXrFpDOe14c9QRVx9vkqPizv26zK9kgtVosz2nMHnoPdDwTkLFAWvY2bHIuBq168/VjJ8EJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXIHu+hM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B69C19421;
	Wed, 18 Mar 2026 03:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773805242;
	bh=ci1TLeG+Q5wv5yzhht4iMsaCcAqoSh8bQP++IRr5860=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TXIHu+hM0Lmy2qrU8gxrRdmeIqAmHvUXGdeiRO3cplllQ9CCZFrUiSsraDSRzmWkO
	 2AigU3LiEXukj8PNRUAJjufPSJy9GmZ7lslsliwlNPIq0LAM8PW8Et6ziw4+7/cXNd
	 TMXnvCAxjYO25M4dmPRelp0MNPNGaTLhYGeyYCcWzXm45TW9AgqXoFyq2k5WJtQuLp
	 AsYjPdQNOf3R+penE6+IpDsACWjbETVvLuo2u+1Rw2XYXaCaauZfnMyTbwcgvJrIRg
	 D1o3D11tWuX3hEE7DeURO5qlWQlOgVsRmJXCEDu6XB+yUeILlXGsDFoc734jbG5LWn
	 usq2LTIj8TbPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0D13808200;
	Wed, 18 Mar 2026 03:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 00/15] net: stmmac: clean up descriptor
 handling
 part 1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177380523454.113469.14485009686148036566.git-patchwork-notify@kernel.org>
Date: Wed, 18 Mar 2026 03:40:34 +0000
References: <abUtGH9KB03PH5Ne@shell.armlinux.org.uk>
In-Reply-To: <abUtGH9KB03PH5Ne@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, ast@kernel.org,
 andrew+netdev@lunn.ch, bpf@vger.kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, hawk@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 pabeni@redhat.com, sdf@fomichev.me
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268870-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9DC3A2B58AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 14 Mar 2026 09:40:40 +0000 you wrote:
> Hi,
> 
> Part 1 of cleaning up the stmmac descriptor handling. Rearrange the
> struct stmmac_tx_info to pack better, and introduce helpers for
> duplicated code handing the transmit and receive descriptors. Remove
> unnecessary struct members that are only transitorily used.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,01/15] net: stmmac: rearrange stmmac_tx_info members to pack better
    https://git.kernel.org/netdev/net-next/c/12b4b16c0c7e
  - [net-next,v4,02/15] net: stmmac: helpers for filling tx_q->tx_skbuff_dma
    https://git.kernel.org/netdev/net-next/c/a4b1590ee0f0
  - [net-next,v4,03/15] net: stmmac: clean up stmmac_clear_rx_descriptors()
    https://git.kernel.org/netdev/net-next/c/ee19df4d3bb7
  - [net-next,v4,04/15] net: stmmac: add helper to get hardware receive descriptor
    https://git.kernel.org/netdev/net-next/c/ee1b6a94ba12
  - [net-next,v4,05/15] net: stmmac: add helper to get size of a receive descriptor
    https://git.kernel.org/netdev/net-next/c/4f6280c450ba
  - [net-next,v4,06/15] net: stmmac: add helper to set receive tail pointer
    https://git.kernel.org/netdev/net-next/c/e9d0cafa9d60
  - [net-next,v4,07/15] net: stmmac: remove rx_tail_addr
    https://git.kernel.org/netdev/net-next/c/bea37bda7f75
  - [net-next,v4,08/15] net: stmmac: use consistent tests for receive buffer size
    https://git.kernel.org/netdev/net-next/c/0b3d09031437
  - [net-next,v4,09/15] net: stmmac: add helper to set receive buffer size
    https://git.kernel.org/netdev/net-next/c/a32734d25d87
  - [net-next,v4,10/15] net: stmmac: simplify stmmac_set_queue_rx_buf_size()
    https://git.kernel.org/netdev/net-next/c/337191f37748
  - [net-next,v4,11/15] net: stmmac: add helper to get hardware transmit descriptor
    https://git.kernel.org/netdev/net-next/c/c493261de1c4
  - [net-next,v4,12/15] net: stmmac: add helper to get size of a transmit descriptor
    https://git.kernel.org/netdev/net-next/c/2c3525ad09e9
  - [net-next,v4,13/15] net: stmmac: add helper to set transmit tail pointer
    https://git.kernel.org/netdev/net-next/c/b2fd52d90b8a
  - [net-next,v4,14/15] net: stmmac: remove tx_tail_addr
    https://git.kernel.org/netdev/net-next/c/0da7809235d9
  - [net-next,v4,15/15] net: stmmac: use queue rather than ->queue_index
    https://git.kernel.org/netdev/net-next/c/8cde3c87039b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



