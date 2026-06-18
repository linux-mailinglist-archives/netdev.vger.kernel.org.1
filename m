Return-Path: <netdev+bounces-300420-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HiNzIEfoM2oPIAYAu9opvQ
	(envelope-from <netdev+bounces-300420-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 14:44:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D418B6A0249
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 14:44:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JULtX1ev;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300420-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300420-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49574301651E
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015903DEAC3;
	Thu, 18 Jun 2026 12:44:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97156391E58
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 12:44:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781786689; cv=pass; b=jMDyq5ZtPi8HOgDt/wLnzLTxqTVoTXu5VoiTJieKipKGfvqL4PoBG/ZIpwS3l9gWgXjsuRkvtCFDc1Kv8bl39SdCuaqBEuQYl125It6lCY3zCDaLPhTm3LDL+9Ril1GdZD8+rAn2cmEdBc5rfipro4XYpHHQToG9+5VzeMirGfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781786689; c=relaxed/simple;
	bh=cHjyJlPjkSk5IHnW6U3juQbIjtycKoqgvK8mOpZ8eYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WIE12t7Iv/Tmto884BnPFtUZEla5Y0cXmnmzrU2f8xAF0lRo4ZFzqtJv0TzQ23doSjwBULyp4DbhgZRCQ9FTDZ/NUPzumv716735EH0UuojYbz0Fvl35MrZQ8i6aQBLoaPNH7aUhGcDuJ/skSdqKcLjULPdlDnoAsN1KcYI/Bco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JULtX1ev; arc=pass smtp.client-ip=209.85.167.181
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-48611ccd5aeso558717b6e.2
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 05:44:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781786687; cv=none;
        d=google.com; s=arc-20240605;
        b=N5K2XWEgyXSIUj1JRCoXHPYxy05Ht951BSrAO8TDvLzoVTRi1PWK6/J2cZ2Cy28g7P
         xzNd7RYtjQMUZOAXOCKGF1/zu0Ltlt4NOxItVgCwmmIYC8WG9Ey8uRmmWr27HYRdqFC4
         ZDGrFVKF7VKRi4YRGdq7KstLZX0XV0+iRPvV2kWcKcbUM9VXo17P85zrTabdW6glwEQ/
         jQXSlbnidbw99quW+ABEgcJ/oKEdzfVvLDUG1lM+9CxtjXry7YiuDGFTKWsKCxB05uOa
         +sC70u/F0bbkAnzKS+8NzirXp3EFyw3kmiU/V0rBu5zL1RQOGmReD2z+EXVGv+cPGrnV
         s8Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R2fRRuZw7nJRtSJKkL6hC70A4Xo5k16bD8Q46Pwfou4=;
        fh=EDHlygtY9SvzUXPxyYVRHo3gxDiL3XP+BxZcmlDqP5g=;
        b=GVa9YqqXbnX9UPWHai32Nri2OuwuCthEve1BdyuL896WtCYdO5pP0PrqrcyllbyHj2
         T3xX4McrlWAPFosbTIOWgMuVRJiDUBjTz3mKdZRujXS6UBpacgHPlm/S53Iv+m86whpP
         C6nHbrtgAPpQ+EK98iPsfPjI5GsTgd3N095H1sMaSNjRFtcWXoKxPcS4GA0E8Uio4HSf
         Hs7/juXUyuv1ohHIbQEhxBOio5xhNJ6mZfSDPRybmYD4+xmRUQfPB8l4R7oroKzv9KZn
         onin8HrQN5S0iYbMRSS2WezRP930kRlgpy7HpVweAbWvkwE1+I8L6yIgzpDOo0ubQ7SN
         65aA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781786687; x=1782391487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2fRRuZw7nJRtSJKkL6hC70A4Xo5k16bD8Q46Pwfou4=;
        b=JULtX1evHXHDkHEwZtey6v+X3+Q/9ouxdBDq17NjEBgZr0yg/riMgduWGRBqEccf1Y
         dZ3VmuIw1O5B8Q5aLNCRZ6mF47uSoEZNEXCUWtwg/2GwzvANVKuU7a4Qs5s5LViwl0zb
         A7dTEtPvHmkg16UeUtuNQ7pV604eaaUaWXB0jnmi3MHAm+s5O/gfkxwXw6KNaLgC0x08
         U8vbE1VLCWIyjPzR2LfU8gaaHAgq9sTG4+e930yBwMhKXkcbqmlEBZaqjESJtl0oK68J
         S0Z3XD3pAlNHyvJa6eNamgw+RF7RBWgGWFYG5r7a5WSMc9fxyvwEx9n+bJKyqYnl7eKN
         NoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781786687; x=1782391487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R2fRRuZw7nJRtSJKkL6hC70A4Xo5k16bD8Q46Pwfou4=;
        b=N19UhyBDC4GdOxw+VW3XX6J64VaKdYa3AoFGz/7G3qZiF72XwVtCL34pr37veQPGlE
         ODVEiW8kDgJolrYyOYptmivrOkbLmuPvKsbdJ0Z8t+K7/uJBMzf29aRciAZcxJbHaZy7
         aJ2DUkKZhrpoAtsRTTE4389znOQZuzysSSAu7q9QRuy0lxBn3/uW5LifuoBdL4sFw2wt
         KpMFBH13hSdZg6Vr1VOkZKX15OLswQTRkQryAZXqbDlS5qcEIil7rokxIqu39WWIBLeA
         aD3+r2OLn+McAkzEazlHcbHM9KKcRgYSY+oQqcla8DbfWtz9W1/ksJbGz++HNsms8qh3
         GUqQ==
X-Forwarded-Encrypted: i=1; AFNElJ+iQ40yQj9VtKFlkaayUhmKlpcOnjgk9Ohhg+dfaaci8wfFa8H9F7Xgqt3918NGQCihVadx/z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNB9gdecGP9M/tO9ntYKXP9GJAmXI51filsNCjQwpb0/v/JBKQ
	s9ztvJ+7Ya07YXNPNZFBg5b2ajtPGzGmPfoCHgh5jH4MvwQ5SKFtmN0rMJjyxv07vfZmJopoOW5
	RFtflkbjm5RBmXdFZR2b7jTsNb5muxyk=
X-Gm-Gg: Acq92OHUy8KVxy/t3MfimySSufgNT5t/9vDAj06dEm2Sgkjk3+qEP5iZOvuCqK+FYGI
	RJeUg34Gmh1q7QC8FSKUgIG8JfFk0f1ITd5p1xYbA7QBEcx0V9y9RZC7lYfpkwgyBa/HCdXVbUa
	kCHDNs4yUzpiIeHgK8f7+arq2NLNFspPCkm5Umwg+DIjgBZaxc0Rg+swPH8BH8BGljvPAZXS8aE
	4orabUqIRYad0dX5AWX3asXuB90LybBsRD8wf7knM/S8sj+8YTZmknJ5qieQGmt9V5r+f7DGwlZ
	WqXmTce4+dBA7nHXyf9J8fcOiali
X-Received: by 2002:a05:6808:1513:b0:486:7c50:6f9d with SMTP id
 5614622812f47-4894445bb42mr6916588b6e.8.1781786687457; Thu, 18 Jun 2026
 05:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615111235.3544282-1-kyle.switch@motor-comm.com>
 <CAAXyoMOp8mYLUx4CQBn=9R8rNqEsb8ybWD0z+=FJgh2j-F0s8A@mail.gmail.com>
 <88f726d5-1617-4d2e-8fbb-d3da9478b386@motor-comm.com> <a689a734-bfd2-4e8f-85dd-9ae210b3161a@lunn.ch>
 <39b79f5b-3e13-4620-83ba-b2ef991acca9@motor-comm.com>
In-Reply-To: <39b79f5b-3e13-4620-83ba-b2ef991acca9@motor-comm.com>
From: David Yang <mmyangfl@gmail.com>
Date: Thu, 18 Jun 2026 20:44:10 +0800
X-Gm-Features: AVVi8Celi2wc1WuKyqlQlsQWzARO52siyoMLgHl1hX-xUHq9xNA__qNdKNW_GqU
Message-ID: <CAAXyoMMQwe4vp_05wfgWaPGh7+Lx+38-6FXkoeDE7Asi75VEMg@mail.gmail.com>
Subject: Re: [RESEND PATCH v1] net: dsa: motorcomm: add yt92xx dsa driver
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: Andrew Lunn <andrew@lunn.ch>, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ming.xu@motor-comm.com, 
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, de.ge@motor-comm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300420-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:kyle.switch@motor-comm.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ming.xu@motor-comm.com,m:xiaolin.xu@motor-comm.com,m:jianmin.wang@motor-comm.com,m:de.ge@motor-comm.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,motor-comm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D418B6A0249

On Thu, Jun 18, 2026 at 5:53=E2=80=AFPM Kyle Switch <kyle.switch@motor-comm=
.com> wrote:
> As you mentioned "One thing i need to point out. Linux has a long traditi=
on of not
> replacing existing code with a new implementation. You take the existing =
code and step by step improve it. " in another mail before.
> I want to explain the patch in more detail.
>
> Step 1. We do not attempt to remove the existing driver implementation, a=
nd don't change the behavior of existing software,
> we will retain the implementation of the existing driver software layer, =
but encapsulate the use of hardware operations into
> functional interfaces. The advantage of this is that it is easy to mainta=
in and easy to support other motorcomm switch series.
>
> for example: vlan add ops in dsa driver:
>
> Existing code:
>
> yt921x_vlan_add(struct yt921x_priv *priv, int port, u16 vid, bool untagge=
d)
> {
>  u64 mask64;
>  u64 ctrl64;
>
>  mask64 =3D YT921X_VLAN_CTRL_PORTn(port) |
>    YT921X_VLAN_CTRL_PORTS(priv->cpu_ports_mask);
>  ctrl64 =3D mask64;
>
>  mask64 |=3D YT921X_VLAN_CTRL_UNTAG_PORTn(port);
>  if (untagged)
>   ctrl64 |=3D YT921X_VLAN_CTRL_UNTAG_PORTn(port);
>
>  return yt921x_reg64_update_bits(priv, YT921X_VLANn_CTRL(vid),
>      mask64, ctrl64);
> }
>
> after patch:
>
> yt921x_vlan_add(struct yt921x_priv *priv, int port, u16 vid, bool untagge=
d)
> {
>  struct yt_port_mask member;
>  struct yt_port_mask untag;
>
>  member.portsbits[0] =3D BIT(port) | priv->cpu_ports_mask;
>  if (untagged)
>   untag.portbits[0] =3D BIT(port);
>
>   return yt_vlan_port_set(priv->unit, vid, member, untag);  // Here we us=
e encapsulated interfaces to complete the hardware configuration.
>                                                              // We can ig=
nore the differences between different motorcomm series, which will be refl=
ected in driver/net/dsa/motorocmm/switch/yt_vlan. c
> }

No for nuking the existing code. Your encapsulated interfaces do
everything that no other does
  - hardwired to static variables everywhere;
  - invented unnecessary types (yt_enable) and struct (yt_port_mask);
  - contain lots of unused files and meaningless comments, while;
  - incomplete in other parts, for example ACL;
  - still require direct register accesses outside your interfaces.
I see no chance that your current interfaces will ever be accepted,
unless you come up with something totally different.

Looking at other DSA drivers, please use one of the following approaches wi=
sely:

struct yt921x_ops ...;

// for simple register relocations
res =3D yt921x_reg_read(priv, priv->ops->some_reg, &val);

// for complex operations, but still reuse the context
do_something;
priv->ops->some_op(...);
do_the_rest;

// for something completely different
struct dsa_switch_ops yt921x_dsa_switch_ops =3D {
    .some_op =3D yt921x_dsa_some_op,
};
struct dsa_switch_ops yt922x_dsa_switch_ops =3D {
    .some_op =3D yt922x_dsa_some_op,
};

> Step 2. if Step 1 is accepted, later, the plan may be to replace the hard=
ware configuration involved in the existing dsa driver
> with the encapsulated interface step by step according to the functional =
module such as vlan, mirror, lag, etc. Finally, upload the yt922x dsa drive=
r.

You upload the driver for yt922x for your first patch.

Take ar9331 as an example, a DSA driver is only required to implement
.get_tag_protocol(), .setup(), .phylink_get_caps() and
phylink_mac_ops, that's is the "minimal" work for a new chip. So
please make changes to these functions (and possibly more, but keep
the patch size in a reasonable range), and each of your patches will
be an actually usable and testable commit.

