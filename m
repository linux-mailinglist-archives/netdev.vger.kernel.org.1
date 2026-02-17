Return-Path: <netdev+bounces-259111-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cN/2CVOllGnTGAIAu9opvQ
	(envelope-from <netdev+bounces-259111-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 18:28:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEFE14E99A
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 18:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BDD8301ECC4
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 17:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E425336F433;
	Tue, 17 Feb 2026 17:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOPsKze7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8435236E49E
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771349322; cv=pass; b=mLMWQeonUhTBhFQPhwiAMYT+Kb3yHzrHEEOyPFc+9SxkcMJ3JkrW9yHEkTpvI09jaW/XUmGMw+rjXUGErgrAK8EpAydvcKr0DDgrl1HULkVLSSOz1TwN2potRli7/mtCFnAuC96cd0DR7fHADDZo3g9TCBnnwojQjEiz7FYL1nA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771349322; c=relaxed/simple;
	bh=P2irtnBFLiL4JYCfo1k5W4sPeUJoEEcGJRi89IOhnS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fOT4QZi1hHFr5vIbiqxABvpCxOB34mBen68QTMx8FKYWEFh04OVJDZQeVSUcI395xcF/No3eiBUxX28QIHdw0W/JA7O2UatlK0l8dZH/wSd0TYUBHNMKKD+v1VHAHSfbH3ZyHWdL/II6zIiMDqqHCffHssCQr1GBSvJ3J/ntn7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOPsKze7; arc=pass smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5fac15a7b88so783183137.3
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 09:28:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771349319; cv=none;
        d=google.com; s=arc-20240605;
        b=XRFCZ+6DyCDz//XUFhP2R9MFGT9ESjFdUl0vCnp4vDRGMLRCDyLClm4AYVJkLNwoq1
         Z+zn+9c+7VzYD1Nc6D6rZLB0B5XCitSxA+Sv9ALVOiNigW0gBhRM9V/jthkH0AYsj1qA
         au1ENAIEZ7u2hr5Ul4/fvQx0lWwSCuQuLxFlOR4S3ijOTbhU9TCpSvsJtJcby66IDpK/
         CtU89NT/Bb+pZoSZ+I489J2hLw56nYPdFiG5/iCBWYGrGVDgf/HsbxVOXjOv6JLUg81R
         jFiY/TRPMTO5RRJw2ObbawSri9jJe25htogdgRx6i7dQa72WhBDWW0vLS+EZGgWatoWN
         Pguw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y1/0i5LwTTeLSjrN/WmRILs65aDQDF4d5uLmTIRIiIc=;
        fh=cbkYnr6q0eSHJDiKdmTwqu57iHJPnIcaqBmC0ySB0Hw=;
        b=f6eDhnxmjjCIYcQTMupe9mozIuQJhMJpRmfrPHnSeDNkMIxXFqxUE/8uFZ7fmi/cML
         vMFkxnawq8Jprchh0NZxUZQfnGyzpxAvcfau0eMSisHs7h+q2sMpPuxHFFNQPbe8tH/H
         z+634pEBuFBJnIOD4oAdVAS/vUPY5si6g9KH5sPZrWuBOazYIBVuWtobPAyaLpz1u/gw
         SI6I4VXeGLmPA0yi4rwrUabWwAzNYRGHUbG6nVx7Kh/ihaIO3S19a3ouP90F4m/F8rIi
         NQaYDNE3XloAHSeucUiaom8YD60ei4BVPZIOdKMqBkjwK3XHe/fjGsGvhY13ot7xE5PJ
         Nerw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771349319; x=1771954119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1/0i5LwTTeLSjrN/WmRILs65aDQDF4d5uLmTIRIiIc=;
        b=EOPsKze7YnYK549Zsf0xwpf6goqGtD5zgbDaeeSZR+M56YAjvduMH9glvboRJgB61z
         90v7IVlpIoqu/PESfhSrwwisPhWSLHB/vg/ZbKZW5WtG2VVCUdnwCwjZtL+iAX514ike
         ireX6tbKsjI8o3/UuEIK/8Lp4OnPgwKupSaaSVU4pGqaQUTWDoQqy03x+acKkD95e4Om
         HXER70dkUQhI6+49sY+bSHQYACAw42BD0jOvcwBC7P1MEDJ0dAjqxNm/BSziOuG6NBlb
         j6Y1RiQDz2+WUlCInNZ+LPJC4lz5XeIEVrJLu8oxRM3geHkdjwF9X+WKekMywPhFICQn
         h2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771349319; x=1771954119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y1/0i5LwTTeLSjrN/WmRILs65aDQDF4d5uLmTIRIiIc=;
        b=sm5E5+A8p0gnm4nVZGr0qnYS9TRXarzXlbrvaVvVbKg6cgqVN8sqNI5nd1WR2gfYet
         rtNpMCCb4oS1Y2ngMSEgBOOmHHip5+bWv/EdyNiugz5aV0n823W68Xfxh1+HmXNX8xqg
         sS7yx0GBNynh9+hhGkD9zkcipnuQIz/CZ+xcCBZdVAk+YxIe8Nx1i7PL3pR5m7hWKYlA
         Wv1VVJa2td9Ih5UtRa/G0VBqwLg3AKdYYNhwwy1aTyDn/zs3WqOTq+e3lx7r4xdFr+U6
         jFi3T+zXd6N4g2iii8PRu0rHCSA9EZRWvUSA/8uuQbBOcDVJNo/oq6Z/Spqhke7ludan
         sN+A==
X-Forwarded-Encrypted: i=1; AJvYcCWysR1ik3BaM1MQJXLjeein+zagBVkXHTEvsoBrD7GSRjV78nFSTYbeAFXW7MD8VJe+qy8TMxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCLAthbkughGk00hHP4OHK998ESiLPRLFx5bZQ3DKB1Zf62nCP
	k8uPK8DDstiQxTEdcn/FD2/DedomtcoKSEYJkmdBBjOcWNrA5QwzNtv6paAPQogI1rOd8d79CQm
	VkGqeCLomS7VMEW1AWBJH2+kFL0cOOZk=
X-Gm-Gg: AZuq6aLdlFZKz4YBTQEx1K76nm+4QQiO5h23s8TvMwDsFvtvW1oYFd9HxVuY4Z30/EQ
	5ew2qX/6KGBdU9ZEsBLj3U6v/EsRgThK3o4BXCoiw3P036AQyruS1GP3ZDI+5RUcxMmyKaTU7IA
	qLVAEdFPt7/1MjZnllmZFlaWSXcAD9CRWxqOCqPmnsdpzYMxhnrZLeKXLeRfqKwNooUyAKG+d/n
	oSavphaYBhuOvoeiZWMmbriOOBZRT8Qf1dBepRbtrwbPQQhtFZ4ZmmumC/qF8Ph06InujgFmr7E
	gC/wpsyUqB8yqXfz
X-Received: by 2002:a05:6102:c8f:b0:5f5:4d9c:de4c with SMTP id
 ada2fe7eead31-5fe16c003camr4631312137.3.1771349319506; Tue, 17 Feb 2026
 09:28:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216174950.455244-1-seanwascoding@gmail.com>
 <20260216174950.455244-3-seanwascoding@gmail.com> <f71cdfa7-25f8-487d-b727-39ae962401a4@lunn.ch>
In-Reply-To: <f71cdfa7-25f8-487d-b727-39ae962401a4@lunn.ch>
From: Sean Chang <seanwascoding@gmail.com>
Date: Wed, 18 Feb 2026 01:28:28 +0800
X-Gm-Features: AaiRm51KC7GN5Nv3xktbA0iIhez-RTH-PxLrpczQXSdcrQEcbb1UDvHXkYyG9ew
Message-ID: <CAAb=EJWNSvTHuUX862vLmA2s1uKO0vy_x9OSZ6VXqY9X-+JNsg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] net: macb: fix format-truncation warning
To: Andrew Lunn <andrew@lunn.ch>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev, 
	trond.myklebust@hammerspace.com, anna@kernel.org, netdev@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259111-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: ABEFE14E99A
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 2:35=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
> > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/eth=
ernet/cadence/macb_main.c
> > index 43cd013bb70e..26f9ccadd9f6 100644
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
> > @@ -3159,8 +3159,8 @@ static void gem_get_ethtool_strings(struct net_de=
vice *dev, u32 sset, u8 *p)
> >
> >               for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; +=
+q, ++queue) {
> >                       for (i =3D 0; i < QUEUE_STATS_LEN; i++, p +=3D ET=
H_GSTRING_LEN) {
> > -                             snprintf(stat_string, ETH_GSTRING_LEN, "q=
%d_%s",
> > -                                             q, queue_statistics[i].st=
at_string);
> > +                             snprintf(stat_string, ETH_GSTRING_LEN, "q=
%u_%.19s",
> > +                                      q, queue_statistics[i].stat_stri=
ng);
>
> These strings are special, in that they are fixed length, 32 bytes
> long, and not \0 terminated. There are some helpers at the end of
> linux/ethtool.h for dealing with these strings. You might want to use
> them.
>

Yes, I've switched to ethtool_sprintf() from linux/ethtool.h and
removed the manual
snprintf() and memcpy() calls. After testing, it behaves exactly as expecte=
d,
so I will send out [PATCH V3] shortly.

> I also wounder, why is just one architecture complaining about this?

Regarding the architecture-specific nature of the warning: I have verified =
that
this warning is not triggered on x86_64, even with W=3D1. It appears to
be specific
to the RISC-V toolchain's diagnostic analysis.

Regardless, converting to ethtool_sprintf() is the correct approach
which does not throw
any warning on the both platforms.

Best regards,
Sean

