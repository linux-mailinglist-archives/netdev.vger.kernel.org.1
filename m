Return-Path: <netdev+bounces-300918-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BIiPNd1fOGq5bgcAu9opvQ
	(envelope-from <netdev+bounces-300918-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 00:04:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D0D6ABB1F
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 00:04:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OzV7DHxp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300918-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300918-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A638C3023DE8
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 22:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A7E371887;
	Sun, 21 Jun 2026 22:01:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D3A372B59;
	Sun, 21 Jun 2026 22:01:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782079281; cv=none; b=Ycf/KXDufTeCkA1YojRxjoKkxyLe7R7/AeLr1S6ZBI/XLOkcTOFPgZ2Tum0j6dw/StaV1JaeY0mJTyDhq7efdazYOZhXyoo1knBX549nngNKLCc2uyZKp8E8ijUC4i5KsuZlmxOxQQNV7QzWNPlMuWFBQSuA7/FjS6uTki0oo0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782079281; c=relaxed/simple;
	bh=gzHqVNtZ9nx/4IWaiCUdxlGpaS/vvrNo1cKnZ+AInUE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fL2paoLojCnqQFU/4O/j3AWVlOTiIPH1CkRkGfoSAVAj49CDgAKq/1w2eFE2ZaQ8aNm2/bRf2rbtf7UihdBWdHJDR+fWSQL40htJm8qp0jvhLwSDBCJLfz8oM1EbML21WMDv57W7bjwUvWxulUld6XixQJ/FvnHIIUhcL5MWFkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzV7DHxp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1B31F00A3F;
	Sun, 21 Jun 2026 22:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782079270;
	bh=rr1kRC7DmcQUsQS5kjH37JE6NDQYexMdeYMI9QWNd/s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OzV7DHxpyF6lG+Iyot/h+RDkyTEKyhL/+zsmhmqcWFxGPgM5gcOQZy8WfZGH8yGli
	 ZzEdSvg/w+0NukhiRwt8OXtUVi0v23HzrhsXS2xYS+qxi4rGmjsSKFAoDQErcuJFS1
	 9Wie/ltdNyq09aRAi1AnE0P/X8eM1eEY/lSVHa3AQi21v9ZaIatTul6GYJVORsdZoh
	 URS86bme3HkFg9oQ0m/iXof6LcI9UL+aKhpgX11CjDF2qtLQ5Dk7PbRN+nttmrPsy7
	 44hL1rT72ZfemULE9F2UI/B4I8scFlOp6d7uKz98zsktNDR9fcQfiT5xCee1kH5ht1
	 HOBrA+TNznHmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5683C3AAA6EA;
	Sun, 21 Jun 2026 22:01:03 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH v2] octeontx2-pf: mcs: Fix mcs resources free on PF
 shutdown
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178207926207.516339.1021134955116133326.git-patchwork-notify@kernel.org>
Date: Sun, 21 Jun 2026 22:01:02 +0000
References: <1781636420-19816-3-git-send-email-sbhatta@marvell.com>
In-Reply-To: <1781636420-19816-3-git-send-email-sbhatta@marvell.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com, gakula@marvell.com,
 bbhushan2@marvell.com, rkannoth@marvell.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300918-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:gakula@marvell.com,m:bbhushan2@marvell.com,m:rkannoth@marvell.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,marvell.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 26D0D6ABB1F

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Jun 2026 00:30:20 +0530 you wrote:
> From: Geetha sowjanya <gakula@marvell.com>
> 
> On PF shutdown, the current driver free mcs hardware
> resources though mcs resources are not allocated to it.
> This patch checks the mcs resources status and if resources
> are allocated then only sends mailbox message to free them.
> 
> [...]

Here is the summary with links:
  - [net,v2] octeontx2-pf: mcs: Fix mcs resources free on PF shutdown
    https://git.kernel.org/netdev/net/c/450d0e90b103

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



