Return-Path: <netdev+bounces-307698-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZOHsBEFCV2oDIQEAu9opvQ
	(envelope-from <netdev+bounces-307698-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 10:18:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E28D75BCC4
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 10:18:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ixkHnIqc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307698-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-307698-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 034B730028A1
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 08:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477C13C2B80;
	Wed, 15 Jul 2026 08:18:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EC62F8EA4
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 08:18:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784103485; cv=pass; b=nNv5yTYKsflSI0rC64HZDgs2c/L2OHIjD8FFqkbnkZG3xc8+DU7dlCbYmHZE4qwycnSxM770rXqPkoEscNm96zdLsHWtCbMgyWmA06QWcvZhkgAwt7tal7UWNFsnjy1c4H8a7L4cCVYKiStmFQ87/Z5y8Jur1gG+8QLKPfWAw6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784103485; c=relaxed/simple;
	bh=AP6gF0tEjEv/vMctSCH8Yuu5/FqIiEEb+sjajbQSp+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nXuLSGxsQWd4ljcnMV+05b6e7+fPYJTrJJYghsTwH/m8SjyeNDBGPl69wu/4D5KBtaOJ2KhPRf/UiZYSMBM7gU2ZR0BpuB3Hpnjg/277kWKN3zYu3G9b4qL7jIvj0ZpavXRGmRofAwv/psd/0SpkVC5JBzzoadbfkjjhI35UReA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixkHnIqc; arc=pass smtp.client-ip=209.85.218.66
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-c029505b389so52460866b.1
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 01:18:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784103482; cv=none;
        d=google.com; s=arc-20260327;
        b=YHutozxSCQLtAO/p+LxoY3Ri1LFNutMp55PAgSn57oAn1NWrgNAZpEcRgmNO+FzLtq
         mlS6eEk2gtDKo3ug98EbOZYIDIJA7uzDbl9vDIcj6Piv3NtmaXMT/3py3x6LpoN/ZXCW
         2ky3AwmCDKOWPxCEW2PUXIZE045aa662NVHmRvGcrELsVCkuWGaCjVzwA41taV5sPIR+
         DpEuZnpWIO5Ix9oz9907jHk/6c4GgKeXsGQdamMpceAWUmZg+Tnuq1oqlpwtca63SUQK
         Lo0wE4EyL6nt3Czc/VH3XBNd7PO3sIq+sOGr4PXBQts9YnEcJcEsXPuNXMrlJfFblepZ
         SJRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D1M03uqUJX0kuAkqVXmzpq08Mjp3bxAKOr4K6xCx7KU=;
        fh=bM08QHLwO7kslKu0kVaHWAoO6xsuyan8mZNDKa7Ofcs=;
        b=BO8Q94b8Ose9N78FigjFMY9xm9pJR3fo3XS7JplRYX9KZAMG72hbCJvHvw6r+Woddh
         VEDnY88OUkbPYcElAyC23GIKNx7x1hrdSrSmAiWojjreRyhLr2CTAaQp9D1Dg6PjAv0l
         o4ZV+zRh0VwKOBFooYdCEliihAB+SEy/uafcy22ZN+LDdH5Uj+HDIiQFkt7KxrN9GO1p
         2od/78oVIgxzz1okcFZOoiesdIJTjk9Oj+846f8NpiITL/2ueIJ498IX2jzDtFCJ5dRj
         NE3Z0c0mV0cpnoK0UXCamX1vRNPkEeU6K8tAPwtRYJ3UaJCeiMCFVURIEXo1KFjaDIkw
         awvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784103482; x=1784708282; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D1M03uqUJX0kuAkqVXmzpq08Mjp3bxAKOr4K6xCx7KU=;
        b=ixkHnIqcIHKkcsgc7Yk3FexgizJtkGwBlxTTvXB7H5WsFVIntZK+kzg0ivhXfaSL0D
         3XXB2sIf+47x4UsWkHVe27yjWHqmlKpcIVov19iJTn5ZrL8qlWR2Hjo0R0nH8VnbCw+u
         T9bK0M8O4bXdt1aOV5/qD3bWjCGxwC0eVwMWPqoa1pL22hQ/LV0OEJbXud70TTD8Ksyw
         tX2PFARJGI2aaGnQXyVjF4pZLKK10b1NEmncVoKYHwqkONaSxoDgNlQljDmYg2w1LTAx
         2isEWIx8UxbaBN1UalyI6YZL7WKBr+bo1ob5nkKvUHzmx044pH5NGgkeqfAhxpJGVLri
         SZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784103482; x=1784708282;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D1M03uqUJX0kuAkqVXmzpq08Mjp3bxAKOr4K6xCx7KU=;
        b=nbNH6Hmdbdw5XBN2fqq/spF3/dvieOh0SBgB7q6EegqyjO9UcJILOpKdrcJHKeyndX
         QFEUaEIr9pu/JnyJNuXXCp4BcAO4+QShsdN/WEJnaYLOSptN18wqyBAM5iFEKBR++aBl
         WKAEbhWVYQZAkQjKt3/MEmIdJ95vDF4OEoIl1pXlZZ3BBsgZAEapsTuDHSe3tfaU3H4w
         prhkRsad4ws5jzKFNydFIrNsZSDhsgKxUsAoodQ/8putLHAEnwC+PPylo1GsQuJYuHNr
         mf1LeC2HUahz16pQaEt0/IAB4Pc2Yp5vIzDpTDknnWbqVyk7zmtm198zfh4+HNrXNXGU
         bOXQ==
X-Forwarded-Encrypted: i=1; AHgh+RoOrGPL1KE+YJRigDDNVJSVb4k5NHToO7+asciFRzImRXtYzTdDXOUQwuu6yDVB4IF8vCmZIAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPaKZRd2f+3adZ0raU29DBXaUuxEKUMo8rl4evirJ6UM2Sa1xN
	yDBWgE45mBeBg5DhvVdhjghZJL7zRUN4TemUIGMrT5ssSoGCBBBl4fakDdqvCfYoYjqLrQHoSEh
	mo7EYW2k723WnVu9Id1syEFkPP5orBHXPOebx7rXpWsVr
X-Gm-Gg: AfdE7cnqVSib2Yf7fvOD1GLb2OyvNLmXkg5g+CHYKTtmjjuvfKFnmKBINL1JFJRB89c
	odQ7yMO8hmOqj9qcDqZFX8MyV8pfAlb9uqf4F82avUGy33EFOAetROJppewfSCFpUyeZrLXQHwC
	Mu3EBeGFhf1eqVa4d3ItDDB2zf6rvW2zuNimgfG2guahnak2f1WKiECSrUTXIQaur6QHD7VQsA7
	MGnI6oNXN7pvlwwwM745VhuVcbDcL2uEI3IW9ZKdAKJj+uz2Dhy7Nm1ic4aL3M4jKYWrnvlbSo2
	Bxymwln1U3c=
X-Received: by 2002:a17:907:d587:b0:c12:58c0:db2 with SMTP id
 a640c23a62f3a-c15fe781907mr1024570366b.18.1784103481564; Wed, 15 Jul 2026
 01:18:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714191341.690906-1-coiaprant@gmail.com> <20260714191341.690906-2-coiaprant@gmail.com>
 <dc21b2fc-ae11-4fde-a5b9-09e2c6bee5c9@bootlin.com>
In-Reply-To: <dc21b2fc-ae11-4fde-a5b9-09e2c6bee5c9@bootlin.com>
From: Coia Prant <coiaprant@gmail.com>
Date: Wed, 15 Jul 2026 16:17:50 +0800
X-Gm-Features: AUfX_mxch48mUromtsSVd92z4I08mky6NZMzT4EVIwR-2P4_-bFyj_YHpBs-rv8
Message-ID: <CALj3r0gWyfHHp0S4=71M1-TjgHKcgGax4Lr0DzPi37Q69-iCwA@mail.gmail.com>
Subject: Re: [RFC PATCH 01/10] net: stmmac: move XPCS lifetime management to
 platform drivers
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, robh@kernel.org, krzk+dt@kernel.org, 
	heiko@sntech.de, netdev@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-phy@lists.infradead.org, Christian Marangi <ansuelsmth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:robh@kernel.org,m:krzk+dt@kernel.org,m:heiko@sntech.de,m:netdev@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-phy@lists.infradead.org,m:ansuelsmth@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-307698-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[coiaprant@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coiaprant@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,sntech.de,vger.kernel.org,lists.infradead.org,gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,bootlin.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E28D75BCC4

Maxime Chevallier <maxime.chevallier@bootlin.com> =E4=BA=8E2026=E5=B9=B47=
=E6=9C=8815=E6=97=A5=E5=91=A8=E4=B8=89 15:31=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> +Christian
>
> On 7/14/26 21:08, Coia Prant wrote:
> > The current XPCS creation logic in stmmac_pcs_setup() is problematic
> > for several reasons.
> >
> > First, if a device tree specifies a "pcs-handle" but no select_pcs()
> > callback is provided by the platform driver, the created XPCS is never
> > used. The phylink framework requires select_pcs() to actually return
> > the PCS to the core, so the pcs-handle property becomes effectively
> > useless without the matching callback. This is confusing for developers
> > who expect that specifying a pcs-handle in their device tree should be
> > sufficient to enable the PCS.
>
> I think Christian's work on fwnode PCS would help a lot with that PCS
> handling in stmmac:
>
> https://lore.kernel.org/netdev/20260618125752.1223-1-ansuelsmth@gmail.com=
/
>
> I don't know when Christian plans to iterate, it could be worth using
> that new fwnode mechanism here ?
>
> Maxime

Hi Maxime,

Thanks for pointing me to Christian's work. This looks like a
much-needed improvement.

I actually spent all night debugging call traces caused by the current
stmmac PCS lifetime management, and it was not a pleasant experience.
The code feels like accumulated technical debt that should be cleaned
up.

Regarding timeline: since Christian's series is still in RFC with an
uncertain merge date, I'd prefer to keep this series as-is for now, as
it solves the problem for Rockchip and has already started receiving
review feedback. Once Christian's fwnode PCS work lands in net-next,
I'm happy to rebase and convert the Rockchip glue driver to the new
interface.

One thing I'd really like to see: the ability to specify the logical
MII port instance via something like:

    pcs-handle =3D <&pcs MII_PortX>;

That would make the DT binding much cleaner and more flexible for
multi-port configurations.

Thanks,
Coia

