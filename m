Return-Path: <netdev+bounces-265060-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oM03N3egq2kKfAEAu9opvQ
	(envelope-from <netdev+bounces-265060-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:50:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48835229FF8
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A61A304DEBD
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 03:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2292C08D0;
	Sat,  7 Mar 2026 03:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHWfPf4H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BE8CA5A;
	Sat,  7 Mar 2026 03:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772855410; cv=none; b=ed+OdJSfeEMzQTc+olivbaKRriO+fZJTYoT89StIcdhIAoFQNV5ogXwxclTqqur31RnTJ6CmwoVPhXBMCsk+C9wTW2FbNlWU9R/1IMfKIM2NDRnV5JjpE7XwaaCHKr6Do+hRYfg4jG69E/YxRh3opTz9UJu1QYceoYeJ99Ag4ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772855410; c=relaxed/simple;
	bh=p7EQiPGlxyBmjCH3g3gPtPkS1GF4dOhZ5LgBywc6bPg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hYkFA9GQNq2g7J3OusSaf4kwvs6Y7LK2OTDl9NOK4smIcVC+a9yvfi3hOxDqK2KWOtjvDp2HROumnGmCl3vzr1v6P2r3k0AzQSoRle+UpXC/sPZjKwl/1XgJP67bk+KvA/yUoGb9ZFxFMHxFkn3f56rbqvAHamPJox7kyew513s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHWfPf4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB73AC19422;
	Sat,  7 Mar 2026 03:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772855409;
	bh=p7EQiPGlxyBmjCH3g3gPtPkS1GF4dOhZ5LgBywc6bPg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bHWfPf4H0n2QDEQMOOcOTBi9o8erIKm9NK0sTTJHgr9GwCCvul7fwjhY+lTfJxePK
	 nCHDQZlrvmZMMPWLHXb3Q9OIdtfRWPz2seOJoNVZpf3y92s/ZXFUYGD/pH3XIuZDvD
	 8jsosbY39Sg13Tol7NyNQZXtyfnduZDD4SdNAzND6uUOdV5Tb4eHu5gKegbKUsAhc5
	 LmzeM4GxcOmcHYBPhVIp/VxPJVYLiqTZOLfT+xmrSelXyzJvIsR8mSPSo5RRGnDiGL
	 upmyVUYOIImyjYa26Kql9JL9m/HDlCPqRvGLGxnzKuJ7jAlRhdSPW93yauJ+VB38JL
	 4DW9/4PzDKpNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DBC3808200;
	Sat,  7 Mar 2026 03:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/6] selftests: net: fix false failures due to
 missing
 features and host interference
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177285540880.145254.2317239509731397843.git-patchwork-notify@kernel.org>
Date: Sat, 07 Mar 2026 03:50:08 +0000
References: <20260306000127.519064-1-aleksey.oladko@virtuozzo.com>
In-Reply-To: <20260306000127.519064-1-aleksey.oladko@virtuozzo.com>
To: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, aconole@redhat.com,
 imaximet@redhat.com, echaudro@redhat.com, sbrivio@redhat.com,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, dev@openvswitch.org
X-Rspamd-Queue-Id: 48835229FF8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265060-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.938];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ovs-dpctl.py:url]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Mar 2026 00:01:21 +0000 you wrote:
> Hi,
> 
> This series addresses several issues in the networking kselftests
> that cause false-positive failures depending on the host environment,
> kernel configuration, or library versions.
> 
> The main focus of these changes is to isolate tests from the host
> environment (using namespaces) and to ensure proper fallback or
> skipping when dependencies are missing.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/6] selftests: net: fib_tests: skip rp_filter test if cls_basic is unavailable
    (no matching commit)
  - [net,v3,2/6] selftests: net: make ovs-dpctl.py fail when pyroute2 is unsupported
    https://git.kernel.org/netdev/net-next/c/0bcac7b11262
  - [net,v3,3/6] selftests: net: run reuseport tests in netns to avoid port conflicts
    (no matching commit)
  - [net,v3,4/6] selftests: net: rename pmtu.sh to pmtu-test.sh
    (no matching commit)
  - [net,v3,5/6] selftests: net: run pmtu.sh in netns to avoid host firewall interference
    (no matching commit)
  - [net,v3,6/6] selftests: net: io_uring_zerocopy: enable io_uring for the test
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



