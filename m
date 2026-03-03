Return-Path: <netdev+bounces-263332-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLuTL/MSp2mfdQAAu9opvQ
	(envelope-from <netdev+bounces-263332-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:57:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F181F4340
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FDE030659F5
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 16:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8A34A2E0E;
	Tue,  3 Mar 2026 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJVK+nle"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26C5492532;
	Tue,  3 Mar 2026 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772556802; cv=none; b=Ilxe9HdpSkOHl2OfwNbtgiZAdF6GxyzNAgSw7mHK1qGSydnKvJuFjcbP6kY4J2Zv8kX5Y3cAJv9Lf47gcNSx+t6V1M004TpSJhYhJ4AM7bQB4jIioONVMmPqGc4Wli4RKMEgSzM5NaZ1iuFyGa+20RPbstpLzF7n5ruuMpSIc9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772556802; c=relaxed/simple;
	bh=wDCqvZbR20asayvEi/uyZYCGSa8bb8CktOtFLgsbc/E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cX7pkN6uRtE8b36VSka9xt1FCjRIkMctx/tfpfr9z83HNKEKwOdKzMqVukS/LeMbTl2xSiUaXIFtPAjHNmaz2RDi3gh969vdgHpauipDmS/Rlg/C/3Gn0K3u7r5pXUVAeHKSJcAxTEvkpgF3hAlCyBWvGTk5Oc534NfiYpL+VVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJVK+nle; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19092C116C6;
	Tue,  3 Mar 2026 16:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772556801;
	bh=wDCqvZbR20asayvEi/uyZYCGSa8bb8CktOtFLgsbc/E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PJVK+nleKUV+VCQsIfBf8pE8r1RQBWeGKvZbcp/Txjz9tyQnNVEeVq+FAq+pLTA9W
	 SD7Kt4WrO3fzCOkBnoCFmmJQEYM3mszcwqyE2MMZuVIFkPP+iIJRmOaT8uxc14oFcC
	 hgEr4vyovkctSwLYZG6WAVMm90V5xctttxJwdjlEJvi82ii+1Z5hOBiJQzU6VwjM0d
	 uM7IVzgAZpno3rbRg6w+n1ABn4Dgso1q5I52WwP/8sg/wKZYVETLu/6OhGImTubChS
	 p6XrM+QXwhmKhhjij3cyiI6g9oeOIVlp/3Xnz8ZTBhxVAQgHDetlB5tuRrzDY31V1U
	 HxQ+YbNFPTZsA==
Date: Tue, 3 Mar 2026 08:53:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: "Nicolai Buchwitz" <nb@tipi-net.de>, <netdev@vger.kernel.org>,
 <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
 <pabeni@redhat.com>, <linux@armlinux.org.uk>, <claudiu.beznea@tuxon.dev>,
 <nicolas.ferre@microchip.com>, <linux-kernel@vger.kernel.org>,
 <phil@raspberrypi.com>, =?UTF-8?B?R3LDqWdvcnk=?= Clement
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH net-next v5 2/5] net: cadence: macb: implement EEE TX
 LPI support
Message-ID: <20260303085320.4a2c2da6@kernel.org>
In-Reply-To: <DGSZWWKDJOFM.CCG4PBOJIRW1@bootlin.com>
References: <20260227150610.242215-1-nb@tipi-net.de>
	<20260227150610.242215-3-nb@tipi-net.de>
	<20260302181522.068f4715@kernel.org>
	<DGSZWWKDJOFM.CCG4PBOJIRW1@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 28F181F4340
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-263332-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, 03 Mar 2026 09:14:41 +0100 Th=C3=A9o Lebrun wrote:
> >> +/* Wake from LPI before transmitting. The MAC must deassert TXLPIEN
> >> + * and wait for the PHY to exit LPI before any frame can be sent.
> >> + * IEEE 802.3az Tw_sys is ~17us for 1000BASE-T, ~30us for 100BASE-TX;
> >> + * we use a conservative 50us.
> >> + */
> >> +static void macb_tx_lpi_wake(struct macb *bp)
> >> +{
> >> +	if (!macb_tx_lpi_set(bp, false)) =20
> >
> > Does this lpi_set() not have a relatively high cost, even if eee_active
> > is disabled? Reading registers is usually pretty slow. Can we add=20
> > a eee_active check here as well to short cut the lpi check?=20
> > If we do we probably want to make sure that the code paths setting
> > eee_active are also under bp->lock, otherwise this new check will be
> > racy. =20
>=20
> Funny how this discussion keeps coming up! I made the same remark on V3:
> https://lore.kernel.org/netdev/DGOXXGNSSMYK.2XNU9AQ6E077P@bootlin.com/
>=20
> And it had been discussed in a previous iteration before.
>=20
> In theory I agree, in practice the optimization was statistically
> insignificant on my platform. The total time spent in macb_start_xmit()
> is tiny, so any optimization inside of it is even more so.

TBH I started looking around because the v5 implementation seems racy.
Probably not in practice but in theory on a multiple queue device you
clear LPI, release the lock, then another queue may schedule LPI again,
if the xmit path is delayed for a long time the LPI work may turn idle
on before xmit rings the doorbell.

The rework I suggested is not only more optimal (dare I say logical to
an experienced developer) but also I think it'd be more correct.

macb has a crazy number of locks so maybe i'm missing something.
But sooner or later someone will hopefully start removing those locks,
cause this driver gotta be dog slow right now :/

