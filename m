Return-Path: <netdev+bounces-303869-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cxMFEUeRRWpXCQsAu9opvQ
	(envelope-from <netdev+bounces-303869-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 00:14:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 843036F2097
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 00:14:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=RWvo8frp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303869-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303869-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F74630214C7
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 22:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A071E3D6CCE;
	Wed,  1 Jul 2026 22:14:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7453A6411
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 22:14:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782944068; cv=pass; b=jxRufovc+60Od0+X4lOBDvfXZeVKYphamQwMmUjAyiRBN0NUpC/YV9KGBOss8pC69nYdXuT2xEvrcHEZ1dNobVHEoAg5ATJaEbJQISVyTKRP8U52smnaE02NS4SgbfTmAOaH40p3Aa4OkHhRJHJ8ti1ikkv/4TirtFPzl7mODCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782944068; c=relaxed/simple;
	bh=9LjznsPm4SlUVd3KyUW7TfpnMRpfZadRiTB9bvXYEcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ei+Su3h1kftk0ttOnDq3T7OfPzDjwMVNaIt7G9QMxN9+ZVl4eYUDVrYwi9EEgX9G3nsOVOg3cJgFzfMQtuGfziqkkRTd3mzYyXaQbx63t5nq5th3EOySx0lnioMsHzEvPQ4FIGoWc6a+wzUTHYJLUuti7eqdmjNGvaLlJrQGB5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RWvo8frp; arc=pass smtp.client-ip=209.85.208.45
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-697ce8cfe65so2103606a12.3
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 15:14:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782944065; cv=none;
        d=google.com; s=arc-20260327;
        b=J5unc7cvgYnLfm42tB4kW1sqkAU6DcT+VqdJ0Xqu/PqB6zD2zlNlpiSAzX7pr4pnDT
         d/ZztSBiPUKJiIQrZT77/LxoGKlujXyE8fmR+C3x10G1tnKTbITJD1R57B/rtCgag/Oj
         kWoYt4y8Li89A+psdiyFhImgL+n0vfEr0meQxNHoD+oPYMvttEnb5aU2aXriQMmYKjn/
         BCgxhW2ZdwuaAQrhc1KD6tEAtI/JYHs1ZojHvV7kKscNbgWjDqhBhnkPoDq/CCAxBDS3
         B0i/PK/eYgI6MFTqsmVww3sNCDc27QD045W306ldAERUE85hBsap6hDPrnBJ3z+jJ56P
         aUkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6tJMm8pjeN1npzA3k7JqmvYhhfH3Iv6sGcCtY9C+w58=;
        fh=5H2Bu6KWt4hCHs4awdWzOSdHMtDz8wP9vtex26FM7v0=;
        b=sovxaga0Rlk41koYJprZuuehVzK7sDccdN4L+4reO7fn8Koln/rQPYE/yjDxUpIRUe
         hGS0CACNDuwkowzkun2bNT8a+9AiZKzMtehC4ZX34v53qlkwqAy/NU3IAM91s1hs77ke
         4kK4kZgpXfNC1a6HguBJj03HvXrDlWmR7/f7K8lXrf6n3JS9NsP3cUcwM+mvXL88pNL4
         AbZbhu9t2C7Md0tqXCUCfPBmYa16zoBRA2UR2+pCZEAPwUU8FHuCYkjRccms1kz8F1Ta
         HUlfS9Rjr/ef3SzT7jEOIkRkgHKHeqr7mp3TfsFNmQ5Hyzi07gNAp47EfTAB262yfsXx
         XQuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782944065; x=1783548865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tJMm8pjeN1npzA3k7JqmvYhhfH3Iv6sGcCtY9C+w58=;
        b=RWvo8frp8rHaQ+oHHQmHGJAwksDCPnz9Bz3iGi2QhGNrdFIZsVtoAVwxgwOYH1RnWu
         waVPXlOWuSdxrvPvwkhRzP6/2h3bMXCIC5lhSUV0JAW/huxMTHjdxNz6mQNHWOuHUNie
         x0/+daJ2F9zdRscqX7K5wZ7wfTJl6vfpRQTQRWjbWIA6S3ZBebRc+s///C76Qaw2uU26
         EYMrhBRqqcCsT4WZQL45q+TiJYYY6XFCJlzegjklISwyT8vkZ6SqvcucRVTnys2dFA4k
         kRbv766akyOWo1FRu1cpExsE/gSBQnJoPbyWjQQ2FNQf3z6HInG3ZWfCLVyrwpdJyJz3
         4E/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782944065; x=1783548865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6tJMm8pjeN1npzA3k7JqmvYhhfH3Iv6sGcCtY9C+w58=;
        b=czg10f06Hh7PTHIdov3JbBoDKE0ZebqLeC6k3eFmAYUJUQ54j+oGtqvkQRU1gZ5s4v
         1lAfVxTTXcRNyluqEgmtUb/WCdzRusX0a0NzyjuefNsXhguMtOdOI9HYCMk/abeBpZ0y
         tPA7+11i4whcEntcFX14iJjNlzQnJkeErxYrpeCou4H7oT65+wxapjfd95JM3K6sRuO+
         l6aHidA/VVIYaguYGquBw8gRxZvimusuFO0Rk4FySsa0YWkKggN8hwXxmduS7yePU2y0
         MDYB9InKWSpWXbcxbgczclBtExAcBQPAsUWQvWxi+4JS+q4UUJpWGVbJi53kWPQH5US4
         LmTg==
X-Forwarded-Encrypted: i=1; AHgh+RoKSJR3LWeY1F51wmkB8LbGBZjG+2CifNyv7u2S5jwmAO/aieFf+Wqtm0ZSdt5u8p3x8B1qppU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9132cZKa6bQOOFycX5YsI4zceDKHCiwbXKHCoW3S2GGkvFj36
	/5uTVa2LJjo9b9gN0S7o3xQQ7F/vWBSleiZP5YUxVV91Id6JvkZPiWgjJvSZH9S0twZYqsl8TUs
	BW7x6pK97UqExAigexzxshNIH2NGlpRX+t57YSC1w
X-Gm-Gg: AfdE7ckM5KmomIPKFY4ey9EL8oqrTV7p+FQs9esPodzpDRRYxQrcZSRHiswW1Hq/wtX
	ATYifQnC7R9WAjjnnpika1GshVMvxI0WpsOBjkRFeBUh8q7Ye8HQaRB92mRqwYEm03vcmppBoFU
	q8Le04Y7BsTeGnQuLH+mrhSeRNwDcGQ24qVNX4UF9RduzDQtJ7dViD93QOVvnFyEEYdjrj6lPFI
	EtSYORkAU1ln+y3GRyekYl2ZF2UqV4Qd6pEEOPYVSly+OEmYdk8He9QS9SPHM8Ci0q8/D8LuvS4
	iOhuOtqzUrJXi8mK7+70+xZ+JJ6u6wcKNfqWRF+M9ezhjvtLU2nwSfnLY29RFouXm/BRJGSjawB
	yzbQr22tnAOiCPzcH9OtrwUgR3UnuBgPiF+OGyEJ7Tw==
X-Received: by 2002:a05:6402:35d4:b0:697:be0e:4b72 with SMTP id
 4fb4d7f45d1cf-6989f2ec718mr1706177a12.1.1782944065189; Wed, 01 Jul 2026
 15:14:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701082214.2974946-1-edumazet@google.com> <20260701082214.2974946-3-edumazet@google.com>
 <3f70661e-539a-4157-9e5f-1ee94a720519@blackwall.org>
In-Reply-To: <3f70661e-539a-4157-9e5f-1ee94a720519@blackwall.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 1 Jul 2026 15:14:11 -0700
X-Gm-Features: AVVi8CdngDweFELt6BJqrVpj67inCDDKWn3TJgBvq4Nxt7XP3BH-FbqUVIEB2aQ
Message-ID: <CAAVpQUAQBrd9gH_EavP2DytLaheGFfAuAwZNS-jUWjy58Hxp1A@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] macvlan: no longer rely on RTNL in macvlan_fill_info()
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303869-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:razor@blackwall.org,m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 843036F2097

On Wed, Jul 1, 2026 at 5:12=E2=80=AFAM Nikolay Aleksandrov <razor@blackwall=
.org> wrote:
>
> On 01/07/2026 11:22, Eric Dumazet wrote:
> > Add READ_ONCE()/WRITE_ONCE() annotations on vlan->mode, vlan->flags,
> > vlan->bc_queue_len_req and port->bc_cutoff.
> >
> > Fill IFLA_MACVLAN_MACADDR_DATA nested attribute and compute
> > on the fly the precise number of elements we put in it,
> > to fill an accurate IFLA_MACVLAN_MACADDR_COUNT attribute
> > as some user space applications could depend on its value
> > and the attributes order.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >   drivers/net/macvlan.c | 71 +++++++++++++++++++++++++++++-------------=
-
> >   1 file changed, 48 insertions(+), 23 deletions(-)
> >
>
> The snippet that sets macaddr_count gave me pause. :)
> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

same here :p

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>


>
> [snip]
> > +
> > +     if (READ_ONCE(vlan->macaddr_count) > 0) {
> >               nest =3D nla_nest_start_noflag(skb, IFLA_MACVLAN_MACADDR_=
DATA);
> >               if (nest =3D=3D NULL)
> >                       goto nla_put_failure;
> >
> >               for (i =3D 0; i < MACVLAN_HASH_SIZE; i++) {
> > -                     if (macvlan_fill_info_macaddr(skb, vlan, i))
> > +                     cnt =3D macvlan_fill_info_macaddr(skb, vlan, i);
> > +                     if (cnt < 0)
> >                               goto nla_put_failure;
> > +                     macaddr_count +=3D cnt;
> >               }
> > -             nla_nest_end(skb, nest);
> > +             if (!macaddr_count)
> > +                     nla_nest_cancel(skb, nest);
> > +             else if (nla_nest_end_safe(skb, nest) < 0)
> > +                     goto nla_put_failure;
> >       }
> > -     if (nla_put_u32(skb, IFLA_MACVLAN_BC_QUEUE_LEN, vlan->bc_queue_le=
n_req))
> > +     *(u32 *)nla_data(attr) =3D macaddr_count;
> > +

