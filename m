Return-Path: <netdev+bounces-283927-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qF+hAfjB+Gkg0gIAu9opvQ
	(envelope-from <netdev+bounces-283927-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:57:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF7C4C106D
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E91CD3033D38
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 15:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105CA3E0C44;
	Mon,  4 May 2026 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1gFnMvu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256FE3914EB
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 15:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777909963; cv=pass; b=p3n/eqcQ+sgBkpCkdyiXaXpdJomqGjQ9R8EHlg/TqTAiMSTagp8U9oR5M6IEKq4GHxlJisAKpuMB2IGKmq8GC+vwxMpkJ77Tja9SeADlRpvPqe3DU34fr3o8W3tuUxl29W2Ogf9G7t0nWXFB0CSE6bRBA3xaMZNsAGbmJ8uyh5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777909963; c=relaxed/simple;
	bh=8lR+5ceBMeB9RuQ0qgK2bfm0kczjqeJjLoxSa5K8L/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tqcoMsud94Y9poRT0erRwMgBLYX2OykKM0Y0oEbuCXFvQVdupT6v12U5yL9w3EvBbsEU1GIMAhFoThvyvQZuuktHdhqC/sryrUVVHxKHqPZCR8NHHMax3nYATqw0cUm9RIcA2CoRfexik3Se4JNvNBzKMWI7nOqHEJnLK+XmMK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1gFnMvu; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso30720415e9.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 08:52:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777909959; cv=none;
        d=google.com; s=arc-20240605;
        b=SOBpi8wyZZYImtImT6zAJfIB0pdGDPr6PfZ8/eVWdtJY9bFqHKZv0brq0TS5ChO23U
         Lh1/dCk4kJ1hCGaU1tGoWAmFjS1XdJyYz0C4dl5XFCTLbLiD43FT85O31IVQW9gLMimT
         Vic98ZNllyvsv8aSi6LTsj4TvZEQwU4nlNe8GyApYl4rJ1wHStsK9SUArQvCLQRmSsz7
         0uOAYj2TaknTUGqIhIKdeiCsB52K+kHqbDaw9yolLEl+xeT3Twa1vF63MKPwYsD9kdNZ
         vysUWDN52P1AFHhj1Ze0Bb67PI+p5M6XfuJd5nUJDsuyYhNwo4W255B6ROjGOy5colZL
         Gu2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=udRl4dRYGy6KxASKdFufirqG/KQ87UOgsPscj92jHKI=;
        fh=k2JnLxyEPBWd5ud4374HQqs8aq20hEISgVfQVRMosDA=;
        b=RefG35sgJyR01N5Zst9YIQtmJybJICQvHSDVrxd3cX6Wv0riWR0/RZmk8j7Z4LEzA2
         ew4MtttM+LMzL1QXiWzihiidHgtxCTaOi5YfdYpWOtV0mFNWm0lXNV/oGSy4OsBFJAAX
         AMfWseGobhmBL86fX14ujEjmXeZw9FHqAyBh+wu8nIlJfeBOZ7Xb7eI6A6fpRgP9wOQM
         06pLvOO3jZpSd9VW3hYdM+B5EIbFuxxRdwhnCpV5HphGhU3TyxNDzyoEObpspdIdxx+I
         ykbjJ6zS7mae7yzV8cAEGs6oi2JrNij1DePYO5ShLAHTSJ6OkCa/qydjnb6UNM29HuI8
         onJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777909959; x=1778514759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udRl4dRYGy6KxASKdFufirqG/KQ87UOgsPscj92jHKI=;
        b=L1gFnMvuCs9LDFhJssNGhF4vrfEP9Is0t3fhbvJ7e+OrL1L97vR3RdsrlvphPkhAEz
         MbCSk63o6oZC95ITArM+O+uxvHo/85rHmS5WteQbIk+MWp/xDcQIA426ms+8TdDqKJgJ
         pVxhW1ToeapFnZjmMrLItZy7bEv9i6vWJdb02K6oKJrx9Q9GYQ4i40CJfv1Hu/7KMTJe
         xpc+qqutfM3B4KI/A+xGTrmi26PMO0wyu6FvgCbfZbnZp2VUrlGFebv6D3T+XNqdvX2Z
         pZlpZCQ+CubXg1523ql/k7jtZPdYG7+95qNd4196kLkB38OR+3HveIX1pDQ9yb4CYwgt
         OQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777909959; x=1778514759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=udRl4dRYGy6KxASKdFufirqG/KQ87UOgsPscj92jHKI=;
        b=jUDlUBG5zHHKBO/PFdiVunSiAFlPgM/aBtAKtIJsUnes+tTRKD4NIc1INzTEue6y5F
         +zLxCLvYGreUahVj8/7Y2ts/5+e9UpvDv7KAFCSFA+MQPmD8lR4dQpMxekkX3G+Lix1n
         URcKYjKmVzs78My186pa02PLXbE31vBUEVx4nxAZpnts7cSmljrllIlwevmvDh5O+Bzw
         +E1sehbdm69dpHuuTcCFrISwOziGdRYvNPhUY74plkUDfwDDWFTHOBt+R6sGyuM8azye
         20ggD5H7p70tkESm0Eukn+it4/EW6gpKCoT+lkgAZYDvjBDCt5tPCvAHp/gSH3aF8OFo
         b1Ww==
X-Gm-Message-State: AOJu0Yxxlvph78BxuFgJxUs6p5xHP4pddxjDw0s1dtWjg/sD2m40ixMG
	pltEKL/vIaZ57vFMOrxk7icDDYN9lj1N+2KBx/9IffPmcI5tLlsRQQ6KJBZ4NopJKziXB30Ulz2
	5PmuyNrd1AyZwR1t2rPXzC24cZE2r8Bw=
X-Gm-Gg: AeBDievuGO+3OlernxhovwWiqp1acMvK+O9zBElJ4U6wQkylBianxKiuHeSrPDL7D3j
	cgUeeloBzOzu+QwhR7nLN8paCyRFQXKyTA6QCa8fpXP487lfNTWykXNWOLp1ZcptvQ7vN4bMXjQ
	/35kG//nKIq5LJ+ngTe1JU16Ta3+IO0ImZHYBAmzzRbNaq+WaKsnJZcJPvyvNdqZ21XxntDbLTF
	fktyfVDSvl1zadAnYNS4F1B26X0h6QdXjC0T9c+oMEzE1wKMZ4S36/xByCg5ZoVZ9KU4R6XI0Op
	iT/R5WnCHw82S2ucGx8=
X-Received: by 2002:a05:600c:4450:b0:488:9e43:9690 with SMTP id
 5b1f17b1804b1-48a986388acmr164807455e9.10.1777909958104; Mon, 04 May 2026
 08:52:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501133924.3100680-1-houminxi@gmail.com> <20260501133924.3100680-2-houminxi@gmail.com>
 <f7tpl3bxjs9.fsf@redhat.com>
In-Reply-To: <f7tpl3bxjs9.fsf@redhat.com>
From: =?UTF-8?B?5L6v5pWP54aZ?= <houminxi@gmail.com>
Date: Mon, 4 May 2026 23:52:11 +0800
X-Gm-Features: AVHnY4JIvmSRanWgofu57dC9BPZqLL8L5MQg0s67Ir7AHFVwBd3Qup5ZP2KlxHo
Message-ID: <CAJ0BgHetRvEDU5ruzbXLYKM1phFzabgThHjviax=wMRp3_SJ4g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] selftests: openvswitch: add vlan() and
 encap() flow string parsing
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	dev@openvswitch.org, Eelco Chaudron <echaudro@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4BF7C4C106D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-283927-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ovs-dpctl.py:url]

Hi Aaron,

Thanks for the review!

A v4 is already posted at:
https://lore.kernel.org/netdev/20260504123713.555461-1-houminxi@gmail.com/

It addresses several issues found during review (see changelog in the
cover letter). Specifically for your comments:

> ^ That's kindof a fix, BUT it also seems like we never actually used it
> anywhere, so I hope it is okay to not treat it that way.

Agreed! Since it was never used, treating it as a new feature is fine.
In v4 the ENCAP type is changed to "encap_ovskey" (a new subclass)
instead of "nested", which restricts the nla_map to L2-L4 attributes
only. This avoids pyroute2 trying to decode metadata attributes
(SKB_MARK, DP_HASH, etc.) that never appear inside ENCAP.

> It would be more useful if we could set the MAX_ENCAP_DEPTH separately,
> so that we have the option to break assumptions.  Maybe just skip a
> depth check here completely.

Makes sense! The kernel already enforces its own nesting limits, so
duplicating that check in the test tool is unnecessary. I'll drop the
depth check in v5.

Best,
Minxi

Aaron Conole <aconole@redhat.com> =E4=BA=8E2026=E5=B9=B45=E6=9C=884=E6=97=
=A5=E5=91=A8=E4=B8=80 23:43=E5=86=99=E9=81=93=EF=BC=9A
>
> Minxi Hou <houminxi@gmail.com> writes:
>
> > Extend the ovs-dpctl.py flow parser to support vlan() and encap()
> > match strings.  vlan() accepts tci=3D, vid=3D, pcp=3D, and cfi=3D
> > parameters and generates the OVS_KEY_ATTR_VLAN attribute with a TCI
> > value in network byte order.  encap() parses nested flow strings
> > and returns OVS_KEY_ATTR_ENCAP with inner key attributes as a
> > recursive NLA container.
> >
> > The encap nla_map type is changed from "none" to "nested" so that
> > pyroute2 recursively encodes the inner flow key attributes.  The
> > VLAN nla_map type is changed from "uint16" to "be16" to match the
> > kernel's big-endian wire format.
>
> ^ That's kindof a fix, BUT it also seems like we never actually used it
> anywhere, so I hope it is okay to not treat it that way.
>
> > Signed-off-by: Minxi Hou <houminxi@gmail.com>
> > ---
> > v1 -> v2: rebase to latest net-next/main, drop --base=3Dauto
> >
> >  .../selftests/net/openvswitch/ovs-dpctl.py    | 190 +++++++++++++++++-
> >  1 file changed, 188 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/too=
ls/testing/selftests/net/openvswitch/ovs-dpctl.py
> > index 848f61fdcee0..317be7878937 100644
> > --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> > +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> > @@ -901,11 +901,11 @@ class ovskey(nla):
> >      nla_flags =3D NLA_F_NESTED
> >      nla_map =3D (
> >          ("OVS_KEY_ATTR_UNSPEC", "none"),
> > -        ("OVS_KEY_ATTR_ENCAP", "none"),
> > +        ("OVS_KEY_ATTR_ENCAP", "nested"),
> >          ("OVS_KEY_ATTR_PRIORITY", "uint32"),
> >          ("OVS_KEY_ATTR_IN_PORT", "uint32"),
> >          ("OVS_KEY_ATTR_ETHERNET", "ethaddr"),
> > -        ("OVS_KEY_ATTR_VLAN", "uint16"),
> > +        ("OVS_KEY_ATTR_VLAN", "be16"),
> >          ("OVS_KEY_ATTR_ETHERTYPE", "be16"),
> >          ("OVS_KEY_ATTR_IPV4", "ovs_key_ipv4"),
> >          ("OVS_KEY_ATTR_IPV6", "ovs_key_ipv6"),
> > @@ -1636,6 +1636,180 @@ class ovskey(nla):
> >      class ovs_key_mpls(nla):
> >          fields =3D (("lse", ">I"),)
> >
> > +    # 802.1Q CFI (Canonical Format Indicator) bit, always set for Ethe=
rnet
> > +    _VLAN_CFI_MASK =3D 0x1000
> > +    _MAX_ENCAP_DEPTH =3D 4
>
> It would be more useful if we could set the MAX_ENCAP_DEPTH separately,
> so that we have the option to break assumptions.  Maybe just skip a
> depth check here completely.
>
> > +    _encap_depth =3D 0  # single-threaded usage assumed
> > +
> > +    @staticmethod
> > +    def _parse_vlan_from_flowstr(flowstr):
> > +        """Parse vlan(tci=3DX) or vlan(vid=3DX[,pcp=3DY,cfi=3DZ]) from=
 flowstr.
> > +
> > +        Returns (remaining_flowstr, key_tci, mask_tci).
> > +        TCI values use standard bit layout (VID bits 0-11,
> > +        CFI bit 12, PCP bits 13-15); byte order conversion to
> > +        big-endian happens in pyroute2 be16 NLA serialization.
> > +        The mask covers only the fields the caller specified:
> > +        vid -> 0x0FFF, pcp -> 0xE000, cfi -> 0x1000, tci -> 0xFFFF.
> > +
> > +        The tci=3D key sets the raw TCI bitfield (no CFI validation) t=
o allow
> > +        non-Ethernet use cases.  Use cfi=3D1 for standard Ethernet VLA=
N matching.
> > +        """
> > +        tci =3D 0
> > +        mask =3D 0
> > +        has_tci =3D False
> > +        has_vid =3D has_pcp =3D has_cfi =3D False
> > +        _tci_mix_err =3D "vlan(): 'tci' cannot be mixed " \
> > +                       "with 'vid'/'pcp'/'cfi'"
> > +        first =3D True
> > +        while True:
> > +            flowstr =3D flowstr.lstrip()
> > +            if not flowstr:
> > +                raise ValueError("vlan(): missing ')'")
> > +            if flowstr[0] =3D=3D ')':
> > +                break
> > +            if not first:
> > +                flowstr =3D flowstr[1:]  # skip ','
> > +                if not flowstr:
> > +                    raise ValueError("vlan(): missing ')' after traili=
ng comma")
> > +                flowstr =3D flowstr.lstrip()
> > +                if flowstr and flowstr[0] =3D=3D ')':
> > +                    break
> > +                if flowstr and flowstr[0] =3D=3D ',':
> > +                    raise ValueError(
> > +                        "vlan(): empty or extra comma in field list")
> > +            first =3D False
> > +
> > +            eq =3D flowstr.find('=3D')
> > +            if eq =3D=3D -1:
> > +                raise ValueError("vlan(): expected key=3Dvalue, got '%=
s'" % flowstr)
> > +            key =3D flowstr[:eq].strip()
> > +            flowstr =3D flowstr[eq + 1:]
> > +
> > +            end =3D flowstr.find(',')
> > +            end2 =3D flowstr.find(')')
> > +            if end =3D=3D -1 or (end2 !=3D -1 and end2 < end):
> > +                end =3D end2
> > +            val =3D flowstr[:end].strip()
> > +            flowstr =3D flowstr[end:]
> > +
> > +            if not val:
> > +                raise ValueError("vlan(): empty value for key '%s'" % =
key)
> > +            try:
> > +                v =3D int(val, 16) if val.startswith(('0x', '0X')) els=
e int(val)
> > +            except ValueError:
> > +                raise ValueError("vlan(): invalid value '%s' for key '=
%s'" %
> > +                                 (val, key))
> > +
> > +            if key =3D=3D 'tci':
> > +                if has_tci:
> > +                    raise ValueError("vlan(): duplicate 'tci'")
> > +                if has_vid or has_pcp or has_cfi:
> > +                    raise ValueError(_tci_mix_err)
> > +                if v > 0xFFFF or v < 0:
> > +                    raise ValueError("vlan(): tci=3D0x%x out of range"=
 % v)
> > +                tci =3D v
> > +                mask =3D 0xFFFF
> > +                has_tci =3D True
> > +            elif key =3D=3D 'vid':
> > +                if has_tci:
> > +                    raise ValueError(_tci_mix_err)
> > +                if has_vid:
> > +                    raise ValueError("vlan(): duplicate 'vid'")
> > +                if v < 0 or v > 0xFFF:
> > +                    raise ValueError("vlan(): vid=3D%d out of range (0=
-4095)" % v)
> > +                tci |=3D v
> > +                mask |=3D 0x0FFF
> > +                has_vid =3D True
> > +            elif key =3D=3D 'pcp':
> > +                if has_tci:
> > +                    raise ValueError(_tci_mix_err)
> > +                if has_pcp:
> > +                    raise ValueError("vlan(): duplicate 'pcp'")
> > +                if v < 0 or v > 7:
> > +                    raise ValueError("vlan(): pcp=3D%d out of range (0=
-7)" % v)
> > +                tci |=3D (v & 0x7) << 13
> > +                mask |=3D 0xE000
> > +                has_pcp =3D True
> > +            elif key =3D=3D 'cfi':
> > +                if has_tci:
> > +                    raise ValueError(_tci_mix_err)
> > +                if has_cfi:
> > +                    raise ValueError("vlan(): duplicate 'cfi'")
> > +                if v !=3D 1:
> > +                    raise ValueError("vlan(): cfi must be 1 for Ethern=
et")
> > +                tci |=3D ovskey._VLAN_CFI_MASK
> > +                mask |=3D ovskey._VLAN_CFI_MASK
> > +                has_cfi =3D True
> > +            else:
> > +                raise ValueError("vlan(): unknown key '%s'" % key)
> > +
> > +        flowstr =3D flowstr[1:]  # skip ')'
> > +        # Catch immediate '))' (user error).  A ')' after ',' is consu=
med
> > +        # by parse()'s strspn(flowstr, "), ") inter-field separator st=
ripping.
> > +        if flowstr.lstrip().startswith(')'):
> > +            raise ValueError("vlan(): unmatched ')'")
> > +        # parse() strips trailing ',', ')', ' ' as inter-field separat=
ors,
> > +        # so we do not need to call strspn here.
> > +
> > +        if mask =3D=3D 0:
> > +            raise ValueError("vlan(): no fields specified, "
> > +                             "use vlan(vid=3DX[,pcp=3DY,cfi=3DZ]) or v=
lan(tci=3DX)")
> > +        if not has_tci:
> > +            tci |=3D ovskey._VLAN_CFI_MASK
> > +            mask |=3D ovskey._VLAN_CFI_MASK
> > +        return flowstr, tci, mask
> > +
> > +    @staticmethod
> > +    def _parse_encap_from_flowstr(flowstr):
> > +        """Parse encap(inner_flow) from flowstr.
> > +
> > +        Returns (remaining_flowstr, inner_key_dict, inner_mask_dict)
> > +        where each dict has an 'attrs' key for recursive NLA encoding.
> > +        Parenthesis-depth tracking handles nested encap() calls but no=
t
> > +        quoted strings containing literal parentheses.
> > +        """
> > +        if ovskey._encap_depth >=3D ovskey._MAX_ENCAP_DEPTH:
> > +            raise ValueError("encap(): max nesting depth %d exceeded" =
%
> > +                             ovskey._MAX_ENCAP_DEPTH)
> > +        try:
> > +            ovskey._encap_depth +=3D 1
> > +            depth =3D 1
> > +            end =3D -1
> > +            for i, c in enumerate(flowstr):
> > +                if c =3D=3D '(':
> > +                    depth +=3D 1
> > +                elif c =3D=3D ')':
> > +                    depth -=3D 1
> > +                    if depth < 0:
> > +                        raise ValueError("encap(): unmatched ')' at po=
sition %d" % i)
> > +                    if depth =3D=3D 0:
> > +                        end =3D i
> > +                        break
> > +
> > +            if end =3D=3D -1:
> > +                if depth > 1:
> > +                    raise ValueError("encap(): missing ')' at end")
> > +                raise ValueError("encap(): missing closing ')'")
> > +
> > +            inner_str =3D flowstr[:end].strip()
> > +            if not inner_str:
> > +                raise ValueError("encap(): empty inner flow")
> > +
> > +            flowstr =3D flowstr[end + 1:]
> > +            if flowstr.lstrip().startswith(')'):
> > +                raise ValueError("encap(): unmatched ')' after encap()=
")
> > +            # parse() strips trailing ',', ')', ' ' as inter-field sep=
arators,
> > +            # so we do not need to call strspn here.
> > +
> > +            inner_key =3D ovskey()
> > +            inner_mask =3D ovskey()
> > +            inner_key.parse(inner_str, inner_mask)
> > +
> > +            return flowstr, inner_key, inner_mask
> > +        finally:
> > +            ovskey._encap_depth -=3D 1
> > +
> >      def parse(self, flowstr, mask=3DNone):
> >          for field in (
> >              ("OVS_KEY_ATTR_PRIORITY", "skb_priority", intparse),
> > @@ -1657,6 +1831,16 @@ class ovskey(nla):
> >                  "eth_type",
> >                  lambda x: intparse(x, "0xffff"),
> >              ),
> > +            (
> > +                "OVS_KEY_ATTR_VLAN",
> > +                "vlan",
> > +                ovskey._parse_vlan_from_flowstr,
> > +            ),
> > +            (
> > +                "OVS_KEY_ATTR_ENCAP",
> > +                "encap",
> > +                ovskey._parse_encap_from_flowstr,
> > +            ),
> >              (
> >                  "OVS_KEY_ATTR_IPV4",
> >                  "ipv4",
> > @@ -1794,6 +1978,8 @@ class ovskey(nla):
> >                  True,
> >              ),
> >              ("OVS_KEY_ATTR_ETHERNET", None, None, False, False),
> > +            ("OVS_KEY_ATTR_VLAN", "vlan", "0x%04x", lambda x: False, T=
rue),
> > +            ("OVS_KEY_ATTR_ENCAP", None, None, False, False),
> >              (
> >                  "OVS_KEY_ATTR_ETHERTYPE",
> >                  "eth_type",
>

