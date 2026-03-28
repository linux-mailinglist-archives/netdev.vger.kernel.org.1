Return-Path: <netdev+bounces-272714-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GtxhFLJNx2k7VQUAu9opvQ
	(envelope-from <netdev+bounces-272714-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 04:40:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B46D834D2F9
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 04:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA75C3057C52
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 03:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29B9322C99;
	Sat, 28 Mar 2026 03:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWNAZ2qh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC321F16B;
	Sat, 28 Mar 2026 03:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774669227; cv=none; b=tgF98RfNIrFdfFhNZOeexCLf9JM/rYd9JfSwVQEwJeiQDmLDwN1NOaVPeXMcRC24YG2EXhPOZgTuWdHgf+QYfYYmlT8Iopxp7c7QyV2kh7LOpkQ41jdABThAmiQSA22QSBT8paFWT9okL6838Yl5glNVHw6jJX/p515qUMFc+vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774669227; c=relaxed/simple;
	bh=89UbiLj17IXKiOjBpxTyV1V6JPFLc2HpE1rwd750GOw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YinLZvWj1BBYZmFDOdY9MceSQx+EZxBPK/jEZGGNXTgJZXRD3Z2S4NHuHp0ZZ7TKzkrJtPR9MlpACMUq4Wj1GG2d3b/RaOPKEtci0VVs88kaylH6vzBGGEe4GmoMf3N4HT36UtIOiGo1DTLl/aDZZPZpXF2h4+rN0nJN+6nWIh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWNAZ2qh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6173FC4CEF7;
	Sat, 28 Mar 2026 03:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774669227;
	bh=89UbiLj17IXKiOjBpxTyV1V6JPFLc2HpE1rwd750GOw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZWNAZ2qhgV3pxWZppktLr8dd7JN+Rd4x0ql9NXYcnxmrRD7iyR0eKiW11cXqZd30S
	 ri75Ax5R4Ks4hnxYQUOGP/Zq6Nc+prIN1UlS8yxUcaGPamMjrTwKBQ7uoJAQztDMW8
	 8ytPVb9/MNgMuql6AzLIJVxROAQCwdfqQFcY2Q7dg2maZ1g3G0RERAs2jhNA31fMib
	 hQLktzTFuV7RC1QzPS6Y5w+KqOeIuMTMI+UkH4NPaxI6Z+7X+cTr6han7v4wwhWQFO
	 2Z4k1VYAvUV3f9xmhgp46CdiDUmFF3EYdnIqMxXQFqz5FOIYuqcNyn2FsFnzMk/LHs
	 y1zBEfbhE/tqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE423930181;
	Sat, 28 Mar 2026 03:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] bridge/vxlan: harden ND option parsing paths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177466921304.4169512.6574568898601672683.git-patchwork-notify@kernel.org>
Date: Sat, 28 Mar 2026 03:40:13 +0000
References: <20260326034441.2037420-1-n05ec@lzu.edu.cn>
In-Reply-To: <20260326034441.2037420-1-n05ec@lzu.edu.cn>
To: Yang Yang <n05ec@lzu.edu.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, razor@blackwall.org, idosch@nvidia.com,
 andrew+netdev@lunn.ch, horms@kernel.org, florian.fainelli@broadcom.com,
 roopa@cumulusnetworks.com, dlstevens@us.ibm.com, nb@tipi-net.de,
 netdev@vger.kernel.org, bridge@lists.linux.dev, linux-kernel@vger.kernel.org,
 yifanwucs@gmail.com, tomapufckgml@gmail.com, tanyuan98@outlook.com,
 bird@lzu.edu.cn
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272714-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,blackwall.org,nvidia.com,lunn.ch,broadcom.com,cumulusnetworks.com,us.ibm.com,tipi-net.de,vger.kernel.org,lists.linux.dev,gmail.com,outlook.com,lzu.edu.cn];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B46D834D2F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Mar 2026 03:44:38 +0000 you wrote:
> Hi,
> 
> This series hardens ND option parsing in bridge and vxlan paths.
> 
> Patch 1 linearizes the request skb in br_nd_send() before walking ND
> options. Patch 2 adds explicit ND option length validation in
> br_nd_send(). Patch 3 adds matching ND option length validation in
> vxlan_na_create().
> 
> [...]

Here is the summary with links:
  - [net,1/3] bridge: br_nd_send: linearize skb before parsing ND options
    https://git.kernel.org/netdev/net/c/a01aee7cafc5
  - [net,2/3] bridge: br_nd_send: validate ND option lengths
    https://git.kernel.org/netdev/net/c/850837965af1
  - [net,3/3] vxlan: validate ND option lengths in vxlan_na_create
    https://git.kernel.org/netdev/net/c/afa9a05e6c49

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



