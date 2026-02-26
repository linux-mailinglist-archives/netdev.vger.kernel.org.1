Return-Path: <netdev+bounces-261512-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEAvMKiIoGlvkgQAu9opvQ
	(envelope-from <netdev+bounces-261512-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:53:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3121B1ACF7D
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D94B30D0539
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 17:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B6B3290A0;
	Thu, 26 Feb 2026 17:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sz7o48WH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8282C368949;
	Thu, 26 Feb 2026 17:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772126383; cv=none; b=fbiU8LzqZk9S+Rv6gCqz88xcp523yBswzbOwYbwWcN94KkgJJTiAHoK5rcbY98DW6g0lQNcCXGn0WBfyqRVlnRvCTyTFC75qQU4LIsZ8ElY3AJZq8wtmMeupHQWx8hn6tkqGNPwwbLwjAg4DrpINntVuE+PRPQDqwlQKv6TgQBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772126383; c=relaxed/simple;
	bh=bzstsHSVl5WjALw7IilqH0FRCA+44iZZUUaFAwF7Kno=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S9MHzpwe/10QM46F/dZYbRcKR84l+Iwzc91ATqDEA/r3XFG2G98vxNaTGKKKQXt4tXjRFa4XID2B45M2WLt5a7GOXa8sXGHSRqInnG4cYvP9HUA77mcO7JibKIot+ymYNAdYFWaGpVjjFGuEz9v2zR4AXWTY7cx8IFyjj3uWrYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sz7o48WH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD51DC116C6;
	Thu, 26 Feb 2026 17:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772126383;
	bh=bzstsHSVl5WjALw7IilqH0FRCA+44iZZUUaFAwF7Kno=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Sz7o48WHvJGwqWpLTd2ri62p4gDmT7P2ze1DFmHyVuXWXIlXIUZdKyVvLCLr+QgxY
	 HY9lLhQxB80iruHws9zPCKjsCMFn3zzHlQGumgO0p5Y2JlaWoVoY/7p+jF0EP/SFZA
	 h5NWLHQN0/JViEOboiZ/emVUcTDcP+huzvcaf/LbIjAChe3BbZ2u6aM8upTQ7na5EB
	 E1QLSUSjHX9Xla4Tl8CrxvKzEiPuwwr6S88sQvRuiM5m38zAyZxQSfdZiInrPS2fXa
	 /lNxhxvxO6ghH1Gws2ing2Z5URN+IlUVYEShpuZ23+wEuCT3NX0CL6aOEOV8HRyK+A
	 YP9bFRPrGQUHg==
Date: Thu, 26 Feb 2026 09:19:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, horms@kernel.org, pabeni@redhat.com, edumazet@google.com,
 davem@davemloft.net
Subject: Re: [PATCH net-next v2] selftests: net: add ipv6 RA route to ECMP
 merge test
Message-ID: <20260226091941.6688b4a0@kernel.org>
In-Reply-To: <20260226120237.5352-1-fmancera@suse.de>
References: <20260226120237.5352-1-fmancera@suse.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-261512-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3121B1ACF7D
X-Rspamd-Action: no action

On Thu, 26 Feb 2026 13:02:37 +0100 Fernando Fernandez Mancera wrote:
> As commit bbf4a17ad9ff ("ipv6: Fix ECMP sibling count mismatch when
> clearing RTF_ADDRCONF") pointed out, RA routes are not elegible for ECMP
> merging.
> 
> Add a test scenario mixing RA and static routes with gateway to check
> that they are not getting merged.
> 
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
> v2: added CONFIG_IPV6_ROUTE_INFO to the config

Same thing:

# 96.88 [+0.01] sysctl: cannot stat /proc/sys/net/ipv6/conf/veth1/accept_ra_rt_info_max_plen: No such file or directory

Config:
https://netdev-ctrl.bots.linux.dev/logs/vmksft/net-dbg/results/535301/config
looks like you're missing a dependency (IPV6_ROUTER_PREF)

Please do try to build a kernel to make sure the config options stick,
before posting v3. More instructions FWIW
https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style
-- 
pw-bot: cr

