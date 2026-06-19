Return-Path: <netdev+bounces-300562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 13JiFAGXNGrucAYAu9opvQ
	(envelope-from <netdev+bounces-300562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 03:10:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E74816A3819
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 03:10:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kK2oENrM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300562-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300562-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9794E3006B7F
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 01:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378612D5408;
	Fri, 19 Jun 2026 01:10:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385AC283CAF
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 01:10:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781831421; cv=none; b=LDjAd4qrPfNHGzUNycZXUJwp13MUHD9loh8WCLCRzPnutR5gTO6C3MMTNh4LdYEqsNINueAMl/WDaCiJw9MHuivQ9B023BidtW7rnq/KFLsmGSZVTffWB/SbRyTau9TkYj3Ba2g1kZ1gpEfSv4Zgv+JA3YSQ1+18us0kH8/jKTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781831421; c=relaxed/simple;
	bh=QQvSJsQ1a44RI46JAn+KepQjcvBSWGqRVRcqok40ROA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KTiG4NuJutYdrS+QiAn+mlXdjzchlrmfgu0C39xTF6zVr5rFeEqAjZB98Ld2zDNbW8X8o6HiE5BONeJM1Mb6nK66nsAmWvda71G8vVHtoJsa0q3GpGSIKuQAaYnW2mvQuDQ6r/f2oI2RHi0ut91FMUzU16IOFfme9akRNWrRZPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kK2oENrM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE1D1F000E9;
	Fri, 19 Jun 2026 01:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781831419;
	bh=XAV1Lkn9x7DjQIlVjm3qbHHpdfC0GAePkIxSz4M+XZs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kK2oENrMiCNMhWzdqshjZfWNDoHpnd/dLc7NdNfCJYV7Jd8HVmdvveiexzfyx/xbh
	 xrx8cCleHCAOB32QLkUX+0j3DxfgU1hI5DZB4fbFvC6Qpi/+bB/2uHrFrF0wS1MM7x
	 xaMG/tElazWzP1c5J6CjxRIiazMi0Dr2UVmOwL2j9viVCXC/Pqp29xTO3B/Bu0H7dM
	 DnFM9i2wpAAVceGiL5byEmk3D+JgJhuCd7R7lYzi2r60QVt5jlLE4+oz7kSGyYBVjm
	 neQLo1jenxiP57vQIm8Y+If/ZFSsWLL8X3kwQdwbnEgEEDzKqEdmSmKh57uyycOrUx
	 bOMWWa/HVoFmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AD83A78A7C;
	Fri, 19 Jun 2026 01:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] devlink: Fix a couple parent ref leaks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178183141314.3148637.4107532095640365241.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jun 2026 01:10:13 +0000
References: <20260616110633.1449432-1-cratiu@nvidia.com>
In-Reply-To: <20260616110633.1449432-1-cratiu@nvidia.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 michal.wilczynski@intel.com, cjubran@nvidia.com, mbloch@nvidia.com,
 tariqt@nvidia.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300562-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:cratiu@nvidia.com,m:netdev@vger.kernel.org,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:michal.wilczynski@intel.com,m:cjubran@nvidia.com,m:mbloch@nvidia.com,m:tariqt@nvidia.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E74816A3819

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Jun 2026 14:06:31 +0300 you wrote:
> These two patches fix parent ref leaks on errors.
> 
> Cosmin Ratiu (2):
>   devlink: Fix parent ref leak in devl_rate_node_create()
>   devlink: Fix parent ref leak on tc-bw failure
> 
>  net/devlink/rate.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)

Here is the summary with links:
  - [net,1/2] devlink: Fix parent ref leak in devl_rate_node_create()
    https://git.kernel.org/netdev/net/c/ba45106342bb
  - [net,2/2] devlink: Fix parent ref leak on tc-bw failure
    https://git.kernel.org/netdev/net/c/ba81a8b80f04

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



