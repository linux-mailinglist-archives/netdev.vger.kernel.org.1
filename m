Return-Path: <netdev+bounces-256510-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKy9KPingmk2XgMAu9opvQ
	(envelope-from <netdev+bounces-256510-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 02:59:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 440ECE0A36
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 02:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66C5D3093957
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 01:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFA728D8FD;
	Wed,  4 Feb 2026 01:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXXDYjZP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CDF274B58
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 01:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770170232; cv=pass; b=EUVlOFXbzGSgIeopHWfgh4H/tNKlMiThqPszfP7JGbJzUZ/XDqy5A0cl99VKW0UbL0cChr7g+w/gSf4ryhGKQ2UXcTKkA9ktLlNtkDF4EC/z/+T7/HK243UMyBpSIZnUZJ/SPAw3QBZL7rK3aLO/SeFT5kgvLDalwzf+YU9P3HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770170232; c=relaxed/simple;
	bh=CS6Hdnn4FB231aPDfUFWzHDPplaGR1hHA8PrYCJG8tY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=esPH3SRkSeDa6DUswn7GAGy95h7iaoccRP/elvxJatAgKhrk2Ek1Z+KHeHiyM5JS1cplsGnVqRkjVaZf3nusUWmz7Rc9WghiKqe3H348znkVGSaRdrLbDeSLD+aHLIco7a2fe0W2GoReeTZ5TWqZEwJLhE2RAE3VE9mlJUDRG2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXXDYjZP; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7948e902fadso2375647b3.1
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 17:57:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770170229; cv=none;
        d=google.com; s=arc-20240605;
        b=WPY1fQXw1m8rl4NydqPSI/dep5A+O2lsTsd+IlVD7z8Y1ZberYd4T5IGYljRqtnv7A
         6GZCUtdWQ5nZyX31YSbcAT4r4jfxoM1z9ZfOAikAUyXtssUndcoCBh6+6DSkh6nWNkot
         acydfKlKH/VMs/KVq+HChRHzE5+Q7ppSdAQBlSiqYr8mompcJqYRrFERmSOG5T6h06cu
         edA0rsK4cZIgZ0P7nwNNa+8faMAD/RGOaTwBiwTMPvhx9WAf6q/mAAgZfoeL+ZnPwPEj
         nysnXhm3AA5NQVc+9id1s10jnNBgzZ/56Y4e08nKPRrpErZ5zW9Y1j8lxVLNckbUHorC
         NKBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JxZQXId/A+aMKZYLsP/G5fTLN63HSRpBMmCY9kYwWYM=;
        fh=0MG9rI8MASxoM8KshU1jAgvgC7rqp7/Xv6hfvXhon4Y=;
        b=a933k7kN59fN7//0hO0cwE46CIYXSxydPRBqQ6qcei/vL38jMxS/nqoGOJtyKN8bbh
         R4tqf9/R6JReGw4jhJkpvRCuJpRVHLbJAJijSthg2hqOGKvv+VdYNpDsboBAYo37lOFi
         J37dKwIxjUEqlDTaYvWbOQB8OnMqexeUnCf2egG2+funTvXXFMOR2taNPUilFtXB6Cj1
         YnHTZR6JDzFhNeKAbf8nmDG1X7JP4CM9OqzCGnsu6VF2Sb55smpeGKa0JvmksEE5doMq
         vfk47e56TVYYpb1llK0m5S0+9RDfb2p2tL+EylzbalD8SSBRo3XRiRPrLTepl/kronzQ
         KGig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770170229; x=1770775029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxZQXId/A+aMKZYLsP/G5fTLN63HSRpBMmCY9kYwWYM=;
        b=YXXDYjZPqLUyLDNo/nzfvOKrMdernxlCKDOENBggBt27s57fJPKXtcZwTaq02VL9IR
         ny3JseJQg0dgsirTTE4p67LeCmIDEopLS6FudX6pBZ6NFz742n1lp9v2L98RD2dYF94R
         CRDCBTYtCVUR83LK/P4MDCFvK3GMQmQP8Tv0cXmLfJ7zG2CttxgrwTKtMo6c8uq4kl26
         c4mNveAxsHHXsWCZ1ABRaD35zOHyJTf7+EobYIYYNGQoVEFIJVahd44LaM9xM33zoLCg
         y/SQZmQOK6ILeKTMCYq5t3NYMdPUpfUg4G4Kvq5dNhpQGUpWPLu50uHEPa5MxrZh+Bev
         CfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770170229; x=1770775029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JxZQXId/A+aMKZYLsP/G5fTLN63HSRpBMmCY9kYwWYM=;
        b=L01VmigIEjQ/T5hJ3nKasb2RjjK8BaeKIOrfzSvGA3EiOqvZt149Gh2EM/dKPJ2eHP
         qEztxWG5SHa+tHshWEmElhjppbMKp+SeT8sXCT1NJG1Wg1myYSKCwljZVy2vNBs6kL6I
         QALt39H0S5LU4BFuLokk0am1eFp9Fo+/fuerCtkWwDx78UHywTjfE2Gla2N9Ag3v33qN
         6ngWu1SpddxG149+AYpyfLWvVXuqifKHbEV0FVpQe1iWr5m22nE1+gpT2jL2MvAAnOaG
         IlrsrC0NVgOf63laP+tEa7vaSd3nCpx1FWXy9cMSN9Zmf5/dBYhHnB2K4M7B3CgLnTjO
         9RWw==
X-Forwarded-Encrypted: i=1; AJvYcCVV3MIvnjCklX5LsqPMi16zh5uIL3XaCT3VsKbJZWecoRmuVCYniWtNaDy4dsIh2eRmCvdWDac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9t7FNPb9fR248rl0OhHxfjtdopg8gDao/SOVyY5kUdCDYDbFf
	ExMQ6L96hTpOGQhpt5FPPLCcbkJoABGXylYcSTd2tLR0HphvdCjV+GCzkcQMQbkw72wa+fC8nw6
	GGaRt0DbnJ9BSu02OpgxD90G4vCEpOwY=
X-Gm-Gg: AZuq6aIpzf1CTg5wiMaoiVV655+jMIPWwZmSk1WC5wCSXuOSnZTExYDRVWJZr6eJogA
	c7yJ4JRm3UmzSn5HC9MkaHYtzobT9LsiqE1gXoUNNkiQ4wfHzIkEk4n9gm8+eUE8xZ4ooYyAkGd
	BizuZukAswtrfUsC9q1xkQdCy+yqP0m47t9IhOXY19c/OwfalgoQOUjKhndUBosftelQqLdthfM
	P4PH0S7QqIiB42vkZRAtbTBdRkhkS1Y8TLOD2n1F/R3W4YkqnBkdznBSHTg23zwLj6q1Q==
X-Received: by 2002:a53:ebc1:0:b0:644:4a82:304d with SMTP id
 956f58d0204a3-649db4b4750mr1206240d50.82.1770170228855; Tue, 03 Feb 2026
 17:57:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203080109.2682183-1-sun.jian.kdev@gmail.com>
 <20260203145511.164485-1-sun.jian.kdev@gmail.com> <aYIOXk55_DRFKCqo@strlen.de>
 <CABFUUZG9LnhXc+nsQA28WHiiT33_5wQ82E1bBSBncWkxkXaKZA@mail.gmail.com> <aYIpcHBufnxrcv5O@strlen.de>
In-Reply-To: <aYIpcHBufnxrcv5O@strlen.de>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Wed, 4 Feb 2026 09:56:59 +0800
X-Gm-Features: AZwV_Qhg067b7BCygExtNCz8lq6mAu4s4-ST68gEvIKgghXpBpcNF7HhnXs8ecM
Message-ID: <CABFUUZELXbEKyjMxOBfoL246dmtBSS_oe0zeWwnkmrXXpyv3Yg@mail.gmail.com>
Subject: Re: [PATCH v2] netfilter: amanda: fix RCU pointer typing for nf_nat_amanda_hook
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>, Simon Horman <horms@kernel.org>, 
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-256510-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,strlen.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 440ECE0A36
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 12:59=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> sun jian <sun.jian.kdev@gmail.com> wrote:
> > > Sun Jian <sun.jian.kdev@gmail.com> wrote:
> > > >  enum amanda_strings {
> > > > @@ -98,7 +98,12 @@ static int amanda_help(struct sk_buff *skb,
> > > >       u_int16_t len;
> > > >       __be16 port;
> > > >       int ret =3D NF_ACCEPT;
> > > > -     typeof(nf_nat_amanda_hook) nf_nat_amanda;
> > > > +     unsigned int (*nf_nat_amanda)(struct sk_buff *skb,
> > > > +                                   enum ip_conntrack_info ctinfo,
> > > > +                                   unsigned int protoff,
> > > > +                                   unsigned int matchoff,
> > > > +                                   unsigned int matchlen,
> > > > +                                   struct nf_conntrack_expect *exp=
);
> > >
> > > Why is that needed?
> > Correct. Manual declaration is indeed verbose.
> >
> > The reason I used it was that typeof(nf_nat_amanda_hook) carries over
> > the __rcu attribute to the local variable, which triggers a Sparse
> > warning when assigning the result of rcu_dereference().
>
> sparse doesn't generate such a warning for me.

I re-verified this with GCC 13.3.0 and Sparse v0.6.4-73-gfbdde312.
Even without LLVM=3D1, Sparse still reports the "different address spaces"
error for amanda on my machine:

net/netfilter/nf_conntrack_amanda.c:158:33: error: incompatible types
in comparison expression (different address spaces):
net/netfilter/nf_conntrack_amanda.c:158:33: unsigned int ( [noderef]
__rcu * )( ... ) net/netfilter/nf_conntrack_amanda.c:158:33: unsigned
int ( * )( ... )

It seems newer Sparse versions are more strict about RCU attributes on
function pointers.
To avoid manual declaration while stripping the __rcu attribute, I
will switch to:
typeof(*nf_nat_amanda_hook) *nf_nat_amanda;

>
> Also, this pattern you are changing here isn't specific to amanda, it
> exists elsewhere as well:
>
> net/netfilter/nf_conntrack_snmp.c:42:23: error: incompatible types in com=
parison expression (different address spaces):
> net/netfilter/nf_conntrack_tftp.c:78:31: error: incompatible types in com=
parison expression (different address spaces):
> net/netfilter/nf_conntrack_irc.c:242:38: error: incompatible types in com=
parison expression (different address spaces):
> net/netfilter/nf_conntrack_ftp.c:521:22: error: incompatible types in com=
parison expression (different address spaces):
>
> so why only fix this annotation for amanda?
Ack, I will prepare a V4 patch series to fix it for  amanda, snmp,
tftp, irc, and ftp together.

Regards,

Sun

