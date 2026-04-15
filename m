Return-Path: <netdev+bounces-278854-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDnPIhjT32kNZQAAu9opvQ
	(envelope-from <netdev+bounces-278854-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 20:04:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D98BC406FCF
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 20:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD3FA30597AA
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 18:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539A331AF31;
	Wed, 15 Apr 2026 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="dL92YRdA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DDA13C918
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 18:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776276208; cv=pass; b=GlMa0TXfD+HmO6nR8ag0cPlDwY/YHqb29H4/ZRt9SD4lgzmnGtKTsTShU2gayEXWW9zVS6/Xi1nwAqNdqes3weqoPND8FkxweGz57PytgNTfXJEtWBWXtmQsJfHgzyFkgRqnccyZUYezRg6FEuTy1+VKuGA20y6KxgjW0tLgvyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776276208; c=relaxed/simple;
	bh=tmmZyGxhNfrOBuJl+Uy3KRe0cfdB4K/rFTEvPqD+9iY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=foIE/GUV4cNKicvo1RVuoBge4lQOjKblSu6f7jTWyblX/DK2xGANlFA2ETiFN136sB4wEl7xh5eIyaZGOnDAEY3weBCfnkNAGp8h6VoGef4bOBlj3CZScu6dt+oUTfIhWwBYd10xozDMCg3gGNNoBtOiszpjKjIu+vyMcurywgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=dL92YRdA; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b9b1df1a6b3so816254266b.0
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 11:03:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776276205; cv=none;
        d=google.com; s=arc-20240605;
        b=O5D5meIEVxRNotzJdwC6CCb7Y/+64JCLVC6hUXYAirZF6TiJvnEJhgOKEGHdjB0nyJ
         oUoYiyICFegkon5K/Fc8du8hXzyOuYUIpcqprSMyQEyr1vXcCH2zPIQKcj5lwmpYOUtT
         a6yNWFjlmCY89aU7f84vRYNkfnuWLOe8jo4imiOQyTQldSjQQNBq9714nmbxDwFgitf5
         H+8D3DcEm/2gK4hqT7YYKS8CnKqGd1SqM3xYi93vCWmMa9poYWSGy0ot+fLvwnvlS+Mu
         ILTUXp4BgbY+jK9HXjS424i9oZOIEjs8mQ4ihmI4DxbHvLHh6Ll3uubAM/Mjo+WywCvS
         lvNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ByBXDqA5q1B0FZhDcK57G+p+lp1SYGrMGUX9uywlaEI=;
        fh=8i4BkJ7A2sbsgM1+Fe68SjLDkqmJfGNb+pxYd/lDi1E=;
        b=NHrsOxbm7Y0GyvexUdbZP65HIMswaBbkI+FulDDNLKskdEUmtc6OfIM6vv6Lsx5LCe
         jigXfy8X4lhp3NDQowfBXJD6LcepDqS2j6O1X9hOvHqcKvLbGETrdD3jRbZXx8wNaMSs
         2MdmjyUFOHi3CM1mdr0KmhODCHxYL1LTVWRGcWzfcEtjuj3T6ejWJofysPlOzDfJeLpp
         HuJcp2ZKn5yNEz3glcoq8yODuIyByMToKQ9wPcTxysGmtSb+gBYjahwGPQpIYWt041rf
         sfSojDCDlBktwrZn198UJflOmC2iTj/7RtMeKgSkuh/vB9vwOe7BTJNjKyG+RgTz8Fmk
         jBCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1776276205; x=1776881005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByBXDqA5q1B0FZhDcK57G+p+lp1SYGrMGUX9uywlaEI=;
        b=dL92YRdAnbvvse6gTolRuE3bQcK0TyUfH2OQ7c+nA4+NvFYKyZq4JvB6AtmrHpS9d4
         xXNaGQ/KcobarygHUbef8vkjt/wMSOyNLGOeuNKBHigSeKV8BC9qiPqvtgWtrbz6NLYL
         gq89ChXsQrHuEJpK+YMjc03xcL4imbTGbtvrMeA64P+pkdhqXGXZSWfy3/dvYzJkhWUz
         kNd6mEBH+KddgBQeIYgj0FDli7zKXLXxYLesiKrW+kXqwB1xnxdPULQAcK/fb32ycpUt
         QBBoM4PIB7iItKLC7HlaUDjZTw53wcR2fuMFYYNHyygoqNnht/dl5ItVR+LI7N8iYPTs
         OAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776276205; x=1776881005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ByBXDqA5q1B0FZhDcK57G+p+lp1SYGrMGUX9uywlaEI=;
        b=gUJUefYlg2h7kr1w4bPT/9VVV3OYRFvN7r75AeWTuQL28kYQCsTwY0cOgpVvgASuQJ
         O9cZmGWHCGUi8lHz+rGGx/nWNbWQyRX2uonfo9K53H6vBMAxPKz0XYCwwWe9pwzjnFnp
         MdKIOIeGVrc+cStn0USzc9oB7oHP0Dbkf0BCB5N7wZQ61rjoIitbtThg4jc2Ts/X3hcQ
         7ZdpjgdvzaOIdJQ3RjBgQGbeiWDttwleOADor5C6O3j9KqChLybHC8gwhrDeMbbcNRsN
         qLIPWMa7V7TgY017hbMf/xLLIY/b5bHUs5B/yt61+7ktbhkTgRYPDjmZ3zFKl0d4lUKY
         rDmA==
X-Gm-Message-State: AOJu0YzKGdPI5boEfySgYS3WqHuvIpU+EXYhWuawUCgcE6fhG2JPFWVt
	pBx6MC7/9tf18o2fi/rUPZrpohKuNaIpM/1q/WsN0WDvUjzBHuikT9NtW98sufIdYuj24vyzsnO
	InSbQxnl5NnCCmfiscP4SSsJF9OzbWqAE8BdJ8eC6lYlLxZyLpZa/y1jPGB6r
X-Gm-Gg: AeBDieudh19k+leg8Jz9bUcc1vKzQtMlRItiBDB2TG2stsMIfHWOfhN6viH3XqN1Rod
	1w92OOFMOG5iE8nMYmMNnfi1be49YwVzBxWYIGSVLjzffeOlKQXQYsaSDtDTjdY4Lz0dn2UFeVQ
	hxTpCqWGrrBLSMi7NTjUInwz8utveTPrPCgCYk5zOuNowVLb9Yrlf1V6sIkE3uCUYSQwodleQp3
	7ddxtIUv9Tfv+VE3aTJmZcnchuQbKTULqj4zyz4aHnCGp/+9Eax3efphuc1EkGe8gNqiyxCf/Bi
	gPEptFI6p6sLasfWkQnFv81/EME2zTkaby0En9FjAen8rkJxtsM=
X-Received: by 2002:a17:907:6c0f:b0:b9b:e346:9a7d with SMTP id
 a640c23a62f3a-b9d7299000amr1201680866b.35.1776276204807; Wed, 15 Apr 2026
 11:03:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408152353.276204-1-louis.scalbert@6wind.com>
 <20260408152353.276204-4-louis.scalbert@6wind.com> <707642.1776098994@famine>
In-Reply-To: <707642.1776098994@famine>
From: Louis Scalbert <louis.scalbert@6wind.com>
Date: Wed, 15 Apr 2026 20:03:12 +0200
X-Gm-Features: AQROBzBVccjdsLu_f8uwYuXswLRXD2mbtLVWETnLdct3I6UvF225mGOY-uWfmyo
Message-ID: <CAJ5u_OeByyvrUxy3Ri_9QChKKtWqPNZwegjPUvR9fR4zdnFL7g@mail.gmail.com>
Subject: Re: [PATCH net v3 3/5] bonding: 3ad: fix mux port state on oper down
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, fbl@redhat.com, andy@greyhouse.net, 
	shemminger@vyatta.com, maheshb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278854-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D98BC406FCF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le lun. 13 avr. 2026 =C3=A0 18:49, Jay Vosburgh <jv@jvosburgh.net> a =C3=A9=
crit :
>
> Louis Scalbert <louis.scalbert@6wind.com> wrote:
>
> >When the bonding interface has carrier down due to the absence of
> >valid slaves and a slave transitions from down to up, the bonding
> >interface briefly goes carrier up, then down again, and finally up
> >once LACP negotiates collecting and distributing on the port.
>
>         Instead of "valid," I would suggest "usable."
>
> >The interface should not transition to carrier up until LACP
> >negotiation is complete.

I agree to take lacp_strict as the new parameter name.
I should write instead:

*With lacp_strict enabled,* the interface should not transition...

>
>         If the new option is off, i.e., does not require successful LACP
> negotiation, it should wait some time before asserting carrier up.  If
> negotiation fails, however, how long should it wait?
>

I am not sure I understand your point.

When lacp_strict is disabled, the existing behavior should remain
unchanged. The purpose of this patch is only to correct the
Collecting/Distributing state when the port is not operational.

This state is not used to determine carrier assertion when lacp_strict
is disabled.

I will double-check that the timing remains unchanged before posting
the next version of the patch.

> >This happens because the actor and partner port states remain in
> >collecting (and distributing) when the port goes down. When the port
> >comes back up, it temporarily remains in this state until LACP
> >renegotiation occurs.
> >
> >Previously this was mostly cosmetic, but since the bonding carrier
> >state now depends on the LACP negotiation state, it causes the
> >interface to flap.
>
>         "now depends" -> "may depend"
>
> >Fix this by unsetting the SELECTED flag when a port goes down so that
> >the mux state machine transitions through ATTACHED and DETACHED,
> >which clears the actor collecting and distributing flags. Do not
> >attempt to set the SELECTED flag if the port is still disabled.
> >
> >Fixes: 655f8919d549 ("bonding: add min links parameter to 802.3ad")
> >Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
> >---
> > drivers/net/bonding/bond_3ad.c | 7 +++++++
> > 1 file changed, 7 insertions(+)
> >
> >diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3=
ad.c
> >index b79a76296966..3a94fbcbf721 100644
> >--- a/drivers/net/bonding/bond_3ad.c
> >+++ b/drivers/net/bonding/bond_3ad.c
> >@@ -1570,6 +1570,12 @@ static void ad_port_selection_logic(struct port *=
port, bool *update_slave_arr)
> >       struct slave *slave;
> >       int found =3D 0;
> >
> >+      /* Disabled ports cannot be SELECTED.
> >+       * Do not attempt to set the SELECTED flag if the port is still d=
isabled.
> >+       */
> >+      if (!port->is_enabled)
> >+              return;
> >+
>
>         I think the change is fine, but the comment seems redundant to
> me.
>
>         -J
>
> >       /* if the port is already Selected, do nothing */
> >       if (port->sm_vars & AD_PORT_SELECTED)
> >               return;
> >@@ -2794,6 +2800,7 @@ void bond_3ad_handle_link_change(struct slave *sla=
ve, char link)
> >               /* link has failed */
> >               port->is_enabled =3D false;
> >               ad_update_actor_keys(port, true);
> >+              port->sm_vars &=3D ~AD_PORT_SELECTED;
> >       }
> >       agg =3D __get_first_agg(port);
> >       ad_agg_selection_logic(agg, &dummy);
> >--
> >2.39.2
> >
>
> ---
>         -Jay Vosburgh, jv@jvosburgh.net

