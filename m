Return-Path: <netdev+bounces-257221-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDkoN7iuhGk14QMAu9opvQ
	(envelope-from <netdev+bounces-257221-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 15:52:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC75F4448
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 15:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32EF9303180D
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 14:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E553D3D19;
	Thu,  5 Feb 2026 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hxRSq51+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YWDckvJa"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E527F212B2F;
	Thu,  5 Feb 2026 14:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770303068; cv=none; b=CQkF3kgb3wPvaKxemcFU5ZPfoiIFlmw60/h0GdcoJpsdtoqYqcBG6k1rfygriGNiVnd6IQMcKFD18y9Zx73YrMugdDJdCtYgXYqos2GAf2USMycRkxi2BE5KxX2xfYBIDrIQACnk2ynEB4TJN/vaKRILpwNJJtV+4+en958+Dsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770303068; c=relaxed/simple;
	bh=yZElp3SuD1M3AlixNxIjQSMZHv6Pj7owFsrOPM3Krgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iU/spqtU1JW0MTPjtL2TxBs2f4Thk6tF6iKy6MdbEk8aPg43IGAC4iJgknSC+kV6WcJNfPN9sQ4w6DSiXpLmW5wCMLl6GGsYseDzAr8LRumZm4WaD64T+Q+Hsig1tASj1RPDIoDI8m8/LrEiAi3hz1IjanhPIRlo/WRQrJe88hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hxRSq51+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YWDckvJa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 5 Feb 2026 15:51:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770303066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+XoniR1si/Fc1Mse1sltdw+xLs5P1HKQG4eFrinu7Jk=;
	b=hxRSq51++0xlBWxa+vAr3WU6zi1Cx2N1v11kBsREHr333phA4SBWpw/pi7pLn6UKlRydp4
	/UJ/uthoIywH2LzEbe1IL0qirDEQxPrd0w0HxPrggonk5xRldfIZWn+l0BmbKU0qvKFDwa
	6FB4w4LFBBROkw0UTDRT7xa9KYCHMscj66Q+IejM5jXOaxOTk2Tte6UvTjOa5SOckfTKFf
	RNbzg4M619l37cPv+/z4sEhXmoUm0YZ64Nz4Uijfl+xJw2AX+3YyujPMyAoaT2/vnIdEAG
	GSiQYtXbv2ybfSdleBvReBWyH9lbTUwVwm2CkHHlcY6XyqF4X0Si0JLPUpP4Ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770303066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+XoniR1si/Fc1Mse1sltdw+xLs5P1HKQG4eFrinu7Jk=;
	b=YWDckvJak0H7GkqEAg1T3ok8Jm0bZmUK2IYfQB2/LYPLzqTjhEUOuhLccbijxJnZWQRSo8
	vZfKl5/Vfs7bDrCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
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
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] igb: Retrieve Tx timestamp
 directly from interrupt for i210
Message-ID: <20260205145104.iWinkXHv@linutronix.de>
References: <20260205-igb_irq_ts-v3-1-2efc7bc4b885@linutronix.de>
 <IA3PR11MB898652699383BA265C5747A5E599A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <20260205100347.ssTBDAI_@linutronix.de>
 <IA3PR11MB89865B46DCBEB496BE28703BE599A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <6a0f4cbb-e8b3-4f0e-b7f1-7f9ca5cba97d@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6a0f4cbb-e8b3-4f0e-b7f1-7f9ca5cba97d@linux.dev>
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
	FREEMAIL_CC(0.00)[intel.com,linutronix.de,molgen.mpg.de,vger.kernel.org,gmail.com,lunn.ch,google.com,lists.osuosl.org,kernel.org,redhat.com,davemloft.net];
	TAGGED_FROM(0.00)[bounces-257221-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6CC75F4448
X-Rspamd-Action: no action

On 2026-02-05 11:56:44 [+0000], Vadim Fedorenko wrote:
> On 05/02/2026 10:37, Loktionov, Aleksandr wrote:
> > spin_lock_irqsave(&wq_head->lock, flags);  <- RT mutex can sleep
>=20
> Hmm... that actually means we have some drivers broken for RT kernels if
> they are processing TX timestamps within a single irq vector:
> - hisilicon/hns3
> - intel/i40e (and ice probably)
> - marvell/mvpp2
>=20
> For igb/igc/i40e it's still OK to process TX timestamps directly in
> MSI-X configuration, as ring processing has separate vector, right?

The statement made above is not accurate. Each and every driver does
request_irq() and here on PREEMPT_RT you can freely acquire spinlock_t.

But !RT looks problematic=E2=80=A6

__skb_tstamp_tx() invokes skb_may_tx_timestamp() which should exit early
most of the time due to the passed bool (which is true) or
sysctl_tstamp_allow_data which is true. However, should both be false
then it tries to
	read_lock_bh(&sk->sk_callback_lock);

where lockdep will complain because this lock is now acquired with
disabled interrupts.

The function will attempt do free the fresh/ cloned skb in error case
via kfree_skb(). Since it is fresh skb, sk_buff::destructor is NULL and
the warning in skb_release_head_state() won't trigger.

So the only thing that bothers me is the read_lock_bh() in
skb_may_tx_timestamp() which deadlocks if the socket is write-locked on
the same CPU.

> But in general skb_tstamp_tx should be moved to BH processing (NAPI poll
> callback).

Sebastian

