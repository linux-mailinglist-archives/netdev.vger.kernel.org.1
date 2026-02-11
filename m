Return-Path: <netdev+bounces-258357-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAkKASXvjGmSvgAAu9opvQ
	(envelope-from <netdev+bounces-258357-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 22:05:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 523EE1279D3
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 22:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DD9B3033D07
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 21:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45156359FB1;
	Wed, 11 Feb 2026 21:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpKSKCFp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220C8359F92
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 21:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770843842; cv=none; b=gzbX0d9U4hgDgqImDujN/f4f6dCFO58eCtTTnumuKuEUANMo44fkD1NpO7pshJeLE6gt+4Umt41TvGrmcCX9Psn98Jggx13R0Ut4pf2xz5Pl0xSjAQZDmsmAnNpAhM34eySobXHaLqugbD/RkwPrcL6ozb0A544pQjy3dYq0/lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770843842; c=relaxed/simple;
	bh=D/k3SnsMcp6kMMQysZou53Ur7hKj5rWTP5WPg8qGUpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s72iNbhpgnUIflDAhWRV3+xYx0yTp+OopWTG/T/8eIGuiciwvW7NMpWxalyxcmfSc5US79zQPRdVU9Vc9Ku4hfVRWjnJd4Z2GPNpIqFWLXDK13aOjob5kRXg0oXLN0tcFu+GKdufW9jovKQncehn1jQnUuCYkepJX8u8cCrLccg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpKSKCFp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0461CC2BCB3
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 21:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770843842;
	bh=D/k3SnsMcp6kMMQysZou53Ur7hKj5rWTP5WPg8qGUpk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZpKSKCFpkdrNY2fn3xQ0exA8x+V7rUHFf6qCe3jhhXyNiGczxHUNdjLUrSaj/LdIJ
	 ik9P/WBWLCrRTYlUqHv2GXMlaZRCnpnVOVZf0vSXM7Tqx9ACW0olxLpXpO5DQdcZY8
	 MLMrI5VhFhEXhkrjME1EA+LQNXhVfxWs2exSFwcsOpfryS9cp6da+jM3REIxVPywVE
	 oa4usfYk7oEw0cLNYyCElB7mR8/AWUBdecH/3sVN6YvD0FNcZMMR7OABWabe1LcIEN
	 w6BG9xWqjIvVrXF87jhlUXEra2U0dbeXnwovwqCANwEq+pv+UmN604fW74Eu567BTI
	 ZtS19YQQbg+Pg==
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64a28af2f4cso2120814d50.1
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 13:04:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVKs3zJlqydHxIkykzZPpl08GYKpyVQYWtICxW3KP5o+kzyBnCH3ISo9qO8BqyCrn9NSJ0oiKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbJQPJ9A39GMhuDJahbbgLT98Qib5vG7yux1F5Lop1FU3nYsnZ
	YARais7ZXziAU1IDcRjUFl3OPgv1FfVQYJIlZ0SITtK7kQbT0Zhq4FmLNa6YFTfFwxlPFQaR7MO
	H3DtcllT7eKAQlTK9xdBLkHWZLzi77SU=
X-Received: by 2002:a05:690e:144f:b0:649:e440:26a8 with SMTP id
 956f58d0204a3-64bdf1dd3e8mr307697d50.0.1770843841164; Wed, 11 Feb 2026
 13:04:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211-ixp4xx-fix-ethernet-v2-1-07567f886c8c@kernel.org> <168768b8-f26f-4f4d-9b76-230a76c312d2@lunn.ch>
In-Reply-To: <168768b8-f26f-4f4d-9b76-230a76c312d2@lunn.ch>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 11 Feb 2026 22:03:50 +0100
X-Gmail-Original-Message-ID: <CAD++jLmaYU_r+Z+t=6a9GZuVNGOHLGUfp7SDpDH8jnRqD1TLhQ@mail.gmail.com>
X-Gm-Features: AZwV_Qg_jU_yXWvhUA3ZwMyc-KvhhoyMgxi6e7tKPSy6B-4r-LF_QQ1CILzAsOM
Message-ID: <CAD++jLmaYU_r+Z+t=6a9GZuVNGOHLGUfp7SDpDH8jnRqD1TLhQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: ethernet: xscale: Check for PTP support properly
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linux.dev,nxp.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258357-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Queue-Id: 523EE1279D3
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 4:43=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
> On Wed, Feb 11, 2026 at 01:58:21PM +0100, Linus Walleij wrote:
> > In ixp4xx_get_ts_info() ixp46x_ptp_find() is called
> > unconditionally despite this feature only existing on
> > ixp46x, leading to the following splat from tcpdump:
> >
> > root@OpenWrt:~# tcpdump -vv -X -i eth0
> > (...)
> > Unable to handle kernel NULL pointer dereference at virtual address
> >   00000238 when read
> > (...)
> > Call trace:
> >  ptp_clock_index from ixp46x_ptp_find+0x1c/0x38
> >  ixp46x_ptp_find from ixp4xx_get_ts_info+0x4c/0x64
> >  ixp4xx_get_ts_info from __ethtool_get_ts_info+0x90/0x108
> >  __ethtool_get_ts_info from __dev_ethtool+0xa00/0x2648
> >  __dev_ethtool from dev_ethtool+0x160/0x234
> >  dev_ethtool from dev_ioctl+0x2cc/0x460
> >  dev_ioctl from sock_ioctl+0x1ec/0x524
> >  sock_ioctl from sys_ioctl+0x51c/0xa94
> >  sys_ioctl from ret_fast_syscall+0x0/0x44
> >  (...)
> > Segmentation fault
> >
> > Check for ixp46x in ixp46x_ptp_find() before trying to set up
> > PTP to avoid this.
>
> >       ret =3D ixp46x_ptp_find(&port->timesync_regs, &port->phc_index);
> >       if (ret)
> > -             return ret;
> > +             return -EOPNOTSUPP;
>
> Changing the error code is unusual. Maybe add to the commit message
> why this is needed, or somebody might ask :-)

Tricky one, but if you look close changing the error code is what I
try not to do! :D

Before this patch ixp4xx_hwtstamp_set() returned -EOPNOTSUPP:

-       if (!cpu_is_ixp46x())
-               return -EOPNOTSUPP;

After moving the check into ixp46x_ptp_find() as requested in the
review of v1 I have to return some error code from that new check,
but it is now called from more places, so it returns

int ixp46x_ptp_find(struct ixp46x_ts_regs *__iomem *regs, int *phc_index)
 {
+       if (!cpu_is_ixp46x())
+               return -ENODEV;

So this:

     ret =3D ixp46x_ptp_find(&port->timesync_regs, &port->phc_index);
        if (ret)
-               return ret;
+               return -EOPNOTSUPP;

Is put into ixp4xx_hwtstamp_set() so it will return the same error
code as before if PTP was not found.

(I can copyedit this reasoning into the commit message if you want.)

Yours,
Linus Walleij

