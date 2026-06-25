Return-Path: <netdev+bounces-301852-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fByvEvmZPGr3pggAu9opvQ
	(envelope-from <netdev+bounces-301852-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 05:01:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AB46C2814
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 05:01:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="m0/B6AAV";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301852-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301852-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B2E3D300B52C
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 03:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13C12F5A13;
	Thu, 25 Jun 2026 03:01:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE9C26A08F
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 03:01:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782356466; cv=none; b=t+u558x2/MLC5RmeL8Vj2qzHK+Gbq31bmei2HCQ7g+++NNxIJlIsxF5+PJb9Pvkc858vzVp3Ir0/u1FIs37zNGzKL0jWYsdCJyxWXNcXj2ls9XbyPauKplhXBtdbiImakP85QQ/WvQkig6W+7mWhtpDR7XFhzy9cK8o1r0A3gh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782356466; c=relaxed/simple;
	bh=p3TqFRAMs1V0l7peSTtTBzPlzLZgbZiXL3mRvBg1j2w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DbnOgxQpCGJKJemC8eGEt7mzMj+EgSvr0tJd9Btak2EWTrbGRYQiEY3f6IbdhgwWIs9LR75K6Z9etVoRuI1WQKg52s95gI9y1zlANuIJA3hd0Heu9YJAud2rFiOCrtj1pvmVLx5uxg+pm4Li5x3T5dYyuG7Yi37K2f+1+ufItso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0/B6AAV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A599E1F00A3A;
	Thu, 25 Jun 2026 03:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782356465;
	bh=v16W+wzPqZuTCTEPG7r4lTESH7gb02Dfc0bZ38tBDME=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=m0/B6AAV+JOzFRIUfoSCeuxPA7I3IvBvnwu/aEMZrca5gp/Rn8CdNHYCc/DocffY4
	 NuXBEBuRe2etONkTccwgpktRvfrAXf4N0zAYzRbgDoyFEw1a+P0wr43x+3TWJFAZxn
	 KoJhEOlqHnzasZqT6E72aLMr5PFFFSHy/Eujfd422l16rCVfixgakU4wD/nPlS2lRX
	 bGpOnO5AchXPSIAV67YFr0VVF+xenlePWhrZhijKLmyK0iN7awY2pSWz2E4NtRiAFw
	 p7Lodeh0pMkDjLcbjkRFwDHCSYbW0Q518X4u9eL/UPptJsWM3bz8opR8WViXhhiXfP
	 nqZCtSrCKwVjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198B53AAA6F3;
	Thu, 25 Jun 2026 03:00:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/8][pull request] Intel Wired LAN Driver Updates
 2026-06-22 (ice, i40e, e1000e)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178235645374.3097853.6788230040205696487.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 03:00:53 +0000
References: <20260622220059.2471844-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260622220059.2471844-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301852-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 60AB46C2814

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon, 22 Jun 2026 15:00:47 -0700 you wrote:
> For ice:
> Dawid changes call to release control VSI during reset to prevent
> leaking it.
> 
> Lukasz fixes flow control error check to check value rather than treat
> is as bitmap values.
> 
> [...]

Here is the summary with links:
  - [net,1/8] ice: fix FDIR CTRL VSI resource leak in ice_reset_all_vfs()
    https://git.kernel.org/netdev/net/c/ebbe8868cf47
  - [net,2/8] ice: fix AQ error code comparison in ice_set_pauseparam()
    https://git.kernel.org/netdev/net/c/2bf7744bc322
  - [net,3/8] ice: fix ice_init_link() error return preventing probe
    https://git.kernel.org/netdev/net/c/eb509638686b
  - [net,4/8] ice: call netif_keep_dst() once when entering switchdev mode
    https://git.kernel.org/netdev/net/c/c0d00c882bc4
  - [net,5/8] ice: dpll: set pointers to NULL after kfree in ice_dpll_deinit_info
    https://git.kernel.org/netdev/net/c/a903afff66d7
  - [net,6/8] ice: dpll: fix memory leak in ice_dpll_init_info error paths
    https://git.kernel.org/netdev/net/c/20da495f2df0
  - [net,7/8] i40e: Fix i40e_debug() to use struct i40e_hw argument
    https://git.kernel.org/netdev/net/c/798f94603eb0
  - [net,8/8] e1000e: Reconfigure PLL clock gate timeout and re-enable K1 on Meteor Lake
    https://git.kernel.org/netdev/net/c/578294b8b60d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



