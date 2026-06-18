Return-Path: <netdev+bounces-300307-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G23ONXJmM2r4AAYAu9opvQ
	(envelope-from <netdev+bounces-300307-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 05:30:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AFC69D52D
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 05:30:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=LvpKpsP3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300307-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-300307-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B1E3E302186C
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 03:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FFC35AC13;
	Thu, 18 Jun 2026 03:30:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190803590A9
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 03:30:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781753441; cv=pass; b=YxfEL9N+Da+TSgD/5YYwHiMlXoBukK+eKohTWd+oZfZOMwyU6xytRoI8uvIFUw2hDmFIbm+YC1QqwjChwTN6sHg6jR14tdLbGE7X7Hi4ERhcU6oFqg2pTwFFgrSoJVOfdgrzac/qNr9Cs4RVpwVczwo7ZN6hfuMS6ERqhBJfEms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781753441; c=relaxed/simple;
	bh=mWtRmKA8npVobusxt9OaAezH9a+b5rVhQeGj5QAtqBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C6c9I8ms/wCqZjCF7N0hNBPN++B1HC1ZY9Hl/32XCt+p+BNtbvPIM08h7Qn7lkL4SfTEwbGYZ8Ojwq1hgr0aMFxwTVvI48Lk+wy+xu0LO5DBucuoJtpXF+SvK1bEiaO/lar1alcq/2raR86Hi/WHPxTJRrJsn9kGTcVG0wqOBMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvpKpsP3; arc=pass smtp.client-ip=209.85.218.43
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bf0170c80f7so64074066b.3
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 20:30:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781753438; cv=none;
        d=google.com; s=arc-20240605;
        b=DQ1HH9IM8YqIiGAhhSiuZRNxbXS5VSCdH2TZGNdEpNGIBpSnMfEB3hPTO+MhPYRxWJ
         1yl0MtcY56LssTmUuAX47yTXttPeNCDahHiXfRVggchh2PWBuyCswI2QTqj8mQJUJER+
         UGPMcFmuFMFweNeZF4sdNamSnsRYpLfyO3TXx1PNuY1DVl0B3piUxd2FWCxvJHMg3ywL
         5EsLMaTWpJ4q9aaPlsWBPi/2Vhbs/EnR/uIPpARUCDc9TPr7jIRZZar9ylyJyB9beUun
         gK+OAz9THBXMSCVgzTmhpcHGveh9pd3zm97ePvxOBEwBL7x7RXpq2KLEtYZTtTIJJiNM
         KtzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mWtRmKA8npVobusxt9OaAezH9a+b5rVhQeGj5QAtqBc=;
        fh=t8Pq3N1Zc/oQ+j9IAaMrbBRk4rnClUfw3Ava/nNnHh8=;
        b=eXRcQ6m3fhF/68Vbt5DNMX3MCGlbgg+HACaF0oBeVKBEONvkZt1lu1ydy+Z559OPou
         WVQHRfQdpZTSDV7/fb0wNUI2xRm6KmI7ZkEqEVOZ+/UAu1ehgtWt+MEPlbsgxuKmwFmn
         IeQfrcU3BesEY3W0Qq7rkum1wKl7UDOEmwJcIbXhlr1Sm+k/fzLWcffNw6WFwxBFqIPV
         KYYIfgOM4mXe7pKvx2ATG9pSetxH0i5stFsnGr1L+ldQmV5Tq/gaPWG6OSeNrVIgpjFu
         gS9TlHmSEFkNNL6vPMzWIuYlGbeGqqUTykwbhtK78o73phr8sR1WX5lHyA00x57NiyNp
         MXag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781753438; x=1782358238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWtRmKA8npVobusxt9OaAezH9a+b5rVhQeGj5QAtqBc=;
        b=LvpKpsP3IybfTFxAj9/uBX0m/ddK2Q/RWTU+at9FqH0R+UScx6jEcLS6uiHHXW4eXb
         HWrga/ajByTvTFQqwe13h9D6GdE/miDPg7YTI58XT45Ym+B89aY6eTQk9IDm/DHvMQmn
         PRCWFsngJTEOpelE9z3uglPm1UxVuP+LbeNChfMkAE3jU0ClRa/w37dLihJ2pQfCmZ+y
         CGR3RqI/u/zC0hct0Pgj1DiU+EX3VLLXFnN8ESsU5qRPMJhc7jbdVgc7U8HVqUGMV022
         CxEWvCpHUF0Pd09plBqsb+0HhDhQuj5qDEZVDFBASMV0KXxH4SufRdzmGAP+pbWs8J22
         JUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781753438; x=1782358238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mWtRmKA8npVobusxt9OaAezH9a+b5rVhQeGj5QAtqBc=;
        b=KMgepfXcIc27L2ByP/c2ejpYdc0opzAqXulTr4nU+YAovgauGDX5N9NRlmdc7k6gdy
         UTNGq180XQwpJUrDm7uSq0J7EQVIB5g/gpeGFUErdzewi5dldNx9DHa/PAki/yfCj04z
         uyN1F6sHFyoE6LEpc02aW5qaqEV+/mVkD0XWwOWB8DRMXrFolPuqmsTdOb8jB7CWRUXe
         DLAPZDm25zRKxnrYCaWTRynm2bY4zwbl2xJcHr/n0uD4d4qYGqfJKliJ2R61w6wJe1Ss
         IZxNw/jH0rNqf4wgP/ovx8lwX4L+yHQccX9eZlryzN2QZBug2fZhRi7vL/RFm51Qyvgk
         h32w==
X-Forwarded-Encrypted: i=1; AFNElJ9amEk5kIfrREKrj+kBdm+7i1+IRbWPP9LoK4/cXywgXNn++Lk2EtCnY5+xSiMlkpJxqRbQj2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzDURDChEizxUPXgYMtOubeiUlz1xsdJi7dl1DRQbHspFnNnkJ
	apeSLTcMS4NKDPXdh4ohFXtrI45w6+sq/nHzpUYncmfN53kd8AkIra+Um2NauMQf6XUmcV/V/M2
	lLsw428wxuZg8r4sFigLFAbm/Z02Tg3Y=
X-Gm-Gg: AfdE7clo+MWa58KFQUQ51W36TtajysG7I0q6Ue0DTdSTbLljn4x6U+OaAcDnoQ/QKMH
	snWHXb9n7QKno/MiIanrQVHytHTJSDSkmNpAxI2xsASTsmASzoPaunf4NVl++YJW8Fpc0xW66IU
	8i8NOMjEMaRx4u5clvai7GbVKE+Vnj4Tnpo2ESra2dz06qxRNarMl1jtHqJsAGvsg8qBfHmtlSG
	YbNUzzPNxmCdkk7xZ4v2M+ZL0h2gFo2SsMtqe65TqeevXHlMH6MX3qJfTBbw5QIPhj7QvCGrq7U
	sbdLBBeuXlhZzm+SeR/B+pwbb2EtDA==
X-Received: by 2002:a17:906:9fc9:b0:bee:965f:dcf7 with SMTP id
 a640c23a62f3a-c074b560a07mr74744666b.17.1781753438303; Wed, 17 Jun 2026
 20:30:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
 <20260331-realtek_forward-v1-6-44fb63033b7e@gmail.com> <CAD++jLmRT+3EJ-f_FNuZwOGU4fBB6pGHhq2OuxBS7O-cEnWt=g@mail.gmail.com>
 <CAJq09z6Y3MfkyiyaMhPTQH3W7p-ZmsNeS-iBKOeQNWWpDi0UoQ@mail.gmail.com>
 <CAD++jLkqcqUThJe+kJhR2hwyg1y_RWJc7yrM-kqMeiA4T-Jqig@mail.gmail.com>
 <CAJq09z6O81Sev07pQiQzCXzbKC2JxBCjep6=tX2Noqd=pPW1KQ@mail.gmail.com>
 <CAJq09z6PjXeDYhfo3=UmLyUhXyx5rPHCK4kBaMaJWNZNssjo2Q@mail.gmail.com> <232d7c53-f413-4c8d-bc70-f03a12d601f5@gmail.com>
In-Reply-To: <232d7c53-f413-4c8d-bc70-f03a12d601f5@gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 18 Jun 2026 00:30:25 -0300
X-Gm-Features: AVVi8CcnbFMsN_K6Lcs4VATLUKbXSnyR3POzemEI_zlMuNILv8QgjKz1pO-XQKw
Message-ID: <CAJq09z7Dj83e1B=dGpM8RwHbnT=Zu2SYr=+MieiY=vBeJf5JaA@mail.gmail.com>
Subject: Re: [net-next PATCH 06/10] net: dsa: realtek: rtl8365mb: add VLAN support
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:j4g8y7@gmail.com,m:linusw@kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:alsi@bang-olufsen.dk,m:yury.norov@gmail.com,m:linux@rasmusvillemoes.dk,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yurynorov@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-300307-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 05AFC69D52D

Hi Gabor, Linus,

(Sorry for the late answer. I left it as a draft and forgot to send it)

> The driver was based on various code found in GPL sources of the TP-Link
> TL-WR2543ND and ASUS RT-N56U devices. Those sources were using the RTL837=
0
> specific API for these chips.

The GPL code from both TL-WR2543ND and ASUS RT-N56U devices were a
dead end. However,
the mention of "RTL8370" simply changed everything. I was searching
for a RTL8367 API.

> It was not clear that the two models really belongs to the RTL8370 family
> or simply the vendors were using the RTL8370 specific code as a base, so
> I have used RTL8367 prefix in the swconfig driver. Probably, it would hav=
e
> been better to keep the RTL8370 prefix to avoid confusion.

Maybe. I don't know if the RTL8367 family exists. I'm adapting the
rtl8365mb driver to work with multiple switch generations, from
RTL8370/RTL8367 until RTL8367D. I simply internally renamed
RTL8370/RTL8367 to RTL8367A as I can reference it as Family-A (and B,
C, D...).

> > The main challenge with the base RTL8367 is the lack of a public API.
> > Most vendors support it via binary managers (ASUS) or proprietary
> > kernel modules (TP-Link). The only available references I=E2=80=99ve fo=
und are
> > the OpenWrt swconfig driver you mentioned and some U-Boot
> > initialization code. I do have the rtl8367{b,c,d} APIs. While the
> > rtl8367b seems close to the original RTL8367, it has fewer ports. Does
> > anyone happen to have access to the original RTL8367 API
> > documentation?
>
> I have no documentation, but the RTL8370 API source can be found at vario=
us
> places [2], [3].

I did have it checked out in my dev dir for years but the missing
piece was to match RTL8367R with RTL8370.

> To be honest, I don't remember all the details, but I hope that this help=
s.

It helped a lot.

I have a mostly working rtl8365mb version that runs on RTL8367R. I
still need more tests with FDB but I think it will be possible to
replace the swconfig rtl8367.c with DSA rtl8365mb. I am still looking
for a RTL8367B and RTL8367D device to complete the family.

Regards,

Luiz

