Return-Path: <netdev+bounces-297875-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NZzJJ8oMKmqPhwMAu9opvQ
	(envelope-from <netdev+bounces-297875-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 03:18:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0EE66D9DB
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 03:18:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=k1DPFvIV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297875-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297875-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7BFCD3011EA8
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 01:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364781E9B37;
	Thu, 11 Jun 2026 01:17:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5531C15E5DC
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 01:17:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781140678; cv=pass; b=udLnr4ZfTwHx5IBUmXUdV2CYoAtaqgH9RaS9qBJYY9aKKAaIAWEN9+e1wKMw/LxWbYEV+v7MPsRx2V4onOtWB6XaP65m1uwP4JbYV/2Rx0djhqlUbjSYU13yW5xlCKf14Y4jq09uhEl3hwLabGk1KGv7qoMpRQ6zx//9YmTwzgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781140678; c=relaxed/simple;
	bh=y6kzzG3ct0h6IoHvAD4R7WtfG1tsXtsc+74I95kF+5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQn7HllgEOvMqa/OIY41lOttuhvSAuLufz5nmEPz9zcTlBdXeY0sm3RtCFt5NHisdtiWeoFYiq2tqReiIdWt2uhfhxVu6hpugNXA6A9F5q1LZhA57dKZSgmfKIUSXg4YoujSM4xL2Nhgo+nA5bfvnQNkFVO11C95dyRQ5R3s6NU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1DPFvIV; arc=pass smtp.client-ip=209.85.128.181
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7dfceeaf168so70634937b3.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 18:17:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781140675; cv=none;
        d=google.com; s=arc-20240605;
        b=gVSM/urfmFJgl74w4UaR0ZqLj5pExsb6T6k3Ks4qeRdInx5f2Tx/2Jq/N6ebOXtB+n
         thB+8kQ9JPOUNEduWWFSu/YLjqdZg3ix5zG+7BKyBQFWDYlmHJwk2WLoFDbDUYneEEWR
         JWsgZE8UW3JzSlzP2PB8JtYSLZOviFmHDhfRsJOeYPcYd7MxirfG3gDr/gFfZAEp4sWM
         yOE18Xx+GvzoMNUdnAN51oa3mZwANcieBWASeeeqLHNRY4tNGgvE9MdX9BGOWfx2FkLm
         xOuplaQTMWAXqlyaEGmQiFx+pXKaYCFWTaaBSJdZQE2ltVZ83Gwtl01dZOjRMTxUTUhU
         Cq+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cwpdyNCQVE9Z0vBjg+vKg/1VB56zfLGyeI5CigKesGI=;
        fh=hE/1WYjjF6v102qI9jvsA3sIrI8JdTwt43npZnXjVOE=;
        b=fr2dUVn3RbzIoyuDdD1pezDLM5ksJBXOjOfVjgIb8SdyNEj3sEWDWcED71KOHQ4Z7f
         MPZEPzYCu8fycoREm+z+aK7890bwiYxBGktOP9vBsoNMn8PJf5LhVc1rZO1azpaPK5LI
         WdrdouQgYVNcKdr1/uq5OapmcwgdMuTMbiDdUF3xqzTWl1KYryTOnlo9JctaoYzNAAZD
         3mY3XXv5+hOuPVF5YW7UIf2RQLbEh07nmWrEzfQ0euykcRMR0C+FniCnZYOgQaZiAhTu
         vCwA7Q1ikbo1RgNfG+tk6xNExzfj5oUCFj/mvjP5NVQz88CWWC0uaS5gar/etjOt6IA0
         zuDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781140675; x=1781745475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwpdyNCQVE9Z0vBjg+vKg/1VB56zfLGyeI5CigKesGI=;
        b=k1DPFvIVaJUG0nOCozFMPM7VTT1VRTdz6b/erSM0D6FJdFyzsu8I9bkzXbRDvldUVR
         o7EmWMu/u1ZqsrsPzmr4oj1slHt0VURPq5WDlsGMJbk6rXhKkp7ATlxhpoNenKZGEsGl
         Cx7hgBJQ5sYtzvmRZAPUMwwSCnu8mU6dqFr4hmaqswcRdT1fj9EqNohlAyGcOUYg16EB
         T4qUyin8OQ6elJ9d9MZnNWkslxZXl3d5eanQ5StrgGbMvOsjHr/R+ZdtkMt7dVDk/0NN
         3MD/jFHPy0Q0UbLbLBGX2b9K6qZ5Ad2N025qBEhBuS72QN4QG9hbyzNLvTHdXb5jiE+t
         LNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781140675; x=1781745475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cwpdyNCQVE9Z0vBjg+vKg/1VB56zfLGyeI5CigKesGI=;
        b=dwRyj6vyvJEZOCaFlOxwxMmCjs+Wn40PSs+Iwj1ICG7UjPdC4QEcJM8wxVyBj8M9ga
         H4KZm/uzt+q+s/LN6oNAsiUoQeXIjEvo/NU0MLCFMoIA5ZoGC8UGhXEJk2S3Ltpz8OKa
         vlSeVh9uQOLcjvUvCRf3Zgv6J1wAF59oeUTumsGtLlHvF9tUkAGECAOMDe8GYWZ0HTc7
         Y7yiTC/ok2c87BEzm+tLpXDVkqntkwMsSBcDioMK98wbUpPt6eWWz1Br3Hz43UpoZpEH
         75nv1jg7tGSdLFzd9JOTIrX8SCZGUmWpWKTfh9ULHWh4gIXwV/HIscn2T98+PaleZ6CD
         L6+w==
X-Forwarded-Encrypted: i=1; AFNElJ/Mm5hsCM84oJu+z91KkmJ8Ph02w1akyU2OZwvNsTuCXnsYbAejH9sJnX9r9RlB/pVr2neC0nE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy591l75y5y22yCUrrQYUUosWn3zmAp3uSmisUnMBWxPeIM9/p3
	UlkxhBceI7tct+D9CXgHqsMUx2sTT3SiDAiOAPFDO8jhT78bM3HvY9vGtLehxjwagtpKWk44lqN
	5PappfyB3Qg2DArVaTeb5IM3cr6gNbUw=
X-Gm-Gg: Acq92OHJIQlcJvOIVf02vG1c8MGkaNrYeUAXHj4EfZo1EiUuCpRLYkepDZ3dDR9Nb2u
	kxx67PdAK7/kROg9jCetOegVoRlTvIuobBHDhtPk5Bb2IUjl/nTbK/UP65sp1G4FhmiZrKBo8m2
	rl4FsIIjiiBeUEX/FraHwmGa/X5IbU7sAxd9HDTridSD7ndZ++4oOH1WKC1XU/P1uE2lVqYO26L
	dhx1mFAZ6g2nPiX+veiFcvKLKSSBt4yGrhGT8AotLVqcaYqMVIWSDHwIUlkSfXNQG1Pr3k/urtD
	NriHz1po/CsE9Lkju4aGxXrG0X0UtiXzh35ipKPiziqKQzR7Zz47Rb/3fxhOR6rZ/m7Yiw==
X-Received: by 2002:a05:690c:3392:b0:7f4:fad5:2084 with SMTP id
 00721157ae682-7f6559e6bf8mr8454907b3.13.1781140675216; Wed, 10 Jun 2026
 18:17:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610102850.483291-1-sun.jian.kdev@gmail.com>
 <871peeacre.fsf@toke.dk> <20260610075018.6162cec7@kernel.org>
In-Reply-To: <20260610075018.6162cec7@kernel.org>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Thu, 11 Jun 2026 09:17:45 +0800
X-Gm-Features: AVVi8CfDR3TXqyYOHmrrylWsHkJhrNSrybKrnHMejG_1zq7GSb6GOaAcLezoD7U
Message-ID: <CABFUUZEKS9P8=hsboyBj_f_9W8ycZHVG3GwqmtcnUoiRgh8iVw@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Run generic devmap egress prog on private skb
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	bpf@vger.kernel.org, Menglong Dong <menglong.dong@linux.dev>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:toke@redhat.com,m:bpf@vger.kernel.org,m:menglong.dong@linux.dev,m:emil@etsalapatis.com,m:jiayuan.chen@linux.dev,m:ast@kernel.org,m:daniel@iogearbox.net,m:davem@davemloft.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:liuhangbin@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297875-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,linux.dev,etsalapatis.com,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2F0EE66D9DB

On Wed, Jun 10, 2026 at 10:50=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 10 Jun 2026 12:52:21 +0200 Toke H=C3=B8iland-J=C3=B8rgensen wrote=
:
> > > @@ -700,12 +700,22 @@ int dev_map_enqueue_multi(struct xdp_frame *xdp=
f, struct net_device *dev_rx,
> > >  int dev_map_generic_redirect(struct bpf_dtab_netdev *dst, struct sk_=
buff *skb,
> > >                          const struct bpf_prog *xdp_prog)
> > >  {
> > > +   struct sk_buff *nskb;
> >
> > nit: this definition could go inside the if statement block below, to
> > make it obvious that nskb is not used outside that branch.
>
> Or maybe move the copy inside dev_map_bpf_prog_run_skb() since it only
> has one caller and already checks if prog is NULL?

Hi Toke, Jakub, Jiayuan,

Thanks for the reviews and suggestions.

I'll prepare a v3 that splits the selftest into a separate patch, makes the
DEVMAP_HASH keys deterministic in the last-destination test, and fixes the
Fixes tag to point at the generic devmap egress-program support commit.

I'll also look at moving the private-copy step closer to
dev_map_bpf_prog_run_skb(), as Jakub suggested.

Thanks,
Sun Jian

