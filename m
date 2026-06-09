Return-Path: <netdev+bounces-296871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FO7oAkKAJ2opyQIAu9opvQ
	(envelope-from <netdev+bounces-296871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 04:53:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 724BB65BE9C
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 04:53:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DFuxT2xP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296871-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296871-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3BADE3080615
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 02:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DA634388C;
	Tue,  9 Jun 2026 02:53:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D13A14F112;
	Tue,  9 Jun 2026 02:53:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780973602; cv=none; b=EiileKXHynZxC+rxVJV3HtK07HdeGkbPyxQg78w2Cv4s6ghT+t4TNsoxf06prgTRCLOn6iLp+aUFn9/fJFh70srGzQ1VHCxZx0aNO25xq5AIgl4bP9Y6XN3u/WU6iWCKcXtc0wnJOjiYPS7Dkk64sEEQHpqJa2e69v0nWzt5noM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780973602; c=relaxed/simple;
	bh=Ivro6vSMIYRry7vN1zqSFklZGe4QJ6SjpJl1xTHkpNo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D/BbHkwLisSiP+AJZvEM2gzVSyRGmV0J1MFfD46IKBaciwKIFFvyGNYjJ2mo8QjC6oUT5vzCn+eh0so3o/B+I9XqYeSpcFnD3pGVxY6S9YohXoLeai/nGZwgtFlXlemdmmSduGbHiba/HfAAHGmh5GBLnhqR1xzC5+beGQqmmAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFuxT2xP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB32A1F00893;
	Tue,  9 Jun 2026 02:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780973601;
	bh=d0Dg2ymvpIPp2nbqsrVn1ZAEjUP4Iy9O/+GN4wMx1z0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DFuxT2xP6g3k2yQ3cQJEY5WQhyk8vyIiOkPP7ChAf+4EIHzaibyNpGobyZ0ifDgFw
	 JC8T47VoQZiIbZzSB5244yYi/2QVTrOlczqgqMUBIA/+WzrNFg+qD2MaqFeqBSDbMo
	 B0PqtNitDPdE5f1F3GJRRvHx6f+Y+82R45K7r0F4vrVQc0YGXz5lJdHYGNEzY8fvms
	 /aFRPEEIglA+lupG+Y3z9mvQNtyC3LSRyC6IGNm1XfoUeSlUlytjpzrjy2fUte9EDT
	 EKHzorYq/jjdrrcnFsXlowzLATkaTg076JvgeQodoWR0TJp2Ttq2xqHoE2HZGum7CC
	 dvDrXLYyh0guA==
Date: Mon, 8 Jun 2026 19:53:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 willemb@google.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: drv-net: gro: signal
 over-coalescing more reliably
Message-ID: <20260608195320.007b34ad@kernel.org>
In-Reply-To: <20260607002401.212976-1-kuba@kernel.org>
References: <20260607002401.212976-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296871-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:shuah@kernel.org,m:willemb@google.com,m:linux-kselftest@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 724BB65BE9C

On Sat,  6 Jun 2026 17:24:01 -0700 Jakub Kicinski wrote:
> +	/* Signal over-coalescing explicitly, it's a hard failure, unlike
> +	 * under-coalescing which could be timing- or loss-related.
> +	 */
> +	if (num_pkt < correct_num_pkts && bytes_received == bytes_expected)
> +		error(EXIT_OVER_COALESCE, 0,
> +		      "over-coalesced: got %d pkts vs expected %d (%d B)",
> +		      num_pkt, correct_num_pkts, bytes_received);

Sashiko complains that this condition may mis-fire if we lose a zero-len
RST or ACK. This is true, tho, if the device drops pure acks ignoring
failures where ack disappeared puts us back at risk of false negatives.
Happy to respin but feels like we only have bad choices here..

