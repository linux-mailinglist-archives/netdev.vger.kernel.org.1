Return-Path: <netdev+bounces-298392-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Wy7EHhQ8K2om4wMAu9opvQ
	(envelope-from <netdev+bounces-298392-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 00:52:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E65F1675B52
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 00:52:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=U+8Zpfru;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298392-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298392-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7445F316B4B7
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137284D8DBA;
	Thu, 11 Jun 2026 22:50:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A792D4C77A9;
	Thu, 11 Jun 2026 22:50:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781218237; cv=none; b=GDMMkTXT2YgVjRtTzeS1HYzMi1ZC3OGHTTYqm3i2NFRb2JEwv+i1FnchCS2pfOOhHVFmCSZGO90q4OT3s6fI/2lRSnXro7Dce2LCPNH5b1Jw9PzHhe0JdFNdo/7oIp21i+IE+rCVCdCgAQOZIMlTuTBQ+FHX8VmiWXRU0+1TRTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781218237; c=relaxed/simple;
	bh=bobSTNL/feNbcfBK8iQXiNhaecHF18/a0GoVzUhWMKM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Iy5x/JOa5gVndypj2TXD95UebNR8dPwZrnNUAKf1g4ZfCgkRuaLNVdW9Zbxt03FyD8hNPdv6OpQ4Vuf3gobH8wtWoJNQtY3a7jQpBGhOb3Ize0R4NdEYwAn6UvLkAL7BDXsJQ8xodjXLXW13ruytrp5txcIVAbo1N1FnXJuiENs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+8Zpfru; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6181F00A3D;
	Thu, 11 Jun 2026 22:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781218235;
	bh=nXdfG7nH/Ru5QlkAW0W9jpNdIe9I0cWwOaA3rKNymnk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=U+8ZpfrueBZqRDziUbIJ072++PAOtdByLPykKuKm4TW0X3HFJ6ssSFYVbmxFs7ebL
	 RRj/uD/7tOhoza7ksWQcSoliNMcYdUQik4gN+PbfivmdeWyrWOa1f2gJWmT35rw2cd
	 wBbHpqH+xLr/0h9MVuqNKtvEpfKNRai3WHZNfWQJM0qtU6ioNkzdXHHSzY8asrHRua
	 KM9o4kOSKg3ivgliIH44GTHCr2ZIcm2tUHAiB5wTksA8kuWAlJyHk6vrahLl/wAACO
	 Y33wmUxK5HqG+lizlSL3g8rWevt85/j9bDldEwogl4r0ckoCwW7/TOHlSRhDQyPdxJ
	 rAvozCPIV14aQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B143930FB3;
	Thu, 11 Jun 2026 22:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] selftests/net/openvswitch: add flow modify
 test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178121823239.394849.414676223815974792.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 22:50:32 +0000
References: <20260609165725.107484-1-houminxi@gmail.com>
In-Reply-To: <20260609165725.107484-1-houminxi@gmail.com>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
 i.maximets@ovn.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 dev@openvswitch.org, linux-kselftest@vger.kernel.org, amorenoz@redhat.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298392-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS(0.00)[m:houminxi@gmail.com,m:netdev@vger.kernel.org,m:aconole@redhat.com,m:echaudro@redhat.com,m:i.maximets@ovn.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:dev@openvswitch.org,m:linux-kselftest@vger.kernel.org,m:amorenoz@redhat.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E65F1675B52

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jun 2026 00:57:25 +0800 you wrote:
> Add mod_flow() and the mod-flow CLI command to ovs-dpctl.py, exercising
> OVS_FLOW_CMD_SET. Add test_flow_set which first modifies an existing
> flow with new actions and verifies the change via traffic, then modifies
> the same flow without actions and verifies the kernel handles the
> no-actions case gracefully.
> 
> The no-actions path is unreachable from userspace OVS tools (dpctl
> mod-flow requires actions) but reachable via raw netlink. This is the
> code path where Adrian Moreno found a possible kfree_skb of ERR_PTR
> when reply allocation fails after locking.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] selftests/net/openvswitch: add flow modify test
    https://git.kernel.org/netdev/net-next/c/3e9201e4fe8b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



