Return-Path: <netdev+bounces-301213-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EC5zEhe0OWoFwgcAu9opvQ
	(envelope-from <netdev+bounces-301213-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 00:15:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF756B295A
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 00:15:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kJhqYeJ8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301213-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301213-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BB0A3012EA4
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 22:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15103438A8;
	Mon, 22 Jun 2026 22:15:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5F057C9F
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 22:15:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782166547; cv=none; b=I4oUxnXEilMeEvSsWxDQ1qnbg+QMPSX9SCnrwsmh0gak3Y2P6ldaTCvoABqrWEuXhg4iY3wp5wpBy5M/l4xP32b7Rw3vrfsTAMAgbs+wAUwbkGhQAX/OKCB7Gd1pgd9u+nR8mpEug7qTg0QVgSyhK7pvnmeqArZyHywUmfpcByQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782166547; c=relaxed/simple;
	bh=G1sdTy4mgqMiYtrPaIQhflyahpgNRB07qllNs1lUX5I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LmhzbjaOjKa1MEau2Lvv3VxRjJ2+TUBz9cowxaSKfOHG2S9JAB2KQgnOYAvZIMx/NUXyYlNi9uk3/6DaZ0EtuogChW36ug95v955LFPOzcu0w5kPOnIPhHe8w4mVJkNeZGxXMorM68I2AQY8oSWM9LsfIxruKODu18NgMDXTqsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJhqYeJ8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4BC1F000E9;
	Mon, 22 Jun 2026 22:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782166546;
	bh=n6Cj3B0lmGIqhGNYby2Kc0qKU/yseO+5CJWPhGVtjvA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kJhqYeJ8blHG/Kdbl49vE5z9xbOqAJgcEYeT7GB2loANFsrT3LyrfLhzXQkFjdzwz
	 oh5ESirqqJqPHviHFFg6GzkAVHO7p4yjzz8+W6/56bop6jyc4vdTWAfvgw01lKShMX
	 83KKkjGziT0BP4/a5JDs/wRKay6d2n6NGQ2GHSf3yMSIsB+hSIzKTphP+UEyAAcIub
	 yvhloR2eo2AZAncfC914kRwfqlevxPuyqZo+BF/+tCuSTPaREo3L0ujFYAofVeMoG4
	 Qm8Gq6cu4LTHHSR5OfFWg39oxpRBBdpc+plLAqVljmQZdqsujCVyr8HZcrrq1Eun2Q
	 MP4+I0KLzPnkw==
Date: Mon, 22 Jun 2026 15:15:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Dmitry Safonov
 <0x7f454c46@gmail.com>, Neal Cardwell <ncardwell@google.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
Subject: Re: [PATCH net 0/2] tcp: make TCP-AO lookups more predictable
Message-ID: <20260622151545.5e1688dc@kernel.org>
In-Reply-To: <20260622185248.1717846-1-edumazet@google.com>
References: <20260622185248.1717846-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301213-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,gmail.com,google.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:horms@kernel.org,m:0x7f454c46@gmail.com,m:ncardwell@google.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8BF756B295A

On Mon, 22 Jun 2026 18:52:46 +0000 Eric Dumazet wrote:
> This series fixes a TCP-AO key lookup precedence bug.
> 
> TCP-AO stores MKTs in an unsorted list and returns the first match. This
> allows newer, less-specific keys (wildcard VRF or shorter prefixes) to
> shadow older, more-specific keys if inserted later.
> 
> Fix this by implementing sorted insertion in tcp_ao_link_mkt() based on
> key specificity (VRF binding, then prefix length). This keeps the RX
> lookup path fast while ensuring correctness.
> 
> The second patch adds a selftest to verify this behavior.

Unhappiness:

https://netdev-ctrl.bots.linux.dev/logs/vmksft/net-extra/results/702701/29-key-management-ipv4/stdout

