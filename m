Return-Path: <netdev+bounces-299927-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TlZBI9+GMWrQlgUAu9opvQ
	(envelope-from <netdev+bounces-299927-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 19:24:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1119693198
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 19:24:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ogGjHaG3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299927-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299927-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 517293169FAA
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 17:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0301947CC62;
	Tue, 16 Jun 2026 17:16:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785B447B415
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 17:16:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630205; cv=pass; b=NVargEWNTcltMdGavWSjIg+o1vNb/D5lAzC1GnoJanK+NtOZGUSPXT4XVj3cA5dhvU3p00FcH6Zs/DFOnsmBc7La7017uK5A9zT3QUmAyY/Y/Ks3yuiUpWnDNLzsPQpBkZVXlM9UbKwwcDRoGNH6rQe5ax1sgOkDXo74E23ntSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630205; c=relaxed/simple;
	bh=Nh4pQEP/JXI3ej0cc0N9+1DaTtnfkzaHu46z64YzAqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHwfK1TrEtmtTecgICTrNm8tVQ6lX5xqPN2S1uetCOIyybN9zGTca/JG2jMdHvI8Zir1nESxudM8fczb+ZKj9M9zgt8N8UU/PwL3CWxrPGoc2aD9ehBN7tjy1dcuGuXwirKwmjacII136SPvApE0f3KCpxoScHhfHUzwak/5Urw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ogGjHaG3; arc=pass smtp.client-ip=209.85.128.169
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7fe4808741eso916977b3.1
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 10:16:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781630198; cv=none;
        d=google.com; s=arc-20240605;
        b=XEZYoVUi2KZyYFJwRWsGuDGr2z6PqcVJTxfxoSErghyvu5EcIjEGzMLxrnBavyzCYA
         QO3Vf2G2tePRtcLcvwNUyBkuFwj6Jo/GOXBTeVqxToLIHmIdcT2xEGIQQj092OlJe8GZ
         nIcXTX88SRKEOK7oPLKRo2j7gR3v4eLd01dVizIsaD5SsxNHbTE5PfCNejuBd7VUHAZp
         8I3VcD9YlIcWZDvZA5Q7U+B6fmpGvJVUw01Wz8P7eJvwK0u4pffXlRIDkOwb56wq9swD
         MBpGTjctrxOIF630KDw+TKtvWjO6bUCvHgSLSeadvoZHSeeiVu4clwdgT2Xhcg45ePBG
         5dBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m0Na40jsKjOOHid0+S5827JBwf9AggIFrx0Gx8lBHzA=;
        fh=6EiDIUy6Gbp7tN50r3T2rwXX3A71R/SF8IySOeHtwZQ=;
        b=DGHltA1nWfPpNO6D7eDEvTaC7gevlNhpER+ItGEmHJ0KJCpRSiRPqL/14k+d+Pok+o
         vUNf84e4ZF2bCaDLwxPT1vp3QhwzrMUWvJvfLRzhvPu1TqOTswgk3K8aX5VezwOoR2g2
         9F+S58D+TNxQqFuowTJHfoA1MW82oLbopOOxbuy7t7gmG7i/c6vUduuPRFZgi4ugbX5s
         6HYKyGEB0R4FiSW8AxGdAtEgLE7W8ibuMMrt+AF5fDBqc6RMds3Llk3CAghrFzOAghbe
         RZfbx8XoErPI6aJLbLCGohxm/ZHQMVW3Kzw3vWhTOhdXZCkBcAmI08kcJS2ltFuxCYT8
         crYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781630198; x=1782234998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0Na40jsKjOOHid0+S5827JBwf9AggIFrx0Gx8lBHzA=;
        b=ogGjHaG3FFir+++MTSWO002gmUl64b68C/JGm7TDn4weBDzqwq2HhTKAVqUVg6n7BA
         fmOjrXkwaduxS2Nkxb22h3pD++L8PkchBwudECRDIFqgtJ5dIgeeCIprCq6RtjU7Vp1J
         Df1F0IhcD49OldeP8v9BtAaNnJaK0dkssJ5U6iErX2VCq+DYISjtTLWBqWbMCXNzQilc
         e38XQJxm/fqmkubdqZg5LfnE+uZa7Vz26NPGknYbEsWgyMnxFTO8AND7TT+3E0nk7D8m
         JM5x+hhEOBrqQsxIHx/BATfkM+VTwYJGwoFV+jPcDIVnD8PjKc4HVUe4N8GM2XtB9Di1
         i+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781630198; x=1782234998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m0Na40jsKjOOHid0+S5827JBwf9AggIFrx0Gx8lBHzA=;
        b=ADNJC2Gz2Sw/Ox1PbiWctAcJJ0swVYJ32n+KMLaHKKb/SY+4/oZlmjq1kTfljNwG0i
         EiYyG0GjE6vPsKgPBjobyi2wdDNf3fRHNVfRIydTP7w8MBfX8V6hC03mRX5vNp5d7++G
         +5nGXseLlG30WKH4ctwqbdu82moMNUUi3UckwlcLfdf/rYe041VOSoyvr8rhF/0pm38W
         Mwz/imvKxxulXjTl6Iv/eijWoFKD9KjtuOVYrJqkpI/VZBy8bVLcMGu1YDnaqoLakh6k
         xhxTtoYiNDX153ePSrpgkj7gUHxTctq6Vpyc/RFcw5wDK8+ePaIoZ6AVpRbt/aIZtvWK
         Wz3w==
X-Forwarded-Encrypted: i=1; AFNElJ/xEFVkJQTUJMYuW6Dl64zBRtfE3CgJAq39UuBze6R8C/nBvy4prks8TUWXefLuI/sTMdtyA9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDVTvy7pIFbfYyqM7CXPUpPLNAVPAaI1zizYsdy/vbZFIAdjdI
	KxyyAwz+IqSUk5Z2VWcm1cXLkxey3ovlmYUH4nQzibsLNKW4c5cvBkmbERGk/H2pHScwu5xe1f/
	YLqu1qIfTXdIG/0QXNa3hRRZ1mU3NjNo=
X-Gm-Gg: AfdE7cknV+ufNLK8YfiNvQcbV5e6fmTMvbqy/6qAAk5df+Ti2fRyWCCenIY5k8bmsB8
	mpD/u4gyx39u7uE7R3VsECeEhboF7WZi2JgyhS6cgP5UNrfoV6xdJaDjvKrdZdOYXtMo07ldrOw
	piptx4ny66qNmbkZbcSA4CFcR8OLOw014NSHn823ufr7iOc+G1UYnyF2pLUc+v26vzFYkK2FMN3
	y6RT38c0o6XHDNgvLj4OEb06YsMMKBgphDeE4MPp5FbLPk2XbWIHAe1waCn02q0yx1/rhvew0ba
	IJvJcgaNvFquMu1Tp2j1ZQZWcAydDjTF3Uw3Nw5W/6sovS+9/Sk=
X-Received: by 2002:a05:690c:c11:b0:7f8:7e60:aca with SMTP id
 00721157ae682-7fd00b41bfcmr45333267b3.47.1781630198070; Tue, 16 Jun 2026
 10:16:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616093103.471444-1-sun.jian.kdev@gmail.com>
 <20260616093103.471444-2-sun.jian.kdev@gmail.com> <ajFQvedGURQuKqbX@mail.gmail.com>
In-Reply-To: <ajFQvedGURQuKqbX@mail.gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Wed, 17 Jun 2026 01:16:25 +0800
X-Gm-Features: AVVi8CfQ9aqklUqfMKfjhMBGm3tuyh-ykNo01OgpkMaLz69xQ_iTRgzZV4nsZPM
Message-ID: <CABFUUZHV2be01_BVO1ZAVf9_z1UOzsYZ7hH1FKrwmJUxPnrR_A@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix partial copy of non-linear test_run output
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, toke@redhat.com, 
	lorenzo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:paul.chaignon@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:toke@redhat.com,m:lorenzo@kernel.org,m:paulchaignon@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-299927-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,gmail.com,davemloft.net,google.com,redhat.com,fomichev.me];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E1119693198

On Tue, Jun 16, 2026 at 9:33=E2=80=AFPM Paul Chaignon <paul.chaignon@gmail.=
com> wrote:
>
> On Tue, Jun 16, 2026 at 05:31:02PM +0800, Sun Jian wrote:
> > For non-linear test_run output, bpf_test_finish() derives the linear
> > data copy length from copy_size - frag_size. This only matches the
> > linear data length when copy_size is the full packet size.
> >
> > When userspace provides a short data_out buffer, copy_size is clamped t=
o
> > that buffer size. If copy_size is smaller than frag_size, the computed
> > length becomes negative and bpf_test_finish() returns -ENOSPC before
> > copying the packet prefix or updating data_size_out.
> >
> > Compute the linear data length from the packet layout instead, and clam=
p
> > the linear copy length to copy_size. This preserves the expected
> > partial-copy semantics: return -ENOSPC, copy the packet prefix that fit=
s
> > in data_out, and report the full packet length through data_size_out.
> >
> > Fixes: 7855e0db150ad ("bpf: test_run: add xdp_shared_info pointer in bp=
f_test_finish signature")
> > Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> > ---
> >  net/bpf/test_run.c | 11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)
> >
> > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > index 2bc04feadfab..976e8fa31bc9 100644
> > --- a/net/bpf/test_run.c
> > +++ b/net/bpf/test_run.c
> > @@ -453,19 +453,16 @@ static int bpf_test_finish(const union bpf_attr *=
kattr,
> >       }
> >
> >       if (data_out) {
> > -             int len =3D sinfo ? copy_size - frag_size : copy_size;
> > -
> > -             if (len < 0) {
> > -                     err =3D -ENOSPC;
> > -                     goto out;
> > -             }
> > +             u32 head_len =3D size - frag_size;
> > +             u32 len =3D min(copy_size, head_len);
> >
> >               if (copy_to_user(data_out, data, len))
> >                       goto out;
> >
> >               if (sinfo) {
> > -                     int i, offset =3D len;
> > +                     u32 offset =3D len;
> >                       u32 data_len;
> > +                     int i;
>
> That doesn't look needed.
>
> >
> >                       for (i =3D 0; i < sinfo->nr_frags; i++) {
> >                               skb_frag_t *frag =3D &sinfo->frags[i];
> > --
> > 2.43.0
> >

Hi Paul,

Thanks for taking another look.

Agreed, I'll keep the fix patch minimal and leave offset as-is.

For the selftest patch, I'll try to reuse pkt_v4 and the existing TC
program where possible, and keep only the minimal XDP frags program for the
XDP case.

Thanks,
Sun Jian

