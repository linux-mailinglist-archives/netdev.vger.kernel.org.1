Return-Path: <netdev+bounces-277280-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN6nA5eo2GkhgggAu9opvQ
	(envelope-from <netdev+bounces-277280-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:36:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 998C63D36A5
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73CF13025A7E
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 07:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76D3399019;
	Fri, 10 Apr 2026 07:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1GqpRI7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9453E308F23
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 07:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775806586; cv=none; b=HbL2aIWslghydNui9gB1O5kX84hWeYwUBJ8K+oJwcQt3Xiy7ofASEedAwBaP2VLeXZ7CySbP4TvmelR/uCjmiBVYY3F/ffcCjR8qyCnLOWX3L9JGRetFMQK5Q8zEEibWpgkuWb+5Nc8wVckxHKi/IYiE1BXNPbuDMVXY0X3SsXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775806586; c=relaxed/simple;
	bh=3oWOppr0XZtEHSIjWbUXa0Jwhf+EuL+KzFva+4DOgGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IUyn50vlOnC0zN4tIKJggSU/Xp2+49G6sTeVneugFTrSRYWsC1Jtrx2l10lwPLqjJe/WC2JlfGAs871urEjaGvETiQwGbueczvFNgvVjlc7c2RBUd/GH/B//1++oNFkLpEiDThitXuGG6qRQBNbGF0rBYFBctQJi6gAJGiuu2vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1GqpRI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9BBC2BCB6
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 07:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775806586;
	bh=3oWOppr0XZtEHSIjWbUXa0Jwhf+EuL+KzFva+4DOgGU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K1GqpRI7Y2GjJGOEMw+aZJPTRGWZqv9KgTWGVwV95lxk9PtjOLkxO8maf0gnsVVZE
	 cw0lOnFOICyoXdS5xAdyE9BmQcYBAABGxrBAzUCQi0TRmBhNuz9mvP0glgLLABNHeW
	 KAZU5vvOTuSo3slf9qFZHyrbyELtpia57QQUegQ9nTaqIQM4s//PjnUGx5tswzCvKe
	 oqOPnWz0dz6XrUgFGZDYgBTBYQNDFqZL2fPBEwukkEACsYNjq9E4p0S205LMpsCX09
	 5jaj/YHVgOVzRlIuwXPvaIkO0Guc2ncq0dlFK+6J2+g95YeK1uMDO/cIGpsoKGORYF
	 FsLEULv5ZW4Uw==
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64eaf8aa893so1510268d50.3
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 00:36:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWPf6bPjnZC1K2PpyqG1dhUQoQc5gu3dJHF0drX+qL77ECMmqQYnnk8P6IOIt8fsSIMQ/rCg5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz24eJubRTN3Ip60l4IA8VYA32GBmw2xqnF9HZ9yAiuIeWbw49P
	nH56uFOXxcCwjK/UGHwJddW8GmB8c1fBumFmVmBSObkBThqUfBtnsG7q/D+cCZ2ItwG8ld61Yu7
	DKsKZW4CuPFwm937u0bBbhQNsgjuRKc8=
X-Received: by 2002:a53:db50:0:b0:64e:8748:38a1 with SMTP id
 956f58d0204a3-65198c0e535mr1364048d50.66.1775806585569; Fri, 10 Apr 2026
 00:36:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
 <20260331-realtek_forward-v1-6-44fb63033b7e@gmail.com> <CAD++jLmRT+3EJ-f_FNuZwOGU4fBB6pGHhq2OuxBS7O-cEnWt=g@mail.gmail.com>
 <CAJq09z6Y3MfkyiyaMhPTQH3W7p-ZmsNeS-iBKOeQNWWpDi0UoQ@mail.gmail.com>
In-Reply-To: <CAJq09z6Y3MfkyiyaMhPTQH3W7p-ZmsNeS-iBKOeQNWWpDi0UoQ@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 10 Apr 2026 09:36:14 +0200
X-Gmail-Original-Message-ID: <CAD++jLkqcqUThJe+kJhR2hwyg1y_RWJc7yrM-kqMeiA4T-Jqig@mail.gmail.com>
X-Gm-Features: AQROBzARhYEjkcFV_qQAWXYJkwluCcPr8hqNWcmzSLyYWBc8ZxYLDLVbNfNJvJ8
Message-ID: <CAD++jLkqcqUThJe+kJhR2hwyg1y_RWJc7yrM-kqMeiA4T-Jqig@mail.gmail.com>
Subject: Re: [net-next PATCH 06/10] net: dsa: realtek: rtl8365mb: add VLAN support
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277280-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 998C63D36A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 9:05=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> Thanks for the review, I took some time to evaluate the possibility of
> reusing rtl8366-core.

Thanks Luiz.

Even if we end up splitting out VLAN, I think my comments on the other
things that can be shared are still valid as well.

> While rtl8366-core is currently only used by RTL8366, I understand the
> goal of sharing VLAN handling across these drivers. However, RTL8365MB
> differs from RTL8366RB in how VLANs and PVIDs are implemented.

To give the whole picture, RTL8365MB wasn't even in the picture when
this abstraction was created.

The ASICs the driver was supposed to handle (and which were/is used
by OpenWrt) were:
- RTL8366RB
- RTL8366S
- RTL8367

The abstraction was part of the outoftree "swconfig" driver for a long
time before being migrated to DSA.

I haven't yet wrapped my head around if the RTL8367 (no extra letters)
is more RTL8366RB-ish or more RTL8365MB-ish... take a look at the
old code if you can figure it out from register maps etc:
https://github.com/openwrt/openwrt/tree/main/target/linux/generic/files/dri=
vers/net/phy
(maybe Gabor knows, put him on cc)

If the VLAN is very dissimilar we can just as well have two different
implementations.

> 1) In RTL8366, VLAN4K, VLANMC and PVID are programmed together, and
> the helpers in rtl8366-core assume this 1:1 relationship. In
> RTL8365MB, the VLANMC is exclusively used as an indirect way to set
> the port VID used in the PVID (port pvid points to vlan MC table index
> and vlan MC entry has the VID number). In this patch, the VLANMC is
> conditionally allocated only when a port uses it as PVID and
> deallocated when no ports use it. VLAN MC membership is not checked by
> the HW but I still keep it in sync when it is allocated.
>
> As VLANMC, at least in RTL8365MB, is effectively only used for PVID,
> I'll put all vlan MC methods behind public PVID methods in the
> following v2. There is no need to expose them for now. For the next
> RTL8367D family, VLANMC is gone and there are dedicated registers to
> set the PVID VID number for each port.
>
> 2) In RTL8365MB, vlan is always enabled, controlling filtering by port
> (.port_vlan_filtering), while in RTL8366, it is enabled by vlan_add.
>
> 3) The abstraction doesn't set the framefilter in RTL8366 nor does it
> clear PVID status. I'm using framefilter as a way to disable PVID,
> dropping untagged frames, together with setting PVID VLAN MC index to
> 0 and keeping an empty (vid=3D0) vlan config at that index.
>
> Without clearing the PVID state in RTL8366, removing a PVID VLAN
> member and re-adding it as a non-PVID member will leave it configured
> as PVID.

OK seems we should split up the VLAN handling if there is nothing
to share in the abstraction here. We don't do abstraction for abstractions
sake.

I'd say make a patch moving all functions from realtek_ops
that can't be reused into the rtl8366rb driver and make them static.

But probably keep the shared core for other stuff. Though I guess it
might be empty then until we add more stuff :/

> 4) I don't know how IVL would be handled in RTL8366... but that's a
> topic for another patch.

OTOMH it seems half of it is generic but it's a helicopter view.
There is no question the ASICs are related, we just don't know
by how much...

> It is possible that the hardware
> behavior between RTL8366 and RTL8365MB is more similar than what the
> current drivers suggest. However, the existing rtl8366-core
> abstraction does not model this in a way that can be directly reused
> here. Aligning both drivers would likely require reworking that
> abstraction rather than adapting the RTL8365MB implementation to fit
> it.
>
> This could be explored in the future as a separate effort as it
> changes how RTL8366RB driver behave. For now, I would prefer to keep
> this implementation local to RTL8365MB and then follow up with a
> separate effort to reconcile both drivers and extract shared logic.
> Some of that work will likely become clearer while adding RTL8367D
> family support.

The reason I push back a bit is that any kind of things that are
"fix later" tend to never actually happen in my experience.
Either we add the abstraction now or never.

For VLAN I'm pretty much convinced that there is not much to
share. For port separation/isolation and possibly FDB I'm not as
convinced.

Yours,
Linus Walleij

