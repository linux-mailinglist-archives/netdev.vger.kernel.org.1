Return-Path: <netdev+bounces-294393-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XIIXAHY4H2qEiwAAu9opvQ
	(envelope-from <netdev+bounces-294393-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 22:09:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10613631A7D
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 22:09:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=GvId2KiR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294393-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294393-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 54F5E300AD70
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 20:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DA0303CAB;
	Tue,  2 Jun 2026 20:07:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AD330BF4F
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 20:07:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780430855; cv=pass; b=a3ZomRtdRzJ3YdWtGBLrzBfY9VttVY4NsRtODmaEYFOGbnMS/zb2OYcY7wh+vFODgN/NDXJN9xAhrOW9FGlmQ3muHq/2r2vCQluqkOfA+qP10W/dszmGoOhcJlugyZbhm1D56gDL2p3j6DTgHn/8DehlTj+45Ly7JK2JdZuLKCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780430855; c=relaxed/simple;
	bh=L2ivZIiAeGHrRCf4KJIKbd1RYBQGdEu3L7NilU0lX3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j7AqwHSU8KxHRpfDIMigk0XRF0BUWb8mrn4vJ9a/VDmGt7/qH8VUGJX4pGZcm+9CVAhlojHsrFPhSlWUZLIBTlKN1bvhsTlBrr9NtSi7RakVHBxA+gKBax74+ItWbeuuDtk6CRSIBTx92ECrR8b6MTWPOw0bdgDbsA7XmnLZeFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GvId2KiR; arc=pass smtp.client-ip=209.85.208.52
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-68c08bfe5afso4192338a12.2
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 13:07:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780430853; cv=none;
        d=google.com; s=arc-20240605;
        b=dlXfPQUfOsFwEkgjAceVc+mmN9YUl4jbw1z64DBqLpdU5e4iPJ3c8+afe8ewjKNMxp
         Y1oz3tlpcRoQfaItig/dNgy9hoBVJAyN9x/+ANNvgQoXijs6PDW2Op7NIsIJU615QpDx
         DPztEwEQQe64oioCpPK1VHXQfJA96/u6pjQ8MS8OH6KzMMXJ5UzKyPjtGBG/lc0lhlZf
         +iBMP/1T1TSgKg6GfNRvt8MuQ7LXqPGmAanhGF+NP6mpz6oAp5OQrrYZ1qDE4vtUyJ0d
         k29ynyJ+ErhUS9kaqVbJJa8BDn/UZrlcUdX9ZDRrs918F0a0MAxtTc9V8Yivh9KAm2yu
         3q8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7e439Vheml0YP9WTIxqBiNdOV+aXkmDQQinM16jLQzk=;
        fh=EirJy800IHd56LQe0fKnwUy+X/vkmZ0z0eqGtLKwUXQ=;
        b=RSVwmzLMk+Y7aIiqOTBTqOnD7xxgKZ6JQGBaYLDeg0CRJSondCu3ouT/V1edwwjNMA
         pXWC48WK7hN/009aLk3ayJ+y5KQMjXQ7qE5kDZM4MINOqvgyRtDPElKPfdgi6+Z0g377
         GMJNCAjegM+tYuZ3KoDl/D2doLgXy9IqRicuzqf2MeWDhlE857O9kzkB97OCjjDKwadc
         DEJHArWWoomd7NORt1P2EVoPnr1ej//PkOV3u+NbBDzzAnrzWrH+CoT+3G7W4aXkfAVu
         fJ17gUxoKUQVfd8lxnOE12HNPR4wTF6BAbJUKGu6BkYIwu1I4ARzFYpWPXe3q2F9k6M2
         3j2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780430853; x=1781035653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7e439Vheml0YP9WTIxqBiNdOV+aXkmDQQinM16jLQzk=;
        b=GvId2KiR476QrUthR/kDq2+vL2d7joqC6uEeqXPGPutxFUrJwnNgGnhBPcSTE2apnl
         SZHGv2PaXDVbpaRah9zrruTeezq/1gjiw2ft0vFyE9WTgXgsSt98ArZjkQAA1QocqC00
         AmoXozIfhuXf+UjMTq+v4yK3smG97Y3fKOpiNMBDdAG4obhZY4O7XfwX2jVBkgYHELWi
         dGZqPEdyX/w8wBzpQ0UE1xeZy8Qfr6tVAo4P1DGW5eKyTUSV3qWhqsne/TyFVpCULPWx
         rnIrHE3bjpgpgP4fVwLaY3gO1HvfNDGfaWh8qRclksD4eIhAvheWPaPak94TXpHbpMJW
         qItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780430853; x=1781035653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7e439Vheml0YP9WTIxqBiNdOV+aXkmDQQinM16jLQzk=;
        b=AZ9eAA0WVNqNO3DAY3MD11kbBpswTNAHd44bDNePjgPwVc7Al0c8EP3Xek9SuBtcws
         t7OfNQCa8KXz92ajomGhyBtAcfhF47bowqw+0gaq2mHGltnFpRYxwyf0eI7w7XGrzDXO
         0hvayTpfKfqbqDn0DNyq1wlxXfWs5kIKIb3yayXbBTJRW+jbDnggGh9tX3tFGpGzssXB
         ynymvWVM/yL5GbbGd7etxytpa4mjrq/P7h7HXeYBppdh1npCujO7ZGSLnlR3+9qh0VkM
         mUPIq235JsIFWPj/gk6R4MR3A/VnGlUz8ItVq/QyChDqAUiOGyZ2JbXiJm2nCL8patrp
         IQ7Q==
X-Forwarded-Encrypted: i=1; AFNElJ/RnL3Q1dHPuQE45Em2yQuS+g940gmV+QrVm22hfYs37xK3vJzgDAl/33zw904hHsA9bAOFLQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM8zug00Ufw8XJfKP+VceCdFUUF2vAUdOf8cXD8pWEjiMdBX34
	CSxaZ2rxhVeGkSzf0LeIkQFNRF6Z9eJh6H/tlq+lYnLW+G4BoSDhT/jpEkysz81hFllNJ7TfGAX
	HTnNkPMx7ji+NUVVplyaBinka8CGfGvzyCJ1glDcc
X-Gm-Gg: Acq92OEKXeRXhwJJJYYZN61hE9QQa3GeUks2bJF/Sjm3V0EbsaQ5jAx92Po+lsXv88M
	Y4QaB1Qz5cU2CLANX+t2QMJ6gVm2Ms8ABvFr0APMZPF3GiocK81zoxu3C17FSkLaSq1oqX7TXVn
	tZbNroFTyb9XLw7n25VzrHJQRzcFvX6JF62nCqyXonYjuY+E59CrYzUUmkZRW4jzydPu4PgEeoi
	xSNonF/gECKbwVjB6fmCmhUIDB8hNzawB+9eUm8Id/1LNN2A6p5nBIQXl2Rc1xXmRjA0cCWOQrV
	hKpDVtWjhL2Y2OQ6p2qoaJn7M/4p2XtlrBFqhnY+nx/NdX/j6mvkp79xB3hYbrHQM1+sTOOy6As
	wqysIzJr9DZ0i4bW4KjMJo7wb5TFBmRzA+nvEdcHeMlgjDwS4FvprdnojJGwy1OU=
X-Received: by 2002:a05:6402:5249:b0:67b:7d11:758e with SMTP id
 4fb4d7f45d1cf-68e6fe4b1b3mr87030a12.11.1780430852152; Tue, 02 Jun 2026
 13:07:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602185711.129769-1-kuniyu@google.com> <20260602130240.26c03c7e@phoenix.local>
In-Reply-To: <20260602130240.26c03c7e@phoenix.local>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 2 Jun 2026 13:07:14 -0700
X-Gm-Features: AVHnY4L9h6x94w7PB59ioqD2mCcWl65DgXFrkk1BakrEWP9iyca7We1t5mUXMGc
Message-ID: <CAAVpQUC3un3P6LvRi=uMt6q5+L8Yx94B9R0X5mcFKn9zE4A9xQ@mail.gmail.com>
Subject: Re: [PATCH v2 iproute2-next] iplink_geneve: Support IFLA_GENEVE_LOCAL
 and IFLA_GENEVE_LOCAL6.
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Ahern <dsahern@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294393-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stephen@networkplumber.org,m:dsahern@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,networkplumber.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 10613631A7D

On Tue, Jun 2, 2026 at 1:02=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Tue,  2 Jun 2026 18:56:51 +0000
> Kuniyuki Iwashima <kuniyu@google.com> wrote:
>
> > +     if (tb[IFLA_GENEVE_LOCAL]) {
> > +             __be32 addr =3D rta_getattr_u32(tb[IFLA_GENEVE_LOCAL]);
> > +
> > +             print_string(PRINT_ANY,
> > +                          "local",
> > +                          "local %s ",
> > +                          format_host(AF_INET, 4, &addr));
>
> Should use print_color_string(PRINT_ANY, COLOR_INET, ...
>
> > +             struct in6_addr addr;
> > +
> > +             memcpy(&addr, RTA_DATA(tb[IFLA_GENEVE_LOCAL6]), sizeof(st=
ruct in6_addr));
> > +             if (!IN6_IS_ADDR_UNSPECIFIED(&addr)) {
> > +                     print_string(PRINT_ANY,
> > +                                  "local6",
> > +                                  "local %s ",
> > +                                  format_host(AF_INET6,
> > +                                              sizeof(struct in6_addr),
> > +                                              &addr));
>
> And print_color_string(PRINT_ANY, COLOR_INET6, ...

Will use them, thanks !

