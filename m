Return-Path: <netdev+bounces-297196-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZRjLOdJSKGqsCAMAu9opvQ
	(envelope-from <netdev+bounces-297196-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 19:52:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DB476663149
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 19:52:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YOl9bLgT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297196-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297196-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2AEC03016F85
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 17:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CECE4CA279;
	Tue,  9 Jun 2026 17:40:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6854D2EC2
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 17:40:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781026824; cv=none; b=p3Mf5RJ9lP/+QmbOou9IlWejPqnLJMH0vz/sGM89LqJMCuKJYhuRx8ti6G4iyJdks9JbcSUHc7Q3OEwTCH6kyiqT4QAkXVpapHQR5R6P+qMUz6f8v1Bz5BbUkAyO29/vXItbS+qaerajmt3gneV0yqpqTjoCKbd9ubTNRjxQl8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781026824; c=relaxed/simple;
	bh=7/8+siXY1Qf+sq1/S6smd/zQsplraEIEceTTlBcek+E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ljpgky+jWtYAKPdHAmYlwN6DrYqJBuDeWMgo+H9cwv4TDZCUPsxooDYMK/+WMoWjUTqA5WtGdECfoLUTC3Vw7fQjTA9KtHkjDRtC3YR4JX0iE0gS/yeTmxkUhvsUYeM0hKD9wRBHvaiVSWDBcCT7yrZAh3h6pqtek6+D+LNyKuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOl9bLgT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CDF1F00893;
	Tue,  9 Jun 2026 17:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781026823;
	bh=KEetjoJKsH/VNU7ggT6g7tJIsIRPNAypK18CdEE8KqI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YOl9bLgTsHVXYYZEUAuVVOvwk+Gl1a4snuFK72ghVOVAQqWJj0LhTlykdaLydTeaw
	 QVw/5moFK/hCrmx9bcmO4o3YLcpmBO+ThwENFCefpvYMMxom5rp438ZO3/4nObjZP+
	 KrzRu3TMraRWpZ3yB7+2baqdkuAHqcKxMAq6qDkNRS6GWOonddqXppuLKsn7SsyiXP
	 XO2691099XZSRc6/B0PI1XlRZ3d/bLaDE/Ej+tjZ743DaMMMWICqN4YHi7aKtt5+Cn
	 MkdzEzW1HGoFwwL91/fiOlTxSjfAOFcVvdqVCRfnc4YcAsN7N+UoK4QEBRgCDmLQQT
	 G2h+f4s+IFjzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939AC393098D;
	Tue,  9 Jun 2026 17:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/12] net: ethtool: let ops locked drivers
 run
 without rtnl_lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178102682114.2158043.6852117340367698479.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 17:40:21 +0000
References: <20260605002912.3456868-1-kuba@kernel.org>
In-Reply-To: <20260605002912.3456868-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, hkallweit1@gmail.com,
 maxime.chevallier@bootlin.com, joshwash@google.com, tariqt@nvidia.com,
 alexanderduyck@fb.com, willemb@google.com, jacob.e.keller@intel.com,
 kory.maincent@bootlin.com, sdf.kernel@gmail.com, jakub@cloudflare.com,
 nb@tipi-net.de
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,gmail.com,bootlin.com,nvidia.com,fb.com,intel.com,cloudflare.com,tipi-net.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297196-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:michael.chan@broadcom.com,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:joshwash@google.com,m:tariqt@nvidia.com,m:alexanderduyck@fb.com,m:willemb@google.com,m:jacob.e.keller@intel.com,m:kory.maincent@bootlin.com,m:sdf.kernel@gmail.com,m:jakub@cloudflare.com,m:nb@tipi-net.de,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB476663149

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Jun 2026 17:29:00 -0700 you wrote:
> With the ethtool_get_link_ksettings() situation hopefully ironed out
> the previous series (commit 6a5d837f0ce2) let's return to the main
> part of the series.
> 
> We have been slowly moving towards removing the rtnl_lock dependency
> in driver ops since the concept of "ops-locked" drivers have been
> introduced last year. Since last year will take the netdev instance
> lock before invoking any ndo or ethtool op of "ops-locked" drivers.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/12] net: ethtool: serialize broadcast notification sequence allocation
    https://git.kernel.org/netdev/net-next/c/8845484367da
  - [net-next,v2,02/12] net: ethtool: relax ethnl_req_get_phydev() locking assertion
    https://git.kernel.org/netdev/net-next/c/ded86da4bbb7
  - [net-next,v2,03/12] net: ethtool: make dev->hwprov ops-protected
    https://git.kernel.org/netdev/net-next/c/97f51bf91b3a
  - [net-next,v2,04/12] net: ethtool: optionally skip rtnl_lock on Netlink path for GET ops
    https://git.kernel.org/netdev/net-next/c/45079e00133e
  - [net-next,v2,05/12] net: ethtool: optionally skip rtnl_lock on Netlink path for SET ops
    https://git.kernel.org/netdev/net-next/c/f9a3e05114b8
  - [net-next,v2,06/12] net: ethtool: optionally skip rtnl_lock in cable test handlers
    https://git.kernel.org/netdev/net-next/c/f16013fde46d
  - [net-next,v2,07/12] net: ethtool: optionally skip rtnl_lock in ethnl_tsinfo_dumpit()
    https://git.kernel.org/netdev/net-next/c/0c334c21f5a5
  - [net-next,v2,08/12] net: ethtool: optionally skip rtnl_lock in ethnl_act_module_fw_flash()
    https://git.kernel.org/netdev/net-next/c/2526717624ab
  - [net-next,v2,09/12] net: ethtool: optionally skip rtnl_lock in RSS context handlers
    https://git.kernel.org/netdev/net-next/c/732fa5ced1cc
  - [net-next,v2,10/12] net: ethtool: ioctl: concentrate the locking
    https://git.kernel.org/netdev/net-next/c/f58a40d07be3
  - [net-next,v2,11/12] net: ethtool: optionally skip rtnl_lock on IOCTL path
    https://git.kernel.org/netdev/net-next/c/f994752b1127
  - [net-next,v2,12/12] docs: net: ethtool: document ops-locked drivers and op_needs_rtnl
    https://git.kernel.org/netdev/net-next/c/b5125db8d020

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



