Return-Path: <netdev+bounces-306613-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P9aSDvYJUWqE+QIAu9opvQ
	(envelope-from <netdev+bounces-306613-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 17:04:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD1F73C0B2
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 17:04:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=a0MhBF2k;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306613-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306613-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 318E9300E28F
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C19F282F1E;
	Fri, 10 Jul 2026 15:03:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22980200110
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 15:03:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783695839; cv=pass; b=ipvp8Ktvn/9BWvaMOrOkVgIhbmvCho9icKLuebdDkDGvoDXNmBjKq7aajuv9KOvcN+qKYJbQZCiIhjmCYuxKEDjeOJUYcmrmMRFwxL1VtYR3jlmbYb7f1Cxj4KvhcVNf1i0En4D0mD/2s4XA/AI1rNnUQBisNVCY1BjciiVgRnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783695839; c=relaxed/simple;
	bh=ndqQfe6IILLuWKMHRBEe33QPMUJ60eJC3KQVW82i5BY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hDPoJH5JzbCdfZWvSnqJN1OnjHkjA6rnlHLQr388oEAJKx3CJXd9//WpwR7I+aqptRMtnJDQ5odMhZ+Ug5UGJvSjz/l4T0kdnhdRYRgjh9CfFANdKo5aiPCf+EdlCUgFYZ237YAXCtl1zDACmX+gJ+e46sIXSEQ4uHhkwmKBikU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a0MhBF2k; arc=pass smtp.client-ip=209.85.160.172
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51bf2479349so6603651cf.2
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 08:03:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783695837; cv=none;
        d=google.com; s=arc-20260327;
        b=Xkh7E9e25v0va4HGz9+ZuAuQJUJTQX+X7lrhz6ERbp07toTACUZmmd2mHHhuXwgs/L
         aZBqOJBWHCeExTkij3jxVTuwyuuruYWLE0TqASltU5SbQdy846fGbvIuMIfwMXN3F6Jr
         7qpGHFbU+SPqvdAAkjIQ7cgPcbRIN26kjB5Q4m/EV0ZaNTPHdirymQHIjZ8x7B5ce0yk
         4qj0SU4x1VPe5LDlJ73QBiSBrqUmgLFzv+oZVFQSIvBSLp6kJULqf7Mz64tZZIM0Ng8K
         32eH5Y2aZNMTnCEH9WOsXIU8YG5y9g5uqa8Pz6bhxfn4tu0f/JuC4ACMKsglKKAEmleI
         GDfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l81GarcxENHw4OefhQcXmqSw/F9R31/dV6yt86dHT+Q=;
        fh=W3wnYswzrupmqdX/y+XPO2RkSzMsN6Ni1CJq04LXVto=;
        b=UZPjweRAK3fArR9iUdpz26uGS9S7UQ/Zqmff9nDCDtN8gjX4Gy/RKNDY3GoPmuXFw6
         U1L6nPnLth0Qe2rqQ3bM63n2VHwyFLYmn/SURkH6L8WXnKKiTtK5LLNJk1ADML8aA+A9
         IoH7c0Oy4GNPISBIAS6rgnZNRN07qxMTOWBHC2v8KjHNjxMAZyO37yvwux4ryz7OoKDD
         /IndSQzBIRz5zs9jMlN7ceHZIxZKzvBusr5fkbCPUSB+vhxaRh9pxiK6U+Ucf5sp+VaI
         EYSqZBpxia7oOD4oAJhIpceqZIaj0hPNwVYRCl9UGH4tFt+Efu6olUxkB1x7KQUxmMIA
         qAnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783695837; x=1784300637; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l81GarcxENHw4OefhQcXmqSw/F9R31/dV6yt86dHT+Q=;
        b=a0MhBF2k0LCAyBUKDE/+zVTdhOSvr9QprML0QZlpfr0+KdYwxd+aJM0JFOmhWCMM7x
         jyKyPWkPmTGZTYaiix0mxFUqYCMT4Dg50HIlo3buvj/aScimjDpimsdC3LIoXQAlg4vH
         xdr1UWTAO2DgrwAbbvFiWhbDl2vNeLvx3VJ7iHK+4nK86qTgKyFEazUZyXfwQJvAFro7
         wfRIEOJ3+MU72CHG4BJ3EebE8SHvccSvg6uL4/L+OQYoWqH5eeMDeuBtOoBJsAx8pwny
         pwGUZ1x4hJz8clDlkonvoS36biXhIBqY2wUyEpFyhmv7Kv/tjQIOt/sLEhpK/3bdqJfu
         U2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783695837; x=1784300637;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l81GarcxENHw4OefhQcXmqSw/F9R31/dV6yt86dHT+Q=;
        b=l/8iw9gnmr25PIqyXufDID+IK82zlLBnV+nSAy+mQynKQa1ZWCtxKxqHd0A6aWrMYU
         PJxET14OWep/wYnu0yK66CttRGPN/Vj6ucW+ShN139BZ9mUkRG10UvCELUOXoHja2NYq
         QgOJWvnEfmnV/5pT3zuHz/TTENXgiOm8WsJO9TfXvKm1SUb3/kaKFvRpZE1cjPnB6ylJ
         b/1XZ9NO4vruf1V1wWTKLVAG6esIAZMFX+9VnpeW0b3bWNsVimg1Gp5a2oIFaQ8QHIHK
         lG+76U2PL5115WgndeVmjE6NrzVpcO5H3hDlNcX4DrOnv0ppGr9GnysCj/HLNvlKfw1C
         6fmQ==
X-Forwarded-Encrypted: i=1; AHgh+RqlnU6mRbCFO6AJHXQixmHaTi16EXBOSuzAEzP8R/EyBN7eZaCQ93nVVZsvCDzlC/GVnfIXo98=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPs6ygBD4UA9EUF8cU5ar2l7PulBo9isDDMJ3a9ox0kV840eGl
	kaTPNE5Hp3qCfl9GiIsSGKuHJBrQTSmftq64kkVe9nJu6fQz5dgPNzGLAVTNFq54jhi0lyfTSKl
	RODN/w6ljqtuEG5zun40eidWmricOnWGwZKRPKqrT
X-Gm-Gg: AfdE7clS96mdQ5oSegEXp9jkB0GK5wazodAp+NCy2ftJdMcQeL2Pbl4/3gFACBVKu4K
	gJW1/sNp0MbHycgIifEXbq3+AcRNnxrnUcmWdQ+v4DlTqhmWoWvTCabZHN4UHbEY++00+NCjGQH
	Hnh/SZH/9DPm6cxVurEIaQ2AZcimQ1HF/2dngoKzWXAPh1VwKJ5oPq6QrPcO8QntpfH8sU4TuOO
	AkhbML9xJtTThi6GjWnHklXRkRb63/8pGS+v54kU8wWD70NG+mxl4pZGQRg2GF/OT2z5MaUQOyp
	hHuOtcVAvBm+3nzDWnHwMW68i8jc6AMyTsvjW+9TvNz+EpBRZjkpVbP7sAilXjDVylatGVTcrJa
	qkBa3cUPR1Q==
X-Received: by 2002:ac8:5ccb:0:b0:51c:168d:3ae0 with SMTP id
 d75a77b69052e-51c8b403c49mr134672391cf.1.1783695836203; Fri, 10 Jul 2026
 08:03:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708160411.1355008-1-edumazet@google.com> <991ec032-c6fe-4236-be22-323a9e3cb07e@redhat.com>
 <e806a628-3710-4bab-bbae-b6dffe3513e1@redhat.com>
In-Reply-To: <e806a628-3710-4bab-bbae-b6dffe3513e1@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 10 Jul 2026 17:03:44 +0200
X-Gm-Features: AVVi8Cepj3D6OiwkRse1aAlts-ysmR8ru3ZglLdAJAglkA9_WtM2QxAZoeWyyuM
Message-ID: <CANn89iKMiWGw-B1yHWBvPyQbPRzxJgJJU8GU-yg1yZW14zSPLw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] vxlan: RCU protect vxlan_config and enable
 RTNL-less fill_info
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306613-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,nvidia.com,lunn.ch,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,m:kuniyu@google.com,m:idosch@nvidia.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:andrew@lunn.ch,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8FD1F73C0B2

On Fri, Jul 10, 2026 at 4:22=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 7/10/26 4:20 PM, Paolo Abeni wrote:
> > On 7/8/26 6:04 PM, Eric Dumazet wrote:
> >> This patch series converts VXLAN configuration (`struct vxlan_config`)
> >> to be RCU-protected, allowing lockless readers and enabling RTNL-less
> >> `vxlan_fill_info()` netlink link info dumping.
> >>
> >> Work has been split into three distinct parts:
> >>
> >> 1. Refactor helper functions in RX, TX, MDB, VNIFILTER, and OVS paths =
to
> >>    accept a `const struct vxlan_config *cfg` pointer (or pass specific
> >>    fields such as `flags`/`saddr_family`) rather than accessing
> >>    `vxlan->cfg` directly.
> >>
> >> 2. Convert `vxlan->cfg` from an embedded struct into an RCU-protected
> >>    pointer (`struct vxlan_config __rcu *cfg`), dynamically allocated o=
n
> >>    device creation or changelink, and freed via `kfree_rcu()`. Update
> >>    offload drivers (`mlxsw`) and OVS (`vport-vxlan.c`) accordingly.
> >>
> >> 3. Update `vxlan_fill_info()` to run under `rcu_read_lock()` instead o=
f
> >>    relying on RTNL lock, completing the transition to lockless link in=
fo
> >>    dumping for VXLAN devices.
> >
> > I *suspect* this is triggering RCU splat in forwarding self-tests:
> >
> > [ 1955.481960][T11074] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> oops, sashiko already spotted it:
>
> https://sashiko.dev/#/patchset/20260708160411.1355008-1-edumazet%40google=
.com

LOCKDEP inablility to understand rcu_read_lock() and
rcu_read_lock_bh() is quite something.

rcu_bh has disappeared a long time ago (it is kept for historical reasons o=
nly).

Perhaps we should finally replace it with standard rcu, to avoid
stacking rcu_read_lock() and rcu_read_lock_bh().

