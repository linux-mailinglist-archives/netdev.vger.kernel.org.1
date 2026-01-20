Return-Path: <netdev+bounces-251655-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIFlNkoQcGlyUwAAu9opvQ
	(envelope-from <netdev+bounces-251655-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:31:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D4E4DD39
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 527A496E098
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 23:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF8540FD85;
	Tue, 20 Jan 2026 23:20:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFD33B52FE;
	Tue, 20 Jan 2026 23:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768951217; cv=none; b=msHNLpAZ48raA9IclX/rgLGXe6BKKZMFmLX46BdsnKZ07bkD49fItmw8+THQgpUlu/cx3gT0FvVs7MxhG71vjD080jIVSPdD3WPgAWJCI7xaDIGnnFAg8OEoxz+pGaInhghwF9BKLlqqYeGw78/4kFAHjjDI2kJIQ3OpmN9a9Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768951217; c=relaxed/simple;
	bh=F0yHXtmpIxcTfkWf3PjyLYYBWYljo+hj5xQHYjzEAlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSnmgv7KyJJMjgF8zQ4hiQeMSMyNtGvBjWqtslblUhMsuIPHZsTqjk4Kjcr1Q9v+BQWp0uFvCaPxlHNgOgSbku1ZNQjcB8fDhBwc0/jeCOn+raCUDmJIKAuREbn6z595vtkOgLmaOb8FlbPsDg0t4o6QtixlEB8J9lBNRLqwmco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 269E1602AB; Wed, 21 Jan 2026 00:20:12 +0100 (CET)
Date: Wed, 21 Jan 2026 00:20:11 +0100
From: Florian Westphal <fw@strlen.de>
To: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Konstantin Khorenko <khorenko@virtuozzo.com>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: netfilter: avoid RULE_REPLACE error when
 zeroing rule counters
Message-ID: <aXANq__7K0_fhq2D@strlen.de>
References: <20260120231106.328585-1-aleksey.oladko@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120231106.328585-1-aleksey.oladko@virtuozzo.com>
X-Spamd-Result: default: False [-1.26 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-251655-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[virtuozzo.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,strlen.de:mid]
X-Rspamd-Queue-Id: C1D4E4DD39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Aleksei Oladko <aleksey.oladko@virtuozzo.com> wrote:
> diff --git a/tools/testing/selftests/net/netfilter/rpath.sh b/tools/testing/selftests/net/netfilter/rpath.sh
> index 24ad41d526d9..90cc21233235 100755
> --- a/tools/testing/selftests/net/netfilter/rpath.sh
> +++ b/tools/testing/selftests/net/netfilter/rpath.sh
> @@ -125,8 +125,24 @@ netns_ping() { # (netns, args...)
>  }
>  
>  clear_counters() {
> -	[ -n "$iptables" ] && ip netns exec "$ns2" "$iptables" -t raw -Z
> -	[ -n "$ip6tables" ] && ip netns exec "$ns2" "$ip6tables" -t raw -Z
> +	if [ -n "$iptables" ]; then
> +		if ! ip netns exec "$ns2" "$iptables" -t raw -Z 2>/dev/null; then
> +			ip netns exec "$ns2" "$iptables" -L PREROUTING -t raw -n --line-numbers | \

I would prefer to SKIP in this case rather than working around
userspace bugs.

