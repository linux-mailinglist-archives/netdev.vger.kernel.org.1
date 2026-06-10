Return-Path: <netdev+bounces-297415-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D2YeMyrPKGoTKAMAu9opvQ
	(envelope-from <netdev+bounces-297415-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 04:42:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A9D6657BE
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 04:42:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PublGFB2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297415-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297415-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED63E3020298
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 02:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF16D27E1DC;
	Wed, 10 Jun 2026 02:42:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F22198E91
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 02:42:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781059368; cv=none; b=tphHb016iRSyXH9M/AYwdCQgQLCu9QJFto4IWRTmiJXetS5w6S/SugHGaHhJP+v+t+AQAL5+w/SzQl9Wk8ix5B89OYyI2BY6vfJArEb5/cE11ymCI3Lq2dkbynE7xeyrTUGJKY0R9cuNjBb1Z1tMj+KS7Z1jt114O2FVdb6pzAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781059368; c=relaxed/simple;
	bh=LcwuuElJeSWryu6sRcjs/ftXOmLB0sJDxYiyLmTlvAo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YgydKr4DAR5WfE8/9LMqtl9jf+2vCEgXuASrGn+dmK6ZpAWWbL5zqbd2WBjMVxByBAYfhVt0u7Y2gOW9eZXRBIBye3p9Nes+W5uAx3uLpDoj0A1qGVP4z8DUu8h2z3fdrdRaZd6fXOR1k9JONZP8hc5U3x20yEePdZUpGy5dpsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PublGFB2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7001F00893;
	Wed, 10 Jun 2026 02:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781059367;
	bh=MHkTMDERPl1A47UHEZMGRZ4pIvAJRWE46Q2Dedu1Iww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PublGFB2pL8u0VTp5EHqUtAAHETz1l5qwcz8hu6/MMu91vOj/ZSYcK448oKXbs5nv
	 oS6j4C12UCHjc2/qydBmsm4ifei0wK7KPv950pQjT3+Ir08805C0gbt1t7KiAjzwkK
	 x6t8Q3wqKgDbtyD9EZuiN30G6xXX1B39OIa33tCjtvu3YjPP+XLd8goFH2KemNgIst
	 8rQJDT6qnrTCgwMCDvTEruB0kPRHfDWjNVgBsoP/3TIvSb+j7jjHZ2a723j6qko5Hf
	 EkkNoZtEmX1LZi+pbVHDHLq22u68PpQC23gNYxdIqZ5+hC0DN0sirigiLbytbpgHXb
	 oT4gDaVcnTDkA==
Date: Tue, 9 Jun 2026 19:42:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Marco Baffo <marco@mandelbit.com>, Sabrina
 Dubroca <sd@queasysnail.net>, Ralf Lici <ralf@mandelbit.com>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net 6/6] ovpn: use monotonic clock for peer keepalive
 timeouts
Message-ID: <20260609194246.23c66818@kernel.org>
In-Reply-To: <20260608150741.3320919-7-antonio@openvpn.net>
References: <20260608150741.3320919-1-antonio@openvpn.net>
	<20260608150741.3320919-7-antonio@openvpn.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297415-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:antonio@openvpn.net,m:netdev@vger.kernel.org,m:marco@mandelbit.com,m:sd@queasysnail.net,m:ralf@mandelbit.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 65A9D6657BE

On Mon,  8 Jun 2026 17:07:37 +0200 Antonio Quartulli wrote:
> Replace ktime_get_real_seconds() with the monotonic ktime_get_boottime_seconds()
> to ensure the keepalive mechanism is robust against system clock modifications.

Why boottime? Unless there's a reason shouldn't we be using
plain ktime_get_seconds() which is CLOCK_MONOTONIC?

(if you decide to respin could you also drop the selftest change
from this PR and move it to net-next? memory leaks in selftests
are not important)

