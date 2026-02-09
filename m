Return-Path: <netdev+bounces-257917-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDyDK5WjiWlU/wQAu9opvQ
	(envelope-from <netdev+bounces-257917-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 10:06:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1880D10D55C
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 10:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 405023006791
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 09:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5510F328B63;
	Mon,  9 Feb 2026 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nds2+wjT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KBSLFnNv"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A790328B47;
	Mon,  9 Feb 2026 09:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770627984; cv=none; b=HPdQcg1IRMIu4nBjSHl1q3ugCdlsUKZ0Zj53Z1Uk5RAHTHzBlgN3Gsu2g5ZLo6O1aPHMklbbt75XT0AP7wt1/eOosXOfRu1n2uyGvfnLh4gz/uvY/6hbohdGFUnGc/LALGc/BL1KtdbGGvAtgTRU4lHQFG9XoSuncL11jiuObS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770627984; c=relaxed/simple;
	bh=izwmXDGcOhI1rhK1YptHQ0xdhXMS3g/xP1mQsaYPcIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kf0KS7/DkMglbFZqEpaGzDSlc6nVI6QPE5wl+m09+Gj419TJABG1wDyoEGDSuFuFI71zB5a1kvh2GYgXdfv5i7UAFqbjYpue5jcvdX+WC4OD6nr5oGNkBXfKgUD7wjIexhU/F78irB1yhCJ8gao4xksQPJ44qamiIMEspsI+AZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nds2+wjT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KBSLFnNv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 9 Feb 2026 10:06:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770627982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=izwmXDGcOhI1rhK1YptHQ0xdhXMS3g/xP1mQsaYPcIA=;
	b=nds2+wjToppI2hWlDjPSv8KFw0Ambxp/OYf6TtQ2EAxUoHIdSZNhrP1jpDUPIYEE3d6md7
	epTZl1IXdHbpnpQKgOImpOLKdnnQiJwmBUXli54nJql3JTmhiI9PoCimLzgUtGVRFrjWEd
	+a3HgIdIqrL9zd25v7SXSng03Y/DBCEMzx+4RvLcl4DCAGjZckAHWGUjZD5aMMkzk1xadu
	lgi+XfHVTjP0WXxrzb2IH7KMjMrwi13EvWehA143lpJl5swkt+YG9SEmEObrhoe8HTvYCS
	Uk+SfPXWxgXtl8wplu3Jzgy2njVwokzyb2EXrr1dZDi2tB4c4Zv/OI2GaOEOGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770627982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=izwmXDGcOhI1rhK1YptHQ0xdhXMS3g/xP1mQsaYPcIA=;
	b=KBSLFnNvVcg2VTnTtba4F0uRzD1NwuN+RJSvnCmiYMGvjLlKaSRLdMEQV5hWqEbta+ksb1
	WUj29unSJMCYVFBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
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
Message-ID: <20260209090621.GiZqTiMJ@linutronix.de>
References: <20260205100347.ssTBDAI_@linutronix.de>
 <IA3PR11MB89865B46DCBEB496BE28703BE599A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <6a0f4cbb-e8b3-4f0e-b7f1-7f9ca5cba97d@linux.dev>
 <20260205145104.iWinkXHv@linutronix.de>
 <66925f09-ef9f-4401-baec-7d4c82a68ce3@linux.dev>
 <20260205164341.pJvni8kA@linutronix.de>
 <76acd5cc-eb6f-4c56-a5e6-f6413736afbb@linux.dev>
 <willemdebruijn.kernel.459b2672b1e7@gmail.com>
 <601f0c4b-52d8-4b60-96bf-f2d65f8073d8@linux.dev>
 <willemdebruijn.kernel.bbdefedfb87e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <willemdebruijn.kernel.bbdefedfb87e@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257917-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux.dev,google.com,kernel.org,redhat.com,davemloft.net,intel.com,linutronix.de,molgen.mpg.de,vger.kernel.org,gmail.com,lunn.ch,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1880D10D55C
X-Rspamd-Action: no action

On 2026-02-08 11:25:40 [-0500], Willem de Bruijn wrote:
> > >> But it's more like a question to maintainers whether it is acceptable
> > >> way of "fixing" drivers or it's no-go solution
> > >=20
> > > Requiring OPT_TSONLY unless CAP_NET_RAW would break legacy users.
> >=20
> > Well, they are kinda broken already. Without OPT_TSONLY and CAP_NET_RAW=
 all TX
> > timestamps are silently dropped.
>=20
> Are you referring to sysctl_tstamp_allow_data?
>=20
> That is enabled by default.

Yes. If so, then we don't need the check below which requires
sk_callback_lock.

Are SIOCSHWTSTAMP the legacy users or the ones which do not set
OPT_TSONLY?

I would suggest to move the CAP_NET_RAW check to the point where
timestamping is getting enabled.
Also if ndo_hwtstamp_set is the preferred method of getting things done,
I could check how many old ones are can be easily converted=E2=80=A6

> > To receive these timestamps users have to get
> > CAP_NET_RAW permission, and it will work with the updated logic as well=
=2E..

Sebastian

