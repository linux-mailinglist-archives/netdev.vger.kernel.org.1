Return-Path: <netdev+bounces-261943-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AD3OF7jfoWlcwgQAu9opvQ
	(envelope-from <netdev+bounces-261943-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 19:17:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED941BBE2C
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 19:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 913C530479D2
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 18:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C67936920B;
	Fri, 27 Feb 2026 18:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzBCm1oe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8743363C7F
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 18:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772216020; cv=pass; b=IkwWv786OnMpiRq5UQbWNKp7f+HLYD3aKrGnImosp9885TP1+eQY2KliiKSmrh2I2TM9Msdz1HyhGxMrkjvJkptiC5xTQDONPZS2isNVFRMA8PqLPRnCo03RxDdbkPY4juPKszi/GmPCwlR+3six1pm3scLstwXKLa/fPunV7OQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772216020; c=relaxed/simple;
	bh=e+ZOuJFjEKbwD9q7zWFM2wYXY3NQYk0zV9XEd/es6/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dwYkM2nr4rPYX2CgjDPP/jPA9ymwr+3d6st0exMs0mxRkw4Yy3JutIATHcUPOoOCAJU9rE6HvpUMO65PClABSVEDM+3Y9rsGr4kNMyWCgw18HyzGxwWTySfJvTCx8PXIApB0wcWKLx0UR3PtDcS5Tvk6ynyaiK1reTrCSbGBiLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzBCm1oe; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-389e139ee5eso29477201fa.0
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 10:13:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772216018; cv=none;
        d=google.com; s=arc-20240605;
        b=jSIj3s/OZAUkKL5/igCv6odN1At9//RqmoICyHLpOGkNPtJgSW+bRZ8Bf4M7lZdfbS
         +DNKdaam9YADOEiBmm1UXbyhddeslZa7wEBvU7rxNDXMnnhw9uEIjoWC0MBtWHBJSFfu
         Alv3fgPaitMo/WAOItNPmVYLstJWfnbKmRVck+uNkbdQXzAkt+hJmPWnQCHunzIVAEPn
         o+PuOkux6YhU70c43JgiCzXyKykUmk/vykJy4Acd//pOmLKnNnN6QHzIymmEvayVdPX3
         U4p5oi/LA3YkIPP510gUd0NoKWdH9ZjKlOSdUnYAz0HU2N5j2ROz8u4B/qWGxGq3K90h
         HlVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e+ZOuJFjEKbwD9q7zWFM2wYXY3NQYk0zV9XEd/es6/c=;
        fh=b0cduC+JnYUsVwxYK46YmwSQDs6jvFuZF3yuixgJBAM=;
        b=I+M1hMq3PIb0x7ykqjZLv+vBgPbHGizOAqKUCGHEXwTUVeqpQco/y/Yp1u/UdbBoCj
         LQOtTDK9OZ4pHu3zch9Us2Z6GnL96jimIwy0NHJNLSk6SrBWSyu8edeTBZkcfdAozddI
         x8tJnO4nQDIhNI3UsWyXXh41+tqfogOQDtV5JQUgsuCVSUh8gMMgDHU5LjzrdFGvNJzM
         13rKK43p0QPviTFammZ/1CFRM5A6sqUICuw6yY/ZDY8mJMQuRDl8uI7D0tp6Cf9IvuWT
         6q7KakPrFvCo+41XuomXGIU0F3eHVjhajXN8046LjfdfF17QWQ4+nrTKT7iO2a4Gbk9f
         inEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772216018; x=1772820818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+ZOuJFjEKbwD9q7zWFM2wYXY3NQYk0zV9XEd/es6/c=;
        b=SzBCm1oebq97OCjFw7Ycygo7HRrMZI04HYu9lh9C9E0E0Bp3/rPE4U7C3wuca9afGq
         A9sS667VEpdmRRQKyQMtmzQy1GweGj4sfTEmA/esDERUwOq+tslLKoQTgjXW+eEgJpuh
         /9wTTANAy+RpviqBXAy5SdRbpAGbZ/3H94UpytLwdJgWEx9p56vmaBQ/ZHBNBXKHWV0u
         E5+LBEtl4/QXSE80SLzfcV2ObsVAPzgc6sOuva45nfCiMzF3y2V38vVTnJC/tdQaGHDh
         NwtAF1AxU3jRbpwKDc6uyF0EFup6lZcGS7KfH8WOU4QJUc411STwVq/SNxZg63mDzktO
         M19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772216018; x=1772820818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e+ZOuJFjEKbwD9q7zWFM2wYXY3NQYk0zV9XEd/es6/c=;
        b=h2nGLEGNB76DhyY9NJbM/yjboA4nVj70wEEeMcvMxbFdsmvLTx9H9MXlxzvu3OpYDK
         yDwYzHPxyZE5r/vAaDO764CrhyhTMPqseZv5OvaDygnvOt9zGNSBofeoNnk63srGwlvC
         sEDWNk/pdtKKNh70MA9mz/1RSEtB3jVrVe9SF1O5v6CRqLSTnDsDegzTwJZgUOXlJ/yk
         Vc8+JidluA7DzKygpw/i5Xw0yQGD3Ku3uHkWgE1Mnl9ZOSN1DoBBaIsD9qTW/BFoTiWd
         uI790A8g3NDvZ3vD5RDRXZ27UA84hHqU+pSCux5mYHkaFEEi3M3rtZt+JZNXMeMHlRV1
         BbDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKcWvUNQGj60WjY1AJKLld7bPUmN5F21DcAEwSQ8Bu/zy8OySYmAfe34Ga0sQum/HjLEOoh2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuQM0RcEQhb3hvTgqiNZry41e2ns35hp2n8TqKCxLj5SL343DO
	ZpH6z5lI/Pw9ic+xSxISpnp48f8IWdi2Q2/Kdq2B9K6vJ3S94zHdizjmb7Mn8usebe2mhhHrbiG
	xMaBXIDmqriPDyWpn4cJOVzVjO6v7DSg=
X-Gm-Gg: ATEYQzzEITmlZXGe6c8KpGKIV3LEjEtBgDtD/ByWqcIUFREqT3Gr4CS4DMEjQsKjIFq
	T8fd/BEQws+WNxRqkJeHSmn5Ks3lAwYSY2M8xIDa5AT14kWIo4aQSMnM76XXZzAN1DxJEUPPb7r
	N6CN8nOCJUuKDqrwGwJPjnEChtNhnw3Qab6jiZCqm2KXDn/K8HClHlEDJ8Iau3HdP/BxYkdsx5d
	qGqOHovRYASq1v/DXAPgDoRr/SFWQ1fqKPRFaMFhaD+zduXVNDIY34vSzkhiZ9EN6g6zcDaedAv
	HEw1WmTmI1uBWaiMIvfTbnU/zwdDX6OHs67UDg==
X-Received: by 2002:a2e:a992:0:b0:385:b735:4fa0 with SMTP id
 38308e7fff4ca-389ff1169b3mr24362181fa.7.1772216017581; Fri, 27 Feb 2026
 10:13:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508091424.26870-1-jonas.gorski@gmail.com>
 <ce4d9b7b-aaf6-4796-94fb-8c3d6a1dcd4d@gmail.com> <d7f9775e-0af6-4294-837b-47e31e0d30d7@broadcom.com>
 <CACna6rw1kF-r40dr-nxouV9E0AigmeVj9fxQm_Px34Z_n2up9g@mail.gmail.com>
 <CACna6ry9B9LiPbWdXzi7FCcaU1YC+HPkor53AiSEaRSNUMcLwQ@mail.gmail.com> <eccf1d40-e4f2-4ea1-a8e2-328606fc0860@gmail.com>
In-Reply-To: <eccf1d40-e4f2-4ea1-a8e2-328606fc0860@gmail.com>
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date: Fri, 27 Feb 2026 19:13:26 +0100
X-Gm-Features: AaiRm53zmA4SNnN1SjQOSX2miadAi47Io5cS3bz9YLeTuEu4yuC3waV2eOvsDCo
Message-ID: <CACna6rzi3_pnduEphRBY3NDKrNqhK2i5TdVTNeEGb4nHm+vOMg@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: b53: prevent standalone from trying to
 forward to other ports
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Jonas Gorski <jonas.gorski@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.10 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261943-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zajec5@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[broadcom.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,hauke-m.de];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2ED941BBE2C
X-Rspamd-Action: no action

pt., 27 lut 2026 o 18:58 Florian Fainelli <f.fainelli@gmail.com> napisa=C5=
=82(a):
> On 2/27/26 05:32, Rafa=C5=82 Mi=C5=82ecki wrote:
> > pt., 27 lut 2026 o 13:23 Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> nap=
isa=C5=82(a):
> >> czw., 26 lut 2026 o 22:26 Florian Fainelli
> >> <florian.fainelli@broadcom.com> napisa=C5=82(a):
> >>> Could you try to program GMNGCFG (page 0x02, offset 0) bits 7:6 to ha=
ve
> >>> the value 0b11 which is dual IMP port (IMPO is port 8 and IMP1 is por=
t
> >>> 5) and see if that helps?
> >>
> >> On my Luxul XWR-3150 (it uses gmac0 and port 5) the value of
> >> B53_MGMT_PAGE (0x02) / B53_GLOBAL_CONFIG (0x00) is 0xc2. Nothing to
> >> set there I suppose?
> >
> > I tried other possible values:
> > 0x02
> > 0x82
> > 0x42
> >
> > None affected my switch / wan / lan ports.
> >
>
> Thanks for giving it a try, how about the BRCM_HDR_CTRL register
> programming (page 0x02, offset 0x03)? Can you see whether it is set to
> 0x3 or 0x1?

It's 0x02 which seems to match BRCM_HDR_P5_EN. It makes sense as
XWR-3150 uses gmac0 + port 5.

--=20
Rafa=C5=82

