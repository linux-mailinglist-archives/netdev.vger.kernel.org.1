Return-Path: <netdev+bounces-275921-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJeqL5DN1GmtxgcAu9opvQ
	(envelope-from <netdev+bounces-275921-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 11:25:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1919D3ABE62
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 11:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA73D301A390
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 09:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D3C39C011;
	Tue,  7 Apr 2026 09:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="herPfiMe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED8F39B971
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 09:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775553637; cv=none; b=AJOqSlSLeGUG/lewGkuF/KWfNYiCEqwUTLAJaTpr8I/vAwtlUn92L+DSsGqQG0LSi/KQCxpHDKSZ5R5ZscRdPAU4VQ7tSojPbSSCV/EXQHvBYMEh4FIBbMO8CcvZ4ZhnjzmDTJO17/zzNPOIV4+ks8vQx+Bnx/FUUKsF22h1awo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775553637; c=relaxed/simple;
	bh=t14bFX05TFXLTsJh9mRddXXLj8M3JZsFETNQEiPN3pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OwVka/T1C4cKnoUd9TPp2WvOnCUued7ZzwBSvjDm+Rx4rWTw0y/U9qpDXHD9gXTJWOQzEUFvo9opS4hWSt882rxnJZP9tzjVm6FWww+PKPBziT7GnWpHZP7nZliHyuoqKDrgb9yYwUqQ3v59AdP4Q704nDeexzk+cCiShbAnz2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=herPfiMe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47BAC2BCB7
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 09:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775553636;
	bh=t14bFX05TFXLTsJh9mRddXXLj8M3JZsFETNQEiPN3pg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=herPfiMejmU6aql+whYpwvyX9HoxpsLxOd0vtWKl+XNzC+jedIc1gpJ9QLldf7CaQ
	 YFABhOmarj/ER91PviosGiSIE4OM59dbzFYH4hcsEjec0mfE8jECvmTFe709YWhn61
	 z7p1EOqNIAHvycgJqurlZCQGj1PgpzKWqC9+2zUlEVbuOq4IF/Q2TDVRuljH8NCSwc
	 RDru3g0Jv19nu8CLbhwpgHG1k9BsCIYuoQPQWEBHVYzrBK4Pd8rNSQagnO921ATdLK
	 0hYhIS5Q/mCVg/xvdTmSkhhsaovz8FuB+mKg4nL7uN2CLu+zi46qr5LG9KBFITlvaF
	 3hKnJ5iRNgHvg==
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6501e465a8eso5293424d50.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 02:20:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+aby9955xcLFvRl4wnhHHBsxsJg9HWHfEFZONhIvhDHQC6QzxkwZhfjDh2AvGtrlJYcPBXaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrNfwaP5jsBkJ9IKu6YXVBXKU/lWRd34YLaw2YnRPLCjAcIB+X
	8WSIgGw1nQqMxOWqoTDElXHSfExSIT03soGA8VuBNdxt4+VGdn8tEHs5Fb94BcIdZVBJBlQmpIX
	grWa9xHb1XEGhB0bnjePwMxT4QbyheRs=
X-Received: by 2002:a05:690e:130e:b0:650:1cbb:50a8 with SMTP id
 956f58d0204a3-6503d84d2e8mr15299210d50.26.1775553636060; Tue, 07 Apr 2026
 02:20:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com> <20260331-realtek_forward-v1-9-44fb63033b7e@gmail.com>
In-Reply-To: <20260331-realtek_forward-v1-9-44fb63033b7e@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 7 Apr 2026 11:20:25 +0200
X-Gmail-Original-Message-ID: <CAD++jL=v6qe+dVF-wk3cPg3aw8Qp7pS6BVtAqmWURJ=JvMvDHA@mail.gmail.com>
X-Gm-Features: AQROBzDB96Ncl7gIJ47tpiERBvt7RrBsgAZwAY3BNEtIyqQE3Rc5aEFEjAct-FY
Message-ID: <CAD++jL=v6qe+dVF-wk3cPg3aw8Qp7pS6BVtAqmWURJ=JvMvDHA@mail.gmail.com>
Subject: Re: [net-next PATCH 09/10] net: dsa: realtek: rtl8365mb: add bridge
 port flags
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
	TAGGED_FROM(0.00)[bounces-275921-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bang-olufsen.dk:email]
X-Rspamd-Queue-Id: 1919D3ABE62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Luiz, Alvin,

On Wed, Apr 1, 2026 at 1:01=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> From: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
>
> Add bridge port flags for:
> - BR_LEARNING
> - BR_FLOOD
> - BR_MCAST_FLOOD
> - BR_BCAST_FLOOD
>
> Co-developed-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

I have been working on a patch for RTL8366RB for this as well:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git=
/patch/?id=3D0d58a9d74f363b969c06a8ac8446e6eef5511795

> +static int rtl8365mb_port_set_ucast_flood(struct realtek_priv *priv, int=
 port,
> +                                         bool enable)
> +static int rtl8365mb_port_set_mcast_flood(struct realtek_priv *priv, int=
 port,
> +                                         bool enable)
> +static int rtl8365mb_port_set_bcast_flood(struct realtek_priv *priv, int=
 port,
> +                                         bool enable)

Those are small and just writing registers so I guess they can be kept loca=
l,
but I think they should be accessed indirectly through
struct realtek_ops .rtl8366_port_set_ucast_flood() etc.

I can just make a simple patch adding the same three callbacks for
RTL8366RB and then it's done for both chips.

> +static int rtl8365mb_port_pre_bridge_flags(struct dsa_switch *ds, int po=
rt,
> +                                          struct switchdev_brport_flags =
flags,
> +                                          struct netlink_ext_ack *extack=
)
> +static int rtl8365mb_port_bridge_flags(struct dsa_switch *ds, int port,
> +                                      struct switchdev_brport_flags flag=
s,
> +                                      struct netlink_ext_ack *exack)

Move this one to rtl8366-core.c under the name rtl8366_port_[pre_]bridge_fl=
ags()
and use the abstract accessors to do the register writes.

> @@ -1691,6 +1797,8 @@ static int rtl8365mb_port_bridge_join(struct dsa_sw=
itch *ds, int port,
>         int ret;
>         int i;
>
> +       dev_dbg(priv->dev, "bridge %d join port %d\n", port, bridge.num);
> +
>         /* Add this port to the isolation group of every other port
>          * offloading this bridge.
>          */
> @@ -1730,6 +1838,8 @@ static void rtl8365mb_port_bridge_leave(struct dsa_=
switch *ds, int port,
>         u32 mask =3D 0;
>         int i;
>
> +       dev_dbg(priv->dev, "bridge %d leave port %d\n", port, bridge.num)=
;
> +
>         /* Remove this port from the isolation group of every other
>          * port offloading this bridge.
>          */

These debug prints seem unrelated to this patch?

> @@ -2547,6 +2657,19 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
>                 if (ret)
>                         goto out_teardown_irq;
>
> +               /* Enable all types of flooding */
> +               ret =3D rtl8365mb_port_set_ucast_flood(priv, i, true);
> +               if (ret)
> +                       goto out_teardown_irq;
> +
> +               ret =3D rtl8365mb_port_set_mcast_flood(priv, i, true);
> +               if (ret)
> +                       goto out_teardown_irq;
> +
> +               ret =3D rtl8365mb_port_set_bcast_flood(priv, i, true);
> +               if (ret)
> +                       goto out_teardown_irq;

Create rtl8366_setup_flood_control() in realtek-core.c and add these
three calls as a helper using the rtl8366_* generic calls there. It will be
done the same on all chips.

Yours,
Linus Walleij

