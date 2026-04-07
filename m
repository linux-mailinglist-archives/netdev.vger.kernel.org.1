Return-Path: <netdev+bounces-275914-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMovHF/K1GmHxgcAu9opvQ
	(envelope-from <netdev+bounces-275914-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 11:11:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0560E3ABC51
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 11:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 56E3F300611F
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 09:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C5A39BFFD;
	Tue,  7 Apr 2026 09:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkd08t6z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842EA39B978
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 09:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775553114; cv=none; b=NeJGzcH1Fc6NkgVCXNjSCbASTGKlAcQyQPF/iupKUQtj/qv0Bh2wNaPGg/6B3wKfOU2OI30VO1f325o1bvsa/N7n5A7g8OiPXt4nbFlz916yl9GdVhtb11TZUL4nvu1eua+305LWUwQEnAQr0D32xSrfrqiAi2qmxxDMAWfCvT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775553114; c=relaxed/simple;
	bh=9O6K76GbPXod6zF7f/GAO+KU5YAJ7mLuXejwa79X9yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m81guWfq2uVVYJTsmBiLa/eiRRmRD5TupoQ2+c2fq6yrlOP54PtiTqaa3pL1nBUV/0N9HzlJzM7OMEWno/lhoDsoXEK6S2zrUyfUCiouPV782ssi/ELwBRYrgkjPhQwj7f3rKg3+prLmMeo9BtpFITzlp4/f15CFL/zoFJgWtLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkd08t6z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7E8C2BCB3
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 09:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775553114;
	bh=9O6K76GbPXod6zF7f/GAO+KU5YAJ7mLuXejwa79X9yo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bkd08t6zcD9ELASoPN/Y0/BJRNJXe94toNwl6AA8M0RReQavWXzOmxulATs16c6pJ
	 O2q++TQKiIhY9HRTd3hJHdGqqpWEN07ajb56njsKDPVZrBk3XJQx4PV5eD1UOtB1GP
	 fbJanpXlioJo1fj4p17ZAIY81Bc3+eUqtWpzOrCCXSRIy7tYDXBUvrS0zzFOoaWA7h
	 IHVyUQYV9A82KAOD/dYsCevSupGW/a9qHENUDHX3f1LO+widT0yIjB9cKt9BNtvefY
	 rbQ6TOTcFKNEhyInCOzOE5p+nt/6btlvkpJ81VU4rXmNDP8Z2l9p9KlxIKHgc/B+KC
	 dirSOxrm/3cVQ==
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6501d32b04bso5102582d50.2
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 02:11:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXIDPoAVDKTexjHPOvj/Nbu5H5s8+EuvIVHeZOz2c36RmMUOvdynQPdwE+FTwpLnMFXJ6WRyqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf1XbMcaP8gSIWudHKZdlt/jhOrWdz0JtJVL+sY5yBVjVYb7gp
	etnn/h2W92AXNign42Pvin6bxgOcVpy83m34qQIi79tyAl0B3GQhqUwgO3kX/6e4QJYvIgyXcfc
	fBEPHjCz1jKPDZ5NKcLJ5nnfftPMCaQA=
X-Received: by 2002:a05:690e:4853:b0:650:39d6:69a1 with SMTP id
 956f58d0204a3-650486f2bedmr11324485d50.4.1775553113462; Tue, 07 Apr 2026
 02:11:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com> <20260331-realtek_forward-v1-8-44fb63033b7e@gmail.com>
In-Reply-To: <20260331-realtek_forward-v1-8-44fb63033b7e@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 7 Apr 2026 11:11:42 +0200
X-Gmail-Original-Message-ID: <CAD++jLnbZ6q+Noe9abWWRNrvYVjCU-X3w4jpzKKYQDUcKNcKew@mail.gmail.com>
X-Gm-Features: AQROBzAWMqIfB8j1OmUm7mGOzsbnBwqtIYLNfP-LEYTan7VwE8-_FiPtDVSOcro
Message-ID: <CAD++jLnbZ6q+Noe9abWWRNrvYVjCU-X3w4jpzKKYQDUcKNcKew@mail.gmail.com>
Subject: Re: [net-next PATCH 08/10] net: dsa: realtek: rtl8365mb: add FDB support
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275914-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0560E3ABC51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Luiz, Alvin,

thanks for your patch!

I actually at one point started to implement FDB accessors to the RTL8366RB
before I got sidetracked (for the same reasons of being able to do hardware
offloading), here is how far I got before I got distracted:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git=
/patch/?id=3D9941b129f91e92423803d6e2869022ffa66e9654

You can see that it also has an L2 table albeit with 4 entries rather than =
6,
and an additional "CAM" (content adressable memory...) table that I don't q=
uite
understand.

On Wed, Apr 1, 2026 at 1:01=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> +int rtl8365mb_l2_del_mc(struct realtek_priv *priv, u16 port,
> +                       const unsigned char mac_addr[static ETH_ALEN],
> +                       u16 vid)
> +int rtl8365mb_l2_get_next_uc(struct realtek_priv *priv, u16 *addr, u16 p=
ort,
> +                            struct rtl8365mb_l2_uc *uc);
> +int rtl8365mb_l2_add_uc(struct realtek_priv *priv, u16 port,
> +                       const unsigned char addr[static ETH_ALEN],
> +                       u16 efid, u16 vid);
> +int rtl8365mb_l2_del_uc(struct realtek_priv *priv, u16 port,
> +                       const unsigned char addr[static ETH_ALEN],
> +                       u16 efid, u16 vid);
> +int rtl8365mb_l2_flush(struct realtek_priv *priv, int port, u16 vid);
> +
> +int rtl8365mb_l2_add_mc(struct realtek_priv *priv, u16 port,
> +                       const unsigned char mac_addr[static ETH_ALEN],
> +                       u16 vid);
> +int rtl8365mb_l2_del_mc(struct realtek_priv *priv, u16 port,
> +                       const unsigned char mac_addr[static ETH_ALEN],
> +                       u16 vid);

I think it would make sense to add these to struct realtek_ops and
 make them available for all RTL8366 variants.

Possibly it would even make sense to move rtl8365mb_table_query()
to struct realtek_ops under the name .table_query and all of
these helpers to rtl8366-core.c as rtl8366_l2_del_mc() etc
just calling the per-chip table query variant. I'm not sure
but you can perhaps see what makes most sense?

> +       struct mutex l2_lock;

Move to struct realtek_priv, every chip will need an l2 lock.

> +static void rtl8365mb_port_fast_age(struct dsa_switch *ds, int port)
> +static int rtl8365mb_port_fdb_add(struct dsa_switch *ds, int port,
> +                                 const unsigned char *addr, u16 vid,
> +                                 struct dsa_db db)
> +static int rtl8365mb_port_fdb_del(struct dsa_switch *ds, int port,
> +                                 const unsigned char *addr, u16 vid,
> +                                 struct dsa_db db)
> +static int rtl8365mb_port_fdb_dump(struct dsa_switch *ds, int port,
> +                                  dsa_fdb_dump_cb_t *cb, void *data)
> +static int rtl8365mb_port_mdb_add(struct dsa_switch *ds, int port,
> +                                 const struct switchdev_obj_port_mdb *md=
b,
> +                                 struct dsa_db db)
> +static int rtl8365mb_port_mdb_del(struct dsa_switch *ds, int port,
> +                                 const struct switchdev_obj_port_mdb *md=
b,
> +                                 struct dsa_db db)

I think you should rename all of these rtl8366_port_* and move them
to rtl8366-core.c. They are generic.

> @@ -2498,6 +2687,12 @@ static const struct dsa_switch_ops rtl8365mb_switc=
h_ops =3D {
>         .port_bridge_join =3D rtl8365mb_port_bridge_join,
>         .port_bridge_leave =3D rtl8365mb_port_bridge_leave,
>         .port_stp_state_set =3D rtl8365mb_port_stp_state_set,
> +       .port_fast_age =3D rtl8365mb_port_fast_age,

.port_fast_age =3D rtl8366_port_fast_age,

Etc.

Curiously I already have a hack for fast aging in the rtl8366rb driver, but
using the FDB directly to do that directly in L2 is definitely better!

Yours,
Linus Walleij

