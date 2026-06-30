Return-Path: <netdev+bounces-302956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id moiaCUdLQ2p0WgoAu9opvQ
	(envelope-from <netdev+bounces-302956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 06:51:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E326E052D
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 06:51:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=V9y6XLoE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302956-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302956-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05CFA3029798
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 04:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4813C0613;
	Tue, 30 Jun 2026 04:51:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37980396587
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 04:51:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782795076; cv=pass; b=RmNWLLPsBHNoB6P0AVPpwBUlyq9EyoispaPrWNEeBMYqI6F8bKF/EtfDO1TXnapTLxkEHvxgllMLhZyVBIgi6d3+hHd5cazJy6xf4F4dQCJYsJrs9AeA2OGDw1bSyum/k2+z722oWsBnSzuIksDKlYH5IRgPjgwEqtjYR9sOIXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782795076; c=relaxed/simple;
	bh=TRjVtJVVkYCXrDDyEP2GKqv9i4PVdFAjyE8Km8RSnC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXD3FVXwAlpgJ3I+sWYtuBQoemEr7J2wRCMUddVoZ6zv2RCs45YCAOuBY76uEa5KmTy15ywswIu9dOtocEQ28yJctLCq0KPxZxHQ8a/UBww807iBgrPMQGRorQwR3LgieYUIYrrytMF9uLmxLT5I6ldwcSt2UvRasqej7PT9I4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=V9y6XLoE; arc=pass smtp.client-ip=209.85.216.43
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-37ff8e0ad0fso1110783a91.2
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 21:51:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782795074; cv=none;
        d=google.com; s=arc-20260327;
        b=WgZV1DP8/Tt4OK7W8Jp7w5mh3bZxQZSlby8FA0+kmsVO1OV6dH4lGgudWtMlbWzm+e
         8XsWKqoaylMxeHbPIJNmouvzisTmgYQJvu6mgGUajXOLdU/U/i42mGJi7N5IlijozQHF
         JDzn9u6aIY5PZtGxf7YIJaAUNSEe1QoismDjjQnCUVyWqc13gohDwjdgYnbeaSx1eirt
         IX5Kt8JgWi1fPTXJulET4PbLcusWiaPbNC8Ry7YN8wVLenkjPOg1bPsRQAN3WvjUKCw8
         roKzAE5lBSMmINGXmTzN5D8QU0r3OV6ddHLJLSK5JN/Tg2W61qO6Ce5bv1u5LQbbK9IB
         Q3yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lGUgc0kMZV3Fo7Zy8Xt0uQZgg4awqO/uttcHalUom48=;
        fh=F6yzBXHyz3XJW6vTxsS1zIjCfYK5/wA6/eHoA1e8zmQ=;
        b=QyP+C55Yj63cV8CV+lB02SjKzuO2hJfP6nmywuNXyrboP2g8X8YhXprOUasaUdAN0+
         NCz2A33PWDYa/PSc1P/uKJ98hTVCIGYmgoB1Www4NqVJmi+YkW6p2Xewm4wW7gOkEC1x
         aBh6YCVW/F/IG7Qt1Fp/JQrZu+URb4KAPTM6dKj9e6LUk1zIRxdMJmwqo9osrzKMRaCD
         kUWXlW7pKGKwlPdtrrZdcieJRck3bQEoUWC9GXfwR8EyYLgCplXW0tUe4b1US+ZJSGRZ
         IDCU+YXGcNL+I3WzTfNhBjcj91Fw58Y6CKLMGQf+ShhU5sWgCYxJDzJcCq3HVRLz1DJY
         K3WA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1782795074; x=1783399874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGUgc0kMZV3Fo7Zy8Xt0uQZgg4awqO/uttcHalUom48=;
        b=V9y6XLoEm9pOSPMLPcWIvx3PZYPut0YC0WKSD0gO+leQ3hgNgI4fI0Fhh3Olcyl08w
         lDlpg8gyWqNHERmuG6tynUrL+u0hb6MOKGQtXpK9LJ+4GyluI2GuoeRoA4RFh0cxFh6n
         o78kG9Bw3jSYJ4Ms6OR7nHG7jR71k+8DFC3qQFLo7jbvToWdsitSs7OaA1MJLBvMkIuT
         UEV/kQZVxeQ5BB2/8iwpCKafXJzK9JTMHp+LPkV1t1aVgHFj3RISiogbt/FTtnhj1QTH
         mFgnzy3SMpsdCkUCOvDuU7JtA73jqLNAJbJXsCtgR/Ao+D4uhwhnDDMwainLaxQbMvrQ
         QxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782795074; x=1783399874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lGUgc0kMZV3Fo7Zy8Xt0uQZgg4awqO/uttcHalUom48=;
        b=OYoifQdk8FdH6YEF8gCDrDeHKNE0iEGjSUmgRi03qpS2Abod6oQQ+sX0kqdP5zlYPn
         NQrNarrI9rVVuOgCpbOhnsaVIr6jVYnQ+pEUPOFl0iIFpmTJ9p/1Vn0Kqk3Eqhr2VD7Y
         AWa+7maBqna2y0PXmQyRq++C9y1rRP+vg9B5vaxjCbdVcKq55RW+bLraj3V3IaEp+9Em
         2He6MC4uU4oh85lGRYNwExUcxQtvHdkRGKCwOxKTnmpbjdDMG9hqCshVgZJDO4SwEz5D
         q1Zdq7Vc5popjdsXBl+4OiVhWPcoSM7iZW49R4d5lwsO3PTFKYmIDVsBDjV90/cVqdPI
         78cQ==
X-Forwarded-Encrypted: i=1; AHgh+Roruo3fn0f9PG5icY8TeXwRzRTpF6nkn1P3atiaSLZ0A8G5xyrPNx63aJO1XIWsPgEUl3mAeTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqegqKIQXjqgN8cD8rPjWIVBszB+q0oqM4I2qFeBvLIUolLNn5
	wwdSSEiqhOk752mGY13ebKLoJEsY/x+fuD3jImTvOCJP4KUCNzmQ3FzbCEwf/XwNcJ5lEGCroat
	ipLwUxBpN2MDBghPQuwTQRAu+d/MsJ8BPgAs0VhZ3
X-Gm-Gg: AfdE7clXhZ+8/ALDCTAYaLMWJa2GHYGaBTcEuZ2PXJTg+Vi4WJbh7qEPII2H9z/3Yhs
	/Gcne5vhwTfNEFQ2O3j1UevAyBy/jeVMN8gUpftQLRxq43aO++nl+i+2DWbV3PO8eyQF232/Pry
	m4lShn2oYyiXEmkG8F3f9T3SAmAa29UnlL8VvdJsKGbdr8TbOLJ6Wy9S8YTPuJirfs8SgsWgj2a
	qlLDer5aKymkkYZRAqc21Qj3kKfLP7moabH+l8GPNHZE187JEN/ciYJtwmAyQgTFAwYKaQH8YXe
	2w1xFK/f4gpoaLfO8czg+okD4mmJNg==
X-Received: by 2002:a17:90b:224c:b0:37c:6973:5a65 with SMTP id
 98e67ed59e1d1-380527a8bfcmr1475127a91.17.1782795074444; Mon, 29 Jun 2026
 21:51:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260627212854.4025016-1-xmei5@asu.edu> <20260629185415.56ec8b67@kernel.org>
In-Reply-To: <20260629185415.56ec8b67@kernel.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Mon, 29 Jun 2026 21:51:03 -0700
X-Gm-Features: AVVi8CewLOgWSWPBc3mXeyF3ERg0gtdsHbk009Us5gbj_iOnook_1HYN5mupzrc
Message-ID: <CAPpSM+Rj9Y_nb1UJNN1koNebGRSwFhpvx-Ne9o3S2juqYFoEJA@mail.gmail.com>
Subject: Re: [PATCH net] net: usb: net1080: validate packet_len before
 pad-byte access in rx_fixup
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Weiming Shi <bestswngs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302956-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bestswngs@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:dkim,asu.edu:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 65E326E052D

On Mon, Jun 29, 2026 at 6:54=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 27 Jun 2026 14:28:54 -0700 Xiang Mei wrote:
> >       if ((packet_len & 0x01) =3D=3D 0) {
>
> just add "skb->len &&" to this condition?
>
Thanks for the review; your one-line patch is clearer.

v2 has been sent.

Xiang
> > +             if (packet_len >=3D skb->len) {
> > +                     dev->net->stats.rx_frame_errors++;
> > +                     netdev_dbg(dev->net, "bad packet len %d (expected=
 %d)\n",
> > +                                skb->len, packet_len);
> > +                     nc_ensure_sync(dev);
> > +                     return 0;
> > +             }
> --
> pw-bot: cr

