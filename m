Return-Path: <netdev+bounces-287740-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLDpAF0BBWquRQIAu9opvQ
	(envelope-from <netdev+bounces-287740-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 00:55:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9AC53BAC2
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 00:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 093E83019925
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 22:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE9B3921DD;
	Wed, 13 May 2026 22:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLlCta03"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220D338D400
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 22:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778712921; cv=pass; b=r2I7mWVW4prr6QDe2vPaBmYKtnaxCRgPoXLwUzpp24udkhvti19KNR9J2Xrpv7iqMRFAsIFYLw68A3v5z0gFIP18RgwcllNNU/6WLHOeydld/M4kZ2A+CPoBbMY8sz2AHZGhudMB5TZldABIaugGhKCiadVlFXu2HsvgcyNeTLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778712921; c=relaxed/simple;
	bh=nHjy4UJTDdvJOJHvKw06Z2z4DxSFo/isWnkkwNp3LP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ExlnpVvzve9iR5ML9h5bjgRNHR1uo27q5WGVauXcWmzDFsawUfCo+evuCPlfgQFQbKWmBnMkZYG0rCo2zuuwuIEXDSJshsHIokV3RvcUoWIpEpux7K5j847E1cmxeCEcCvi8Zjo1tfdogykr73Cx/i8rv9o+c2XRTur1GFIOAnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLlCta03; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-676a89de629so1035597a12.1
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 15:55:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778712918; cv=none;
        d=google.com; s=arc-20240605;
        b=aRqkTi/5oRnaNdwgBte+krkF2AdI/pIarKdrvlOijU4AKwFmMVH345N43LGKZj6zFn
         vXP+ccfRt3mVslcALwoYf1olxl24UnQom+MCLqWjvoiuGGrSOr/VJB38iqaYe7snplCJ
         /jRBUbWm0PMaBeGp3gHLTuElj7O00GqTI28r2YXGyQNxG55guSFWf9Ts5wJnbaEh/brT
         kLtyFukgyGwi+0kUMDGyQlBT+EW8vRLg0/vsZgzdQ1psyYfNzIvk5mSDFTmO9N9/Svjn
         sFmuHFxL/uCp1TImt/F0L86kmrZSiHp5kMYzHGXvvr0cUKAj7Td2W/kMH3f3EB+GjGCl
         ZFjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=C0HkcZ8y8sSEmBG0+Kp+qYnXhAmI9OeCWfZrXZbzP4w=;
        fh=jpZfqOE2rMBZrwY6ZQ01paESzYs3MtEEuWuPjEZfst8=;
        b=D7UkB3M2t8Ohk5SrtvM4IQtESiKZGUEEah/xw5y+aGKWp3ELWwZ4USODkRNiBqi/qh
         U2XT4mTVV1q8y53a5TB4pwCJu7evYSh/YYl+bJsk6NrQimQuJTHs0jcE3thjBvO8YCCc
         dmJB6NrAkbSWu1l8AKpPZwVrM7KpK/A1rEOWOcQu3xf0fI+4fQY0ThI+SjIV0aUEeGqV
         hZfDYq57iTIm4h4hoFEI0IJYGUDFDqeeFZYnazvspkPhVLGNfEAPkid5nEuqhyIQmk9M
         mwxWQmmOYecRqRMVw4Rf54TvJ3pHbesNOHZGxOYd0HSX1ibaE+IodtH9ujqSSv6IJbyn
         HpuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778712918; x=1779317718; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C0HkcZ8y8sSEmBG0+Kp+qYnXhAmI9OeCWfZrXZbzP4w=;
        b=CLlCta03wmt7yyDyaT/1qjO4Kvm4G04ovVtpoGPJgK2CHFHdz7vNjkd3uWdiKzi0Oo
         x5rYgwTAJCvbgStyzaJ3jV49WG7e1/pLBbo93NZ4MtGmxa02lJdyrHrMbTaGs5XIj/oe
         wmTUzpdx+yVJDodTLIZc5t4Evc+umKy7HeWGwD8rX3xkg23nXudAj5ZYcWuAPsfTrwnU
         pDs+UjdCJsZnS1FFAsoTEc5wekwFBCiVbRpSkomhHqhWFaoTkgigAbMnnxB3LSFH4Dcq
         zwHW/gfCWl2+D/nr9qolrL7mByMyIFQ40EWt00HPU9xRrw7IQdRie0NHM1tI5ES7gXQd
         LpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778712918; x=1779317718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0HkcZ8y8sSEmBG0+Kp+qYnXhAmI9OeCWfZrXZbzP4w=;
        b=kvfrggtfmATJKjlKvRvJCfW4/tgc11eyzrQmBy5yYTl1niplBeuU7oWI2Reo8bYizv
         IlbkCFBWbP5N5p3Sb00kGZSiBCYAo40CeaABjQlaUnuu9995zHdnfovb6BW4pEA+SaVm
         XcsmMvfWasMPow7ypVT2IjG0z1RI+FAbdQ0EeejrPA9U7JXjPf9DsIJ+ovtrppkULYHs
         v5vhLw80kbz3wSU0I+ZJZS3N8tu2TvUFDyW4MJ3wogYzMhiANILd7oe05g4S6+PcejxO
         /xNOboFT35rTGIY3vJIhUHOrhXbgydnRe2ZvfU+sNsbkwo/dXZR1QpEyYJp/3u7Fas1O
         Dhaw==
X-Gm-Message-State: AOJu0Yx8K86O3gJ/jG5tAE/VXGafj3jIVoQiEuEvlw8+EjGb0siiwh4g
	r8iRfyPkXKfsWOavdLnyhYxrPkpXcYlEZ7Zyd1nbhqjWwnD34PjYIxdoKD+R5h/yRgVCMCfuOUi
	/LKXoMJ6FReHEc4yXk8bUMjKEjfY7Vdk=
X-Gm-Gg: Acq92OHLdQ73w05+FyPXNuwjhzXvkiLioGYbLg7LSZpuAgjlEApHRLYKC1Ql0BJoc23
	Qz6TofSu8uZ9I91BII27goMGBfcYehcd7oWGfn9b6x2Ye+yGEAulh1e7oCcOmxG78Vjj//Jff2T
	q0voAC+EG2InS/3pX53xIyucppXKK0uGSkHZFCcOIQBWIEvM0vOixoN1O4Mng62NHy4mVgWSE8e
	6Pn/ZDsn+mkxF5f6BcR9yhV22VAJLh/uT1VRChFYni9NwmyT3KBk4+trVyF/XgJGm96TC58wTiM
	GrsmMU9LgIe+gVf4lSc=
X-Received: by 2002:a05:6402:2b8b:b0:67b:7d77:14da with SMTP id
 4fb4d7f45d1cf-682a7004f63mr2779221a12.8.1778712918228; Wed, 13 May 2026
 15:55:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506-realtek_forward-v3-0-1d87c5f85a3b@gmail.com> <20260506-realtek_forward-v3-7-1d87c5f85a3b@gmail.com>
In-Reply-To: <20260506-realtek_forward-v3-7-1d87c5f85a3b@gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Wed, 13 May 2026 19:55:06 -0300
X-Gm-Features: AVHnY4JTA7jBw2Kf0qw1Ltqiwi9rq0Ms5lbAH4h3yGrTlLDcGUjZBKOe6lrh9tg
Message-ID: <CAJq09z75AKwTtuW4DU4M+ES7guAM2GJe+yQ=ZiJ+aci+2o3yLg@mail.gmail.com>
Subject: Re: [net-next PATCH v3 7/8] net: dsa: realtek: rtl8365mb: add FDB support
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 5D9AC53BAC2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287740-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hello,

I'm getting double calls to delete the same MDB entry:

[11725.824460] rtl8365mb-mdio mdio-bus:1d: rtl83xx_port_mdb_del:
port:2 addr:33:33:00:00:00:02 efid:1 vid:1 dbtype:2
[11725.836787] rtl8365mb-mdio mdio-bus:1d: l2_del_mc: found existing
addr=1376 member=0x4 igmpidx=0x0 static=1
[11725.848130] rtl8365mb-mdio mdio-bus:1d: rtl83xx_port_mdb_del:
port:2 addr:33:33:00:00:00:02 efid:1 vid:1 dbtype:2
[11725.859746] rtl8365mb-mdio mdio-bus:1d: mdb_del ERROR -ENOENT
[11725.865656] rtl8365mb-mdio mdio-bus:1d lan2: Failed to del Port
Multicast Database entry (object id=2) with error: -ENOENT (-2).
[11725.865656] Failure in updating the port's Multicast Database could lead to
[11725.865656] multicast forwarding issues.
[11725.865656]
[11725.890297] rtl8365mb-mdio mdio-bus:1d: rtl83xx_port_mdb_del:
port:2 addr:33:33:ff:cc:27:50 efid:1 vid:1 dbtype:2

(port 2(lan2) in this case is forming a bridge with port 3(lan1))

Is that normal?

I checked if 161ca59d39e9 from Vladimir Oltean was supposed to avoid
that but it explicilty ignores user ports (and focus on CPU/link
ports).

> +int rtl8365mb_l2_del_mc(struct realtek_priv *priv, int port,
> +                       const unsigned char mac_addr[static ETH_ALEN],
> +                       u16 vid)
> +{
> +       u16 data[RTL8365MB_L2_ENTRY_SIZE] = { 0 };
> +       struct rtl8365mb_l2_mc mc = { 0 };
> +       u16 addr;
> +       int ret;
> +
> +       memcpy(mc.key.mac_addr, mac_addr, ETH_ALEN);
> +       mc.key.vid = vid;
> +       mc.key.ivl = true;
> +       rtl8365mb_l2_mc_to_data(&mc, data);
> +
> +       /* First look for an existing entry (to get existing port members) */
> +       ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
> +                                   RTL8365MB_TABLE_OP_READ, &addr,
> +                                   RTL8365MB_TABLE_L2_METHOD_MAC, 0,
> +                                   data, RTL8365MB_L2_ENTRY_SIZE);
> +       if (ret)
> +               /* Any error, including -ENOENT is unexpected */
> +               return ret;

The easier solution would be to ignore -ENOENT here and just return 0
with a dbg message.
Some drivers I checked just do like that.

> +
> +       rtl8365mb_l2_data_to_mc(data, &mc);
> +       /* the port must be removed as a member */
> +       mc.member &= ~BIT(port);
> +       if (!mc.member) {
> +               /* With no members, zero all non-key fields to delete the
> +                * entry. However is_static is everything else we wrote.
> +                * (and probably all that is needed by the HW)
> +                */
> +               mc.is_static = 0;
> +       }
> +       rtl8365mb_l2_mc_to_data(&mc, data);
> +
> +       /* update the existing entry. */
> +       ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
> +                                   RTL8365MB_TABLE_OP_WRITE, &addr,
> +                                   0, 0,
> +                                   data, RTL8365MB_L2_ENTRY_SIZE);
> +       return ret;
> +}

> @@ -2442,6 +2448,12 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops = {
...
> +       .port_mdb_del = rtl83xx_port_mdb_del,
...

> +/**
> + * rtl83xx_port_mdb_del() - delete a multicast database entry from a port database
> + * @ds: DSA switch instance
> + * @port: port index
> + * @mdb: multicast database entry to delete
> + * @db: database where the entry should be removed
> + *
> + * This function deletes a multicast database entry from the standalone port
> + * database or from a bridge database.
> + *
> + * Context: Can sleep.
> + * Return: 0 on success, negative value for failure.
> + */
> +int rtl83xx_port_mdb_del(struct dsa_switch *ds, int port,
> +                        const struct switchdev_obj_port_mdb *mdb,
> +                        struct dsa_db db)
> +{
> +       struct realtek_priv *priv = ds->priv;
> +       int ret;
> +
> +       if (!priv->ops->l2_del_mc)
> +               return -EOPNOTSUPP;
> +
> +       if (db.type != DSA_DB_PORT && db.type != DSA_DB_BRIDGE)
> +               return -EOPNOTSUPP;
> +
> +       dev_dbg(priv->dev, "mdb_del port %d addr %pM vid %d\n",
> +               port, mdb->addr, mdb->vid);
> +
> +       mutex_lock(&priv->l2_lock);
> +       ret = priv->ops->l2_del_mc(priv, port, mdb->addr, mdb->vid);
> +       mutex_unlock(&priv->l2_lock);
> +
> +       if (ret)
> +               dev_err(priv->dev, "mdb_del ERROR %pe\n", ERR_PTR(ret));
> +       return ret;
> +}

Regards,

Luiz

