Return-Path: <netdev+bounces-304616-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BSQXELHoR2rIhQAAu9opvQ
	(envelope-from <netdev+bounces-304616-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 18:52:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFE87046C6
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 18:52:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=st7E7XKu;
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304616-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304616-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3A24300EA8C
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 16:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C3F304976;
	Fri,  3 Jul 2026 16:49:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F3F2BEFFD;
	Fri,  3 Jul 2026 16:49:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783097355; cv=none; b=p0E+tYduEvyrxUF8ymDqPjVl/519E7SsqyVNWtlPaup+nectKOeLajwsUbAoRa3cXb7PYcEaIYnXRn8cip9uS3uZWpqkDA5plUMAFArHiW4lak707TfHhRj4js042CQMyDJGvcvQhuXE7QO+mDYnhy33cd4jZzmmI7xK0rviwmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783097355; c=relaxed/simple;
	bh=DW8Kf/W07wnmel1ihkI8fXZTHAYF8dvkKkKEdVNWc7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2ygSIVToTFywckOpM60aCq0WfSRSD5D6vDNBjGA4mYzfrCfdQ1IgbhU9973OVMy9A5Bu8YUYYuPRLdSAvd9gXR8UgCxeiodgmqWmloUgrt17zeJ3RPSLKimjx86VVbS0RBeq05LmCs7HJ9QkdORpimo/ltzcZJeJ1wR3rCMk2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=st7E7XKu; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KkfkIxit2DyHiIlOS7bD5oQMicHBv7cPPNHZOnBEHG0=; b=st7E7XKulO1Kr4VkSmLkL0DKAs
	Vpqggk54xydD2P5g0byGIcVzEPDjEm4ySWu0uFYXuuWFCBXslCqStkR9rYymeQebdPxf78hRdkF6D
	H76JII4/NlzlONGHU5fJgJV1MaBltjdhKYaUo3gjGPfppDjqSMz9KekaeJMWAlJwNxR0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wfh4d-00AZth-1r; Fri, 03 Jul 2026 18:49:07 +0200
Date: Fri, 3 Jul 2026 18:49:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Praveen Rajendran <praveenrajendran2009@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: qed: Fix spelling typo in qed_dcbx.c comment
Message-ID: <5821933d-00eb-4251-9016-a216ed5721ca@lunn.ch>
References: <20260703143130.3685-1-praveenrajendran2009@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703143130.3685-1-praveenrajendran2009@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304616-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:praveenrajendran2009@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:from_mime,lunn.ch:email,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7CFE87046C6

On Fri, Jul 03, 2026 at 08:01:30PM +0530, Praveen Rajendran wrote:
> Correct a minor spelling error inside a comment block of the QLogic
> Core module where "successfully" was misspelled as "successfuly".
> 
> Signed-off-by: Praveen Rajendran <praveenrajendran2009@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Before submitting more patches to netdev, please read:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

    Andrew

