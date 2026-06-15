Return-Path: <netdev+bounces-299628-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OBwqFrZzMGq/TAUAu9opvQ
	(envelope-from <netdev+bounces-299628-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:50:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE6B68A39F
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:50:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FPlgPyPn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299628-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299628-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBD4130D59C7
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB663A8739;
	Mon, 15 Jun 2026 21:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8A73168EB;
	Mon, 15 Jun 2026 21:50:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781560224; cv=none; b=nMmwfqbpKWfldoaqbpo4kX91mjlftzGdob0m6vLUebADrB5ODagmz09UGgZM19UvAp78+IkBuPaX2HBmhzn63Qa/jL3JeHkJXBvNHvNsnTRnhuP27Rmxw1/21yu3UrI3szm12qhzF8PaudTSNZFE/+DdmKu7uAteE/dG85Dmlnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781560224; c=relaxed/simple;
	bh=nbBHTERh0KFAK1aKiV1GLYZku94l+EpzH+fw+6xwXaY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FQZFhyd01mVd/mv0iPpBVg/Rtzsk9Q8gM3KfX9a1ix5uMSgkWh3PtRfb8c5vcITbO2jk4eNAtJxAlgN9AUMZg/VgitkXKcXJJpl55hdGxvteLfjwpRGG/PjGh04JNsZpu2gN+9biNfKn7OgR5jpQS2lHQs/J98CeiZeFQg9dWPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPlgPyPn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170051F000E9;
	Mon, 15 Jun 2026 21:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781560223;
	bh=B/XcSAGeoGp/BP+1XhwRml/MI2qj10vi9ZYd7jCnORI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FPlgPyPnuMeIfmdNU0MP3k6aXAwqDVGYRcBE+vdzcnANEahuHxJHj2EkNlS3P1irG
	 bA8kdm03jzL0CAYujQzr05f7I7SgYDmlEH7AdJf7+j1+P17KJGHbFrrKRJX2ci7urj
	 YvTxUdTk3Mz5yKlyDsq1tygwgKni+g9/IcHtySqn/EY1SQq7ephrBf5+WEu+BsbXC2
	 /61fn0E1dvpYIf1ilHh1HAK/H1u/RBp7e5FfRPATCcPXShx/cKIPK8b6Eu4qZg5sO3
	 uTraskHJ8ayVvuPud8Rfc890OZKeOsgL+Ky+qeM7fuLqQBpT7XTRGm/JxsmD1QPJNq
	 kM5RnuPl7b74g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568803839A06;
	Mon, 15 Jun 2026 21:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 net-next 0/9] net: dsa: netc: add bridge mode support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178156021814.308382.3109768586287971042.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 21:50:18 +0000
References: <20260611021458.2629145-1-wei.fang@oss.nxp.com>
In-Reply-To: <20260611021458.2629145-1-wei.fang@oss.nxp.com>
To: Wei Fang (OSS) <wei.fang@oss.nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, chleroy@kernel.org, andrew@lunn.ch,
 olteanv@gmail.com, linux@armlinux.org.uk, wei.fang@nxp.com,
 imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
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
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,lists.linux.dev,vger.kernel.org,lists.ozlabs.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-299628-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:wei.fang@oss.nxp.com,m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:chleroy@kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-arm-kernel@lists.infradead.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
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
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FE6B68A39F

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 10:14:49 +0800 you wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> This series adds bridge mode support to the NETC DSA switch driver,
> covering both VLAN-aware and VLAN-unaware operation.
> 
> The NETC switch manages forwarding through a set of hardware tables
> accessed via NTMP: the FDB table (FDBT), VLAN filter table (VFT), egress
> treatment table (ETT), and egress count table (ECT). The series extends
> the NTMP layer with the operations required for bridging, then builds the
> DSA bridge callbacks on top.
> 
> [...]

Here is the summary with links:
  - [v5,net-next,1/9] net: enetc: add interfaces to manage dynamic FDB entries
    https://git.kernel.org/netdev/net-next/c/ca394837dfdd
  - [v5,net-next,2/9] net: enetc: add "Update" and "Delete" operations to VLAN filter table
    https://git.kernel.org/netdev/net-next/c/c52b6702a948
  - [v5,net-next,3/9] net: enetc: add interfaces to manage egress treatment table
    https://git.kernel.org/netdev/net-next/c/3cc291a35939
  - [v5,net-next,4/9] net: enetc: add "Update" operation to the egress count table
    https://git.kernel.org/netdev/net-next/c/d51f238a154a
  - [v5,net-next,5/9] net: dsa: netc: initialize the group bitmap of ETT and ECT
    https://git.kernel.org/netdev/net-next/c/1a58ae73dd74
  - [v5,net-next,6/9] net: enetc: add helpers to set/clear table bitmap
    https://git.kernel.org/netdev/net-next/c/8469b17310d1
  - [v5,net-next,7/9] net: dsa: netc: add VLAN filter table and egress treatment management
    https://git.kernel.org/netdev/net-next/c/84b4a3b30abd
  - [v5,net-next,8/9] net: dsa: netc: add bridge mode support
    https://git.kernel.org/netdev/net-next/c/751aa5a5d593
  - [v5,net-next,9/9] net: dsa: netc: implement dynamic FDB entry ageing
    https://git.kernel.org/netdev/net-next/c/05b5ee610fbb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



