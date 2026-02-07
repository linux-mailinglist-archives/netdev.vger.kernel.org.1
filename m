Return-Path: <netdev+bounces-257767-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICZxEaJVh2kRWwQAu9opvQ
	(envelope-from <netdev+bounces-257767-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 16:09:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 633A210650F
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 16:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE87F3009537
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 15:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483B0352C52;
	Sat,  7 Feb 2026 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UmkD79nb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548283502A7
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770476959; cv=none; b=UkSO+epQ8WoUaAiQoIH3HNMQKY97YqFkrUE53JILtZa05X4keCgRyO3GTwRQQXdMjCbjonqFXzityoKuLneTt52NvwjqPdVFrRxj3wQq1RAyBm4Jh0d4TgsgzgDvJr06PtWvU6HSK59/F4IShzbLVLQyCziPjgg1Q6gQX1djJFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770476959; c=relaxed/simple;
	bh=Hkcji6X7dANRJFePNTF8fuTjG+u+9X2zCf5od8CIuZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R22CugteVHQ5K6sfQ2YSN8Krv0sIkw82H16nSnbv/TTBC4p86svy6uAjq432ezBd/ARBwLB7Ppz73vS5pcSildVcUiYLjL9iLsB4jXoaJyYu+DEPe2I5pw601uKr3/ExSSCNoEDU9HLHNn1relR9fYgXK+AZxhgiw62U8L43Hqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UmkD79nb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=EBAawNMpPD+jhTBS4ytBoeJeAWdNCu3nLbpDofNg1bw=; b=Um
	kD79nbuUcN72L/ILQbwryFoRENdXLCIKnldoAgteIK3nrkzoglwF7fESJj1qnoi1h6QaLfwpRvlRa
	SK/morP8zadOuQIElYB8rYGC8b+Dzcfp1mJxJeR8eYC0MwiA9jUB0IhXJc4QAAtC9gGj3J9phDTwU
	58QW7RuGBAagCSE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vojvt-006TyZ-Cy; Sat, 07 Feb 2026 16:09:13 +0100
Date: Sat, 7 Feb 2026 16:09:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Deren Teo <deren.teo@outlook.com>
Cc: "jhs@mojatatu.com" <jhs@mojatatu.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [tc] Invalid JSON output from hfsc qdisc
Message-ID: <8698fad4-c406-4bd8-bfe3-33e5fda641e2@lunn.ch>
References: <SI2PPF4F82E9256898C9826AF17C3AE8AD9F467A@SI2PPF4F82E9256.apcprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SI2PPF4F82E9256898C9826AF17C3AE8AD9F467A@SI2PPF4F82E9256.apcprd04.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257767-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 633A210650F
X-Rspamd-Action: no action

On Sat, Feb 07, 2026 at 02:01:01AM +0000, Deren Teo wrote:
> Dear Jamal,
> 
> I apologise if you have received this email twice. My first attempt mistakenly contained an HTML part and so was not delivered to the netdev mailing list. The original content follows.
> 
> 
> The JSON output for the hfsc qdisc is not parseable when a default class is specified; `hfsc_print_opt` uses `fprintf` to print the default class.
>  
> 
> Environment:
> 
> - Fedora 42
> - Linux 6.19.0-rc4+
> - iproute-tc-6.12.0-3.fc42.x86_64
> 
> Reproduce:
> 
> 1. Add a hfsc qdisc with any default class. For example, from the tc-hfsc man page:
>     # tc qdisc add dev eth0 root handle 1:0 hfsc default 1
> 
> 2. Show the qdisc with the `-j` flag:
>     # tc -j qdisc show dev eth0
> 
> Actual results:
> 
> [{"kind":"hfsc","handle":"1:","root":true,"refcnt":17,"options":{default 1 }}]
> 
> Expected results:
> 
> [{"kind":"hfsc","handle":"1:","root":true,"refcnt":17,"options":{"default":1}}]

Just an idea...

Could the self tests in tools/testing/selftests/tc-testing/tc-tests be
extended to dump the configuration in json and test the output is at
least readable by the python json parser? That should catch simple
formatting errors like this.

     Andrew


