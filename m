Return-Path: <netdev+bounces-280319-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EQbEk5m6GkLKAIAu9opvQ
	(envelope-from <netdev+bounces-280319-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 08:10:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C148E4424F0
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 08:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 333CC3059E16
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 06:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94E12D7DCE;
	Wed, 22 Apr 2026 06:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nxm39Kd6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C262DB7B9
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 06:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776837993; cv=pass; b=pGcr8NlOENVrX1qk+4QS37UmCwd0EmODMEX2pJ1U9Vy5o4Y4Eq3lJ3zmRohaB3GvroMnlevKpI8+yq8RtjxpS3iUAJfkwJyW5vQOKEkwdhmv45/F65Dl81Oo76fGneBmsaX72uEM8QXO5LR9E6UtyLF9pShBzLP3JIDKelTlikM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776837993; c=relaxed/simple;
	bh=Rh7Z1oqkCtIKP6IZti0zcf/vxEpcilMzd+W9RZI37eY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FavmllaKNbPdE9sdG1Z4ZGjHYnhWYfzTWC1tPHICkAa4rSaSatT3R5WAPESJvHtJaekhvp9N5618l5t914lfIRsvf1QdXq7jMJF4jufUvZEknc3d5iAOeYVkbAwDx8h1xnfT8xddDJTXXLLpmlaxHe7AgxSOjR8htxK7nE1je0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nxm39Kd6; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-66f8f556f39so6470017a12.0
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 23:06:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776837990; cv=none;
        d=google.com; s=arc-20240605;
        b=exyYmhTWDNItyTvRnJanDl7zYYb4EhmzAx6SDLzt0QdkYFMd04K/y1b/hn7Cy+uYEv
         y6SBq1RNyGb/jjk2fZ11ufeBRWT0Znb5WOdm4EEWiqY87fRg8qiPiAR8aT3/17N+frZp
         HsWERncctCJvIcELcYc+4PSEMDaDswG8DNjCAtgoiEYqldNlMUnHt/Pl3ft1jPUIGgyP
         qKt1fcURXBF3nGg5KXQ64bQrYqnx8xZH4x50X67wuxcWEk1FTE+dBEe70uMUFAvxSSrC
         MWPmhQk4y9YsW3joXiHpFG0cAeUfU/R2V4Hs56cEsEUC6BYXaFEWXwLthgjzzRn2f46B
         qLBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=egbi2sYWJLZOIX/56COa8I4dQSgeroMlNExgr685yww=;
        fh=Tq+RCCvtE49QZdm1LBsmIxIXIX044JCOD2UEZtYxFjk=;
        b=XyBV2YGSuF7gn83ArAu+Bole9lx0QnM5eMKfEEY1LzBI816OUBpEmgRCcqB+27tbpl
         6HvZSXhytPcS6tur5H9BOYdqK7UGjK4idFNPfQSg3BSn6oGS465u/K1v5CCcO7i2X8/Y
         2A+vFglBeidlznlvpF/n7zVXra4itYggR3QxDtlxj21qSZb5Nu+TUYywA1hNYH4LCu9l
         Uo8yRNJkNg3DrnIsvxZNmCYJkNPKr+WgX17sCYyB65OmRfZ348Bl4k5H6wWzezKZVQT9
         MOI+HoluK8E5ZZuRQb74BlrK+/eplAs0B9MnPVC6T+dNh180s/u1O3Jo0dL8rdFssQfE
         XyuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776837990; x=1777442790; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=egbi2sYWJLZOIX/56COa8I4dQSgeroMlNExgr685yww=;
        b=Nxm39Kd60I3Ao0EdqMv2aquunRsxzS6GwoPr2lbSxRHl6b4WSgKmzhzhrUx9+XW03S
         vSATzFgB/XL2VRbIzrREuBdACXQEB5V2bAvJZdSq4xyGTiuxnvhQFKsdes4uOUjm0GBu
         0yixTDZeWd/FCI/LU6sXtK2sq9BzzddCJWp0TY7a1mlmZEylkq//Cs48u8nTwkRWtQgW
         Uk7dINBEOcFkN3syUOatCRg2Tq7xbUo6gIUryNsLgvcyskOhYkUnZn66zx6lqvIKksss
         5aY0pXasbPdtaLD2EzVVwMV/LC7P2j4uGwTRtB/mjNU4VQtkEtgN59jornV+MBZZoR5c
         tdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776837990; x=1777442790;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egbi2sYWJLZOIX/56COa8I4dQSgeroMlNExgr685yww=;
        b=nTnXMntCydxU09bDGncQTSk0dDiTSd5oEzdaTRozXuWjzmgxc+FuhULPxgDzoiy8rx
         Ffvb5B+HU1xC3Ak073suK0+5rrpAamfQ6a3R/40tL8UPCj7WOGj0wyp74DEKTQk+EfmQ
         R7ATqd/dF7MMohvh/+eYD7Rc3bx3DHNer5FRq0EL3os7ztV1+A/ORmVriCnWYm5oF7Yz
         ZPl4SPifjYUpOoCUDRaZL+mK1n9/9kHy1RH1ssNX9fejdoUDUus9y3NuIlcPca3p11xC
         zPo43yX/TR7KtkhzOxDsYYYBzxUdlhcLMqe3XfsFEVtdkArKRnl/uUZrhHFxtBSO4Qj9
         Hssg==
X-Forwarded-Encrypted: i=1; AFNElJ+7QjYc8Zxb+alP2LyR7CXUDDQOj74PHa3ZtxoyRxpLc3+SD8qjU1pMdzNqNYqmLK38qs5mpfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL2NE+yi8XUBmhODvRdYGHIYivIErdzq73GLjcZ0Ln1D5qBRN8
	4ZP2ejxtqAmNJT49C4pCM6xyOWqLEm502Bg4XqML3mrxXR43LdtYJGuXDGdIYZP9VDBPUSE+VwP
	FHnjiKNp6yruSafJsG+KDcnF+e3fPMtc=
X-Gm-Gg: AeBDiesrPjLysSpF/cyFKJaqrS9F6YeFz+g9r4OhXSXRt4ziLWME6EV+Rwu5i2Vy+fi
	hFkfjhWr9/TkRUUr+9my/ara4wRRqo+FQXseaavqJjuVzx4CqbeOBgmiEthNEeuU9TcYygPsCTA
	QGL79P+54elTgo7lopnPLQFrFbqUi2Lrq9QK3Sam/h8amBrtHPPqklT044qvrmWRA5Q+SZ5XIgA
	88PDQ4IhLW5wjdRct411Z4NMso+ZkYHtlBwGbXIusU/Tfoy6m/AvqPWEvjsVUPfrjlZWEPNvfBb
	riwpCKa7uaz5TOQy3B3yGLbT6qnOEM2Y3CKwkTJ2rD8Bd0GAgPLXBogtvwQj
X-Received: by 2002:a05:6402:e9c:b0:673:f729:c7a1 with SMTP id
 4fb4d7f45d1cf-673f729efcdmr7714570a12.14.1776837990242; Tue, 21 Apr 2026
 23:06:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
 <20260331-realtek_forward-v1-9-44fb63033b7e@gmail.com> <CAD++jL=v6qe+dVF-wk3cPg3aw8Qp7pS6BVtAqmWURJ=JvMvDHA@mail.gmail.com>
In-Reply-To: <CAD++jL=v6qe+dVF-wk3cPg3aw8Qp7pS6BVtAqmWURJ=JvMvDHA@mail.gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Wed, 22 Apr 2026 03:06:16 -0300
X-Gm-Features: AQROBzDnU5su9t_BJb2buOZf5bl6PP_zSF1VLxTuTSd-YLTkPSfkk9N7GCVu_JA
Message-ID: <CAJq09z6LJAZCFCymK=zR7W9qfQi5WLA2A9gg-O7S_JsT=Bbk_Q@mail.gmail.com>
Subject: Re: [net-next PATCH 09/10] net: dsa: realtek: rtl8365mb: add bridge
 port flags
To: Linus Walleij <linusw@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280319-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C148E4424F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > +static int rtl8365mb_port_set_ucast_flood(struct realtek_priv *priv, int port,
> > +                                         bool enable)
> > +static int rtl8365mb_port_set_mcast_flood(struct realtek_priv *priv, int port,
> > +                                         bool enable)
> > +static int rtl8365mb_port_set_bcast_flood(struct realtek_priv *priv, int port,
> > +                                         bool enable)
>
> Those are small and just writing registers so I guess they can be kept local,
> but I think they should be accessed indirectly through
> struct realtek_ops .rtl8366_port_set_ucast_flood() etc.

Sure.

> > +static int rtl8365mb_port_bridge_flags(struct dsa_switch *ds, int port,
> > +                                      struct switchdev_brport_flags flags,
> > +                                      struct netlink_ext_ack *exack)
>
> Move this one to rtl8366-core.c under the name rtl8366_port_[pre_]bridge_flags()
> and use the abstract accessors to do the register writes.

OK

> > @@ -1691,6 +1797,8 @@ static int rtl8365mb_port_bridge_join(struct dsa_switch *ds, int port,
> >         int ret;
> >         int i;
> >
> > +       dev_dbg(priv->dev, "bridge %d join port %d\n", port, bridge.num);
> > +
> >         /* Add this port to the isolation group of every other port
> >          * offloading this bridge.
> >          */
> > @@ -1730,6 +1838,8 @@ static void rtl8365mb_port_bridge_leave(struct dsa_switch *ds, int port,
> >         u32 mask = 0;
> >         int i;
> >
> > +       dev_dbg(priv->dev, "bridge %d leave port %d\n", port, bridge.num);
> > +
> >         /* Remove this port from the isolation group of every other
> >          * port offloading this bridge.
> >          */
>
> These debug prints seem unrelated to this patch?

Yes, sorry. I'll move them.

>
> > @@ -2547,6 +2657,19 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
> >                 if (ret)
> >                         goto out_teardown_irq;
> >
> > +               /* Enable all types of flooding */
> > +               ret = rtl8365mb_port_set_ucast_flood(priv, i, true);
> > +               if (ret)
> > +                       goto out_teardown_irq;
> > +
> > +               ret = rtl8365mb_port_set_mcast_flood(priv, i, true);
> > +               if (ret)
> > +                       goto out_teardown_irq;
> > +
> > +               ret = rtl8365mb_port_set_bcast_flood(priv, i, true);
> > +               if (ret)
> > +                       goto out_teardown_irq;
>
> Create rtl8366_setup_flood_control() in realtek-core.c and add these
> three calls as a helper using the rtl8366_* generic calls there. It will be
> done the same on all chips.

OK. I think

rtl83xx_setup_port_flood_control(struct realtek_priv *priv, int port);

might be better as we can avoid looping again over the ports.

Regards,

Luiz

