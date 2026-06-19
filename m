Return-Path: <netdev+bounces-300575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aQ+aCtKZNGoJcgYAu9opvQ
	(envelope-from <netdev+bounces-300575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 03:22:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C6F6A389E
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 03:22:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EJoebdRj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300575-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300575-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB01130C9BB2
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 01:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A043314AE;
	Fri, 19 Jun 2026 01:20:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E54032ED34
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 01:20:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781832029; cv=none; b=ixazNfy5Eoh+m2kNtAieo+e0j5Nk7v2+Unxr/l7zrx2nmJWx6VnLhOQE2McxEEhnZKcisG6vh/JaMFpy85G0ylFsaBfW5mpydY/qD5+y4k+5jCl1LvjzyOUEJzQnhinsrJYkBi+tA3oWuOTLtcgc5lLIFzmFZd6MaTKrYISl+M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781832029; c=relaxed/simple;
	bh=gCw2dmlnIMwrauPurSoFOQMc9BjHDUult4sq6Ckp0Qc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q1cndQtpwa+l+4uOJi1AyNBvc7GsxB/SD4nM5M17/+VnRRgVTv8zrZ7J0g472WJXY6tAgn+EUz6HZBkK2Sr2uQg5xLy4pYCNh6fPMOf29DJMOm6bK1oPMSo3gUmmMg8m+qCH6cf6yk5BEjb2g4igAyEQbopAK5d01LAh4lWPdhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJoebdRj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC781F000E9;
	Fri, 19 Jun 2026 01:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781832027;
	bh=FWvwd7by0dJtvNw7/aunWq07cMGl4DDPTxRI6HQH4JA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EJoebdRjlMe1RaXs079+rf/3k4G6kfNKnvNccteFfH+SJigAX9Fi2oEH4R9NeyaVk
	 ZIcbxNTjLsDtnrmFkuGUw2AJ0/B0GhMve7zJWpgNd+Dt1JF3Jrk4FX1Cpcfp17ujRw
	 Mb+KN23U+0NJrv1sTca6obWEKUeXpfZIGuUqJMJfNER3azYSHNCKUGfhDrikuNXZxV
	 dZfSLDxPjsVDDenFYJxl/NGX9sJd56i8b7Z95u84DpZLZmbRA6c1rKszCRrJABiI63
	 rW/TqYtgWBpPjG9ysHIKN6J622xr79n+ddgREbvEgL+n9cpGYsqYvUA3NARVSfOK80
	 /tiFF4Zqs9Udw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56D643A78A7C;
	Fri, 19 Jun 2026 01:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: vlan_bridge_binding: Fix flaky operational
 state check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178183202088.3150917.3273185102876786641.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jun 2026 01:20:20 +0000
References: <20260617104323.1069457-1-idosch@nvidia.com>
In-Reply-To: <20260617104323.1069457-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, petrm@nvidia.com, horms@kernel.org,
 razor@blackwall.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300575-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:petrm@nvidia.com,m:horms@kernel.org,m:razor@blackwall.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 80C6F6A389E

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Jun 2026 13:43:23 +0300 you wrote:
> check_operstate() busy waits for up to one second for the operational
> state to change to the expected state. This is not enough since carrier
> loss events can be delayed by the kernel for up to one second (see
> __linkwatch_run_queue()), leading to sporadic failures.
> 
> Fix by increasing the busy wait period to two seconds.
> 
> [...]

Here is the summary with links:
  - [net] selftests: vlan_bridge_binding: Fix flaky operational state check
    https://git.kernel.org/netdev/net/c/4045f1c3d68e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



