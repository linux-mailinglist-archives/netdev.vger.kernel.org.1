Return-Path: <netdev+bounces-259028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDKMHA5tlGkEDwIAu9opvQ
	(envelope-from <netdev+bounces-259028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 14:28:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EEC14C91F
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 14:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4DB9300AEF2
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 13:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93BF36AB5B;
	Tue, 17 Feb 2026 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XtN9DsKn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="umWQX51f"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6512DF6E9
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771334922; cv=none; b=eOe/y8sqm3uWeTI+JXLQmH91aLQdV8LyUBhs4yZ31tTSdJcQ2qmfGvVqF7pcw8v+v/IdB42+rzIwmCqvHrO0ccmoXvjtyw7fbhEiFXSm64dEmJDV0VpKiMGQrAnjXCrgxMT4MfPi/I9ZMQPs1Dmf5wxWkHbJlNt3Hn+pv9nrc64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771334922; c=relaxed/simple;
	bh=dzF54vHa4qv4qsKiqfLWwFCBx2jgiBg+WXVjMwwVwiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdvAdjYySsFdj8Vhmy54t4G9PmQo3rWX/6EYfQMg6inj1fbFenVGevyUZeRPFZaZIvqjhNI3FfXlVopK1iCfXF9UMqtR2yS3ys1TZ0Sl/VZzZZcgGFnnx9XPqlCobwNCCjms3PPsHQPVbIc+uBPwn77YXQx/0G6G8HLMamVzdKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XtN9DsKn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=umWQX51f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Feb 2026 14:28:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771334919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WWmu+0Yz56GzeboLvFV77hV87S/DSzzD383ahe/Igrg=;
	b=XtN9DsKn+9pP7YRN9O7o4++GYJ7ynPFtyns4igqPlfQRc3mV0t6QaM9zWEIvsqJGS8i2Uy
	fSn9iMk1rQ4ncKpWbeJCgcWdJfz/IWgf1PUu8ijbFaR6c9og1Ek4Hv/Nhxdkas27AKAQ8V
	STW8v01622cvjIeS6oEs35r7D+6HE7mhU2v1aAd4aY5q0CrXRx4JJqTMrVf9Q4meCKXN5X
	LXx1GQx13sMBN6wrBA9dOaVJeSY/EH6VerqFirBsNZl728NIqmbC/SaCIsGZWdua/aMEXS
	exgYiRS3wONu0uRvA9E0bgT3FZeHrvQVujXncFr8mBIQ+84L7VeSp+Ukj/S7ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771334919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WWmu+0Yz56GzeboLvFV77hV87S/DSzzD383ahe/Igrg=;
	b=umWQX51fWOH5sjmbIxfmpnaRclf0YtshuvDaupf7OwVgGeUeZ1GrDfIcS9ZbREuoRXXYeb
	JxduCWfRYUKS4FCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net] net: Drop the lock in skb_may_tx_timestamp()
Message-ID: <20260217132838.kgRAQ87W@linutronix.de>
References: <20260214232456.A37oV4KQ@linutronix.de>
 <willemdebruijn.kernel.1682a93525c87@gmail.com>
 <20260215184608.8dk4hemG@linutronix.de>
 <9130dfca-1e85-4975-8df9-4de8bd9e8f5e@linux.dev>
 <willemdebruijn.kernel.3b597169afaae@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <willemdebruijn.kernel.3b597169afaae@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259028-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: E2EEC14C91F
X-Rspamd-Action: no action

On 2026-02-16 13:08:43 [-0500], Willem de Bruijn wrote:
> It will be great to have this additional context in the commit
> message.
>=20
> And a Link: to the original discussion thread.

Okay.

> Btw, the commit states that a few drivers already call this from their
> hard interrupt handler. Can you point to one or two?

- bxcan_tx_isr() -> can_get_echo_skb() -> __can_get_echo_skb() ->
  skb_tstamp_tx()

- at91_irq() -> at91_irq_tx() -> can_get_echo_skb() -> =E2=80=A6 ->
  skb_tstamp_tx()

- hclge_misc_irq_handle() -> hclge_ptp_clean_tx_hwts() ->
  skb_tstamp_tx()

- igc_intr_msi() -> igc_tsync_interrupt() -> igc_ptp_tx_tstamp_event()
  -> igc_ptp_tx_hwtstamp() -> igc_ptp_tx_reg_to_stamp() ->
  skb_tstamp_tx()

> If this is only for new drivers, it would be vastly preferable if this
> can go through net-next.

I found three, I knew about igc. I don't mind net-next but if we keep
the stable tag, it will be backported anyway, it will just take longer.
But if we want to do this in order to catch problems with it before it
hits stable then it makes sense.

Sebastian

