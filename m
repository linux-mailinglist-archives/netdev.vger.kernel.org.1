Return-Path: <netdev+bounces-303444-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tCLzGH5/RGpqvwoAu9opvQ
	(envelope-from <netdev+bounces-303444-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 04:46:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 403016E94C1
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 04:46:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=OL4YoBGb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303444-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303444-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 125D0302AE3B
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 02:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941E51A682A;
	Wed,  1 Jul 2026 02:46:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3230136358
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 02:46:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782873969; cv=none; b=Nwmh4UUof9xbCJ7TwkPqZUniZQJkAbLLwPs37FrB7vQ5/B3RsBHCGnLtyiB+U5iAL5RQsJwxg7JdavdmL24vrv053BQ6yc+7dM/y/wAdqZG7vH3Q/F1gk/02WqVjH+S54EL1bGzdD6DfTk3BVtiinDc6sEAZS+r0JVMOzQ8cIiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782873969; c=relaxed/simple;
	bh=AkM2YMbS4cgrcGDPieW2Q/7KIitk4hyUSMotQdJZHd0=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=p6+SYJbx05pJ4saWS8Q5uq0y0WxnaJguekTttOfLvYN5BTWZJJkDnKYo61JkVHEf6KZu34LhFtjsc1TrkIoJLkbFl0quQa/SKe7WlN1kJ9CBqyTeIwqkI7xjw7ZSPIBXiMR23duA727fthfBXMk0ukIx51cHE1AQiDasPftWGZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OL4YoBGb; arc=none smtp.client-ip=95.215.58.171
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782873955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pGyYp8fgvM0spGaHVAVIN+LiPqSPwBtl4s6NpkpojzU=;
	b=OL4YoBGbS7vuYSsBvGPeotMJNvKpOq0DOYLqAUBiJ9x7OuDuOTiBFJolspB+C1Rq8L26Kg
	RI1EW/adYnx/it3Zf0waWtnQDcL7D9PeItx6Ldqgaga03Xfpha2ZdIyVxWLkGuLpz6srBo
	nYwJ7eVCqV6H3Fn2pngiezhLkJ+6UgM=
Date: Wed, 01 Jul 2026 02:45:49 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Tianchu Chen" <tianchu.chen@linux.dev>
Message-ID: <eb9d8a511c83224d1af492799b551e33fca8c7d1@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] net: usb: cx82310_eth: stop parsing reboot marker as
 packet
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20260630154255.2954c33a@kernel.org>
References: <700e16e9523d7f1299b00df75b13a3c66b6e517b@linux.dev>
 <20260629174458.6ebf647d@kernel.org>
 <e87b8ecf4bbcf87635d144508bf35377dd5397b3@linux.dev>
 <20260630154255.2954c33a@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303444-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[tianchu.chen@linux.dev,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tianchu.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,tencent.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 403016E94C1

July 1, 2026 at 6:42 AM, "Jakub Kicinski" <kuba@kernel.org mailto:kuba@ke=
rnel.org?to=3D%22Jakub%20Kicinski%22%20%3Ckuba%40kernel.org%3E > wrote:

>=20
>=20On Tue, 30 Jun 2026 10:30:53 +0000 Tianchu Chen wrote:
>=20
>=20>=20
>=20> June 30, 2026 at 8:44 AM, "Jakub Kicinski" <kuba@kernel.org mailto:=
kuba@kernel.org?to=3D%22Jakub%20Kicinski%22%20%3Ckuba%40kernel.org%3E > w=
rote:
> >  On Thu, 25 Jun 2026 15:32:04 +0000 Tianchu Chen wrote:
> >  > From: Tianchu Chen <flynnnchen@tencent.com>
> >  >=20
>=20>  > Discovered by Atuin - Automated Vulnerability Discovery Engine.
> >  >=20
>=20>  > cx82310_rx_fixup() treats an RX length of 0xffff as a device reb=
oot
> >  > marker and schedules work to re-enable ethernet mode, but then con=
tinues
> >  > processing the marker as a normal packet length. This is an out-of=
-bounds
> >  > heap write controlled by the usb device.
> >  >=20
>=20>  Where? Can you be more specific in the commit message? At a glance=
=20
>=20>  the accesses seem to be bound-checked with skb->len.
> >  --=20
>=20>  pw-bot: cr
> >=20=20
>=20>=20=20
>=20>=20=20
>=20>  The "len > skb->len" check bounds the source read, but the overflo=
w is on the
> >  destination buffer.
> >=20=20
>=20>  The buggy path is:
> >=20=20
>=20>  if (len =3D=3D 0xffff) {
> >  netdev_info(dev->net, "router was rebooted, re-enabling ethernet mod=
e");
> >  schedule_work(&priv->reenable_work);
> >  /* <- BUG: missing return; 0xffff bypasses the oversized-length reje=
ct */
> >  } else if (len > CX82310_MTU) {
> >  netdev_err(dev->net, "RX packet too long: %d B\n", len);
> >  return 0;
> >  }
> >  if (len > skb->len) {
> >  dev->partial_len =3D skb->len; // skb->len is bounded by the USB tra=
nsfer size (4K)
> >  dev->partial_rem =3D len - skb->len;
> >  memcpy((void *)dev->partial_data, skb->data,
> >  dev->partial_len); /* <- TRIGGER: can copy 4K bytes into 1516-byte p=
artial_data */
> >=20
>=20If skb->len (=3D=3D dev->partial_len) is not bound-checked to the siz=
e
> of dev->partial_data - aren't there more paths that could hit this
> overflow? Are you fixing the right thing?

Yes, skb->len and CX82310_MTU are different limits here.

skb->len is the amount of data received in the current USB RX URB. This
driver sets dev->rx_urb_size to 4096, so skb->len can be much larger than
the network frame MTU.

The safety invariant for the partial_data copy is not that skb->len is
MTU-bounded by itself. It is that, for normal frames, the code first reje=
cts
len > CX82310_MTU, and then reaches the partial-packet path only when
len > skb->len. Therefore, on the normal path:

	skb->len < len <=3D CX82310_MTU

so copying skb->len bytes into partial_data is safe, since partial_data i=
s
allocated as dev->hard_mtu =3D CX82310_MTU + 2.

The 0xffff reboot marker is the only case that breaks that invariant:
len =3D=3D 0xffff is handled in a separate branch, and it just bypasses t=
he
"len > CX82310_MTU" check entirely.

So the only case that may trigger this OOB-write is len =3D=3D 0xffff, wh=
ich is a
reboot signal and should be skipped from being parsed as normal packet.

Also, skb->len is governed by the USB RX URB size, not by the network MTU=
;
it is a different length limit from CX82310_MTU.

I believe this addresses the concern, but please let me know if you see a=
ny
remaining issue and/or would prefer a v2.


Best regards,
Tianchu

