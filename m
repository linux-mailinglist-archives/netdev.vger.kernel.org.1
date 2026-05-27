Return-Path: <netdev+bounces-292214-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNfcF1e5FmqLqAcAu9opvQ
	(envelope-from <netdev+bounces-292214-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:28:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0398D5E1D15
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C82B53001313
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8073E5EC7;
	Wed, 27 May 2026 09:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzKIVsjy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE4D1E7C18
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 09:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779874132; cv=pass; b=Se3JFiAv4AmZ2tbREGlTVy5KKYipzzWPNubwC//SWQRXaBw1VqggVO27fTRXM0xx+0y0JcT1+fp7bC687gkQECf77uJTjMa2i88cqkFOtNdwiYpkRBbl9ZA8GvZs8+XNV7djmLZoDOhsA255D9Kz8IHMo0IHoYqhgkxsxp34fwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779874132; c=relaxed/simple;
	bh=4fREXzYdW3nSilqi0pUb9NRe/6FZoBYQX7YJJ+9FyDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPcgiCHQBPYqfC55x8kiHyg7+6w8CS8phZnQQbDwwtCOKUBvr7qa7FT2zTRr4uC7fWPkJQqFDCqV9ivB3P9f1BtmwMf5/+85irICEkSb42KVqepGxx6RQkQ6O8GXOVxw9XjukgE2la9osmP6HMtp2+rF9k/jf8skXc6hh838HfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzKIVsjy; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-65890a6ca20so12387867d50.0
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 02:28:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779874130; cv=none;
        d=google.com; s=arc-20240605;
        b=i92xtQ+xisP21X0KP6PZ3lC0PoZRb97nj2QdQffvSgfJWGT9dAVdfSSHWKC3RLC+FH
         6whVOXtmF3CzReK6RwAS0Ew1tgplrft4GWmdnthSiaS1tmDT+xYl7dc5RTQkNlOTc3v9
         NyvrRK9gG9uMpiGZybXpXJnhUg283yTXSQ6rxPFq+LfEpZK+nAVgtRPVWq1RARQQVjYq
         LXleo8XP1283KBhELvBNnfVHm/neGm7M9bY5mWe4o8A+5mWgOS8jHE7juC7iZmYu5s6G
         xR8hLyuRDLZFehFD/SXMdu7OJbAK9db7hvLYg3hMberjJGUKZp/omhQ5X/FHbUsVI7vU
         9j8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Lb4a1mvXhD0AyG1X662FlMDwuDdCyGEU9LvZ1PV1CrI=;
        fh=4KFoli5BYm1+80MAMWJ9t5pEaZ7cp3CadvHQOo6okOc=;
        b=NNCJzlk4f80++kHr41Q6HgJISP+OBZ4CxmABp+1zn7BtDRgM4JVyuaBeII4ysV1/Ib
         azKXzztgCW1H3Xln2N9bprO+G7fuscv9S5/fPEDzcz+QyzbaZ98FeeGPVM9B9WIYt9aH
         cScpp9vLcxWEQvU2ITcHffEfpw2cH1XMdVACgDPRmXc1z2jLDRcOAkfrQUDqbA3IrXjd
         QD/y37hVmt3R5yXwlRPWtesBQ8hOaz9A+DERJ6lODhfX0JKH0r29RjLfx6iyri8nngl+
         1LwBJTbjE/6uZX78BNWALiaL/7s8nVCBeq1RPJVS4vFWWr5yDG78NOHZ+V9BNHGcfoPw
         7A5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779874130; x=1780478930; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lb4a1mvXhD0AyG1X662FlMDwuDdCyGEU9LvZ1PV1CrI=;
        b=CzKIVsjy/pm8kcLU4YUhLYeQbDYsl8zyEu6N6voBh06A+F2Kc5AVnZilcarl6SoM0a
         dG0y1allD36BD48uTHj2ICwMhA0+62i3st8OHnWvPrwCczIGdDEFmzSE/gQZ/jTHKyFB
         07SncAtdg9X8vUw7qSGuXmrx4JxYED73qb5MBRPC0LP9XHMfooKwjDvL0dZnmkITXNkW
         mJPrYjvwm5JUgqSipmS7E1shHWtHMkJQDkYh0A6baBlYPCNUEkQrZOJHSQCkSpPeOzTZ
         SNChRxHHXVXNy3poA4zxrdJsgsw4vzN7IfPk6Z20jhFhmAbkz2Fw8VrjxjDNV8oxd3H7
         9j1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779874130; x=1780478930;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lb4a1mvXhD0AyG1X662FlMDwuDdCyGEU9LvZ1PV1CrI=;
        b=ednA2J1mYoAp2oysHnT4XAiyJh3rxruzpNtgz4pj2mgT/tkZUmg7yHRNwJ33lof0fi
         el6Gu62R1alu1HBH7/hsS5BNJbZ2EVJyBOH7C4GYsiyqz8Y5ISxLMFuoyPIGI5B29UDX
         ovHGmOu+gqXlaTcTLqGxvgJPB4cmGbB22B6wtYJiDV0K56BiSZuCkkFzZ0zl1QonIehu
         4W1ZAIlYx5/tgqmj8UmMH3FBihV1ZS/g+0nf7zzWQawsAwS5n+Oif3A1HHdfKjQ/QEMv
         c6kbGOKn2CjGFQDgJJh7kH7sRPJdr0CRRmhRiwZTpn+/DsdZEJAxA09PS619OD3e+Nfj
         C63w==
X-Gm-Message-State: AOJu0YztdzwFusrYpXeQppzf6hbe4LcxeTNfx7evfKQ0Bx+Rn1KIYPrY
	yePaekLEF55JQkcBvkcB6DNe+PFLRPK8HMBSmwLq+1MrZ0aGaKNNF90Um4CkxuxM5CY9BuVYqbF
	fdZY2hdR2OSEdQXm66QeqplDe+d4YFVQ=
X-Gm-Gg: Acq92OEEeQVZyUpGIDQpXK8sDV9lPPPWiWi7dSw9C0ig11Xzupveplt4+4qy8N7eUwQ
	5c2dIAKrDKbjkMLp5DhA5RVhRKvdwXCluN2ETduD9oy+z8e6LxMa/jnWHOW5iS7rgecc207hYG6
	fCtk2x3ZaHGhKlSahe41fGZrKZO0Sz6Vdbz3EoUXYIBIrR81MAkGw9GSfahV6AaoUCar8hZLaNP
	Rw0ee7B6VDZ/IuaXqSTCZWZBgnsKpiQuC0cOuc7ni4r+qRQ0IdHRGGYyy5hTlLRxZEJbY+EUMXp
	TpjOtOaqcUwPt8UPOoG6
X-Received: by 2002:a05:690e:14c3:b0:65e:5955:2e44 with SMTP id
 956f58d0204a3-65ec98f957dmr20743565d50.47.1779874130422; Wed, 27 May 2026
 02:28:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1779841530.git.lukeh@padl.com> <b4279a06b836da86ad0c0137c3a6989a99241427.1779841530.git.lukeh@padl.com>
In-Reply-To: <b4279a06b836da86ad0c0137c3a6989a99241427.1779841530.git.lukeh@padl.com>
From: Cedric Jehasse <cedric.jehasse@gmail.com>
Date: Wed, 27 May 2026 11:28:39 +0200
X-Gm-Features: AVHnY4JCJrwHCukzP9nlntLF1eJUkvp3FaB37dSW9uQ3h0M2BRF2gvsplTZRD7M
Message-ID: <CABvLYuAYBwbJbNwhTQi=aJ=APdQekVBELog=tyDO3deAr16o=g@mail.gmail.com>
Subject: Re: [PATCH net-next 5/6] net: dsa: mv88e6xxx: CBS support
To: Luke Howard <lukeh@padl.com>
Cc: netdev@vger.kernel.org, Kieran Tyrrell <kieran@sienda.com>, 
	Max Hunter <max@huntershome.org>, Cedric Jehasse <cedric.jehasse@luminex.be>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292214-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,sienda.com,huntershome.org,luminex.be,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cedricjehasse@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0398D5E1D15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> +static int mv88e6xxx_qos_port_cbs_set(struct dsa_switch *ds, int port,
> +                                     struct tc_cbs_qopt_offload *cbs_qopt)
> +{
> +       struct mv88e6xxx_chip *chip = ds->priv;
> +       int err;
> +
> +       if (!dsa_is_user_port(ds, port))
> +               return -EINVAL;
> +
> +       if (cbs_qopt->queue >= chip->info->num_tx_queues) {
> +               dev_err(ds->dev, "p%d: invalid AVB queue %d\n", port, cbs_qopt->queue);
> +               return -EINVAL;
> +       }
> +
> +       mutex_lock(&chip->reg_lock);
> +
> +       if (cbs_qopt->enable &&
> +           !(chip->avb_tc_policy.port_mask & BIT(port))) {
> +               err = -EOPNOTSUPP;
> +               goto out;
> +       }
> +
> +       err = mv88e6xxx_qav_set_port_cbs_qopt(chip, port, cbs_qopt);
> +       if (!err)
> +               err = mv88e6xxx_avb_set_port_avb_mode(chip, port, cbs_qopt->enable);
> +

Why is the avb_mode set from the cbs setter?
avb_mode is an ingress setting that controls if frames are classified as
AVB frames. Cbs configures shaping on egress.
Eg. if an AVB stream is received on port 1 and is forwarded by the switch to
port 2. AvbMode needs to be set on port 1 and cbs is configured on port 2.

