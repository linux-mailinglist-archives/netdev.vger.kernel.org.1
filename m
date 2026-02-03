Return-Path: <netdev+bounces-256087-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IWsBxpbgWlnFwMAu9opvQ
	(envelope-from <netdev+bounces-256087-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 03:19:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B1FD3B06
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 03:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 142F23009141
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 02:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E5A29ACDB;
	Tue,  3 Feb 2026 02:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVRHE6Nc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EB51C5F27
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 02:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770085143; cv=pass; b=hsURsqTWQFgg90Oxzz4ZzLf7CVD5QB5Oj/JnYpxq/vEGdjVuFR+RgflS3Qa9DSm5wTs5/I9nfA9gEbkM5PEzhQ4LGl9e9WtJTQWJ6G/7REr3ct5n/GiqfDzoDx7EkJgS7jWvtFKaAgHLL2UbYukFje4t1xos76nvUZtcUUdYfSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770085143; c=relaxed/simple;
	bh=L4d4/QRtIcydrbCfPdYa34C7f6yn2Gw6GGWDDTF1wKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TLAi2nQaf5L5KkUWbDYmSbhhr0HdxkAtJ609OEo6yQHTs6U+Xfsgmk4iU5tYwHGvZkkkRGFkGcesigCwm/e1spOBgruEXYC8jB28D4roehHsMF87wOaI+bjBj0kQgBK2wEkYTTQGQOB6uFRcT+H4fa8j8fyKe3j3tIsTHc8Mbps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVRHE6Nc; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7cfd0f349c4so3149424a34.1
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 18:19:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770085141; cv=none;
        d=google.com; s=arc-20240605;
        b=k1dgoUzRxduxCu+OLs4WuPb3HmQjpOikILMkAF2KsUAPyylQ6dCJxziRaRtrqJGTdi
         fSyRMnuCRUP3VMIBniLjSBUpSEhSCw+rJQHeH6fWp3Y0BcSHOW54nXz0iwGJrRDqYCuY
         sRgeXrvm+Nh46yhDAw9cJxkm6egteccHlD9CiP6fJrITVLLf8TSrSNIJt0sEtpiKQvYk
         yqSjQ2+9rR0FkzhHpj3E9R2AS2y50KzRjuUOCZisN8ImD5lQYWj0btkDyBT6ahefDguU
         CLITVc6kphKsjmb3Hcdo///gfsBcbamHRajGg0UlIe05Pe3sM0Z/aMpgaz+zEFjKDe08
         o6tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/q47wHJTzk6X4W1ncZLoj08KgNEOw/FsaX5tJbJBeu8=;
        fh=/sJYqGRaD9iiN881ptfpaHdSBr/VT2/taUWBSrWEvLo=;
        b=QsTopFHiZaBWWzIWIly/Dw3PVEoY+CauvizdhenNWPPTCuuT+pfJD14/c2MKBNwxdm
         jv4dV8xA/EpUM2zswC1faeqk4zRsIcplEeGQzfN3fxeeneom0c0GV218TLgKTmxZSszY
         Ywp6AjXXLHoMICLIk6ow6TdnYITY/wQX784sJ67HpCEfEt8nLbfha+b4C9R4KT+XkzTk
         TAK9DaH/6aOr9kFS8tL30q0SSXVSAozzKiOL9tnsDZMPX1V0jFbsmNPHfnZgtSbN+BUm
         6gG+7A5JwtPKyZZySlq9LKKZBth507/5iEVApybSbbdAERaU644dJkrMeT1OkZ9Lrts8
         9qbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770085141; x=1770689941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/q47wHJTzk6X4W1ncZLoj08KgNEOw/FsaX5tJbJBeu8=;
        b=JVRHE6NcwwGQCcezs0IpCWCdmTmw35M63VzEb+WAf5dP5Tf5PItSRMYRWbY65EqOaZ
         oqoc9IVj9Lsm3NS7+jmOXpp76YptXA4NfBMrZY8IEHtpLPlcTTOWWx/CaN1PsaCbERoC
         +harQl+yxYvhg49cGn98pAArXu23EioK0lXyczUfPseBqBFVGeUk2+bC9KcNpuFn67SX
         T2wOmwKWyFxI/jrD5++hJ2c532STRlKIujSRgt5RsCP/PIwdhmDhrEpoPfwDQr+2cCim
         u8PdKEhmaHjkMw0Ii0yTs7k6MCmNT9uwiJalvNjcK5PEK9WkIX6RbH7HCAo+gKiRU7GB
         9LLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770085141; x=1770689941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/q47wHJTzk6X4W1ncZLoj08KgNEOw/FsaX5tJbJBeu8=;
        b=F7p0Zz3amQhPKJDl7bSznJTOH4xEtmkjzVpvtfQOiQlJH54iIv/5WE0LrTPFpLAdKV
         DiS6rkkTavU9S3FgoP7GOgm354KOWFNh+JB/EWsMVZSZeKyhMEn6CcNPPV7nSRST9IiD
         VcmK6ldzakjAxhizE62vnLVe2Nb30Ktn/5mb9QXknXcsn2ln7Az/rhs21nxl7wQEIldX
         tLWXNyxxYnEcxuUcl5POmlp054Rx2EN3F7linoi/vY9BJDcwDT4qsPPY0x6PIQgigy1W
         e6PWC8I7HnxwQVnqX00v//lHZkqvTOMYXcA4oyX49/XI7oMA+jL2GVaqLYpqQ5lmQkB3
         jngA==
X-Gm-Message-State: AOJu0YwRdkT5O5l3+X73Frlqw/1Gfbus74u6ToIuVlbr5wYqI+OdLnvX
	D0pEkOm5Lc87Ke0UylLa9/+2G+pF4ZuZTji3d5+rUm7DAu8PN6BMVplE8BRTQUUJehJ8dnyF7S8
	I6YBhk/VwPhKR+UhCrd0GpotyZWTsfDY=
X-Gm-Gg: AZuq6aKPBxpBE82plGY+ghPJncRQKMCXEr3pWUF3rMz2NGceCkxd+OfJZtuFh031VCU
	2FtvyAILi3JKeDEuAuJTdxlN7OZtP//wkNYm/uM87xkCcdwkE53KneD9cjbOgp0QV7vRiCs2HOb
	/+gE+tFp2jTzh4A+he2vqF6Rm7EFa4jCFJ756+sB7tEJ/m5XfdgUrTIE7ioFqp4Nbp3cD1/x8PV
	8hh6r3DMOuvMyePfNmSbEkEH4xLvi0UUWCaOa+1b6rb6sSJkBnnXcTPJ+nP3jMYgx/J86VkZe4G
	Rh517nZEX9kvNj1DNPin/HXHdUzTGQ==
X-Received: by 2002:a05:6820:f015:b0:65d:1336:f667 with SMTP id
 006d021491bc7-6630f38fd0amr6989540eaf.54.1770085140900; Mon, 02 Feb 2026
 18:19:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131021854.3405036-1-mmyangfl@gmail.com> <20260131021854.3405036-6-mmyangfl@gmail.com>
 <20260202131019.6qz73anlgutewrww@skbuf>
In-Reply-To: <20260202131019.6qz73anlgutewrww@skbuf>
From: David Yang <mmyangfl@gmail.com>
Date: Tue, 3 Feb 2026 10:18:24 +0800
X-Gm-Features: AZwV_QjgrDiVIewsGeOGii5iFN_L90QaUbLt8FF2PD_emoHUO6MdLqYStltKJ5U
Message-ID: <CAAXyoMN7oS0zVWdeC4av-Bv4yhqjcebNz9e0E5UNBZgEKGm5QA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 5/5] net: dsa: yt921x: Add DCB/QoS support
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256087-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 75B1FD3B06
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 9:10=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com> =
wrote:
>
> On Sat, Jan 31, 2026 at 10:18:51AM +0800, David Yang wrote:
> > @@ -1774,8 +1778,11 @@ yt921x_vlan_aware_set(struct yt921x_priv *priv, =
int port, bool vlan_aware)
> >  {
> >       u32 ctrl;
> >
> > +     /* Abuse SVLAN for PCP parsing without polluting the FDB - it jus=
t works
> > +      * despite YT921X_VLAN_CTRL_SVLAN_EN never being set
> > +      */
>
> Why "abuse" - what else does this setting affect? Does the port not
> remain VLAN-unaware w.r.t. filtering/forwarding destinations?
>

It does. Recognizing SVLAN without enabling SVLAN bit makes it ignore
VLAN tag, but somehow except for PCP. I guess the manufacturer never
expected such usage.

> How is the unused YT921X_VLAN_CTRL_PRIO_EN field from VLAN table entries
> related to VLAN PCP parsing?
>

It's another appsel APP_SEL_VID, using priority in PRIO_M instead.

