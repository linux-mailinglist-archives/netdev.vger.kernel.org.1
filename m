Return-Path: <netdev+bounces-305683-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id POgKJucOTmqICQIAu9opvQ
	(envelope-from <netdev+bounces-305683-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 10:48:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E91FA723540
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 10:48:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bH3pODnE;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305683-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305683-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D78073045682
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 08:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920CB403B05;
	Wed,  8 Jul 2026 08:40:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9453FF1D0;
	Wed,  8 Jul 2026 08:40:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783500035; cv=none; b=CNH4e4H5FfwA6ZWShHqvjm1gzYCjgfeAXn5CzkWYA3h5BiftGBSt9PXJOACwT94Oye2s7Zp/GTRDSncY7ivsvrMxLwDvsPR/bb/m83BJRNskirwI3dB2Lp38bGBcJISaIMf9wcoMEoDtq3m3S7lky0KF8qA/MrXxIuphVFHwkS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783500035; c=relaxed/simple;
	bh=9VQdfdtHghpxl/1NVOnJ3+eiZORLyI8T/JPV1T58o84=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MjxcgZ0En9Y0k8VUvivcGe6akhB8BuA9d0/zvXE/for2Bkhj4OIWejfJZDrWO+QFsy9nFrUONt06EcSfPr2XRvahAfI5Eelp3BfibJaawsC8SKZ7JpJygURwiVSmcW0wgIZ9YfCHh/d7wp49H7RKcp8Ha9zdBsTcIo2YkVRWivg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bH3pODnE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4158D1F000E9;
	Wed,  8 Jul 2026 08:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783500026;
	bh=yf87XJNoQkN3VLsWjUPSkPSyKWdRSfNMzT1yWJe7RAo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bH3pODnEhU6/NnKRldMGQRFLL/PfqjreZcW7rVbXuIfdPyfXPGw78enPHSscQF7+F
	 F/w3u9u1SoD8NtdMYuHbUnWZ1NJ1I3t62gdzL62o7WpfV1BY1NzHFPZT+yfETFuRhZ
	 nIs6wK6H9teztsjTEnh1oLu6QF55/k8+w2OTW1j7nefzvta2XRt+hwuyynWp8yB9Ps
	 73ysJDoabiZoeZmu3TCjeni7OBWn3gNSOzo8amQBCiCYUn5fJ5L13XbSLDRUxf157G
	 ncMuAd8zH7tzIHPKiaItLh7bCQQYes888D6dMxoFQ2m7sqG8WBHIjO1dBtbsxRPRkC
	 wSNZFvB1yGSow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D08E43926384;
	Wed,  8 Jul 2026 08:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: rmnet: annotate endpoint lookup under RTNL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178350000539.2376807.15934938683516609692.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jul 2026 08:40:05 +0000
References: <20260701124017.3205729-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260701124017.3205729-1-runyu.xiao@seu.edu.cn>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: subash.a.kasiviswanathan@oss.qualcomm.com,
 sean.tranchetti@oss.qualcomm.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
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
	TAGGED_FROM(0.00)[bounces-305683-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:runyu.xiao@seu.edu.cn,m:subash.a.kasiviswanathan@oss.qualcomm.com,m:sean.tranchetti@oss.qualcomm.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E91FA723540

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  1 Jul 2026 20:40:17 +0800 you wrote:
> rmnet_get_endpoint() is shared by packet receive paths and
> RTNL-protected control paths. The receive paths already run under RCU/BH
> context through the RX handler, while the control paths reach
> rmnet_get_endpoint() after obtaining the rmnet port with
> rmnet_get_port_rtnl().
> 
> The helper walks port->muxed_ep[] with hlist_for_each_entry_rcu(). Pass
> lockdep_rtnl_is_held() as the non-RCU protection condition so
> CONFIG_PROVE_RCU_LIST can see the RTNL-protected control-path calls
> while preserving the existing RCU-reader behavior for data paths.
> 
> [...]

Here is the summary with links:
  - [net-next] net: rmnet: annotate endpoint lookup under RTNL
    https://git.kernel.org/netdev/net-next/c/4fa0619d039f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



