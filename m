Return-Path: <netdev+bounces-280330-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MACeHfhx6GkSKgIAu9opvQ
	(envelope-from <netdev+bounces-280330-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 09:00:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E36CF442ADB
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 09:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5580130104B2
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 06:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3A1296BA9;
	Wed, 22 Apr 2026 06:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/2CjADV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D532E21C9EA
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 06:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776841023; cv=pass; b=KL8xWcrKjJ+2VLqDP5liVKFl3/eQ5H9LEUqTwWuVFY1mGkETM7ay5dFhKPwkWiotFIcV4byP0WTWJ6aCaPdDKNLPbElTYe8fNEkQpKcCnfc2HYrvVVQWJj9PKmz/5xia5HhCmLQLyLSA6HxgL0AVEvjvMDVU+/twRyMFTrjRJAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776841023; c=relaxed/simple;
	bh=yLE11MeCFeetS3czLgq8Pjwc45aBpmJm/oGj4ZtOZxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xx4rKUu98AaZf80bFDR2KWHeThIZ8HDW2uBewXkmDgedGAFhdJPtnNvGcFzwloJBkqfBG5VEO8Eu7sgrf9OBRmbC4PzqWskKu8RsM7n6DhnCHc80mPJ6VeP7iqaeRr3oxsqbROaCviyf3UxxjalN9FV31wBje1nwzUd7jeBuSTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/2CjADV; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-676e62faf2bso1155539a12.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 23:57:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776841020; cv=none;
        d=google.com; s=arc-20240605;
        b=S9jDXtEmWKkerWeFWyfQwSKu29qNv0sPA7QVz8nAEs5bkfE25aAkstC1xVDCRbJUvD
         aDOKgPBi8WjNTXuzvNtAvmQ2vhsGrG0VkdE5bc8TOjd8vmyFnZkaz3X08tWxsfc2xkKM
         dS6R7Ov01LHz1b+CTcY3TmUJGhZR+CuXlRazj3Eck2iDwCvkaYdP+Ywv9mC9aRSVFR4s
         QN107bwwLIfSIUhGAnwHdgtNwC7EwR4Oj4RpfoBemAkrt+X+YJMxWdZGNMtuL1ijnMvJ
         rgorFpuClbfVFqh5Z+jwgtYB8OCtWQcxPVM6Oy79syksQBw7KyCittHMSiylHIoexPdE
         nLiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mCCL5JMhZWas/kLIZBfmLtWUdx8tT416PCq2Caj0ZQo=;
        fh=IUu3u3jDb0MwMriRQKGlbH3HzTg8vzPb6fdEZ/ByhlQ=;
        b=C4k6t3ypynV8Zt2m2n/wzSULaT0wDE0kBRF8STSwNXOja70TSwpQ1e2EqDWbqR9uQA
         fQbw0NsvUpbRlnq3dp0rCfCcoShDkpPoRi1h4vuHr7ayjrn4YgA5F5sRGE/c54HVpJB+
         TTGOLhnRD0VcYldCw8csEOj1zTvi6OQNm2pE/rdWXtSeYJ2w8FDAIZbYJMZyZenxBcr1
         QcHkfjqDkKutbFhcthQvvjFeEm4CrJTSFiO61uNSrmSFooJbIvAKJmCh9+NIeSbW3j+d
         y61z2AsJBNJzLVTkWz7rxhWUIxmSXy9C56pvwhD9hXVxPJ0B3MbkhkA/5SD64ZHsIwIv
         BA8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776841020; x=1777445820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCCL5JMhZWas/kLIZBfmLtWUdx8tT416PCq2Caj0ZQo=;
        b=I/2CjADVox+Oap9jk0pn+x6jMbmNxXuJWtn1Uph94Y7eLfvbPG3lY2UoRrN5mxtIkU
         awv5m0NCAeRL10sANiSqyqn1IV3KQcsoqovofIU7JoLAs9iNPgnl/ZHcGvVSEiKZBvjm
         CfOsR1utLcCwLGUIsZsrzqAznyL/OZYNmMee4tXN6aC39RRr8FDNoPbU/o0Rc71DoEm3
         8N+lemK2X6Ut86JtupnM8dQeMRjbp1t+faVU2NJkxOKj/k3iLQu/rTZ6tqcqi7OMG1xT
         DcU5fbUEqx7Qkp9CYGi4/6EoFb4e0Y5llqjMVqNSHJmHGNUOmDHF2/OY/udIBAvxuJvz
         ycqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776841020; x=1777445820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mCCL5JMhZWas/kLIZBfmLtWUdx8tT416PCq2Caj0ZQo=;
        b=gnYXlWcBRNXOXIh4fdnLOGyaNVqIZcHuVRy7kjw3pOD4ANuMdwkfQRQXD9NKKOtFz2
         CII2Vg+18LZLKu/eez+a34arcgF5VprZcROkO2yuc4P+5Jl0Fq1EOjKZcI+pJRrZY/k4
         QQp5jE40INTJzOKPPqkfIJ2lf3qqP+uYqwWwcRd4DiZ5/IxB7gUmkkb2l/ZdrOCcHsYT
         fNwqHVyQjQ3W9sH1uO/yTi3YNS6ZWjJiQ48KYjOS2SnQjBhsdxt8uge3OI/Vt9xljuAj
         dec6hBsrxyIgtbBoECs+6McOUahjmlnbKzCF/DuEwacCj3MAg/5QAkHC5kMtGzI9Lqox
         wYew==
X-Forwarded-Encrypted: i=1; AFNElJ+YnmNI3FXVt7Y+3O98hmn0e5gzqKlfpCKN5Xoh6ZacOtJyTRzxnebvTfPKAvKfrHhpGt7phYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMBS/ukygY0ZbewA34DzteVYC1gfBGoDxQx1SkoQRxeLHu5O2a
	lnoUZnZbIvFQx10cEWhOgal5etpjNfe+hN5i/O1+L/YCwxhDUlhfgOrIhXhVp25m198IXtsgLAt
	580D8y7pzoseDAT2i7XIbT+kntOXzdW4=
X-Gm-Gg: AeBDieu2IbguDiYeFwiuG7dIOvd4YuYj+XZLQF3yaVO5/hMGBSFfVw7l3IO7m4eZTF+
	QhRniTQImE9Yx3XT/5aTsDbcjn7zGbAsy1W+0cRyydJflRL5CdEBpFLCXVwLdcaM/xDlB3Yme/p
	J29HeSUwwaa++63JlubnjDoa56azJyVEJbrwu2hMSD0xy02QqKZhdMRc7234U2zDwJI2i4g8CjZ
	OUgMptsdXUmnxRtVjh8sQV6iYs36F5Jpo1cA3W48lPWYBwqhQ/A9TELkHq4p0Hja0lDO53KSPSP
	0R/sP3gBlcWs/Qbs/FqEquOAXzBd/V+vQJQ48VD4mKEbv11wBw==
X-Received: by 2002:a05:6402:46cf:b0:673:1d30:29b4 with SMTP id
 4fb4d7f45d1cf-6731d302a0emr7440079a12.23.1776841020064; Tue, 21 Apr 2026
 23:57:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
 <20260331-realtek_forward-v1-8-44fb63033b7e@gmail.com> <CAD++jLnbZ6q+Noe9abWWRNrvYVjCU-X3w4jpzKKYQDUcKNcKew@mail.gmail.com>
In-Reply-To: <CAD++jLnbZ6q+Noe9abWWRNrvYVjCU-X3w4jpzKKYQDUcKNcKew@mail.gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Wed, 22 Apr 2026 03:56:47 -0300
X-Gm-Features: AQROBzBP0C_UXLocaYpGge0ITSkbQwpxlORni0-j_m80aAVfYuFXeBjUBxYn9Tk
Message-ID: <CAJq09z45vpYP+-pkWH=F4xmbur5iDh-Z=fz4KFLF+SVQhWrnLA@mail.gmail.com>
Subject: Re: [net-next PATCH 08/10] net: dsa: realtek: rtl8365mb: add FDB support
To: Linus Walleij <linusw@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280330-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E36CF442ADB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> I actually at one point started to implement FDB accessors to the RTL8366=
RB
> before I got sidetracked (for the same reasons of being able to do hardwa=
re
> offloading), here is how far I got before I got distracted:
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.g=
it/patch/?id=3D9941b129f91e92423803d6e2869022ffa66e9654
>
> You can see that it also has an L2 table albeit with 4 entries rather tha=
n 6,
> and an additional "CAM" (content adressable memory...) table that I don't=
 quite
> understand.

I will look into the CAM table info in rtl8367c family.

> On Wed, Apr 1, 2026 at 1:01=E2=80=AFAM Luiz Angelo Daros de Luca
> <luizluca@gmail.com> wrote:
>
> > +int rtl8365mb_l2_del_mc(struct realtek_priv *priv, u16 port,
> > +                       const unsigned char mac_addr[static ETH_ALEN],
> > +                       u16 vid)
> > +int rtl8365mb_l2_get_next_uc(struct realtek_priv *priv, u16 *addr, u16=
 port,
> > +                            struct rtl8365mb_l2_uc *uc);
> > +int rtl8365mb_l2_add_uc(struct realtek_priv *priv, u16 port,
> > +                       const unsigned char addr[static ETH_ALEN],
> > +                       u16 efid, u16 vid);
> > +int rtl8365mb_l2_del_uc(struct realtek_priv *priv, u16 port,
> > +                       const unsigned char addr[static ETH_ALEN],
> > +                       u16 efid, u16 vid);
> > +int rtl8365mb_l2_flush(struct realtek_priv *priv, int port, u16 vid);
> > +
> > +int rtl8365mb_l2_add_mc(struct realtek_priv *priv, u16 port,
> > +                       const unsigned char mac_addr[static ETH_ALEN],
> > +                       u16 vid);
> > +int rtl8365mb_l2_del_mc(struct realtek_priv *priv, u16 port,
> > +                       const unsigned char mac_addr[static ETH_ALEN],
> > +                       u16 vid);
>
> I think it would make sense to add these to struct realtek_ops and
>  make them available for all RTL8366 variants.

Agreed. I will add these to struct realtek_ops. I'll need to create a
generic replacement for struct rtl8365mb_l2_uc, but the rest of the
migration should be straightforward. For now, the efid argument can
simply be ignored by the RTL8366 implementation.

> Possibly it would even make sense to move rtl8365mb_table_query()
> to struct realtek_ops under the name .table_query and all of
> these helpers to rtl8366-core.c as rtl8366_l2_del_mc() etc
> just calling the per-chip table query variant. I'm not sure
> but you can perhaps see what makes most sense?

I suspect rtl8365mb_table_query() might be too complex to abstract
effectively without first seeing how the RTL8366 handles table
lookups, as hardware-specific behaviors can vary significantly here. I
suggest we implement it for the RTL8366 first; once we have a
reference point, we can discuss the best way to consolidate the logic.

> > +       struct mutex l2_lock;
>
> Move to struct realtek_priv, every chip will need an l2 lock.

Sure.

> > +static void rtl8365mb_port_fast_age(struct dsa_switch *ds, int port)
> > +static int rtl8365mb_port_fdb_add(struct dsa_switch *ds, int port,
> > +                                 const unsigned char *addr, u16 vid,
> > +                                 struct dsa_db db)
> > +static int rtl8365mb_port_fdb_del(struct dsa_switch *ds, int port,
> > +                                 const unsigned char *addr, u16 vid,
> > +                                 struct dsa_db db)
> > +static int rtl8365mb_port_fdb_dump(struct dsa_switch *ds, int port,
> > +                                  dsa_fdb_dump_cb_t *cb, void *data)
> > +static int rtl8365mb_port_mdb_add(struct dsa_switch *ds, int port,
> > +                                 const struct switchdev_obj_port_mdb *=
mdb,
> > +                                 struct dsa_db db)
> > +static int rtl8365mb_port_mdb_del(struct dsa_switch *ds, int port,
> > +                                 const struct switchdev_obj_port_mdb *=
mdb,
> > +                                 struct dsa_db db)
>
> I think you should rename all of these rtl8366_port_* and move them
> to rtl8366-core.c. They are generic.

Yes. Once rtl8365mb_l2_* is moved to realtek_ops, these functions
become generic wrappers and fit perfectly in rtl83xx.c.

> > @@ -2498,6 +2687,12 @@ static const struct dsa_switch_ops rtl8365mb_swi=
tch_ops =3D {
> >         .port_bridge_join =3D rtl8365mb_port_bridge_join,
> >         .port_bridge_leave =3D rtl8365mb_port_bridge_leave,
> >         .port_stp_state_set =3D rtl8365mb_port_stp_state_set,
> > +       .port_fast_age =3D rtl8365mb_port_fast_age,
>
> .port_fast_age =3D rtl8366_port_fast_age,

I will update the ops to use the new generics.

Regards,

Luiz

