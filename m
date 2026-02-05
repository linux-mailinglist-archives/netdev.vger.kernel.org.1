Return-Path: <netdev+bounces-257148-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OWtJzaKhGl43QMAu9opvQ
	(envelope-from <netdev+bounces-257148-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 13:16:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA5BF24DB
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 13:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D74EE304D978
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 12:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5F73A9D96;
	Thu,  5 Feb 2026 12:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZQPf6a6y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PgYUZHNk"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F4335CBAF;
	Thu,  5 Feb 2026 12:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770293553; cv=none; b=g8DxEMedtQaxCjs5yWKKcJOe1lO3zKEY2acvWcH450d9e4TIijq8rzHNXKz30aXK07ZdS+26j3Mulesd5IQ9Qxnd9crzHNnfxjfoq6oFGAkvU0mitKtjC1+M8QRPoQbs4v8CVT8cKGsSzxjDWDyYyww0TzeslPcr4xPurBF1jbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770293553; c=relaxed/simple;
	bh=ORAOeIJ6mq47EDXOG7LquwoajELnCjdFAwjFw7s31Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NP8ou8+2GSG/KmJMixOWTy3Bd8GV0+cdlsdG4AC3URdoyka2Et29NnHNwiEOiBtMinOTX1NOnhm9zWOnocfkpc5HjqZxCer0W6KgPqLE1RpSPdnC8dTxOShpqrfX/riDCe8J8RGGro96knrEsILZgyWzW+NJrZWcW2KWtzwH+XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZQPf6a6y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PgYUZHNk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 5 Feb 2026 13:12:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770293551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7PelbcnS3xUMscOsvh2ZeX/gyBEvi2+xKP1rvNjD0C8=;
	b=ZQPf6a6yM+MN8oWcb8D/hbpJDAPU5eQClQGr/bAQeReS94O/EkUOlrrvm+Y5BQkFcE/Fin
	xsPHTaZLbJCrxVqYEH2qlXYPyy6y6vR7Jqg3GLgHHFbKuANwi/pQTK9ZH951Uc9xh3x54a
	r5jjdxcHJdZdAYDJ/U8QZ1akFmO9fNihVjG87eg4uXkR8d3pSSoUXe15kgrLhhDjm9ti3e
	udq4klY7jPgyfNuSK/DjCCyT2Aztzf+CmEIJdx2IXyFehCsCTLNTZrz1vcZrht7PwDUQnI
	kMLEaFNgdT+dCDunkdhaJ4pHmZ7rNMigRWl0GlqdYbOgTnO1LswqwDV6ShC7Mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770293551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7PelbcnS3xUMscOsvh2ZeX/gyBEvi2+xKP1rvNjD0C8=;
	b=PgYUZHNktT88QYXXPu7EIYbh4Rp3lqX4vzxGT81vpxAupALs1NelX9ES3lsjbJXxZZmBC6
	mm8buKh0B+D8XLAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-next v3] igb: Retrieve Tx timestamp directly from
 interrupt for i210
Message-ID: <20260205121229.AwxNfEl_@linutronix.de>
References: <20260205-igb_irq_ts-v3-1-2efc7bc4b885@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260205-igb_irq_ts-v3-1-2efc7bc4b885@linutronix.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257148-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,molgen.mpg.de,linux.dev,lists.osuosl.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DFA5BF24DB
X-Rspamd-Action: no action

On 2026-02-05 08:54:34 [+0100], Kurt Kanzenbach wrote:
> Retrieve Tx timestamp directly from interrupt handler for i210.
> 
> The current implementation uses schedule_work() which is executed by the
> system work queue to retrieve Tx timestamps. This increases latency and can
> lead to timeouts in case of heavy system load. i210 is often used in
> industrial systems, where timestamp timeouts can be fatal.
> 
> Therefore, fetch the timestamp directly from the interrupt handler.
> 
> The work queue code stays for all other NICs supported by igb.
> 
> Tested on Intel i210 and i350.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

IMHO this is a compromise with Miroslav where he observed less PTP
timestamps on the i350. While testing I did not get near Miroslav's
difference but there was a small change. I don't understand *why*
because the current workqueue usage reads the timestamp on the same CPU
on which the interrupt occurred. Doing it directly just avoids the
context switch. This feels beneficial.

Sebastian

