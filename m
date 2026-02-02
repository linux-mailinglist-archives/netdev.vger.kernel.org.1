Return-Path: <netdev+bounces-255912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKn6NofKgGl3AgMAu9opvQ
	(envelope-from <netdev+bounces-255912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 17:02:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4FACE983
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 17:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8D5D30530E2
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 15:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CE026E6FA;
	Mon,  2 Feb 2026 15:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HRVGol+5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zN8sJBou"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1A625A359
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770047721; cv=none; b=KvDeWyksukANHy6093R9oiO7pU/+SYmPTPEm0RCna7+/xRSroZdbBA6v9GDvqrptgsZ0gFeOlrlw4x3cBxd4jwqmibSbQ0aa8tVzG81PMWS/9D4wXbTA/5OYOWAvobPf5AZvUB7jZc6wpsEhlZA1QPTW4m6DmZfUsFVTl1IC/MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770047721; c=relaxed/simple;
	bh=djGef6lbEOAxne/CHNTtMDlsVAYFTF82PtQWdpxIbnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxJb2CIo+l3xnviPdJwiHm/b2gjHHnl3HkiJoyRxsbnSNiLXH+oEqPTYpEHeCPqMMdPkqXvmtvq1xYQtVpzwduu0z+SNdnmSMAq4xOgNpNtEG0krIaosmLT2NinIxzeWKo6IRDPaToOBry7dpyu0qISdwwonIxLtEvz8labr5A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HRVGol+5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zN8sJBou; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 2 Feb 2026 16:55:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770047712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4N466cezhTxRA2tHnMg4e8iM47CokcYzSXlphkbfhjI=;
	b=HRVGol+5WjkqXqgzaf2tYA3eGqkvdcTL8V79ISYnHCqfSUxXEGKXAhdAxjU2sOuMIvA3PH
	qefpX+xBS4/rPL8ICMuvMhtejz5P8gtK6UbHslkyxmTp5UnWLR/oJKoZVQtg6ymcNccxRO
	tOJAyOZonUnPHD2CYkCqGm/VkOQ4u8C8XIIxZsWVKVtwI+KUjJjqrH7SyBrmJbKKU77ehY
	tW4jmp3cJkOd6dQ4y31fkuqL8DGTS9fVbfb218vEmTVT//GifnKgrB+dG6Jbgt6xemaopc
	CEQAxS5dLC4iwPtJAqUgbaAjcNCYheuzPGz11PFuvcW0yEplN6aGbMsp0cFE3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770047712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4N466cezhTxRA2tHnMg4e8iM47CokcYzSXlphkbfhjI=;
	b=zN8sJBouraBmY+Gi3e3cujFLsdzUDsOW9mzr8WpS5j7fAaQSYbeXRwLS/mTp37rEnR/ItL
	E9qWRDTw6JgzSFCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jkarrenpalo@gmail.com, tglx@linutronix.de, mingo@kernel.org,
	allison.henderson@oracle.com, petrm@nvidia.com, antonio@openvpn.net
Subject: Re: [PATCH net-next v2 1/9] selftests: hsr: Add ping test for PRP
Message-ID: <20260202155510.C1zpsxnk@linutronix.de>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <b54f9225ae39d0d4bd9c8c1b0b98fe47fb7211eb.1769093335.git.fmaurer@redhat.com>
 <20260129110500.l2jOMEYp@linutronix.de>
 <aXthMlr6Hpas1LBt@thinkpad>
 <20260129152149.dKwN1yGM@linutronix.de>
 <aXucj8L-cBUVIYHX@thinkpad>
 <aYCPsDZeJvCrJYRH@thinkpad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aYCPsDZeJvCrJYRH@thinkpad>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255912-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[linutronix.de:query timed out];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: 7E4FACE983
X-Rspamd-Action: no action

On 2026-02-02 12:51:12 [+0100], Felix Maurer wrote:
> > Hm, I am not sure? For PRP, it's an explicit requirement to use the same
> > MAC addresses for both ports. For HSR, I think the standard is less
> > clear about the MAC addresses. And at least our code seems to assume
> > that there could be different MACs on the two interfaces of a node? But
> > yes, the node merging addresses this.
> 
> I'm still not 100% certain, but I agree that the standard reads more
> like the MAC addresses should be the same for the two HSR ports. At the
> moment, the kernel and the test assumes that they can/should be
> different. Therefore, I think we should fix this across the board in
> another patchset if we agree that's the right thing to do.

I would suggest to do so. This could serve as bad example and my PTP
userland patches expect the same MAC on both ports. So ;)

> Thanks,
>    Felix
> 

Sebastian

