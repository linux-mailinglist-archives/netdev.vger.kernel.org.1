Return-Path: <netdev+bounces-292072-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNgXJpRZFmrFlgcAu9opvQ
	(envelope-from <netdev+bounces-292072-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 04:40:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB795DEA25
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 04:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6913E301457B
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2E535836E;
	Wed, 27 May 2026 02:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLAwneKe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAD635F184
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 02:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779849608; cv=none; b=JvQBUTfbPVk3uu3kfWZFvF96/hnTsqQGjXBfp16wPKZw7zQLff369DMGOH2QhgAtrCkNeopbahNg/iQb0VeV6/Uozxt09qfZse+z8ixVytuaGITu8txqs1FggmPtYRSsbEMMvVoyMLijO5D4/VFIfiLaJnc+4TbMP4BMoMFrvM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779849608; c=relaxed/simple;
	bh=F7QSFQBQV0wayzVD5xzWfvvmoC3fPnCnV7J77HEqTxE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SVvcRI0u8HOLgXRjuUXYgVirV2wlQyT944npRC8eIlxGCJWlbRmDsbBCdCr4x+xowGQD/HwWekBfPW5IIfD31N6Vg8Tb/RGUgtfT+bFC7fj/PqKYHCYQ4+e7tsHymUy7pq0prjJkFNSxkOdYmbA8y3Kl8+vHyfPw8txvYGnEF58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLAwneKe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96F51F000E9;
	Wed, 27 May 2026 02:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779849606;
	bh=7AVifT8uuj4tekezMqtxnhozJ1X9ZuYmQKfvWSaFPZk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nLAwneKe0Rj4FjB23xfG3WYilJcxXb0mFWHEM6T/I7AlYFvSMIQGhl31PbRRNUt1t
	 MwVicBjsE7xALd1a3R73M9AMWjmek74/HEkrr3YplRKMjr8frko9GFlqnwkaHizn9r
	 8IYZU2LKO2Bn0377bh0+63LVlhcQsIu5kTbGwAKbrTxq/cu411o5I/qrQ8YPhCY+SX
	 nqL7FacQ4shy63w3guntkPYieZIcMM7NYA1IbgzLEE6Tl8cleQy6N1iXKaZxNpHgTb
	 tNfbLceyiCT5o4a1oUKbV4mGm7GYstcGgoACE7E3VV0jgvUbNLITy/cxo09B7Z2VXI
	 j+x7yC68Iojpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93947380CEED;
	Wed, 27 May 2026 02:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 net-next 0/5] rtnetlink: RTNL avoidance in
 rtnl_getlink()
 and rtnl_dump_ifinfo()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177984961239.4057662.14266234471660780599.git-patchwork-notify@kernel.org>
Date: Wed, 27 May 2026 02:40:12 +0000
References: <20260525083542.1565964-1-edumazet@google.com>
In-Reply-To: <20260525083542.1565964-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-292072-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0FB795DEA25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 May 2026 08:35:37 +0000 you wrote:
> Many shell scripts invoke iproute2 commands specifying a device by
> its name.
> 
> This series improves their performance avoiding RTNL acquisition
> for their (repeated) name->index conversion.
> 
> v5: fix rtnl_fill_prop_list() return value.
> v4: Addressed Sashiko's feedback.
>     added 2 patches for rtnl_dump_ifinfo().
> v3: insert patch 2/3 in the series (Jakub reported a KASAN splat)
> 
> [...]

Here is the summary with links:
  - [v5,net-next,1/5] rtnetlink: use nla_nest_end_safe() in rtnl_fill_prop_list()
    https://git.kernel.org/netdev/net-next/c/73a7c8fb2302
  - [v5,net-next,2/5] net: defer netdev_name_node_alt_flush() call to netdev_run_todo()
    https://git.kernel.org/netdev/net-next/c/00888feb6014
  - [v5,net-next,3/5] rtnetlink: do not acquire RTNL in rtnl_getlink() with RTEXT_FILTER_NAME_ONLY
    https://git.kernel.org/netdev/net-next/c/e896e5c0734b
  - [v5,net-next,4/5] rtnetlink: do not assume RTNL is held in link_master_filtered()
    https://git.kernel.org/netdev/net-next/c/6768c7c3d70f
  - [v5,net-next,5/5] rtnetlink: add RTEXT_FILTER_NAME_ONLY support to rtnl_dump_ifinfo()
    https://git.kernel.org/netdev/net-next/c/d628604f7ea7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



