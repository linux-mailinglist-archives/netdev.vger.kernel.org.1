Return-Path: <netdev+bounces-267618-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPniLoWLtGlUpgAAu9opvQ
	(envelope-from <netdev+bounces-267618-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 23:11:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE2C28A474
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 23:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B5BDF301FB83
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 22:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871D231E82D;
	Fri, 13 Mar 2026 22:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2aTGTkx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EE530EF8B
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 22:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773439875; cv=none; b=l3XPGU9zs7JOKKWUDHVMQcQfmeRgZ+ixPoAYJGFJ/IeMhPMLipMje8aRuvG0uBqBdtxc6kWDUHXm4EUILJjMQxEyVxGXoIZW13IjwjQmZly/AneE2DnEjkDvs7uAUHoqgsVlHSp5PV8k0Mn2EH7l5sbW3GH1LX9fVBsP4hD+M4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773439875; c=relaxed/simple;
	bh=PKuIGfNiXvE8waOg9A1gvR2xR02zXM5dfhgbZgNOPU0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eh+TxL+IWMhJjZ7ju9BcX8ZrOVWtH2eQDRCmdUlNtrMwa7xz5rz32Mk1SmFuZ37q57egANaPeR0IVC4IcG//z+rDEPZ5304AmpYZCLKItRQ2YvAF/hToB+lOLX8+P01x3J6DIWvM7vTeWJWIkcCfL6IuRIwLDUr+65EYxfrWduw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2aTGTkx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9535EC19421;
	Fri, 13 Mar 2026 22:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773439875;
	bh=PKuIGfNiXvE8waOg9A1gvR2xR02zXM5dfhgbZgNOPU0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R2aTGTkxTE3IhRqX2pUFJaXa6dWcJeB7VOOpy3cmvr0UX89U1WtdZaU01T7EiISB1
	 ev2bBYfzKxSP+7QOYJUr1g0sdCjK/ejWLEff7Ws4x31ycLqWemIxNySkd7djRmracM
	 qoM5ULnQ8bxmey5Pu0QfDte4XTBEW3xUVxy02JwzhJf6EB3jDZWBo5jOBdo3h8gqI6
	 zgMvUMEhbL1P3tHK+LCQDSW3pDh4Khmn9oiio+d3NHWAo5rHOq6t/TvrXzWgDnuSJd
	 ICqY0Ul79t/RAMtFt9NGorXX7gGtEuDEmiepX1nOLZ2tq/Hf1AH4gqGFRHbWucSjuY
	 IQ97Kp7vd25Pg==
Date: Fri, 13 Mar 2026 15:11:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Davide Caratti <dcaratti@redhat.com>, Victor Nogueira
 <victor@mojatatu.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko
 <jiri@resnulli.us>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/3] netdevsim: support ETS offload
Message-ID: <20260313151113.4b405c8f@kernel.org>
In-Reply-To: <cover.1773411667.git.dcaratti@redhat.com>
References: <cover.1773411667.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267618-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5DE2C28A474
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 13 Mar 2026 18:23:55 +0100 Davide Caratti wrote:
>  - patch 1 moves netdevsim tc offloads to a dedicated file
>  - patch 2 enables ETS offload on netdevsim
>  - patch 3 is a tdc test for ets offload on netdevsim

Looks like this is failing in TC CI
Is it possible that the system / container doesn't have ethtool
installed?  Adding Victor

I'll drop this from PW for now LMK if it's a TDC thing I'll restore 
it once fixed.

#  -- ns/SubPlugin.__init__
#  -- scapy/SubPlugin.__init__
# Executing 1174 tests in parallel and 88 in serial
# Using 38 batches and 4 workers
# WARNING: No route found (no default route?)
# WARNING: No route found (no default route?)
# .WARNING: more No route found (no default route?)
# ...................
# -----> prepare stage *** Could not execute: "ethtool -K $ETH hw-tc-offload on"
# 
# -----> prepare stage *** Error message: "exec of "ethtool" failed: No such file or directory
# "
# 
# -----> prepare stage *** Aborting test run.
# 
# 
# <_io.BufferedReader name=6> *** stdout ***
# 
# 
# <_io.BufferedReader name=17> *** stderr ***
#   File "/nipa-data/kernel/tools/testing/selftests/tc-testing/./tdc.py", line 535, in test_runner
#     res = run_one_test(pm, args, index, tidx)
#           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/nipa-data/kernel/tools/testing/selftests/tc-testing/./tdc.py", line 419, in run_one_test
#     prepare_env(tidx, args, pm, 'setup', "-----> prepare stage", tidx["setup"])
#   File "/nipa-data/kernel/tools/testing/selftests/tc-testing/./tdc.py", line 267, in prepare_env
#     raise PluginMgrTestFail(
# ..........Test b438: Add basic filter with canid ematch and a combination of SFF/EFF with masks
# Test 0811: Add multiple basic filter with cmp ematch u8/link layer and default action and dump them

