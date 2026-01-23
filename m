Return-Path: <netdev+bounces-252716-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHVPLIs8c2kztgAAu9opvQ
	(envelope-from <netdev+bounces-252716-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:16:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8CB7319A
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B4043091D60
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 09:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EDF31A06F;
	Fri, 23 Jan 2026 09:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=u-n.cz header.i=@u-n.cz header.b="IHphi0KM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DBB3043BD
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769159584; cv=pass; b=jX6Ls/Uh2lTWQmAISC37/ItriEZYvIu8Ing36tZa7CD8lSfKi6D0lyyLXDMf2j/2JXG/y8PGaBAo8X0NXMoMw85ID6oontrKFczrTYRLPaFKj6GrM+k8GjnnmtCE74kdROuOo+otxoyv1J376Y0sKxr+EW0+PK72LwtzJwiC/BY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769159584; c=relaxed/simple;
	bh=jxa9yd7FMnAxbFMU15T6utvhMUQJyHMWHQUBlMgYKn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N03phNgbdGEY9AB/L6R+Hp4PJnwIJ+p95BhSDhcTWQfMnB4E8PD/EICAfKDR21w4xyf1nazC7Uh6evFffc/gXJshXdt9L4Gb/LCm55ffGvTRBTatyoky8dyCjdVQjlbIB2qdE3pfjAs8Jeq2453BzKcpIdk/s8zA4YkDXUufatA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=u-n.cz; spf=pass smtp.mailfrom=u-n.cz; dkim=pass (1024-bit key) header.d=u-n.cz header.i=@u-n.cz header.b=IHphi0KM; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=u-n.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u-n.cz
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-65813e3bdaaso3061145a12.1
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 01:13:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769159580; cv=none;
        d=google.com; s=arc-20240605;
        b=OIZFmJIz2qpbTFNQ9G6QuwhQV82cWa0Rh3LvxgheRrYN30+y8od5ZjsuxgDakX8OEG
         g8HFKquujcoqtGKwYGpHxl0KJX0WbWGocVJcJ6GK+s94N8jQJ4uc8GhYhYlgQiZT/Zgk
         86GqyHuatlWT95n4HGOHeSA5mLchxPHsc+xAHUunSFDKYI2iCKkPWmwkgHHW539LDM39
         Uuh8u8qT0NCMvbEwL4lnlKKy6aRyQ7X2KlCJMtLbmaW+uV6bvJgV1hw/1OXR+wR3RmkP
         UmFNOvDB4Rf1DDWZz5YP3qW4PCfGoxQ2x+NP0bSLxn2PknfLcm+/JOmP6rLaQITSiRvt
         lTOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jxa9yd7FMnAxbFMU15T6utvhMUQJyHMWHQUBlMgYKn0=;
        fh=L+ALsM/XySKlV4QZhnT0KshdmI4K4+P0fAGid1SFYjo=;
        b=GjKMGpnc/dDUetiKhvsx/wbCu9sJxgAU6TnLuV/xt+7e4nV7W8XZkU0nr17IRvqwH6
         IaEmVoKn3Fxoy+glrZDVQDnj77dVPnRqcm210swFVtPVxCBJ8HxgJEIScVn8wbF5AKOY
         4H526h/qvZ0Hl+rs4JIBvpiPYCdtd4Kq6rqG0mtOZSU2FO+iR8SoXvZcu1o1tHNTwg5+
         iVF1qC1gjo90UZzRXubN4NTShU7I1JnRwVRBQqRrjrI1ewj0AH/WsqPUr8QHBS1+LkQw
         tkfaFKSH4X8I3QZkGgqKujOvX5vxQ99UZB1XgbZA4BJRn1vl7jjhGZTHTK/NM6aW2+pU
         asdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-n.cz; s=google; t=1769159580; x=1769764380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxa9yd7FMnAxbFMU15T6utvhMUQJyHMWHQUBlMgYKn0=;
        b=IHphi0KMEXQ2Tk5BA9GMLh8FNTW0jQY2CTmf5XM4bbi1iivF5UsoJ+FEUyAQPC6P6+
         znWnqhfajgD5TyfB3BtOqe1G7XoDuc71W0mq/j9h1BGoH8Xiq2wQbLZ1PKwuOHmsar1u
         0mmkFRqkavDMrfVoAtSENn70LPTbLBmiBoRKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769159580; x=1769764380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jxa9yd7FMnAxbFMU15T6utvhMUQJyHMWHQUBlMgYKn0=;
        b=K3Ngiun1/lABj7FA8Mai1hTZWx2QsNNAVga6BtNUpfMgkrJ4gcI6O7J7OFNadvwqaa
         D1gqq73OpHHhx8LH8firK72xctl801m8nIA3knj17ghRPWE10f4Qooyrcs/YEOO6K4lJ
         Fne1CbP7kLHcwqEOXowXjHYEWcC/e8rcvuEntuGK0xHXvqUh6ORZ96nAOLSn8RbUdpWQ
         9/r0FNFaREIJL/iqb+9e3etQM1tz2+8EjbeEhkwkxEfPID3WwEobaA9jTwa3gmyBe+/p
         yRN0uBCJkuBWXWCqjCk5Ciyjz+QjMYEg0gxcyqyjnI/WJd2Ra6Ha0Vv4j0VgE7PhCE9g
         cxDw==
X-Forwarded-Encrypted: i=1; AJvYcCUeXm5vR44TCkJ09um6NIFoTL4f9dk8nWXQzPR2nnw/PekaWo+uQlVHaggKv05+XzNis3pLi7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQU6Zl6D0wOzLjXmk8LFHIb3cFjfI9VA2bUICQktJRCYW1+qTW
	80e7uO4zXvypoHK2F5w6kmOwpMUlPA7l1jJ6dI5l1BCOO+fk1oHfBqUWZqBqUXBY7PXXmEHTpkE
	2ZpSrALIP2ZEq02d8R/VMdlAD3GTMqXA3JNcTASn7SQ==
X-Gm-Gg: AZuq6aKzYyWcxnwVsdGuFt4AjhJDrBclOxt0h3jA+QkxdBkaxB+irn916b2+++xrbfi
	LWDwhDn0ovcBJ32aJbs/EuEPg8UXkeNchg0Rm/u+qYdE8jCsHcRJOCMyDSqxBLsS63EYlgTpkl0
	9nctDe35c7XxCEByo4jr2E6y5UfqHDjjw52P9kkLD22ko2jPFrbxxGjf5mNo93oSNoHCzOj9TB9
	39jRhni2t8CWBYaZ210XJjJKCzhlKOsqI5lrMNDzAwsmJhpg5HT2cqJViYeGxRvYLOt
X-Received: by 2002:a05:6402:5251:b0:64d:a80b:3268 with SMTP id
 4fb4d7f45d1cf-6584b1a3795mr1416836a12.10.1769159579699; Fri, 23 Jan 2026
 01:12:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN0zt4Mi4NDdUua5HXDexyyvD9naan6CnQV1yB_QT41=aY8LEw@mail.gmail.com>
 <925987de-2685-442b-a185-6ba1230dc6fb@redhat.com> <CAM0EoM=DmfHD2aPCR5GJUi-Ay2+u+iJWsrQvP7L2xgRwZhXxjA@mail.gmail.com>
In-Reply-To: <CAM0EoM=DmfHD2aPCR5GJUi-Ay2+u+iJWsrQvP7L2xgRwZhXxjA@mail.gmail.com>
From: =?UTF-8?B?S2FyZWwgxZhlxZlpY2hh?= <karel@u-n.cz>
Date: Fri, 23 Jan 2026 10:12:48 +0100
X-Gm-Features: AZwV_QjHWH10ERVh571_t220C04F_6TzctBU8VbW5d0F4KzJg1Dhk2vwQ8dSCDg
Message-ID: <CAN0zt4M7G-kUb21YJkBwXawwEio91jaMOELHO+Vkv7Yv2YD0Nw@mail.gmail.com>
Subject: Re: Bug report: CoDel patch
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Paolo Abeni <pabeni@redhat.com>, xiyou.wangcong@gmail.com, 
	Jiri Pirko <jiri@resnulli.us>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.59 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_MIXED_CHARSET(1.25)[subject];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[u-n.cz,quarantine];
	R_DKIM_ALLOW(-0.20)[u-n.cz:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252716-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[u-n.cz:+];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karel@u-n.cz,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,resnulli.us,vger.kernel.org,mojatatu.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,u-n.cz:dkim]
X-Rspamd-Queue-Id: DD8CB7319A
X-Rspamd-Action: no action

Hi Jamal,

no simple script so far. Bug appears on servers with tens of thousands
HFSC classes and FQ_CoDel qdiscs with around 10Gbit of traffic,
multiqueue interfaces and CPU core affinities. So it would not be
trivial to prepare a simple test script.

Two days ago I tested 6.18.6. Original kernel went into deadlock in
about 20 seconds after I redirected mirrored traffic from the
production server to the test server. When I reverted commit
342debc12183b51773b3345ba267e9263bdfaaef the test server is stable for
34 hours now.

If it is required to have a test script for independent confirmation I
can try to prepare one, but it will take some time and I will have to
move the test setup from mirroring production traffic to some kind of
TRex Packet generator or so.

Karel

st 21. 1. 2026 v 13:53 odes=C3=ADlatel Jamal Hadi Salim <jhs@mojatatu.com> =
napsal:
>
> On Wed, Jan 21, 2026 at 6:27=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > On 1/21/26 12:12 PM, Karel =C5=98e=C5=99icha wrote:
> > > please see
> > >
> > > https://bugzilla.netfilter.org/show_bug.cgi?id=3D1825
> > >
> > > Apologies for contacting you directly, but it has been a week and
> > > nobody noticed it. Maybe the wrong place to report?
> >
> > Indeed the netfilter bugzilla instance is not the best place to report
> > sched issue. Adding the netdev ML and more people.
> >
>
> Hi Karel,
>
> Please post this on the netdev mailing list in the future.
> The proper commit is 342debc12183b51773b3345ba267e9263bdfaaef
> Do you have a simple script to reproduce this issue?
>
> cheers,
> jamal
> > /P
> >

