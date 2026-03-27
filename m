Return-Path: <netdev+bounces-272511-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHD0BzxrxmmkJwUAu9opvQ
	(envelope-from <netdev+bounces-272511-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:34:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5D6343878
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0133B300E595
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 11:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA44315D40;
	Fri, 27 Mar 2026 11:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMbUrHBy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993AA3537C5;
	Fri, 27 Mar 2026 11:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774611257; cv=none; b=eaZI+YYcW3xslDgWiAZJziUrL6u1ozyfYzJe3oqAOD29EulMzsG4iQWIrjQnxztnLqCLjyBUsUPkBFn6lyUHGEWHlDF4TxiwTRxgIQEM75vKqHess/aDrar3TdRjjx2pez17ws4B5tBv7pBvwPr5E7UN5mID6ZT+Juu6k9tu110=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774611257; c=relaxed/simple;
	bh=WR8BDpAV82QZnrPWyOwCxs5EorLHQHTEonZ5+TQwu24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bj+kZe+Idm6R3+94ZMEPN7B/arh7htEqipjC/6HGlGLfyyz+C+j+bunx2Z2zcN517Nu/MatzHIWBnYrhy55AeQZDhYF+BJUiWfWqvTW1FaWnPx4PrtV6s4jtn4OdyznkGXREOPSQkj2aLjwFxNY9Q2FTN3hVjuJuVE2iRVqftHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMbUrHBy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A687C19423;
	Fri, 27 Mar 2026 11:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774611257;
	bh=WR8BDpAV82QZnrPWyOwCxs5EorLHQHTEonZ5+TQwu24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pMbUrHByB/UZb8gRp5lGYzL3VP2iyEn1M1YnWR8VM69HxamZcuxvY9ypowCcfDVaN
	 U2a14LeL+VKGWftyTCN6kqh0lL/7RqXzsPTzyBOTyi2XlzSlaUSQrUneNjGJsGjg5K
	 eMqrvrncXvBZIwrU9Fv2c3bDfYXNITlmopGOQ8M/ACXVU7osPRIiV9SbwdobsD/mll
	 Rfko5QWJn+tcC83ceZJOEwmpYsbJfE/s9Q7gezbieX/MOmJdR4fDciTr/aQ9Bhmzpg
	 S+ufzogq/0JNZ8Qk4XwhPio0kxLoYhdGh1mVVYfB/4t1kquL3yeEb/J7Dun4LBVveY
	 g6fQhbWzthtdw==
Date: Fri, 27 Mar 2026 11:34:12 +0000
From: Simon Horman <horms@kernel.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, razor@blackwall.org,
	idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, bestswngs@gmail.com
Subject: Re: [PATCH net] bridge: mrp: reject zero test interval to avoid OOM
 panic
Message-ID: <20260327113412.GD567789@horms.kernel.org>
References: <20260326032438.3307549-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326032438.3307549-1-xmei5@asu.edu>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,blackwall.org,nvidia.com,davemloft.net,google.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-272511-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F5D6343878
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 08:24:38PM -0700, Xiang Mei wrote:
> br_mrp_start_test() and br_mrp_start_in_test() accept the user-supplied
> interval value from netlink without validation. When interval is 0,
> usecs_to_jiffies(0) yields 0, causing the delayed work
> (br_mrp_test_work_expired / br_mrp_in_test_work_expired) to reschedule
> itself with zero delay. This creates a tight loop on system_percpu_wq
> that allocates and transmits MRP test frames at maximum rate, exhausting
> all system memory and causing a kernel panic via OOM deadlock.

I would suspect the primary outcome of this problem is high CPU consumption
rather than memory exhaustion. Is there a reason to expect that
the transmitted fames can't be consumed as fast as they are created?

> 
> The same zero-interval issue applies to br_mrp_start_in_test_parse()
> for interconnect test frames.
> 
> Use NLA_POLICY_MIN(NLA_U32, 1) in the nla_policy tables for both
> IFLA_BRIDGE_MRP_START_TEST_INTERVAL and
> IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL, so zero is rejected at the
> netlink attribute parsing layer before the value ever reaches the
> workqueue scheduling code. This is consistent with how other bridge
> subsystems (br_fdb, br_mst) enforce range constraints on netlink
> attributes.
> 
> Fixes: 7ab1748e4ce6 ("bridge: mrp: Extend MRP netlink interface for configuring MRP interconnect")

I think you also want

Fixes: 20f6a05ef635 ("bridge: mrp: Rework the MRP netlink interface")

As highlighted by AI review.

> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

...

