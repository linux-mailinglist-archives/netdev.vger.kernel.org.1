Return-Path: <netdev+bounces-298160-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MXzUMaTGKmpLwwMAu9opvQ
	(envelope-from <netdev+bounces-298160-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:31:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 132AB672B96
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:31:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IMXDoEX6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298160-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298160-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C19E1319BDD8
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 14:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500D726ED59;
	Thu, 11 Jun 2026 14:30:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555FCCA6B
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 14:30:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781188243; cv=none; b=i2r/WXj7cvdOFK+gUBPFZ2tBbcLEiQOxHjjjfV62ETEuTztxWhwIteINE2k5KhxceNiet37vuIi27YRGcEhNZdmpI5dWaON+5FgAcRILHEFSTLwa7GNu2WjQgQ3b9NvHdlZxe/neJL6EYzeTf8pc1w7Fa9CmdSahhalUe59dJ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781188243; c=relaxed/simple;
	bh=1pQHAjNMa3DKLEoaqvirsb540qyS/ijIEghIj9SK1Os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ArEwrhDVYT6w3LOI6aECsNFvTQ8RjCSg9M/pu74NjAd6n/Yz9raitQoFCClkoOlJUsCuYCuHUrUfIaq3cpjujFhcoI5ME35MgYJenL43OEstuzj7pKVun1NrqGpJDeTaWvwnWyiThC5luOsoqugGDkgjRkRJySyxCDPNcd08XLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMXDoEX6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BAD01F00893;
	Thu, 11 Jun 2026 14:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781188242;
	bh=KzOShb+oepXktIoWmG8bCkb+rLXb4XUjLJM0fydmB28=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IMXDoEX6VcWjlJwaSBOBDfr7qyHz8nI7/MFuoypwKah7ft6nohjz3yFzoeHlQ/K5l
	 8TMKGK2a/9/eNRaz3Zy7xeBmrHaZKxFwJLf2xifljUaS7y1zrxF3dbPnheBUVa/0nx
	 Qr2pHzvEEmpe2Q4upeUBDMei+UTzyYgP5LfO+b+OpIQGbmp5m/EPpO9mtWkBKAaVF1
	 F7Tzx1VNFWUuITh3k7QMXCOM5W9AsZydPF4aaa7V84y6TksE7hLF+gRMMJ5Z+us3Ra
	 OiUII/8EoGJWbO0uxRRwEuJPFSsRnIhnskRgw04qWUubXmDfgfM++9ncP8Xp4iGB35
	 zUYH5/0CLYS/Q==
Message-ID: <5d7f1438-4517-4fbb-8f21-18632c1efb1b@kernel.org>
Date: Thu, 11 Jun 2026 08:30:41 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net 2/2] net: fib_rules: Don't dump dying fib_rule in
 fib_rules_dump().
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@google.com>, Ido Schimmel <idosch@nvidia.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Amit Cohen <amcohen@nvidia.com>,
 Jiri Pirko <jiri@resnulli.us>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20260610061744.2030996-1-kuniyu@google.com>
 <20260610061744.2030996-3-kuniyu@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260610061744.2030996-3-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
	TAGGED_FROM(0.00)[bounces-298160-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:amcohen@nvidia.com,m:jiri@resnulli.us,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,resnulli.us,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 132AB672B96

On 6/10/26 12:17 AM, Kuniyuki Iwashima wrote:
> rocker_router_fib_event() calls fib_rule_get() during RCU dump.
> 
> If the fib_rule is dying, refcount_inc() will complain about it.
> 
> Let's call refcount_inc_not_zero() in fib_rules_dump().
> 
> Fixes: 5d7bfd141924 ("ipv4: fib_rules: Dump FIB rules when registering FIB notifier")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  include/net/fib_rules.h | 5 +++++
>  net/core/fib_rules.c    | 6 +++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



