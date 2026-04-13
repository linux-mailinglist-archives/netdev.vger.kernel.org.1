Return-Path: <netdev+bounces-278236-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBlKG3uB3WldfAkAu9opvQ
	(envelope-from <netdev+bounces-278236-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 01:51:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF683F4510
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 01:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93DD63051BDB
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 23:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980613A0B3D;
	Mon, 13 Apr 2026 23:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbJ6loio"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751FC39F183;
	Mon, 13 Apr 2026 23:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776124240; cv=none; b=iyCgZP4P+9P0BZ4nkqaLpNT2sIrZTXHUWIq1z4zZiiVgwv5bhPLNSdpJa3tc5zbY6NtR67CTqvUhUxGLZn6eXre/SPM75JJMHTs2BdcTR7+O+/RdMDTB/YqGImkzm/Ac9YRgolOvm4767ZWSSocvm0oek8R6J6zPKLUoLPdj8oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776124240; c=relaxed/simple;
	bh=wfM0L/SSAk2/unLLqMDNKRbsQK3R2OHLCXzpKTenlnM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Edd108OVhnWZ0XVDy+LUmIXW92w6EdXV4Ebyp0ueKVFoAkR6gzaTUTt8yBTulpzUVgoi3G4iWZUbHYbUBaeoHGsD5j3IKRpLBuPSO2KdzMg11nKWBVAQEXnzhlsTUYra+PFhLr0xaKmyxjEg/E7D/sQsAOUqGZFjiaFcIrh+9no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbJ6loio; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545A6C2BCAF;
	Mon, 13 Apr 2026 23:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776124240;
	bh=wfM0L/SSAk2/unLLqMDNKRbsQK3R2OHLCXzpKTenlnM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mbJ6loioAqpEhCCHYOQDev2UNR701egfpv3sHdjBn2I/HgsBbJGE+cAu+w/JMLWXg
	 eW9DzcJhDd7mPTSLvuIEAoNZU4VjeT1b54bul/pea4bj3ifWlj/3aNv20r/xIKrQ+t
	 BS4LrzctNhlXfEfh9fzglTak+yWftnbVSLHTgNNr7XdhT2R8gxBO517woF6M/c5L4R
	 tS0T8k0Qg7MuDQjQzJWbfbiJfu6LZ7212CgKTBoLQvz2of/Et/pzuxy3QFYRyRzKgV
	 ZluMe/2LjbT8ZhzxC7G3y9RSNy4DRRBSUV+nrnsaEcpM8wBbCf6+AUQkFMID8RF8jp
	 fUmf+zf45zJbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9D7F3809A0B;
	Mon, 13 Apr 2026 23:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: dsa: mxl862xx: add statistics
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177612421128.603926.12770250649892920484.git-patchwork-notify@kernel.org>
Date: Mon, 13 Apr 2026 23:50:11 +0000
References: <cover.1775951347.git.daniel@makrotopia.org>
In-Reply-To: <cover.1775951347.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 frankwu@gmx.de, chad@monroe.io, cezary.wilmanski@adtran.com,
 lxu@maxlinear.com, yweng@maxlinear.com, jverdu@maxlinear.com,
 ajayaraman@maxlinear.com, john@phrozen.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	TAGGED_FROM(0.00)[bounces-278236-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CDF683F4510
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 12 Apr 2026 01:01:48 +0100 you wrote:
> Add per-port RMON statistics support for the MxL862xx DSA driver,
> covering hardware-specific ethtool -S counters, standard IEEE 802.3
> MAC/ctrl/pause statistics, and rtnl_link_stats64 via polled 64-bit
> accumulation.
> 
> Changes since v1:
>  * trim mxl862xx_mib[] to counters not covered elsewhere only
>  * remove histogram counters (moved to .get_rmon_stats)
>  * remove RMON error counters (moved to .get_rmon_stats)
>  * remove counters already in .get_eth_mac_stats
>  * remove counters already in .get_stats64
>  * add mxl862xx_rmon_ranges[] and mxl862xx_get_rmon_stats()
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: dsa: mxl862xx: add ethtool statistics support
    https://git.kernel.org/netdev/net-next/c/e6295d124644
  - [net-next,v2,2/2] net: dsa: mxl862xx: implement .get_stats64
    https://git.kernel.org/netdev/net-next/c/a21d33a5265f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



