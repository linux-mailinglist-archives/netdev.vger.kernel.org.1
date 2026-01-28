Return-Path: <netdev+bounces-254078-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOy0BSl4eWkSxQEAu9opvQ
	(envelope-from <netdev+bounces-254078-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:44:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4F49C628
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 26D8C3006933
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 02:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFCC2BF001;
	Wed, 28 Jan 2026 02:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMd74uBu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C8229B8DB;
	Wed, 28 Jan 2026 02:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769568290; cv=none; b=R7IOUDhgcEQoYZifdn7rqi/gXpENZWO9/NTzUu3CFn1YHG6FyrvBCnrRrF/zoinA2HUXx2FR+P4Xfqp6S0sw+szp9u3+O+Nu1LNfbr4mrpR6qF6lkNNjeNqxMf0R8Gu6aB1mcO4U1YAQim9caJx0t30NiASaYsmi4YNV3+WwqJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769568290; c=relaxed/simple;
	bh=QI4eswQrEkadHsXfTL8PxZRa+DYKd57x62u0Yj8uH8c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PfPhwl1qYoSaRqTYWi6ShUHd+VMjtvysPqTUhZRBckcGO+FxAutwi1rRxg9Sw07otK9NOcxVEvF120WuUZmAj8ePldVeCsE8cq/v+ZVw9fLykJNoz3Hy3Pl4qAYBiwU4tWTzO3DgBf8AMbK+1g7fpvJ1ct3zX7IBJ8p9NOVwXYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMd74uBu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06E2C116C6;
	Wed, 28 Jan 2026 02:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769568290;
	bh=QI4eswQrEkadHsXfTL8PxZRa+DYKd57x62u0Yj8uH8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HMd74uBuf5bN0n4U/rfjpjS/v17wlub0COHTcgH1Q/h8ogrPIgvsP2NpJXoyP89Y3
	 zm4xRLfGcjVnj5LaQIFBJ/Wwwz+hR5KrcuwXaQNaVrtcGwyOasSH86SXqEt7iDDL+F
	 7sulgKKzY6JcAFrrvkXdFB0UZytQ868zY1jhcmeW2BUJpIXy9B+QRKNphMPXyOkgik
	 Pv27KHBaSlq/tvj4Ttaisd2L8i8FN33gVlLZEP7GiPkOnI9P+rQfxDOYunQ/lg4OqR
	 X1Q676fu8WQPar615rwUhwGpzrDdHxQFOuqdLsyAjDhaQ7WpUl7J6k15pF7/L2G4FD
	 fLbnQD8c6edhg==
Date: Tue, 27 Jan 2026 18:44:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Aaron Conole
 <aconole@redhat.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] selftests: net: fix false failures due to
 missing features and host interference
Message-ID: <20260127184448.2976475f@kernel.org>
In-Reply-To: <20260127225134.304362-1-aleksey.oladko@virtuozzo.com>
References: <20260127225134.304362-1-aleksey.oladko@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-254078-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,pmtu.sh:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F4F49C628
X-Rspamd-Action: no action

On Tue, 27 Jan 2026 22:51:29 +0000 Aleksei Oladko wrote:
> This series addresses several issues in the networking kselftests
> that cause false-positive failures depending on the host environment,
> kernel configuration, or library versions.
> 
> The main focus of these changes is to isolate tests from the host
> environment (using namespaces) and to ensure proper fallback or
> skipping when dependencies are missing.
> 
> Summary of changes:
> 1. Adds a check for cls_basic module in fib_tests. Without this
>    module, the test fails when attempting to add tc rules instead
>    of skipping.
> 2. Fixes ovs-dpctl.py to return a non-zero exit code when pyroute2
>    is too old. This allows pmtu.sh to correctly fall back to ovs-vsctl
>    instead of assuming the configuration was successful.
> 3,4. Move reuseport and pmtu.sh tests info dedicated network namespaces.
>    This prevents failures caused by port conflicts with host processes
>    or interference from host firewall rules.
> 5. Ensures io_uring is enabled via sysctl before running io_uring_zerocopy
>    test, preventing failures on systems where kernel.io_uring_disabled
>    is set.

Something in this series breaks the pmtu test for us in the CI:

# 64.84 [+2.54] TEST: IPv6, bridged geneve6: PMTU exceptions - nexthop objects      [ OK ]
# 65.73 [+0.89]   ovs_bridge not supported
# 65.73 [+0.00] TEST: IPv4, OVS vxlan4: PMTU exceptions                             [SKIP]
# 67.20 [+1.47]   ovs_bridge not supported
# 67.20 [+0.00] TEST: IPv6, OVS vxlan4: PMTU exceptions                             [SKIP]
# 68.66 [+1.45]   ovs_bridge not supported
# 68.66 [+0.00] TEST: IPv4, OVS vxlan6: PMTU exceptions                             [SKIP]
# 70.11 [+1.45]   ovs_bridge not supported
# 70.11 [+0.00] TEST: IPv6, OVS vxlan6: PMTU exceptions                             [SKIP]
# 71.57 [+1.45]   ovs_bridge not supported
# 71.57 [+0.00] TEST: IPv4, OVS geneve4: PMTU exceptions                            [SKIP]
# 73.01 [+1.44]   ovs_bridge not supported
# 73.01 [+0.00] TEST: IPv6, OVS geneve4: PMTU exceptions                            [SKIP]
# 74.46 [+1.45]   ovs_bridge not supported
# 74.46 [+0.00] TEST: IPv4, OVS geneve6: PMTU exceptions                            [SKIP]
# 75.92 [+1.46]   ovs_bridge not supported
# 75.93 [+0.00] TEST: IPv6, OVS geneve6: PMTU exceptions                            [SKIP]

https://netdev-ctrl.bots.linux.dev/logs/vmksft/net/results/492641/137-pmtu-wrapper-sh/stdout

It was fine before:

https://netdev-ctrl.bots.linux.dev/logs/vmksft/net-dbg/results/492461/6-pmtu-sh/stdout

Since this is a bash test there are of course no logs to go by.. :/

I tried running 
 python tools/testing/selftests/net/openvswitch/ovs-dpctl.py add-dp br0
in a netns and that works just fine. 

No idea what's going on..

