Return-Path: <netdev+bounces-257102-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDNABwxrhGl12wMAu9opvQ
	(envelope-from <netdev+bounces-257102-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 11:03:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EE3F1285
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 11:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75810301184E
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 10:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DF538E5EC;
	Thu,  5 Feb 2026 10:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iPqvicQh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MJJHq2Aw"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EB82BDC0C;
	Thu,  5 Feb 2026 10:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770285831; cv=none; b=Nnibb/A6rNDkohfoubhiH0/K5lJ1mcQjttpDl0yBROlsDhEMCDMWqJQrUIFJRlWT8v79XgA0/Z1SryEZb5Z2SDr21wQ5i3My2gXxMwAFcBbHsFqgXJKUV0hik0oMVU7bj1H6LFenPrjDrrllg7aubLMQCBYfL43wvLU9PJsUelQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770285831; c=relaxed/simple;
	bh=2o0ihCwjD7pZSGRPBQ65CA+7KpSJ+6cmHCpxQv9lEzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQjk6LAw+f2qR+Zo4O467YrLoYL1l2kZRmjlhxnw6Dy9YL+9zPqJY05pQFH3hXYRLPJTfCnuIb8V6kO7TeOQ2F7E7R0tbVhHMFqCouZDPdYk/Ewq3rXiI8H6+UD6oMo6eBW0+aFRSmtngMeDn5oQvXwcLrM9+VfxktTfJHFqwEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iPqvicQh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MJJHq2Aw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 5 Feb 2026 11:03:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770285829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fQPyjkQUj0CrgCplTVC5o5k5VpSdyGnFYoPkqfUzEeg=;
	b=iPqvicQhcMbKs6L3g8urxCaD0uZU5Aj/5gzzDosbTiSZg4r7ibS8urYnIiN6TV98KotHnc
	34ebAipEqJGqeO8qmJqQdQg7EP7HC8iDT5imaaboa6e5e1M547mBn80oqocVRIiMNEaPHl
	LN97gqynFq445YSqHmmUhhL6aLCX/RUVuACaolQjis5F/GqWXjao9raH6vEo9/S1pZI5Kw
	gwz5xj5U+HFI6r4tYpkWyLmBzrOEjhZDFOlBo8qVQRsFrzU7jvsZkSfOqSajtBcqr++72z
	WjZ+6d/qeHlGNedOJ9nUb7ERCHiwLplwMbWrSSgQfY9wvwCcQFWYb2dpP9B+WA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770285829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fQPyjkQUj0CrgCplTVC5o5k5VpSdyGnFYoPkqfUzEeg=;
	b=MJJHq2AwE5PKr3woWyhX/HVcZwwGwCSXv8vVxC7+nSWxrjP+mCOGSXecuWttfNslXOHhVl
	t1F2j/aGYl+tc0AQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"Gomes, Vinicius" <vinicius.gomes@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: RE: [Intel-wired-lan] [PATCH iwl-next v3] igb: Retrieve Tx
 timestamp directly from interrupt for i210
Message-ID: <20260205100347.ssTBDAI_@linutronix.de>
References: <20260205-igb_irq_ts-v3-1-2efc7bc4b885@linutronix.de>
 <IA3PR11MB898652699383BA265C5747A5E599A@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <IA3PR11MB898652699383BA265C5747A5E599A@IA3PR11MB8986.namprd11.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257102-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,intel.com,molgen.mpg.de,linux.dev,vger.kernel.org,gmail.com,lunn.ch,google.com,lists.osuosl.org,kernel.org,redhat.com,davemloft.net];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:mid,linutronix.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 53EE3F1285
X-Rspamd-Action: no action

On 2026-02-05 09:47:14 [+0000], Loktionov, Aleksandr wrote:
=E2=80=A6
> > --- a/drivers/net/ethernet/intel/igb/igb_ptp.c
> > +++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
> > @@ -796,6 +796,28 @@ static int igb_ptp_verify_pin(struct
=E2=80=A6
> > +	igb_ptp_tx_hwtstamp(adapter); <-Calls existing function designed for =
work queue!
>=20
> skb_tstamp_tx() can sleep
> Smells like sleep-in-atomic isn't it?

How or where can it sleep?

Sebastian

