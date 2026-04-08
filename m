Return-Path: <netdev+bounces-276696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPuELsCs1mmZHAgAu9opvQ
	(envelope-from <netdev+bounces-276696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 21:30:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 426C03C3157
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 21:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAE543091C9B
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 19:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E02C3D523F;
	Wed,  8 Apr 2026 19:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ql6grjlV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFF334D3A9
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 19:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775676167; cv=none; b=n57anVHgCtCA5ZsLYWJqQ3ETc1njV4sWs16vsslJD75+CJqdBnDwhHYtsqoVGDr1v8nLLfdmPJEL0I+Y91XGLbNB7OoQHE6Lc3Zh2TEgvOF75e7ecYKpRG+YKliv065oVgzAEAujPHwi+esKThnsnmUxHYoTLsn8PEZ7cYU0jcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775676167; c=relaxed/simple;
	bh=FOGDadXlBxdlXCoO3c6S0SumyHhWL9dtjdG9AXbZ6uI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tq9aDVw3hRaIjjN5cfvhCQLfMoBe2I/BXsdTdIOsdbEd+teRCSwBNDreqGgRbTYYXT2Lv9QrZJewbY36n3M4VS3G5KbUZSeTw8bsxRDhW27+Yynt6Bupm+1T0eoClSVipNeCtgmEOA4RWpleG38tWAG1Rv6kA0KoYWM4CbU5m0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ql6grjlV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D08CC19421;
	Wed,  8 Apr 2026 19:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775676166;
	bh=FOGDadXlBxdlXCoO3c6S0SumyHhWL9dtjdG9AXbZ6uI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ql6grjlVa/4olc1mRkeAy2QJZrG/Q6ehdCvbcVmGw1Lw8Jyz3PITerQOGNTNQaB9X
	 Ict/6IGztowjdxG4oGShA7tGPE8t3C+ZQoVER3TM5JD4/gyBvUySnIG39dqZ6oTw1F
	 oGQyqNYHNiFv517QjZdwRXx89tPm/SvNfi0WjZc3lBfukNH0EQ9fFB/7ccLQKDDcv+
	 F5IX9RJkXC9nUXXPylzkJJIm0iYAxg8Qa7Dn/uon5PvLJ3FBYaBYNQq0FPNUIQd8+h
	 lzu7dCxK0j6fffhPZJOTydai7mbQN1yYH1XyMMd/fr6V+iNKckGZt51FROe1p2nf5E
	 DcYF+IJonCrsA==
Message-ID: <36618554-367d-4b01-a4f5-6a183abaf918@kernel.org>
Date: Wed, 8 Apr 2026 13:22:45 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv4: nexthop: update has_v4 flag for any family
 change in replace_nexthop_single()
Content-Language: en-US
To: Xiang Mei <xmei5@asu.edu>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, idosch@nvidia.com, bestswngs@gmail.com
References: <20260408182850.2618488-1-xmei5@asu.edu>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260408182850.2618488-1-xmei5@asu.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-276696-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 426C03C3157
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/8/26 12:28 PM, Xiang Mei wrote:
> When a nexthop within a group is replaced, nh_group_v4_update() is only
> called when the old nexthop is AF_INET and the new one is AF_INET6. The
> reverse direction (AF_INET6 to AF_INET) is not handled, leaving the
> group's has_v4 flag stale at false.
> 
> This causes fib6_check_nexthop() to incorrectly accept an IPv6 route
> referencing a group that now contains an AF_INET nexthop. During route
> lookup, nexthop_fib6_nh() returns NULL for the AF_INET nexthop and the
> subsequent dereference in rt6_find_cached_rt() crashes with a general
> protection fault:
> 

...

> 
> Fix by calling nh_group_v4_update() whenever the old and new nexthops
> have different address families, not just for AF_INET to AF_INET6.
> Using a general inequality is safe here: individual nexthops can only
> be AF_INET or AF_INET6 (enforced at parse time), so the only family
> transitions possible are between these two, and nh_group_v4_update()
> is a full rescan that always produces the correct has_v4 value.
> 

please add a test to tools/testing/selftests/net/fib_nexthops.sh
covering this use case.


