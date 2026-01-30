Return-Path: <netdev+bounces-254970-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Mmz0KG0RfGmiKQIAu9opvQ
	(envelope-from <netdev+bounces-254970-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:03:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FE5B651B
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1497C300EAA0
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 02:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6402512DE;
	Fri, 30 Jan 2026 02:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jn5f+QcU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7A91DE8AD
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 02:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769738602; cv=none; b=ikdRZgQGtaMCQTpp5kUM5UHgudHZDS6aVSOXB7SZfvvt94azYQz+HAtOI4cMuQdicfm79v1XiCOflFIbiG6uj+HZRPdrX3Syt9U/5NqtPpJuMwEBTbNgsfmj/1xvVdbuezNQTkBG9pPch2m5TrzJ2Xs8zgjpuR6AdoSNW9afQXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769738602; c=relaxed/simple;
	bh=cNOqiT4D/FdF9TjSY18T66fyd9g4JgwbUe9kEhdtbAs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SMokcWDX7AUVD6/Cmnggo21usNZzWqD/QSsrKPN/okLnDLcJHERIGF84c9MzGrtt4Bdbj8GpCn61LvXd1UYY3sPXGnsVvA5GoJ6b5NENMhsG6QVkOhdaNFnqO3Q3dwzNB7LebM4rQ0AjUzz24Np+gyyRptG8GPSoh+oaxf0Rt3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jn5f+QcU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EE9C4CEF7;
	Fri, 30 Jan 2026 02:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769738602;
	bh=cNOqiT4D/FdF9TjSY18T66fyd9g4JgwbUe9kEhdtbAs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jn5f+QcUyknDgJGIAkfvDaA7ydAj6v+Xb8fO4lUSqfHvh6/2bMwBZYkmfB6/l97Ys
	 umlK7iJ+vHMkizmN1bK3zEvPS/STDShE9TTX3lf1Y+jDJ+CtnpwOrE/SewcVjl1IcL
	 ms2ob2ecTEr5lEY+wqYLKrPLQNEU/03YMbJr4Lt5lcBDrON7Hc6BIiP+DMdpbygcDP
	 5BofztPmak9oiE7MGX0UatZ8cc9DHTyGV+x9vt0as4KsJ5VEEicYJCh9a0N0GTw8lx
	 s+9AaePdEo6ZRRarny/FWWvyR+fGLYgBoE08u5YQF0d/h5S29+4tr+BlCKf7+h3zHz
	 nq5LPxgrs+w0Q==
Date: Thu, 29 Jan 2026 18:03:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net 4/4] selftests: drv-net: rss_ctx: test RSS contexts
 persist after ifdown/up
Message-ID: <20260129180320.1c69a0c4@kernel.org>
In-Reply-To: <20260129061646.1417185-5-michael.chan@broadcom.com>
References: <20260129061646.1417185-1-michael.chan@broadcom.com>
	<20260129061646.1417185-5-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254970-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rss_ctx.py:url]
X-Rspamd-Queue-Id: E9FE5B651B
X-Rspamd-Action: no action

On Wed, 28 Jan 2026 22:16:46 -0800 Michael Chan wrote:
> From: Pavan Chebbi <pavan.chebbi@broadcom.com>
> 
> Add tests to verify
> 1. that RSS contexts persist across interface down/up
> 2. that RSS contexts persist across interface down/up along
> with their associated Ntuple fitlers
> 
> Testing on bnxt_en:
> 
>  TAP version 13
>  1..1
>  # timeout set to 0
>  # selftests: drivers/net/hw: rss_ctx.py
>  # TAP version 13
>  # 1..2
>  # ok 1 rss_ctx.test_rss_context_persist_ifupdown
>  # ok 2 rss_ctx.test_rss_context_ntuple_persist_ifupdown
>  # # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
>  ok 1 selftests: drivers/net/hw: rss_ctx.py

Thanks for the test. Please make sure that

  ruff check $file

is clean

> diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
> index ed7e405682f0..4e46c5931c7f 100755
> --- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
> +++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
> @@ -809,6 +809,119 @@ def test_rss_default_context_rule(cfg):
>                            'noise' : (0, 1) })
>  
>  

Please put

@ksft_disruptive

decorator before test cases which may disconnect the machine (take the
link down). We won't be able to run them remotely 

> +def test_rss_context_persist_ifupdown(cfg):
> +    """
> +    Check that RSS contexts persist across an interface down/up cycle.
> +    """
> +
> +    require_context_cnt(cfg, 10)

Why 10? I don't think we're gaining any coverage with > 2.

> +    # Create 10 RSS contexts and store their IDs and configurations
> +    ctx_ids = []
> +    ctx_configs_before = {}

appears unused

> +    try:
> +        for i in range(10):
> +            ctx_id = ethtool_create(cfg, "-X", "context new")
> +            ctx_ids.append(ctx_id)
> +            defer(ethtool, f"-X {cfg.ifname} context {ctx_id} delete")
> +    except CmdExitFailure:
> +        raise KsftSkipEx(f"Could only create {len(ctx_ids)} contexts, test requires 10")
> +
> +    # Bring interface down

these comments are pointless and make the whole thing look AI generated

> +    ip(f"link set dev {cfg.ifname} down")
> +
> +    # Bring interface back up
> +    ip(f"link set dev {cfg.ifname} up")
> +
> +    # Wait for interface to be fully up
> +    cfg.wait_hw_stats_settle()

Why?

> +    # Verify all 10 contexts still exist after ifup
> +    missing_contexts = []
> +    persisted_contexts = []
> +
> +    for ctx_id in ctx_ids:
> +        try:
> +            data = get_rss(cfg, context=ctx_id)
> +            _rss_key_check(cfg, data=data, context=ctx_id)
> +            persisted_contexts.append(ctx_id)
> +        except CmdExitFailure:
> +            missing_contexts.append(ctx_id)
> +            ksft_pr(f"Context {ctx_id} is missing after ifup")

You can use netlink to get them all

ctxs = cfg.ethnl.rss_get({}, dump=True)

> +def test_rss_context_ntuple_persist_ifupdown(cfg):
> +    """
> +    Test that RSS contexts and their associated ntuple filters persist across
> +    an interface down/up cycle.
> +    """
> +
> +    require_ntuple(cfg)
> +    require_context_cnt(cfg, 10)
> +
> +    # Create 10 RSS contexts with ntuple filters
> +    ctx_ids = []
> +    ntuple_ids = []
> +    ports = []
> +
> +    try:
> +        for i in range(10):
> +            # Create RSS context
> +            ctx_id = ethtool_create(cfg, "-X", "context new")
> +            ctx_ids.append(ctx_id)
> +            defer(ethtool, f"-X {cfg.ifname} context {ctx_id} delete")
> +
> +            # Create ntuple filter for this context
> +            port = rand_port()
> +            ports.append(port)
> +            flow = f"flow-type tcp{cfg.addr_ipver} dst-ip {cfg.addr} dst-port {port} context {ctx_id}"
> +            ntuple_id = ethtool_create(cfg, "-N", flow)
> +            ntuple_ids.append(ntuple_id)
> +            defer(ethtool, f"-N {cfg.ifname} delete {ntuple_id}")
> +
> +    except CmdExitFailure:
> +        raise KsftSkipEx(f"Could only create {len(ctx_ids)} contexts with ntuple filters, test requires 10")
> +
> +    # Bring interface down
> +    ip(f"link set dev {cfg.ifname} down")
> +
> +    # Bring interface back up
> +    ip(f"link set dev {cfg.ifname} up")
> +
> +    # Wait for interface to be fully up
> +    cfg.wait_hw_stats_settle()
> +
> +    # Verify all contexts and ntuple rules still exist after ifup
> +    missing_contexts = []
> +    persisted_contexts = []
> +    missing_ntuple_rules = []
> +    persisted_ntuple_rules = []
> +    broken_associations = []
> +
> +    for i, ctx_id in enumerate(ctx_ids):
> +        # Check if context persists
> +        try:
> +            data = get_rss(cfg, context=ctx_id)
> +            _rss_key_check(cfg, data=data, context=ctx_id)
> +            persisted_contexts.append(ctx_id)
> +        except CmdExitFailure:
> +            missing_contexts.append(ctx_id)
> +            ksft_pr(f"Context {ctx_id} is missing after ifup")
> +            continue
> +
> +        # Check if ntuple rule persists
> +        ntuple_id = ntuple_ids[i]
> +        try:
> +            _ntuple_rule_check(cfg, ntuple_id, ctx_id)
> +            persisted_ntuple_rules.append(ntuple_id)
> +        except CmdExitFailure:
> +            missing_ntuple_rules.append(ntuple_id)
> +            ksft_pr(f"Ntuple rule {ntuple_id} is missing after ifup")
> +        except Exception as e:
> +            broken_associations.append((ntuple_id, ctx_id))
> +            ksft_pr(f"Ntuple rule {ntuple_id} exists but is not properly associated with context {ctx_id}: {e}")

Not sure why this is a separate test, TBH. You can remove the test
without the ntuple filters. The two cases I would have expected based
on patches is:

tests1:
 - add a couple of contexts
 - add a n-tuple filter to one of the context
 - ifdown/ifup
 - check contexts and filters are there
 - run some traffic to make sure it flows right

tests2:
 - ifdown
 - add a couple of contexts
 - add a n-tuple filter to one of the context
 - ifup
 - check contexts and filters are there
 - run some traffic to make sure it flows right

You can probably have one shared implementation and pass a param to 
it  to tell it whether to "pre-down" the interface.
-- 
pw-bot: cr

