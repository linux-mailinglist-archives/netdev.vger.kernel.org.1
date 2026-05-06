Return-Path: <netdev+bounces-284636-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OE9gHd+S+mmZPwMAu9opvQ
	(envelope-from <netdev+bounces-284636-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:01:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D874D5224
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 68E36300668B
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 01:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7477145BE3;
	Wed,  6 May 2026 01:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOukrArX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E4DC2FF
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 01:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778029277; cv=none; b=snWM+VmWBjMauPHES5sxaci5+6n15CDUEGKQYNsO85sYp++FVFAbIpmMx/pOcA50j6BTkGP3rG4JlKlcw+6aN4pyWC6Awji5FLcgQXHyfPX4YAO0ansL8HXbmYBn0VT5u7PBEDyHRr+teSmpHr2jv+VuCmYX80ZfDStofJquuuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778029277; c=relaxed/simple;
	bh=xAVs+yZzELYDzcohDpcCD3pqLgclVEks0P9GxssIc+E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CkMeD48T1Xp2VFbvn3bKlZU1Ro4Pa39uJUoihBi6EGNDv7uzVbVQXBLW3IPJ6PN6Y47H4b0WRz6Rc5Zn7qd9xTclPLCRcLFWjYZsWalUbbKqO4m6Pf445FPz+YzMej6RMM8Jpm++4zXqyO1DpRNaIiCAiDm5V/OozRuxBRh6Ch4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOukrArX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E082EC2BCB4;
	Wed,  6 May 2026 01:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778029276;
	bh=xAVs+yZzELYDzcohDpcCD3pqLgclVEks0P9GxssIc+E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JOukrArX3oYu5toTrUDhC5U55Il7mxfQGx+j49A76EmytM2u+IdNRzS73HRQ30J1b
	 sek/ULZVYUBHLCFQySz65+9o8o7x0Gf+kAwN4rmL07yHW3glVqTlmrmThQtLRll6ex
	 yRXXWwCWBvx3ZbQxuKmWELeQoCJTEef8DquSHKafBAFvUARzBXPNvTnWKj6lxi+YAC
	 1bG9RS6XyXFuGmjXC0suSeoRuzM7E/IxyiDIHCiC/EBe5zocPXTEPxNUg/tUA5QB5X
	 bbo0EsUjoHQYRmmmfFKMXO+uuJC+cUsKN17NC7ge8dnH5CbRayVp0mDUqPcvmuPKnG
	 bg+8mYZuhSEjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDE13930780;
	Wed,  6 May 2026 01:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next 00/15] udp_tunnel: Speed up UDP tunnel device
 destruction (Part I)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177802922680.2330352.4228235075044391782.git-patchwork-notify@kernel.org>
Date: Wed, 06 May 2026 01:00:26 +0000
References: <20260502031401.3557229-1-kuniyu@google.com>
In-Reply-To: <20260502031401.3557229-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 kuni1840@gmail.com, netdev@vger.kernel.org
X-Rspamd-Queue-Id: 17D874D5224
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-284636-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  2 May 2026 03:12:53 +0000 you wrote:
> Most of the UDP tunnel devices call synchronize_rcu() twice
> during destruction, for example, vxlan has
> 
>   1) synchronize_rcu() in udp_tunnel_sock_release()
> 
>   2) synchronize_net() in vxlan_sock_release()
> 
> [...]

Here is the summary with links:
  - [v1,net-next,01/15] udp_tunnel: Pass struct sock to udp_tunnel_sock_release().
    https://git.kernel.org/netdev/net-next/c/944bfc1b1c6f
  - [v1,net-next,02/15] udp_tunnel: Pass struct sock to setup_udp_tunnel_sock().
    https://git.kernel.org/netdev/net-next/c/2cba193628fe
  - [v1,net-next,03/15] udp_tunnel: Pass struct sock to udp_tunnel6_dst_lookup().
    https://git.kernel.org/netdev/net-next/c/9333d5ff28bd
  - [v1,net-next,04/15] udp_tunnel: Pass struct sock to udp_tunnel_{push,drop}_rx_port().
    https://git.kernel.org/netdev/net-next/c/8d0012ce1b41
  - [v1,net-next,05/15] udp_tunnel: Pass struct sock to udp_tunnel_notify_{add,del}_rx_port().
    https://git.kernel.org/netdev/net-next/c/af3f903fbb70
  - [v1,net-next,06/15] vxlan: Fix potential null-ptr-deref in vxlan_gro_prepare_receive().
    https://git.kernel.org/netdev/net-next/c/30a45c0bffdd
  - [v1,net-next,07/15] vxlan: Store struct sock in struct vxlan_sock.
    https://git.kernel.org/netdev/net-next/c/027bffa1ad19
  - [v1,net-next,08/15] vxlan: Free vxlan_sock with kfree_rcu().
    https://git.kernel.org/netdev/net-next/c/4f71dd1b421d
  - [v1,net-next,09/15] geneve: Store struct sock in struct geneve_sock.
    https://git.kernel.org/netdev/net-next/c/82720c6196dc
  - [v1,net-next,10/15] bareudp: Store struct sock in struct bareudp_dev.
    https://git.kernel.org/netdev/net-next/c/bc773b15eb19
  - [v1,net-next,11/15] fou: Store struct sock in struct fou.
    https://git.kernel.org/netdev/net-next/c/173a79f6966a
  - [v1,net-next,12/15] amt: Store struct sock in struct amt_dev.
    https://git.kernel.org/netdev/net-next/c/65c6e06d5aba
  - [v1,net-next,13/15] pfcp: Store struct sock in struct pfcp_dev.
    https://git.kernel.org/netdev/net-next/c/fe57adbe0dac
  - [v1,net-next,14/15] tipc: Store struct sock in struct udp_bearer.
    https://git.kernel.org/netdev/net-next/c/1ae552c7b665
  - [v1,net-next,15/15] udp_tunnel: Remove synchronize_rcu() in udp_tunnel_sock_release().
    https://git.kernel.org/netdev/net-next/c/72d3b9a4c2b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



