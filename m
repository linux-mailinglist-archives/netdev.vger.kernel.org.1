Return-Path: <netdev+bounces-258473-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFJDMyUEjmlf+gAAu9opvQ
	(envelope-from <netdev+bounces-258473-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 17:47:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D2412F938
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 17:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ABBA6300D0C6
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 16:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846B5188596;
	Thu, 12 Feb 2026 16:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N+K6lj3w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="btvf8tIt"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56542224B05;
	Thu, 12 Feb 2026 16:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770914849; cv=none; b=CLEA3ZNCpL5UE0BRezAenGKZsaGUqYRx9FxVnT1ItescKqr8rT83g+GGdT84FdCeeY4l+QN7zUY0j+3xHH92hpjVQigZDKCwPUgDw+vTNXSFXP+Xc/huF48QQWyPSOqh2X6Hz8/ONl8tCRV1d0M0RTYLMOzHnUDz7g5DrWKen6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770914849; c=relaxed/simple;
	bh=s/DyEPe+77NoYsDIGpxy2seHogqaqunQv6TIiFOPDzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYpQhdZ7MYPThJyuzJmtbf48VJpWfqrCmbFIHMIivlAja5zGD4nKwLjr+kmiWDx3I2LB8PweQQoBUGV0sPq6yqwRtA44aDt+nIE8gpNZYf80tKdzHAnfrwljcIfqdWw8xw1L00MXHdLeJLiWeDwN+HEQc0AKqev/L/lRelpgikk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N+K6lj3w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=btvf8tIt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 12 Feb 2026 17:47:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770914846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s/DyEPe+77NoYsDIGpxy2seHogqaqunQv6TIiFOPDzI=;
	b=N+K6lj3wl0VbioEZ2q8gSVvJkdOh63504F2+D57irJaU2pWVpxcMDwW9us2dAeOCkB/87C
	+QBuXkmNV+2uv2l5Rv6bomcRt4GBEOzbGtYteuiWnLRR3fLUbPgh1g1mHzovFydc/yjjds
	9cPwYvdaVH8N7HpjkDlUQYYqs87NCmNd3vtohZSP0bkHKFo7bd0f7Iy4hwigfKarWD2LJY
	x+N/LBXH9JCfQHOV9/+6NjeFbfX+RZHl8VXpVRq/0He245+/CjNjude04vIqPCIjJnbMUI
	E0Z/y55krglNbf8fu8b+K/KNn2E2EACfL1AecxGuyPmjUed+yYkmWdEE5hanGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770914846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s/DyEPe+77NoYsDIGpxy2seHogqaqunQv6TIiFOPDzI=;
	b=btvf8tItfDYAqnNr2fTa3aIBM0VfbBgRuxc5XlsgCD+E/96PiUpsz5xehfp5OiFe9pqUAc
	nsEH/9rOuy4fCGBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	"Gomes, Vinicius" <vinicius.gomes@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] igb: Retrieve Tx timestamp
 directly from interrupt for i210
Message-ID: <20260212164725.ltllw51l@linutronix.de>
References: <20260209090621.GiZqTiMJ@linutronix.de>
 <8e762437-69f9-40d7-bb75-3a45bef1d5d6@linux.dev>
 <20260209114836.GPU-vnnh@linutronix.de>
 <78e2af2c-40e6-43f1-9471-42f350e69389@linux.dev>
 <willemdebruijn.kernel.2e6213a98660b@gmail.com>
 <20260210121207.9kLHroS0@linutronix.de>
 <willemdebruijn.kernel.cceee43f5b9b@gmail.com>
 <87qzqr5vos.fsf@jax.kurt.home>
 <12520aac-c69a-41a0-9710-497392bc18f6@intel.com>
 <20260211134436.1e623034@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260211134436.1e623034@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258473-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,linutronix.de,gmail.com,linux.dev,google.com,redhat.com,davemloft.net,molgen.mpg.de,vger.kernel.org,lunn.ch,lists.osuosl.org];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: 72D2412F938
X-Rspamd-Action: no action

On 2026-02-11 13:44:36 [-0800], Jakub Kicinski wrote:
> On Wed, 11 Feb 2026 11:29:03 -0800 Jacob Keller wrote:
> > > Moving the timestamping in IRQ looked like a good solution, because t=
he
> > > device already signals that the Tx timestamp is available now. No need
> > > to schedule any worker/work at all. So, it'd be very nice if
> > > skb_tstamp_tx() could be called from IRQ context. BTW other drivers l=
ike
> > > igc call this function in IRQ context as well.
> >=20
> > Right. Reporting the timestamp from the interrupt is the simplest and=
=20
> > lowest latency method. I know Miroslav had some situations and devices=
=20
> > where it apparently caused more problems than it helped, though I don't=
=20
> > believe anyone else has reproduced those?
>=20
> There's a BH workqueue now, as a replacement for tasklets.
> Presumably smallest fix would be to switch to that?

Hmm. This would raise the TASKLET softirq from the interrupt handler and
then handle it on the irq-exit path.=20
Let me look if that one lock can be removed first=E2=80=A6

Sebastian

