Return-Path: <netdev+bounces-259601-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKE3E0+Rl2mR0gIAu9opvQ
	(envelope-from <netdev+bounces-259601-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 23:40:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA501634D8
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 23:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4510330333AA
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 22:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F4432D0D9;
	Thu, 19 Feb 2026 22:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fw0v2CLf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C8132C301;
	Thu, 19 Feb 2026 22:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771540799; cv=none; b=lLvSO6qvhiP5EEYe/KO86MQi7bZDspY2wZKVHvlZS1baSGO1rzB6nkfE4S1sdaKeV/hluoyHk4gj8n4XnhnQCeH5a6tp4gxOBQuoAcdQ5iQR8uU6MpNIYPHnqAFV/2m5S4j+QrHlOMqYJX+MOmZIjoKEwZ8+4xEYr4exibsXK0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771540799; c=relaxed/simple;
	bh=DaHLecqH5tG+HIf4jNTxFZD6G4x+h97HoVmUdaebPf0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Eiws04zX0IN+YO9vwlBhlxjhSOm7O9K7C3M9O8IAXF9ZeOFL9irIiAFo6rVW1mB++HvA4S0sVQJOXC++1/dlkY8mXVRmeH/wcO43TD8viamFPrq3ZvrQQF3Ec96ziPmTNwgfNexAxi//w39xraD3CrDe4GoGZlcCZxL5Qqtg8pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fw0v2CLf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55ADBC116C6;
	Thu, 19 Feb 2026 22:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771540799;
	bh=DaHLecqH5tG+HIf4jNTxFZD6G4x+h97HoVmUdaebPf0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fw0v2CLfzkFqOIubJwppxPBy7cir64ap+lXUnS8QyxBlGdVvzGl5xmYzC7Su1+hpF
	 LwtphYz7dbOKOJa4W0eYD4e/NhQjg1AfDax/HPcPzqj0nPR/NS6jVRvjiGTny3uxtC
	 Rm7ltVwjVKKWmtOFxRDtaMxToFFgeicygoB5rBAblJJK+/MKBAs2qu7frjNG7a3DnB
	 1vOso1YLooUTTjQqtD8AvZ5uaOdPYMMWRDFhBl6NRn21Piqr4VuxhmDp/HFrteMXub
	 QrfwpGTF/AnUwp4ukmrek9UY/hY2EDX9dzjIsIlEIKrgjIDuo9dHoriAYIlEYi/XCv
	 ZpuafXSQTmhBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02ECC3809A88;
	Thu, 19 Feb 2026 22:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: usb: kaweth: remove TX queue manipulation in
 kaweth_set_rx_mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177154080754.118053.12390721384603068785.git-patchwork-notify@kernel.org>
Date: Thu, 19 Feb 2026 22:40:07 +0000
References: <20260217175012.1234494-1-n7l8m4@u.northwestern.edu>
In-Reply-To: <20260217175012.1234494-1-n7l8m4@u.northwestern.edu>
To: Ziyi Guo <n7l8m4@u.northwestern.edu>
Cc: pabeni@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259601-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BDA501634D8
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Feb 2026 17:50:12 +0000 you wrote:
> kaweth_set_rx_mode(), the ndo_set_rx_mode callback, calls
> netif_stop_queue() and netif_wake_queue(). These are TX queue flow
> control functions unrelated to RX multicast configuration.
> 
> The premature netif_wake_queue() can re-enable TX while tx_urb is still
> in-flight, leading to a double usb_submit_urb() on the same URB:
> 
> [...]

Here is the summary with links:
  - [net,v2] net: usb: kaweth: remove TX queue manipulation in kaweth_set_rx_mode
    https://git.kernel.org/netdev/net/c/64868f5ecade

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



