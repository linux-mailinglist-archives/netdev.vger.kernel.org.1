Return-Path: <netdev+bounces-258097-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOSYHH9Di2mfRwAAu9opvQ
	(envelope-from <netdev+bounces-258097-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 15:41:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BF111BFF0
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 15:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3E2B304D944
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 14:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1303803FC;
	Tue, 10 Feb 2026 14:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IW56OCQc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097FD3803F2;
	Tue, 10 Feb 2026 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770734410; cv=none; b=GokS5JuiEa44pssFngC+yqiGCG5y0ctSgUQknPcQXbnhe2/OuTxHopaI63Kc0fSeteVlOmFSAeqfkHgaIRLHp36nAs+JzYZs9NKiFOZ1gCb6nLT81NyfZFL90aJ5szioh/QhVhZsoYk6AB+Qz7Gh31ECjy6Xy/dvlY2y6CHgVpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770734410; c=relaxed/simple;
	bh=XDrQUrJL/2Rr3apaPDp6vjdijLQntmn9jZU6u2gL+sw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=grCmJXySBEg9Ln7ILDPmEUlSgDJH/POyfnd34kK4MHDSpxv90YDs7bRSMvhRYMgNLHqw15Yidt7hHMNs2Bv8UGFMFrmibNw0RYaYPtZHXAJ1xKnooDQDjT2rThNhsp4Lz65EN+le3KQeMn9r++zuIpn+uCr9L0JQN1Ij0lo6+Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IW56OCQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755A1C116C6;
	Tue, 10 Feb 2026 14:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770734409;
	bh=XDrQUrJL/2Rr3apaPDp6vjdijLQntmn9jZU6u2gL+sw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IW56OCQcwlQgCiYaP30eBCkDCiyy3Uggh54Rsq+bqXLl5NeatuQPmjRr/ElFPpIE4
	 xnqiZzJI+IRpVbTiGROmjQ+h3V3eemvzpeueooZ5s0JisXg2+NBdqqlBphR2RYmk6t
	 aAmCzxejvJzeLqKCb3qO6G0UtlhtKkbsrpGnzMb9Sjya5uxyNPg0ilZ4p+zPSo1EYB
	 s7mjixXgHZy5/VgtuO1HcilTbkxaUgwHuy3bgd/uoZdX3Gaipxoffy4lPwufPA9Ruq
	 WjsZPiEh3PE/DxwANKSwM+iMkOA0ymaeFe7E5+ksEgH4YpJPB8k0hUOZSjO8IZ6Lgs
	 9dJAPzYzOcYHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B06039D267E;
	Tue, 10 Feb 2026 14:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: dsa: eliminate local type for tc
 policers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177073440483.3536807.13134954749305147323.git-patchwork-notify@kernel.org>
Date: Tue, 10 Feb 2026 14:40:04 +0000
References: <20260206075427.44733-1-mmyangfl@gmail.com>
In-Reply-To: <20260206075427.44733-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, vladimir.oltean@nxp.com, claudiu.manoil@nxp.com,
 alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258097-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: D8BF111BFF0
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  6 Feb 2026 15:54:21 +0800 you wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> David Yang is saying that struct flow_action_entry in
> include/net/flow_offload.h has gained new fields and DSA's struct
> dsa_mall_policer_tc_entry, derived from that, isn't keeping up.
> This structure is passed to drivers and they are completely oblivious to
> the values of fields they don't see.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: dsa: eliminate local type for tc policers
    https://git.kernel.org/netdev/net-next/c/c22ba07c827f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



