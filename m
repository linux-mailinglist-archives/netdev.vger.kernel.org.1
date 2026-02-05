Return-Path: <netdev+bounces-256913-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /t1KNF/+g2mvwgMAu9opvQ
	(envelope-from <netdev+bounces-256913-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:20:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E77EDEDD
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68F92300B9F0
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 02:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741832877D4;
	Thu,  5 Feb 2026 02:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2o6vatD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519C8279324;
	Thu,  5 Feb 2026 02:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770258011; cv=none; b=CCrjp9AVqsfjMv8i7UPcGL2hD0IbQN47PziJyr1tWUcn0BpwdZfhdjIelkUaGvjXd+rdfL1OZ2eJ/vYPoh2D0MGInZ6fAoYkxYlkBJ4B6dK+bt4J17LUBstxafQFPQcVNKHQnFueh03Lv4AxSxKuLhD6zsMkygumPCwel9s11O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770258011; c=relaxed/simple;
	bh=Ckmx0GKVNpOSKyHt5m2XWiZUVYGFKxGhni8kQ1Gktb4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gjyFUTL70FU1XbPSSZXvYY9Yfl3cr0L/JqHrEqsAbtyv5FqhwB+0KhJVgyuTPeMYdvDxESFXK8TnxtVedzzRCp3A3V49JYsCt8PzNQXhJgm5cIk4m7ZHQK/rPbkNsG52r/ru4NbrOF4sZdkdmfJIHwJ8KRGOm+kiyA0Wg6vVoAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2o6vatD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09301C4CEF7;
	Thu,  5 Feb 2026 02:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770258011;
	bh=Ckmx0GKVNpOSKyHt5m2XWiZUVYGFKxGhni8kQ1Gktb4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N2o6vatDJbzPlSdkxwhmk91jq9i3M8ppchl4fJIc0tNapuejOR+vc7OsLApIJ6Q2l
	 OjLIBg11mF9MfPOQqlN80qxbxHBvGDA927XWE1qxd/R/hEgfePuVXRaEQwGBZC1d7I
	 OMRL1+1aTaidkNzdQwxhS0E1dnvZSlTFDw86DLQI3B4Y5FCD/ejUxYqAR/oWg67XOT
	 MPR3LJoszYSmajzVqJa5iviYdinh1T0poJUMcjbKhDKSo3rAvhq3XNlHe3WmOaxsE+
	 xq+ANUbmCMUazXKxrBRHhvoSlOenAjOWM5BFQ0/9nLqaG6vj02lWEPRrXeTgzmd6/J
	 R428Efxptc0KQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 481973808200;
	Thu,  5 Feb 2026 02:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v13 0/3] STP/RSTP SWITCH support for PRU-ICSSM
 Ethernet driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177025800908.129535.18427051023918224853.git-patchwork-notify@kernel.org>
Date: Thu, 05 Feb 2026 02:20:09 +0000
References: <20260130124559.1182780-1-parvathi@couthit.com>
In-Reply-To: <20260130124559.1182780-1-parvathi@couthit.com>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, danishanwar@ti.com, rogerq@kernel.org,
 pmohan@couthit.com, basharath@couthit.com, afd@ti.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, alok.a.tiwari@oracle.com,
 horms@kernel.org, pratheesh@ti.com, j-rameshbabu@ti.com, vigneshr@ti.com,
 praneeth@ti.com, srk@ti.com, rogerq@ti.com, krishna@couthit.com,
 mohan@couthit.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256913-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[24];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 19E77EDEDD
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 30 Jan 2026 18:13:42 +0530 you wrote:
> Hi,
> 
> The DUAL-EMAC patch series for Megabit Industrial Communication Sub-system
> (ICSSM), which provides the foundational support for Ethernet functionality
> over PRU-ICSS on the TI SOCs (AM335x, AM437x, and AM57x), was merged into
> net-next recently [1].
> 
> [...]

Here is the summary with links:
  - [net-next,v13,1/3] net: ti: icssm-prueth: Add helper functions to configure and maintain FDB
    https://git.kernel.org/netdev/net-next/c/4c8566a12f14
  - [net-next,v13,2/3] net: ti: icssm-prueth: Add switchdev support for icssm_prueth driver
    https://git.kernel.org/netdev/net-next/c/eea65b87493e
  - [net-next,v13,3/3] net: ti: icssm-prueth: Add support for ICSSM RSTP switch
    https://git.kernel.org/netdev/net-next/c/eca327ae9aa6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



