Return-Path: <netdev+bounces-257935-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHFKJm7biWndCgAAu9opvQ
	(envelope-from <netdev+bounces-257935-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 14:04:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 156F310F633
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 14:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A244F301CC48
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 11:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BB3372B5E;
	Mon,  9 Feb 2026 11:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A31THiiX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l0fcvTmR"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1400372B38;
	Mon,  9 Feb 2026 11:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770637720; cv=none; b=oZ7WEQJxt6MpUQGXI/P2hbe5YzXSgREIL2LyJtmL2i7qPuS1qSDtzYA3IpzOgI/yxLQzOh3apUYUX4rtNZW5rKt8lUO8d8jTdOmJ48HBELPBqTrJiCLHNZazJuOWuKH1g56pL2wzmb+ty5NJOX0SzyqOy7j5HWFewmkZQGhbL4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770637720; c=relaxed/simple;
	bh=bii6nDpRq3u0mpk5uwFaoKraWGApqndaiRM8N5c949k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPMKNMAIsU/qiJ5s5b14mfJC+unM+lxLRaxJ3iliDMeXIFX35/5NOmUvozurcmF2UBSo/J/LfOoEMCOqq/PgbfO0JDjcY9cZHJSO3Ww1riXgNnWp8aDVJ6Gi19WzwfLlJ9EFadN5v/t2EyxRIo5qFIFo3JRg0u4kh7xO95AwABk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A31THiiX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l0fcvTmR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 9 Feb 2026 12:48:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770637718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bii6nDpRq3u0mpk5uwFaoKraWGApqndaiRM8N5c949k=;
	b=A31THiiXz/ZEIBWBv9USPdzhGFjS+SGL92Q7iViSw2762PATFFUy6ZZgX3AxSH4CAXs/DF
	9EEk+SyCQZzPKjl9g2IIGUxwQyGQP3EZIyhixke96C998lAB8bo0rUPRh35UImFZokyOHI
	qKEWWe32YXtrlsFKkyKNskEvQI3UwxOgactbVBQzJHknxz99jxc1I30DZkaJWyJ1RVMtRS
	s44DgJou9Kx/YRZSO5O2sENh10/dAVxGadEIaTz+lJ1fS9LCB7Wzw+NMOrzgaIpNgDTURF
	TKdTCVSdlfeJWzCWJwFNQbqKNHtSXLe8Bii6uBJIAUwM8JGIdvLeTxj6+z9/oQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770637718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bii6nDpRq3u0mpk5uwFaoKraWGApqndaiRM8N5c949k=;
	b=l0fcvTmRCFEA7JLnK8XN1VpILVOQ5rHWlrEEm4fFMfqcV8w9osP7VJYir6sXCGjcsLC+8l
	+fLT7xoD74c8vIDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	"Gomes, Vinicius" <vinicius.gomes@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] igb: Retrieve Tx timestamp
 directly from interrupt for i210
Message-ID: <20260209114836.GPU-vnnh@linutronix.de>
References: <6a0f4cbb-e8b3-4f0e-b7f1-7f9ca5cba97d@linux.dev>
 <20260205145104.iWinkXHv@linutronix.de>
 <66925f09-ef9f-4401-baec-7d4c82a68ce3@linux.dev>
 <20260205164341.pJvni8kA@linutronix.de>
 <76acd5cc-eb6f-4c56-a5e6-f6413736afbb@linux.dev>
 <willemdebruijn.kernel.459b2672b1e7@gmail.com>
 <601f0c4b-52d8-4b60-96bf-f2d65f8073d8@linux.dev>
 <willemdebruijn.kernel.bbdefedfb87e@gmail.com>
 <20260209090621.GiZqTiMJ@linutronix.de>
 <8e762437-69f9-40d7-bb75-3a45bef1d5d6@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8e762437-69f9-40d7-bb75-3a45bef1d5d6@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257935-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,kernel.org,redhat.com,davemloft.net,intel.com,linutronix.de,molgen.mpg.de,vger.kernel.org,lunn.ch,lists.osuosl.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 156F310F633
X-Rspamd-Action: no action

On 2026-02-09 10:43:55 [+0000], Vadim Fedorenko wrote:
> On 09/02/2026 09:06, Sebastian Andrzej Siewior wrote:
> > On 2026-02-08 11:25:40 [-0500], Willem de Bruijn wrote:
> > > > > > But it's more like a question to maintainers whether it is acce=
ptable
> > > > > > way of "fixing" drivers or it's no-go solution
> > > > >=20
> > > > > Requiring OPT_TSONLY unless CAP_NET_RAW would break legacy users.
> > > >=20
> > > > Well, they are kinda broken already. Without OPT_TSONLY and CAP_NET=
_RAW all TX
> > > > timestamps are silently dropped.
> > >=20
> > > Are you referring to sysctl_tstamp_allow_data?
> > >=20
> > > That is enabled by default.
> >=20
> > Yes. If so, then we don't need the check below which requires
> > sk_callback_lock.
> >=20
> > Are SIOCSHWTSTAMP the legacy users or the ones which do not set
> > OPT_TSONLY?
> >=20
> > I would suggest to move the CAP_NET_RAW check to the point where
> > timestamping is getting enabled.
> > Also if ndo_hwtstamp_set is the preferred method of getting things done,
> > I could check how many old ones are can be easily converted=E2=80=A6
>=20
> Looks like you are mixing things. SIOCSHWTSTAMP/ndo_hwtstamp_set are HW
> configuration calls while OPT_TSONLY is socket option, which is setup via
> setsockopt, you can find points searching for
> SOF_TIMESTAMPING_OPT_TSONLY in the sources, basically
> sock_set_timestamping() is the function to check

Yeah, but what is the legacy user here? If you enable HW-timestamps but
never set OPT_TSONLY and the sysctl is also 0 then you reply on the
CAP_NET_RAW later on. Right?

I just try to justify the CAP_NET_RAW check and if it is required to
move it earlier (where HW timestamps are enabled). And if the sysctl
check is enough then maybe it is not needed.
=20
> > > > To receive these timestamps users have to get
> > > > CAP_NET_RAW permission, and it will work with the updated logic as =
well...

Sebastian

