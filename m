Return-Path: <netdev+bounces-257296-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEvyIPfshGkj6gMAu9opvQ
	(envelope-from <netdev+bounces-257296-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 20:18:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4FFF6C55
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 20:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FA0D3011BDD
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 19:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D243832572A;
	Thu,  5 Feb 2026 19:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wsf1j6w9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B843242D2
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 19:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770319092; cv=pass; b=rLTaAS/LwY4t8n/5p/F9VJjLllhzy7O6bPI2TXGMt8hSXJh3C15l1kS7fgRRETdvCEa153cFLFGDcoLA8Z6KmW+IyYrX1PZJo8eQLmcLfXOV2ZV7wr+Ee6yafeg5kEdX0qYE4zJTFV4QURoE8WLgflmzPOEJ1u+KfSHkR/tB8BE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770319092; c=relaxed/simple;
	bh=QRhy0aaIatw5X2ingQ3dP6bzvBtQ67P0/48x91gmp1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVZ7gf88Iv8vDTQ6qHt/DI5nAC214Cigx5CnWjX8m37340e2PzJpM10Dxqd1ajG5hqUjA6tMiKfvpWE/iP6V48Aj0u+p2CK8SKwzTTc+/i7ucOB15dA0b/mZlInsW7mrrMEccJgspFl6FuMQyseIhyUXmNIGMdyzxT4Nx/4GEYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wsf1j6w9; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3530f597ea3so528496a91.1
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 11:18:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770319092; cv=none;
        d=google.com; s=arc-20240605;
        b=I/n38Wu6nJWssiZhpZa5sA7pM+t06BjZDSDDU2gogWV2IFtel3cDD2x8ILtuFEfJGj
         FWA3CE3H2JZlezMZ8B30HFLQmKI/mJRKjUxGFIkchdC895xqtqG8oaa6lIOJp2W6BT/g
         8wpwglHjh0OkVKJmqjx+XlhG6GcilOs9ypRSFyvdPe9XH2n89qZoliSlwVNyd8zlpFZn
         Oiiiqs92BvLpqAq2bc8urDmMdUUWLDzOXjZbrfRwlVqTbl+ysa0jP8VgachV6OIdRRgH
         v1r1V1ZngugLG/ZnXojpUSLSngbD407+66P7dWMSvFrvayO2xnLRRJBvXSWrxQVm1PzJ
         9v3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vp6eSjM8r19A+ldOLHO2Ln5yqplokvRmWPI5a2FR3lU=;
        fh=G3xFl1aQrHw5TcVuUYIHOW/EDBUi3Mt1hFNxF/nCi3c=;
        b=ljCsCqn3ExUyutKdQ7txqC4OpJZM3k8w3c/mYJkeETbK1uOzq5NVYEBtopyWM0JjiC
         pByOe+s5LERs63QB+HVgFM0zDp9Hmyt+Z1UuMF/LtYG7g6dH+THLpOE4NxdIuigWZyA8
         XIDuzl+88v1Py2LkFsz12ZQZ6y4WsgcIsHCQqjZvCOSsX7Y5nlkC5/AUV4XZOMJl6taq
         4gGvBBDlSwWo5grU4hECAXD92mN7NFmaIj0EE6fMJLozEl36ZDjeGlMLFuluHZB6DkvQ
         18WolPPVpTQccuZ7otH3O180vT44liF8+Hmi2eDnqavsqeOXkhoEXrmSRWA8mXh0AlWO
         EpPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770319092; x=1770923892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vp6eSjM8r19A+ldOLHO2Ln5yqplokvRmWPI5a2FR3lU=;
        b=Wsf1j6w97UwfEIyFwzWGNa28q28GTq8e5u7+D9V0xLKQ+VxTPI92JUmWyu6J5eGYzA
         38gyAL998O3UNabkmGuN9uHMuB1yCt0//NAyG97Awd52lE7MXle3JvDYP6GpArFhjpXb
         X5NdEJkuhITXNXdocoHPOVVSw/T/0PaMgAuXT05rwdm9CIJPDwLM/WHlD9G/spr/u9CB
         gNr2LMBdBzsCc1m0e4YF6MSW6xaITa9jCXEoE4Olep54/nqmsXgprbacF+PoA/rRvAMA
         0mAkQ7z+GmjiRo0zc2b+J/FaX8T37McF9ooscprY1tziTW5Iq32GRiR4M/RwFzVu2WQR
         bp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770319092; x=1770923892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vp6eSjM8r19A+ldOLHO2Ln5yqplokvRmWPI5a2FR3lU=;
        b=nY3zJ0KfmrNjsKG4sEKK05muNR4TS8ujOrKtvVgjcD+nFnWukH5gvVGd0ke1AoGqRh
         B5UYFsKSngMyeayxsdMdOdCX10oxI6foQGbOvzaprS74k91irE008PaGMfx0kBBcQC1H
         lwkJwxWw9VygGxVjGepBPfjbIQeNwZ4axetAmam5nO6CQcOpfbLa26xCKf5xWzKOoEsf
         070/6Ql/WrS/Bi4JcDFo4TpCi6/Wbd8yWXb2AtH16m1AEWDM/dFdFRNOw5FOy88F6Gqt
         Z5YSNB/5wSFimamhPyk0Pg3JjQCFuxS1fYklfRaInnubKLnR7qhGzZYBJbZRm9BdemrX
         jAeA==
X-Forwarded-Encrypted: i=1; AJvYcCURb9DRG4T4gf2uHEiq0CzvObtzYuhoV5mvhi1/OmPHPOABe+lxeWmG9Fns3MMFppGLcrLSVxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLbBeSh08NWdgXOuHX+JKF2FqBbnS5adlaXNGShWZKZH4QzaC3
	Awf+5vUniAT7BUYBgCs/j00Vu+MrSqdtst7sqwvtzIqaGvzee5ruL7M9j3kg79Tt8J9nnKiEhkl
	NA3iXn6T+lXcqkkEf2/PbWbLQy0KsIn8=
X-Gm-Gg: AZuq6aJ4eM6lnUZqlB9SL4U7vih/wZJUl4jF3yiVKX+3PRRizbiz6/yEPoPi8pZsU5x
	TGgG180IGOaoaMAEif3FkAkjYjMBeCWV3kzmx75yq/IyG3UWih+iwZou0HgBRs57Z6e5YpGbTfM
	+2RKbSDVrTtHf0rqGoC0qbm1K6rvxkcVLOlhIy4UlV+OxybW3vQOW2c68dtSF/4fbv0DeqWcMIK
	tENdqDSMwzagLHKi6BFRlR9euVItqYgiq2KVDZcIDbsQgOG+VqOQGL5g86Dh/EJr23bUXibvYin
	V0Oo1CX0/CzwZP8sfhdV9xkYMsJv
X-Received: by 2002:a17:90b:268b:b0:34f:63b7:a1f5 with SMTP id
 98e67ed59e1d1-354b3e2f135mr64355a91.21.1770319091958; Thu, 05 Feb 2026
 11:18:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <74174c085fb11b8a63e72a7df730b6f4a7479c5c.1770042461.git.lucien.xin@gmail.com>
 <20260205115449.2195294-1-horms@kernel.org> <1bcfe20e-0103-44a5-82b5-90cba7ba5a60@redhat.com>
In-Reply-To: <1bcfe20e-0103-44a5-82b5-90cba7ba5a60@redhat.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 5 Feb 2026 14:18:00 -0500
X-Gm-Features: AZwV_Qh_mc3jaIOzqDW1hY_eOgDZvqz5PolYvBWVQrjtRoVkuvNydWMH3Z6Pil0
Message-ID: <CADvbK_eLJ2HWxx5G8PBwePCUZ7dXdDw6X8pryWWyn7SRx1NdDg@mail.gmail.com>
Subject: Re: [net-next,v9,03/15] quic: provide common utilities and data structures
To: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, steved@redhat.com, marcelo.leitner@gmail.com, 
	aahringo@redhat.com, alibuda@linux.alibaba.com, jbaron@akamai.com, 
	hare@suse.de, kuba@kernel.org, tom@talpey.com, linux-cifs@vger.kernel.org, 
	daniel@haxx.se, quic@lists.linux.dev, jlayton@kernel.org, tfanelli@redhat.com, 
	dhowells@redhat.com, linkinjeon@kernel.org, hepengtao@xiaomi.com, 
	pc@manguebit.com, kernel-tls-handshake@lists.linux.dev, 
	illiliti@protonmail.com, xiyou.wangcong@gmail.com, 
	andrew.gospodarek@broadcom.com, mail@johnericson.me, edumazet@google.com, 
	matttbe@kernel.org, netdev@vger.kernel.org, smfrench@gmail.com, 
	metze@samba.org, mbuhl@openbsd.org, chuck.lever@oracle.com, dreibh@simula.no, 
	davem@davemloft.net, sd@queasysnail.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257296-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,gmail.com,linux.alibaba.com,akamai.com,suse.de,talpey.com,vger.kernel.org,haxx.se,lists.linux.dev,xiaomi.com,manguebit.com,protonmail.com,broadcom.com,johnericson.me,google.com,samba.org,openbsd.org,oracle.com,simula.no,davemloft.net,queasysnail.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url]
X-Rspamd-Queue-Id: CE4FFF6C55
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 7:51=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 2/5/26 12:54 PM, Simon Horman wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> >
> > For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-lo=
cal.html
> > ---
> > quic: provide common utilities and data structures
> >
> > This patch provides foundational data structures and utilities for
> > the QUIC stack, including hash tables for socket lookup, connection
> > ID management, and helpers for encoding/decoding transport parameters.
> >
> >> diff --git a/net/quic/common.c b/net/quic/common.c
> >> new file mode 100644
> >> index 000000000000..94321f3f213d
> >> --- /dev/null
> >> +++ b/net/quic/common.c
> >
> > [ ... ]
> >
> >> +/* Reads a QUIC transport parameter value. */
> >> +u8 quic_get_param(u64 *pdest, u8 **pp, u32 *plen)
> >> +{
> >> +    u64 valuelen;
> >> +
> >> +    if (!quic_get_var(pp, plen, &valuelen))
> >> +            return 0;
> >> +
> >> +    if (*plen < valuelen)
> >> +            return 0;
> >> +
> >> +    if (!quic_get_var(pp, plen, pdest))
> >> +            return 0;
> >> +
> >> +    return (u8)valuelen;
> >> +}
> >
> > Does quic_get_param() need to verify that quic_get_var() consumed exact=
ly
> > valuelen bytes?
> >
> > The function reads valuelen at the first quic_get_var() call, then deco=
des
> > the value with the second quic_get_var(). However, quic_get_var() deter=
mines
> > how many bytes to consume based on the varint prefix in the data, not f=
rom
> > valuelen.
> >
> > If a malformed packet has valuelen=3D2 but the varint encoding requires=
 4 bytes,
> > quic_get_var() will consume 4 bytes while the function returns valuelen=
=3D2.
> > This could desynchronize parsing of subsequent parameters since the cal=
ler
> > expects the buffer to have advanced by valuelen bytes based on the retu=
rn
> > value.
>
> Hard to tell without any caller for this function. Possibly you could
> drop it? IDK if enforcing such check would be correct/safe from an
> interoperability PoV.
I kind of forgot why I didn't validate it, I will decide if it should be
added after interop testing with those userland implementations.

>
> >> diff --git a/net/quic/common.h b/net/quic/common.h
> >> new file mode 100644
> >> index 000000000000..bfec0aaf2907
> >> --- /dev/null
> >> +++ b/net/quic/common.h
> >
> > [ ... ]
> >
> >> +#define QUIC_CONN_ID_MAX_LEN        20
> >
> > [ ... ]
> >
> >> +struct quic_conn_id {
> >> +    u8 data[QUIC_CONN_ID_MAX_LEN];
> >> +    u8 len;
> >> +};
> >> +
> >> +static inline void quic_conn_id_update(struct quic_conn_id *conn_id, =
u8 *data, u32 len)
> >> +{
> >> +    memcpy(conn_id->data, data, len);
> >> +    conn_id->len =3D (u8)len;
> >> +}
> >
> > Should quic_conn_id_update() validate that len does not exceed
> > QUIC_CONN_ID_MAX_LEN before the memcpy?
> >
> > The destination buffer conn_id->data is a 20-byte array, but the len
> > parameter is u32 with no bounds check. If a caller passes len > 20, the
> > memcpy would overflow the buffer.
>
> It looks like the check responsibility is on the callers. I guess it
> would make things more robust and simpler move the check here.
>
Parsing the connid from incoming packets will always check its length,
not good to move the check here then return an error for coding.

I will only leave a comment here. like:

/* Caller must ensure len does not exceed QUIC_CONN_ID_MAX_LEN. */

Thanks.

