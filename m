Return-Path: <netdev+bounces-269048-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKAgFha7umk4bQIAu9opvQ
	(envelope-from <netdev+bounces-269048-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:47:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 209ED2BD7DD
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 107963022E11
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7F13D904B;
	Wed, 18 Mar 2026 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LtfJ50+v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C263DBD68
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845081; cv=pass; b=YQYxa2fXJk3kmgxgokgKOsdEQXYVsr8SPhgoyRlxl/rwlrbDKUoWKHIV18qP5CT/OBqWFXyJHaFhdBBPRmsKXqsrlJ7x+EWX6ckRcsTVpIKA8QnA0mlqJJk3J+3u1ZJBWsvPzDl/Rp9trA0j7hCjffLYydmv0JV9LRXdtRD01Ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845081; c=relaxed/simple;
	bh=Z4wqF9sWI9YJ+rS20uembpUi4U7sFpRC+JVMwf92TZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8ExAe0YdN6VW4lfcOhpuwfhCk2ltFakvysl14KkIT/qS3Jr06iUB/8iM0LDL9DWQi2Rb/BnCIflKhxEHZMs9isJX+E6/RTiDDlu/7QsQb5VDtByIcyQJ+AszYGCxTzQOd/ztq2uY66tiJ9u7MgTRkbrnOmLZz56rT3GO6xhBV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LtfJ50+v; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35a09e0dd63so7922344a91.3
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 07:44:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773845079; cv=none;
        d=google.com; s=arc-20240605;
        b=JfpalrdrNQVEQ3YgbSv0a7SGcDSaeXsQ4jG56IRA7bPG8u7tOuX4nQg8qcHLAgE4H0
         Y0syM8LnyY3Yaj5xz6kUZ5FQV6s2Dx6oK0+LDokfhhXOueK83bJXdyKTGItXvZCGnS+o
         aBQFIiL5CAaaGiJaSDuANbb004NtgH8a1+pNXhHb71pLoZCSQlu1MoWf6FQKEGOlBHr2
         AplvsARXnZy91jrutQoGqkU/Ukz4Zz/mdEuLnfRIWROJR87qx1YDdFaW9hGRrXW6IUiQ
         4j05b1f++x+CQ3DSOA1lOFljjRLG+Fo8pQr9h6q6aduuyKKxdtq0HQRD6J5IPcuQW78R
         icMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HkavQrv5cWvoxe4AZ9l+fP74uR/q1B9HToUrpGg2U84=;
        fh=bseyJJu/KILyl3micEdAVF1U7S1C1B+pS3NRNXI5kwU=;
        b=ae7iDNSQP+NUhFgQGSGrNDkBMtxC2N596j/8S/66c6ox414lD9yw+vZ/bOwL0qljzh
         M0YPeF5meSwwrVQfIAvxbVTggeJj5X1av2LDYisy9ZSgbjDU2RtXIMPvTC0tR8HGx40z
         P70SSEsgi10jdpAoDqZDMtFo4Z+tTVnULcj/bVc9usdg3lD8jN3Rb10n9mcR0ZEDs+ky
         KIXB/r0citaPagRh5WhmsrjCm+kji0v2apBvADyFJSv7SiMeNQtPg40RfFGWGEEudPqZ
         Rb8XxXrTmy5V1gaslkhVQvRmTn93JDuKgZRStXpLlVBLhd8XI8T+7PnSHSz6U13wG/3B
         Yh8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773845079; x=1774449879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkavQrv5cWvoxe4AZ9l+fP74uR/q1B9HToUrpGg2U84=;
        b=LtfJ50+vGOl5L+bLvcSZCj3PDRDRMn4P2P805uqGLqb3Spy++kIYGQorAT8N4DmFVe
         UuJdxNW9Tb7v8CffysJ824Sznzz0ceAdnMwBAsJO62MKMMr1tYiHxqxTI9ONL1Vdw4cP
         4ORFohxU9AXlL12y+vbHOn+JT6LkQ6oAg/ZkAvufUZ4JPdRHrhkIX/oakvTQQUZ/P5Nh
         nc59iJYCzh0yuMs/puSSEPaTAHqTLuEYkpVNtHF07PFTJgtsaWdKUYrXCIgTC5rRL5IO
         bEoP0EWhpKXO4FnTPdxcXmuZTk4bhDjZal3uFYibnFOKUIQ0DZSFaU/p5/C3htEx6SVt
         brqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773845079; x=1774449879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HkavQrv5cWvoxe4AZ9l+fP74uR/q1B9HToUrpGg2U84=;
        b=Ig2946PcO5w5bCOn1DfNUnS0X9lr0H95PEsglNBQZpV7RzLYTdVb6Ny6PGkFzaEKX1
         JUAfpOfqBGcS+p+vHY/SfQtrSlLfSAqPq8Jyb7vRxoe4owmM4mdf6R1m2UbuvQoTBfYT
         9nuj6eaQ2eDOJVDWO7fA/5J2LMyId3t+DFvLWBWZGO12STNmxrZgRawvhfFwD6VrB0BU
         XU9DtxbUZ219ai1VAlvCNcWn5Gd57wuKnppt5r39hSGNa3Gr8ZF8xEULQAlUDnqlvLoq
         3zP1KoE2BM+9rB0GCvLPDLCx8BjCEg+rM9NPOBtqmEN7s90tTWOF3JmxtJDnmDRT69M6
         RzzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO3wZCTjYYjHs16t9T3VzzUk0unEfD3CT5ZTQbmAmmVtG9orQxchqH8lS2tBcwez/b9u5LD+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJXPumzeSCfwDVkAnWxQgcHgWNev8RXoQPnJlyZtppUhwyjFjv
	2qUmddiHw5fYdfRPtEOv/3Oz74y1rPsTzSov5YgE/NS4g4C8RQHJvPkIXwaxO70mysSj79iDWcw
	zD70Kk8SI6yKqcJQXMBF310k2Gss86BUWcafsf/pi
X-Gm-Gg: ATEYQzwSoBisMfAXhD4rYG5yTPOljjqRrS1PGe3LBTMQuY3z3FnjVNa5ufQPKG2/h7e
	vRZvCxWd5Ace+I4XGAZlABshDM2cPxkupz0ZJGSqP2sfJWe69KLmXkriVoFon29nwCAblMm6JUD
	o0K1tq0FP8vXf0e6QabiKebbq/2Okp7HWaOJAFsZG2xWiIFWoiYkbbg+1zgeX30dJYIwfkqMcvb
	jpPVNLAktpawGLqbGnZPE1qUHu/ePLXZsDS7NaG0q77T7RwJ4fjeSloBo19RETL4f5RBavBpC2J
	yuLnkw8=
X-Received: by 2002:a17:90b:35cb:b0:35b:a44f:b82 with SMTP id
 98e67ed59e1d1-35bb9e51084mr3564914a91.11.1773845078585; Wed, 18 Mar 2026
 07:44:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260315222150.121952-2-gnoack3000@gmail.com> <2697b9f672967b1318630f2ffa21914f@paul-moore.com>
 <20260318.In1aekohyivu@digikod.net>
In-Reply-To: <20260318.In1aekohyivu@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Mar 2026 10:44:26 -0400
X-Gm-Features: AaiRm53K5dsL5XuuN56xBEWUroqIt1ab6AzZo4hfS_0P9wo1tK90pKj6Bu_pEyY
Message-ID: <CAHC9VhRy2j3nYHHnyjsDf9Rk6=5DAzCSrmXgHCpo4arVnfBjRw@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] lsm: Add LSM hook security_unix_find
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: John Johansen <john.johansen@canonical.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>, linux-security-module@vger.kernel.org, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269048-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[canonical.com,gmail.com,namei.org,hallyn.com,maowtm.org,vger.kernel.org,oracle.com,buffet.re,huawei-partners.com,huawei.com,alyssa.is,google.com,linutronix.de,kernel.org,zeniv.linux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-0.970];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,paul-moore.com:dkim,paul-moore.com:url,digikod.net:email]
X-Rspamd-Queue-Id: 209ED2BD7DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 4:48=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> On Tue, Mar 17, 2026 at 05:34:57PM -0400, Paul Moore wrote:
> > On Mar 15, 2026 =3D?UTF-8?q?G=3DC3=3DBCnther=3D20Noack?=3D <gnoack3000@=
gmail.com> wrote:
> > >
> > > Add a LSM hook security_unix_find.
> > >
> > > This hook is called to check the path of a named unix socket before a
> > > connection is initiated. The peer socket may be inspected as well.
> > >
> > > Why existing hooks are unsuitable:
> > >
> > > Existing socket hooks, security_unix_stream_connect(),
> > > security_unix_may_send(), and security_socket_connect() don't provide
> > > TOCTOU-free / namespace independent access to the paths of sockets.
> > >
> > > (1) We cannot resolve the path from the struct sockaddr in existing h=
ooks.
> > > This requires another path lookup. A change in the path between the
> > > two lookups will cause a TOCTOU bug.
> > >
> > > (2) We cannot use the struct path from the listening socket, because =
it
> > > may be bound to a path in a different namespace than the caller,
> > > resulting in a path that cannot be referenced at policy creation time=
.
> > >
> > > Cc: G=C3=BCnther Noack <gnoack3000@gmail.com>
> > > Cc: Tingmao Wang <m@maowtm.org>
> > > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > > ---
> > >  include/linux/lsm_hook_defs.h |  5 +++++
> > >  include/linux/security.h      | 11 +++++++++++
> > >  net/unix/af_unix.c            | 13 ++++++++++---
> > >  security/security.c           | 20 ++++++++++++++++++++
> > >  4 files changed, 46 insertions(+), 3 deletions(-)
> >
> > Some really minor nitpicky things (below), but nothing critical.
> > However, as we discussed, I would like to see the AppArmor folks commen=
t
> > on the new hook before we merge anything as I know they have an interes=
t
> > here.
>
> John, Georgia, we've been discussing this new hook for a few months now
> but didn't hear from you yet.  We plan to merge this patch series with
> the 7.1 merge window (in a few weeks), so before that I'd like to merge
> it in -next in a few days to get a broader coverage.  I'm pretty sure
> this hook will work well with AppArmor too, but could you please take
> look to confirm?

I probably wasn't as clear as I should have been, my apologies.  The
major reason I held back my ACK on this patch was that I wanted to
hear from the AA folks regarding the hook's suitability for their
needs.  While I don't expect they will have an issue with this hook
as-is, they have expressed interest in the hook, and I would just
assume make sure it is okay for everyone before we send it to Linus.

Since this is a feature addition and not a critical bug fix, I will be
quite upset if this is sent to Linus without review by the AA
developers and my ACK.

--=20
paul-moore.com

