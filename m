Return-Path: <netdev+bounces-264234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6J/ZFp1JqWlZ3wAAu9opvQ
	(envelope-from <netdev+bounces-264234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 10:15:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FC020E1BE
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 10:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EE51308CE73
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 09:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CED1377547;
	Thu,  5 Mar 2026 09:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eotp24Tp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3iF+bWsS"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06790364EA5;
	Thu,  5 Mar 2026 09:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772701777; cv=none; b=mIpfJfMTLFqa49Au6n/Rf7nzN3Tbk/joQ8/M/1x2ektp0CEhMz391IEHE4cgecIorxeeBDpQXMrcVFZ+9mHna5mu9BHFuaDOuOnHl/17aDTR/z4yjpBsQTVnSOTtrUB6T9HJg9Tirwgzw49Vclh8wZ0qPA6dx5jCNycMTgeKA2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772701777; c=relaxed/simple;
	bh=nyLabm7rePodPLfIvnROK6ei2A7rsOrTR7KFP1H7Y0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJYHLSLufO/JciSkoYfVDJqvLVDHKBysu7WRSnGemWPX7zPEyo4GTBWx4nxNELkM7HFRaBEtmuV1wHJjz87oKdrxrst7gPX+Mkt8Yz98azka4nYqbxKu0EEkkY6wuwtCva2pCHks1Wuk5Sh897SwEJFydKpyqRiEUKdzSEJpC0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eotp24Tp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3iF+bWsS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 5 Mar 2026 10:09:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772701773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UPuzedcxjUIiFnBFa5d/1QPOTAJC09yVagzd21r95WY=;
	b=eotp24Tpj1wZlBl/koatxtddKm8kangFvKTmIuKIS/TKBjGdxylNAN03xZjDmwcXfg1OIg
	VfccobwnE4lUJEpcnBzwlVnj3Vg1C/FtKwfEeZOsvQyes2ja5EetYBIP/kbTSXCo5GNFjc
	6rBAEpjAGiwDOsW97fKhnjlRHkcde3fxzi9Teg6MCQtUswUi+6n8l7lQCUt9dw25nbMhpw
	EoPcCJVu5Q2no0woceOyiZgPbQlkuuxERvvbi4yKgtiZvrQ+RT4AvtF7kmDF+cGN1ZXjPj
	yEweL7RwdVlD3VxsKGxy6xhB4fTWC89m135/1+i21FRDBuZotNSMz2REOf4wHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772701773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UPuzedcxjUIiFnBFa5d/1QPOTAJC09yVagzd21r95WY=;
	b=3iF+bWsSwMc7gwCEzNxFRrKl9iaEOf1Ctz5RB/l50NCidsRlLh0cMn+jLXiq8B9bCNDDsi
	6udBgMB5F9oPLEDA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v3 v3 1/2] selftests/harness: order TEST_F and XFAIL_ADD
 constructors
Message-ID: <20260305100753-6320e123-c6a0-4013-8003-688460da868c@linutronix.de>
References: <20260225111451.347923-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225111451.347923-1-sun.jian.kdev@gmail.com>
X-Rspamd-Queue-Id: C6FC020E1BE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264234-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.weissschuh@linutronix.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,linutronix.de:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 07:14:50PM +0800, Sun Jian wrote:
> TEST_F() allocates and registers its struct __test_metadata via mmap()
> inside its constructor, and only then assigns the
> _##fixture_##test##_object pointer.
> 
> XFAIL_ADD() runs in a constructor too and reads
> _##fixture_##test##_object to initialize xfail->test. If XFAIL_ADD runs
> first, xfail->test can be NULL and the expected failure will be reported
> as FAIL.
> 
> Use constructor priorities to ensure TEST_F registration runs before
> XFAIL_ADD, without adding extra state or runtime lookups.
> 
> Fixes: 2709473c9386 ("selftests: kselftest_harness: support using xfail")
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
> v3:
>   - Move KSELFTEST_PRIO_* definitions above the TEST_SIGNAL() kdoc block.
> 
> v2:
>   - Drop the lazy string-matching approach.
>   - Use constructor priorities to enforce initialization order.
>   Link:
>     https://lore.kernel.org/all/20260224113859.12345-1-sun.jian.kdev@gmail.com/
> 
> v1:
>   Link:
>     https://lore.kernel.org/all/20260222111846.12345-1-sun.jian.kdev@gmail.com/
> ---
>  tools/testing/selftests/kselftest_harness.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

FYI there is a selftest for the harness in
tools/testing/selftests/kselftest_harness/harness-selftest.c .
You could update this with your usecase to make sure, that this functionality
keeps working.

(...)

