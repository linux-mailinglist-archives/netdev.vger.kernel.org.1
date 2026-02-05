Return-Path: <netdev+bounces-257147-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDo6LjGHhGl43QMAu9opvQ
	(envelope-from <netdev+bounces-257147-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 13:04:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B53F22FA
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 13:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5A6830523EE
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 11:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4A93B95F8;
	Thu,  5 Feb 2026 11:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vN4rmS3Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6+ZmsWrQ"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82973ACF1D;
	Thu,  5 Feb 2026 11:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770292709; cv=none; b=A6PFInB0qclPfQcnPRsVtYnpaCHgvJF3zAFGjbVuMDv47BpDISJ877oUKNSRZhLQ3wn+cyP3agF75VZHhBGGdv+bPZaOB6rbfuzfL1MEPjA8/YR51AGnoxtjeuZt8ag9QvN0oIguc7w6GOzt2z/YcUxB6MBIQ7IJ94bPy8QLSG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770292709; c=relaxed/simple;
	bh=N23dYywCMziktifosectkdnNS1A8dZ9vP+mNzg0bllg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vCUgxS6Eo+H/tCSp6FVHaGp5RYOlxVCXnunbEJhaL/2eaIFkkXmVUAs9Rr910/sqfiZr0zuGdgUiLULpy/v3t5IxPPiVajowkvFp36feWK/Ij8RCJCKIRZ2PZlzB49k7JDvBEpUuOJrFUaAB4RVdJXGVVHP2MabOGMS8Ba+2Frs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vN4rmS3Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6+ZmsWrQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770292706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FaY+zcPJsv44lhmYeTzy0QXccJoXnwqwWFDyKJTpeRc=;
	b=vN4rmS3QaOHC0G2Y7Vyl87abmG6X+AMgvf7NovoT/aTYnlc6qAXMxaUQ49STghr8zEkt/E
	rHU3dPC1LkzlC6I5GJFLtiHfzI2o5el4AKztHm/DDXbcCD4NvOIWPJECN3eDVUfRo4PgLs
	mYL1jRViE/RJTWfsJE8ITrfcqNfK/wg5qPt3hyBAygA6T+c9aVsSV9WGpumf+LSmKcTh6k
	ZmWb+ub3339Bc1SD2NLyNEOlKQnU0XFBpmdY9FUksX9Aagcm9QqY5xKkKDDaZu5gdIc4IS
	1L/A2ffInttIkqRVAl5aurEE7+QVG9CE5dwgza3gp/9vcv+fN3m0v4pdE31cMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770292706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FaY+zcPJsv44lhmYeTzy0QXccJoXnwqwWFDyKJTpeRc=;
	b=6+ZmsWrQWpPklOV8aRq2FmT4SM82M6hCiQyG9ciE6tr66UcF4kwMHiaKRiSy+Y4bp+KmzW
	C7u56BbNeEl8UCCQ==
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Nguyen, Anthony
 L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, "Gomes, Vinicius" <vinicius.gomes@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric
 Dumazet <edumazet@google.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v3] igb: Retrieve Tx
 timestamp directly from interrupt for i210
In-Reply-To: <IA3PR11MB898652699383BA265C5747A5E599A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260205-igb_irq_ts-v3-1-2efc7bc4b885@linutronix.de>
 <IA3PR11MB898652699383BA265C5747A5E599A@IA3PR11MB8986.namprd11.prod.outlook.com>
Date: Thu, 05 Feb 2026 12:58:24 +0100
Message-ID: <87ikcbwgf3.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[molgen.mpg.de,linux.dev,intel.com,vger.kernel.org,gmail.com,lunn.ch,google.com,lists.osuosl.org,kernel.org,redhat.com,davemloft.net,linutronix.de];
	TAGGED_FROM(0.00)[bounces-257147-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kurt@linutronix.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jax.kurt.home:mid,linutronix.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 29B53F22FA
X-Rspamd-Action: no action

--=-=-=
Content-Type: text/plain

On Thu Feb 05 2026, Loktionov, Aleksandr wrote:
>> +/**
>> + * igb_ptp_tx_tstamp_event
>> + * @adapter: pointer to igb adapter
>> + *
>> + * This function checks the TSYNCTXCTL valid bit and stores the Tx
>> +hardware
>> + * timestamp at the current skb.
>> + **/
>> +void igb_ptp_tx_tstamp_event(struct igb_adapter *adapter) {
>> +	struct e1000_hw *hw = &adapter->hw;
>> +	u32 tsynctxctl;
>> +
>> +	if (!adapter->ptp_tx_skb)
>> +		return;
>> +
>> +	tsynctxctl = rd32(E1000_TSYNCTXCTL);
>> +	if (WARN_ON_ONCE(!(tsynctxctl & E1000_TSYNCTXCTL_VALID)))
>> +		return;
>> +
>> +	igb_ptp_tx_hwtstamp(adapter); <-Calls existing function designed for work queue!
>
> skb_tstamp_tx() can sleep
> Smells like sleep-in-atomic isn't it?

AFAICS skb_tstamp_tx() is safe to call here.

> spin_lock_irqsave(&wq_head->lock, flags);  <- RT mutex can sleep

In case you're worried about PREEMPT_RT: On -RT the IRQ runs a dedicated
thread. BTW I've tested this with and without -RT and with
CONFIG_DEBUG_ATOMIC_SLEEP.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmmEheATHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgpSIEACp5OFasb0yP4xndC0NnYoFS2pJFu4A
kYJaT8KZ+Om5qTpruFYi+RAz4eGL97eqg0+sOJTyx5QhQhl2glDe7OJMOyG3+k7u
LLOwCnIfldZI/7MatML3r5RmU5McpyN5lm4pLINEUPhRtfHzX9nH59mOQbrJsD7r
sSFxVvyd0IobQyJOhfS5rgxlNWnPAPHiv7iXglR5+fwWGIDXxYeZ82WeV9GhcIe5
hXOCrQcPqfodbNhuC+8g0q4N0tbTF/IINpv/s+O9F+9mCMmbteSEZIr02BGI4GbJ
dwUGLzj8vJYw0Cpz3lZDKesBYGz+qrKSbEdCUFDswlxyjFk2NlYjEP5pU+E9ssE6
ExDotEp/WgCj5AVTC2O0f4SuYs2EPwWBIfa0L4zcs8KHmRzwP9MoQ+ZK6tjlPCd5
FzAVdrLFgNgABUOD6GuvU4tUYjNQY/W1lGeYKrDL/KSeBBtpIAMSXsd6aOIGkKp7
AsZ0eNwLFfnWCuAFGqvn5PJfCJzbPmeIXDz2ZxFaH8GPwhDdEjrOMSR4djmtcleC
txcUduxQaBZlF2SyaJGHI96qs8D5aM2AQs0Pi7M2SvaSxXZXjTaYTgleRLZELmqs
QyqkwOa4pLUGIlBzupzo6n9BxCJ1WM74zOwoZIvcCUAMTrCsrojMxJNOfDlOawNA
wd2tjTxoKKz/7w==
=R2Ag
-----END PGP SIGNATURE-----
--=-=-=--

