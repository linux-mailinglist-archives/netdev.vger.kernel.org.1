Return-Path: <netdev+bounces-307123-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3XSBOX3CVGogSQAAu9opvQ
	(envelope-from <netdev+bounces-307123-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 12:48:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 27898749F58
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 12:48:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=l3g+Blii;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307123-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-307123-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C07533001591
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 10:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA1C380FE0;
	Mon, 13 Jul 2026 10:41:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0D237F8BA;
	Mon, 13 Jul 2026 10:41:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783939278; cv=none; b=Mrt1w7J2lKvwUO4/u61wlCKtM3IokEffr6DUII7AsUf2g51npRFizHKTZOsOienxwrUfFtwAxk8xHkqxwFWvlGQb35obh9Lhw+OlI6fMPkWkkhrLE0SIrrq9BlPGVF9XyfoenVI9PHyqzepzwGvZnjqC4ls0De4lR8e+BX1OZ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783939278; c=relaxed/simple;
	bh=ZKZ7XG7TpbyNrs4YixOL1bm5LrxH4B8fu7GTNJK782Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lz7Jgvv1+1mNhVq5lPxnWijEdFPaW6fMsbb/jSUxSj9ItLKzSGJH1WTT9sbIx+qhxtkGGsIHlL97FXKy6BrRj5ENynEZ5AwDnHi8ExJ652L/zlXgPGCVAwnDp/oDEu6eA3LXrvXtWbKfgm5NDDxIvR3Hbvl6LlnIkmsCJZ4s+uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=l3g+Blii; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pvi0+VVen/SpVPKknVBEOhcrgfRrza0lNi9Dsqi3WKg=; b=l3g+BliisUFFeilqz8T8WXnh1E
	UfXu/fXiW2KBKnYYk6kJjxn6YWTixBdHww2vUfNwMQwby762aBK5Ih3I/ut7K7MqGb1dU1VuCl+mJ
	N7baseFZqmxI6sfqpmqtKnOOy/x/UfOTtq2C7QBV8990Uiw0UPFeYWb2pForp7E9FBI13se5yj3Z9
	MOLIcfNFYYUtEWb9ISgY9LCpKxsrOaBNE0/jMlzJr6DdsWCApE7eGWQ1bgUqTb6bMqldMFqTJlwrh
	IzGTsLxaeBmPiIOrxiDUi18GvtfbLqA7Tjjp0vzZVLgb2Sr+jr05j1rTAwOQV9UA8u630Fjpjuk10
	M4gTE6Fw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wjE61-001RVs-1f;
	Mon, 13 Jul 2026 10:41:09 +0000
Date: Mon, 13 Jul 2026 03:41:04 -0700
From: Breno Leitao <leitao@debian.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Andre Carvalho <asantostc@gmail.com>
Subject: Re: [PATCH net 7/7] selftests: netconsole: ignore busywait errors
Message-ID: <alS6Xdmj-dX2at9z@gmail.com>
References: <20260710-net-sft-fix-containers-v1-0-a2915c294ef5@kernel.org>
 <20260710-net-sft-fix-containers-v1-7-a2915c294ef5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-net-sft-fix-containers-v1-7-a2915c294ef5@kernel.org>
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-307123-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:matttbe@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew+netdev@lunn.ch,m:asantostc@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lunn.ch,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 27898749F58

On Fri, Jul 10, 2026 at 08:04:47PM +0200, Matthieu Baerts (NGI0) wrote:
> In these netconsole tests, bash is used with errexit (set -e). It means
> that if the busywait timeout, the tests finish without printing an error
> message.
> 
> It is fine to ignore these errors, because the following validate_xxx
> helpers will check the content of the output file, and exit with an
> appropriated error message, e.g. FAIL: File was not generated.

Agreed, the validate functions will catch this and report it more
appropriately.

> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Breno Leitao <leitao@debian.org>

