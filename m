Return-Path: <netdev+bounces-277612-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0P2sGz2E2WmvqQgAu9opvQ
	(envelope-from <netdev+bounces-277612-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 01:14:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E88B03DD6C0
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 01:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A4E13051C82
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903BD37DE8B;
	Fri, 10 Apr 2026 23:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcN4upGV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D07037D107;
	Fri, 10 Apr 2026 23:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775862648; cv=none; b=HL8CU1L/rJpHd21DLT2k/9kbqDf5DNvEbm8bI4LgcJ3pGPSdeKSxoit5TIiSEdB9/bD58Kp4T0hv5ShN80Ns4rLZUzNoRCvf0LtVDGUu8EOUnMuxA8RpLDjeyQrSayaaghGTPsAXSsLWoKZbm/ReeQzE1Vhphzryzl2yAS4swGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775862648; c=relaxed/simple;
	bh=uhtaOGVkRMG9iRSD3Hk7CaEFgOohH9/9wv1T8qTxXwk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NPAylwr4J4p/4d8VtBgLHYtA5C/wp7kH3/5kbVL+Py6/ITkIAvvvs7NnMBnu8/0BBKpGz07khiHISv/Ao7+akVgFeMmWjvxyLHVc+/suldgn64+RNZEx8tvocCY5B+KEpZD+H7VY9zc3Weq6rcyWkc438Yw/F60td2J/qW/A6ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcN4upGV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4B9C2BC9E;
	Fri, 10 Apr 2026 23:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775862648;
	bh=uhtaOGVkRMG9iRSD3Hk7CaEFgOohH9/9wv1T8qTxXwk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rcN4upGVgU0ZW0QYoeuyvYpeAvFUYN2MFIKafq/K5BtIjXFF5yyksQ6WeKFQflGjt
	 W+gOp9gaRTWzkUZS2ayZwlm8Ata6Ai6Y4udV6m9ov+XXYEi0jpGDY0H29MR5i3et06
	 au3tc1wYJXLoJBOKuMvgXxhxuFHh/miR5P2SB89daJbjeN1K/sdNYay8xtqvyKFCYQ
	 YAir9HBgrqXo2wzSWQMREFL90eihN+wQ5g9DLx+Lr3oyyTG5OKjgBhprosGrxiCz5C
	 15D66fVc0LM2HKpG6ZV6AArVkv1/7ma1OMJoMzv0QaKzzXPhf3/KszBslAU1Ru352w
	 xI+BJrpWbSHiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9DFF3809A88;
	Fri, 10 Apr 2026 23:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: dsa: mxl862xx: VLAN support and minor
 improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177586262229.2678602.6379825282482013499.git-patchwork-notify@kernel.org>
Date: Fri, 10 Apr 2026 23:10:22 +0000
References: <cover.1775581804.git.daniel@makrotopia.org>
In-Reply-To: <cover.1775581804.git.daniel@makrotopia.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	TAGGED_FROM(0.00)[bounces-277612-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[18];
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
X-Rspamd-Queue-Id: E88B03DD6C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 7 Apr 2026 18:30:14 +0100 you wrote:
> This series adds VLAN offloading to the mxl862xx DSA driver along
> with two minor improvements to port setup and bridge configuration.
> VLAN support uses a hybrid architecture combining the Extended VLAN
> engine for PVID insertion and tag stripping with the VLAN Filter
> engine for per-port VID membership, both drawing from shared
> 1024-entry hardware pools partitioned across user ports at probe time.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: dsa: mxl862xx: reject DSA_PORT_TYPE_DSA
    https://git.kernel.org/netdev/net-next/c/3a4056ec7ec8
  - [net-next,2/3] net: dsa: mxl862xx: don't skip early bridge port configuration
    https://git.kernel.org/netdev/net-next/c/71934b9e6f36
  - [net-next,3/3] net: dsa: mxl862xx: implement VLAN functionality
    https://git.kernel.org/netdev/net-next/c/d587f9b6dcc9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



