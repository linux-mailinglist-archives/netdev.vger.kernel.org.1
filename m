Return-Path: <netdev+bounces-275890-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MP80MpK51GnQwgcAu9opvQ
	(envelope-from <netdev+bounces-275890-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 10:00:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D383AB0B9
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 10:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2159530053D2
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 07:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3236C3A382C;
	Tue,  7 Apr 2026 07:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vo2FAFtA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEE43A381A
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 07:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775548792; cv=none; b=nKYqpuUb1qlV6sEeeBz5o7dQAB8xbzTh2Zac3mW9Y5H3VTJbCVf5e49pps2q1RIYE4d5LEQr5u6w3mNUCNCQm04MyLj9f6caUbHYcIMcV4wdJ2ZH+Q4fPTt8rNysYk48ErUMmp2QEYDjLn7qVP5cT6p1m3Qi3rsN3TXy/opGh30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775548792; c=relaxed/simple;
	bh=frAmkuTgP2dSjHd8B0fZF03UIuplXCuIlN7oKbjWcXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fITiVTe10H3jbrsr8xPS4lWeEyJ6sjaL6mhL+p3e76siingjUTqffQeUbGmFfjcQrDskhL8oPUFbXi671CzvLycoso6Sri0ndctxEye02QBwy3i95UA7X0Rsz4+g5xh2ig0bsj2tLD4byYBQQkM4YWDjzvY1TrBG453GwEq+znM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vo2FAFtA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF212C2BCB5
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 07:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775548791;
	bh=frAmkuTgP2dSjHd8B0fZF03UIuplXCuIlN7oKbjWcXU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Vo2FAFtA+faS4VTXSaZNI84ImD5/V+X1OKXueozJR6jU5q/ZyR420UWS6o/c/lcjJ
	 719bPyVdSdwojmtDy99Yhqlts5JhQaOdN+4pMlnoxb3ZtAgtmq9PPQOvyV+amQE4PD
	 xWANGAZZEHxtEiuQGJ4iw8q3uinMo8eLjMKjVxv8Rn8rLSyti5WiQDIgp/NBkycklD
	 +aoHaID4ZNF4yqHWXQBcGGWeGeARwJRUCMXEWciriFe0j4z2YsiQmamtI7tBfoTDQb
	 IDCNwIuIbYUCcAjdGFGgr9o/JC2vFFDmYEajpsNlb2uuzpc9y5OTB/d4sb8zgFNoRT
	 Kl1xu1ICDMFiQ==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79f855b2575so45743377b3.2
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 00:59:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXTBgNXCVG7hp4nW6kZhl62IRdsgDoQvITAJ/gpYFwnb0S4ZThi7LomtMhHNk6YQQk2HjSE0IQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnUhEpHa9/NSYwFbz5mOCnNobh4Ga4ZU09a7ALP1ItcSxO3HtA
	qi1GAthXjEPH0ym4BTOhnTIKBtG5tb9V9gIjqOwKqTSDcG/XvRk6Mka8+rESWXmHk61Ruc7pvhU
	AnlZCzhIL5k3LJkRRBEsX/lstw8g003s=
X-Received: by 2002:a05:690c:c36e:b0:79a:dae4:5848 with SMTP id
 00721157ae682-7a4d3ec9a5bmr127068957b3.20.1775548791255; Tue, 07 Apr 2026
 00:59:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com> <20260331-realtek_forward-v1-6-44fb63033b7e@gmail.com>
In-Reply-To: <20260331-realtek_forward-v1-6-44fb63033b7e@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 7 Apr 2026 09:59:40 +0200
X-Gmail-Original-Message-ID: <CAD++jLmRT+3EJ-f_FNuZwOGU4fBB6pGHhq2OuxBS7O-cEnWt=g@mail.gmail.com>
X-Gm-Features: AQROBzDoc5pVoMcVhuloeT4ma0flCVt38NSkmePLngpEVqq-QR9Ofazt0QEg36U
Message-ID: <CAD++jLmRT+3EJ-f_FNuZwOGU4fBB6pGHhq2OuxBS7O-cEnWt=g@mail.gmail.com>
Subject: Re: [net-next PATCH 06/10] net: dsa: realtek: rtl8365mb: add VLAN support
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275890-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bang-olufsen.dk:email]
X-Rspamd-Queue-Id: 50D383AB0B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Luiz, Alvin,

thanks for your patch!

On Wed, Apr 1, 2026 at 1:00=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> From: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
>
> Realtek RTL8365MB switches (a.k.a. RTL8367C family) use two different
> structures for VLANs:
>
> - VLAN4K: A full table with 4096 entries defining port membership and
>   tagging.
> - VLANMC: A smaller table with 32 entries used primarily for PVID
>   assignment.
>
> In this hardware, a port's PVID must point to an index in the VLANMC
> table rather than a VID directly. Since the VLANMC table is limited to
> 32 entries, the driver implements a dynamic allocation scheme to
> maximize resource usage:
>
> - VLAN4K is treated by the driver as the source of truth for membership.
> - A VLANMC entry is only allocated when a port is configured to use a
>   specific VID as its PVID.
> - VLANMC entries are deleted when no longer needed as a PVID by any port.
>
> Although VLANMC has a members field, the switch only checks membership
> in the VLAN4K table. However, when a corresponding VLAN entry also exists
> in VLANMC, this driver keeps both membership configurations in sync.
>
> VLANMC index 0, although a valid entry, is reserved in this driver as a
> neutral PVID value for ports not using a specific PVID.
>
> In the subsequent RTL8367D switch family, VLANMC table was
> removed and PVID assignment was delegated to a dedicated set of
> registers.
>
> All ports start isolated, forwarding exclusively to CPU ports, and
> with VLAN transparent, ignoring VLAN membership. Once a member in a
> bridge, the port isolation is expanded to include the bridge members.
> When that bridge enables VLAN filtering, the VLAN transparent feature is
> disabled, letting the switch filter based on VLAN setup.
>
> Co-developed-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

This patch ignores the existing abstractions for generic RTL8366 VLAN
handling in rtl8366-core.c and realtek.h, which is actually compiled
and bundled into the same object with the RTL8365MB driver.
It provides rtl8366_vlan_add(), rtl8366_vlan_del(), rtl8366_enable_vlan(),
rtl8366_enable_vlan4k(), rtl8366_set_pvid(), rtl8366_set_vlan().

The RTL8366RB notably has the same 32 PVID thing and the
same 4K VLAN table.

I understand that it is always easier to develop and test something
for "just this one chip", but I predictably have to be the one to ask
if this can be done in the shared code.

You need to either:

- Take a second sweep and refactor to share the existing VLAN
  handling with RTL8366RB (preferred).

- Explain why RTL8365MB is so very different that it cannot share
  code with RTL8366RB, then proceed to move all code from
  rtl8366-core.c into the RTL8366RB driver, change prefix of functions
  and generally make it local so it doesn't bloat the
  RTL8365MB code before adding this.

Yours,
Linus Walleij

