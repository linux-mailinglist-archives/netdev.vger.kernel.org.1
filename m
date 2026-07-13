Return-Path: <netdev+bounces-307187-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zwkKHV3uVGq0hQAAu9opvQ
	(envelope-from <netdev+bounces-307187-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 15:55:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7665D74BF07
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 15:55:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307187-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307187-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 125773050992
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 13:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046F3431E7D;
	Mon, 13 Jul 2026 13:50:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9815E433BD2;
	Mon, 13 Jul 2026 13:50:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950604; cv=none; b=F4Ehdl5bwaX3aogYFpJ4+AjoRkIBOj7cjrwiW+KthcmmO/4wvEnG3jUpnJ4JGrZZWzVcy8bSnT0C5NdxG77zyH1JxE8tM1OrxV0T9AkES227k6zGHUj2AdIZLcWITDni8SyJmJDscjjwxWpClMJDKOI6liJACvHTfwdJ3AHZrI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950604; c=relaxed/simple;
	bh=gvFBCp6oCXgGaGuHcNpfnQGVuqtKvCrdVu/GHrCmwdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQ+tnQXKpxJJPworf1fIM9/nEfFt4y5KEmLxn6ztIhr8QlGBG5dqGwWiTzygACIIfTjhxfcuri89Q17fbFSSnDbNfdZlG+1uGcxyzeHpKb+UgyXYcETa7c3oxBdKIUr4Xuj5ntU7FYVc+wTxX5ujmcyMTfYBY+V8t++at7sdAB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Received: from equinox by eidolon.nox.tf with local (Exim 4.98.2)
	(envelope-from <equinox@diac24.net>)
	id 1wjH2l-00000001XIV-39vz;
	Mon, 13 Jul 2026 15:49:59 +0200
Date: Mon, 13 Jul 2026 15:49:59 +0200
From: David 'equinox' Lamparter <equinox@diac24.net>
To: netdev@vger.kernel.org, mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Subject: Re: [PATCH net-next] mptcp: sockopt: implement IPV6_TCLASS
Message-ID: <alTtBzvuUbmyMMfP@eidolon.nox.tf>
References: <20260713080634.296011-1-equinox@diac24.net>
 <202607132109.n8GCw6cD-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202607132109.n8GCw6cD-lkp@intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,m:matttbe@kernel.org,m:martineau@kernel.org,m:geliang@kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[diac24.net];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[equinox@diac24.net,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-307187-lists,netdev=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[equinox@diac24.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,eidolon.nox.tf:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7665D74BF07

On Mon, Jul 13, 2026 at 09:24:52PM +0800, kernel test robot wrote:
>    sparc-linux-ld: net/mptcp/sockopt.o: in function `mptcp_setsockopt_v6':
> >> sockopt.c:(.text+0x908): undefined reference to `ipv6_setsockopt'

Oops.  Forgot IPv6 can still be disabled.  v2 in a few minutes.

