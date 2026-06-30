Return-Path: <netdev+bounces-303081-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iq2+AL2bQ2oAdQoAu9opvQ
	(envelope-from <netdev+bounces-303081-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 12:34:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2EE6E2ED9
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 12:34:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=RzDUAkFI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303081-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303081-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 24B7A3023AC5
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 10:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0197F3FBB44;
	Tue, 30 Jun 2026 10:30:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484C23ED5A6
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 10:30:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782815458; cv=none; b=OSBZFFHGTrLcYUUN0w1S0MGrCyRiBtp/b+wUB/v1An0EyndZg2GnbTxiF+oIVjr7bM4TUzV4ekZARWjZ+/6W4g8H8F8UB9WWhxgkEdeExx+Z3v2uZ8StDAlu9lnCt5G0r2uQ7OnfUAmebMM0IohqVQPqZoNb4vxu0q+PZlMkrl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782815458; c=relaxed/simple;
	bh=XvDQJvE4M7XT7qt7Y6KTCu/jIFJH2/QmiZiRcck1yNU=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=AEj/yT5kgnTl96O4vc2tyZPGMPCDvfMp7N5QVWYBT3dRF4IZMqRSWUKJ2x3cDAxNUXCVbRgmBWt9v+m0O7ZX9pJGyt7gMgEQX0F8/ahQWUF95FwDxhaFvAxf21QtoXGqUmAv0LkS2KmQOarh+0t8LrvlI9GpnFrGBxEIUIl0BM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RzDUAkFI; arc=none smtp.client-ip=91.218.175.188
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782815455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GLoCBIg3HCmpmWjUPvotZGyKOLRzdtV91re2dTJIL1o=;
	b=RzDUAkFILWC/o/M/4TZRlATAn/JZaqIvcW27ziULpEIqBWQtET9nz+lOZaT2jk3SLc8ux2
	JESCgvmSwCuoiuVDYobgpT2SFQ7AZ95/yceW43f0BpWEqVmHLak6IBrM+BNyh3+CF0XYX+
	lYnk0Q8W1twJpCGSvgkJM7IOAxRGLdQ=
Date: Tue, 30 Jun 2026 10:30:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Tianchu Chen" <tianchu.chen@linux.dev>
Message-ID: <e87b8ecf4bbcf87635d144508bf35377dd5397b3@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] net: usb: cx82310_eth: stop parsing reboot marker as
 packet
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20260629174458.6ebf647d@kernel.org>
References: <700e16e9523d7f1299b00df75b13a3c66b6e517b@linux.dev>
 <20260629174458.6ebf647d@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303081-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[tianchu.chen@linux.dev,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,tencent.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D2EE6E2ED9

June 30, 2026 at 8:44 AM, "Jakub Kicinski" <kuba@kernel.org mailto:kuba@k=
ernel.org?to=3D%22Jakub%20Kicinski%22%20%3Ckuba%40kernel.org%3E > wrote:

>=20
>=20On Thu, 25 Jun 2026 15:32:04 +0000 Tianchu Chen wrote:
>=20
>=20>=20
>=20> From: Tianchu Chen <flynnnchen@tencent.com>
> >=20=20
>=20>  Discovered by Atuin - Automated Vulnerability Discovery Engine.
> >=20=20
>=20>  cx82310_rx_fixup() treats an RX length of 0xffff as a device reboo=
t
> >  marker and schedules work to re-enable ethernet mode, but then conti=
nues
> >  processing the marker as a normal packet length. This is an out-of-b=
ounds
> >  heap write controlled by the usb device.
> >=20
>=20Where? Can you be more specific in the commit message? At a glance=20
>=20the accesses seem to be bound-checked with skb->len.
> --=20
>=20pw-bot: cr
>


The "len > skb->len" check bounds the source read, but the overflow is on=
 the
destination buffer.

The buggy path is:

	if (len =3D=3D 0xffff) {
		netdev_info(dev->net, "router was rebooted, re-enabling ethernet mode")=
;
		schedule_work(&priv->reenable_work);
		/* <- BUG: missing return; 0xffff bypasses the oversized-length reject =
*/
	} else if (len > CX82310_MTU) {
		netdev_err(dev->net, "RX packet too long: %d B\n", len);
		return 0;
	}
	if (len > skb->len) {
		dev->partial_len =3D skb->len; // skb->len is bounded by the USB transf=
er size (4K)
		dev->partial_rem =3D len - skb->len;
		memcpy((void *)dev->partial_data, skb->data,
		       dev->partial_len); /* <- TRIGGER: can copy 4K bytes into 1516-by=
te partial_data */
...
...
	}

For normal oversized lengths, the len > CX82310_MTU branch rejects
before this copy. But 0xffff is special-cased and falls through. With a
4096-byte RX URB, after the 2-byte length header is pulled, skb->len can
be 4094, while partial_data is allocated as dev->hard_mtu
(CX82310_MTU + 2, 1516 bytes).

So the source read is bounded by skb->len; the destination write is not.

I am happy to send a v2 with this spelled out more clearly in the commit =
message
if needed.

Best regards,
Tianchu Chen

