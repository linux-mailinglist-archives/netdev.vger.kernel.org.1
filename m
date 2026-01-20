Return-Path: <netdev+bounces-251557-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJ4ANYTNb2mgMQAAu9opvQ
	(envelope-from <netdev+bounces-251557-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:46:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F0549BF5
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 48D4776B918
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE4644B69B;
	Tue, 20 Jan 2026 16:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="37rFqslp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856802777FC
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 16:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768927113; cv=pass; b=iRmc+ZEYjWGDRnjklWL5TMBzwf3bmQCM6O2SoMu2XsGZKIAABvxjKWTqRxOXsK1khCAE+4e2CJgDsaHI8gGSCN4/y5Z57aAyaIMzZnDwnuwJx5OaiqQsNkDzMImK6oXcod7zY7T6SCbN6kpYU0nzt4lRer5lfhfN89LP7dHugR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768927113; c=relaxed/simple;
	bh=9P080f24t5ZtF1Umwv/OIBX+xNUA/VUVkCQvbqkf4FY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a044ozdVeyATTiFNISjgYj3etsekvPcUBhFOG4SwAx/Y4VZB8ALV6VfXehGCvYCI4OWObTcbR9xzOL/ZIOwBx78nVFqZ3zCjRxt6W+uN6C+BGRU8InRM1zYakimdVf3rzZ8IUkFsQr7mBMb5lRohGy06sp87CUnlQJk57RyO3sQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=37rFqslp; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7927b1620ddso162417b3.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 08:38:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768927110; cv=none;
        d=google.com; s=arc-20240605;
        b=Jxb5u/L9BMe/4kfsJeAeD8QUnCxikSv+Bx9zYgbmgKifaMkw43lj6MhWE4cTybEtn6
         Nr55VT+bk+Q5FHW+HAfzoTI04Ds2zJ26ggwHmP/iKHImKATwGo51hl9IvJLcgeOx00PX
         vZ0txNS4KX1l6nAvBuzc/9REMEh08Top6eTR1wZm0WevgWLnVeACY8EPMFhYfIH0Fxyq
         WpfHyl7BCRwQFgZEjSQNq9GlJgeS34d+2+wLRH91GmBfxjK6Pz721GBTANP5Wfd/Hokr
         Mjm2okFBjMc62jfSHqLIVE52ETWSgf4eVS1+mTCT5vA2/sMyG1qdPv+5vxRkXAg+INs9
         7daw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1WTGG2ytHaY23kSUxsu1UAySzMOYsXMBO8CWz9PWhsI=;
        fh=iX7uFn3OVQnyKu9yWVVc9DMdvy+lry2yudm3R78UdsY=;
        b=kbRef6Zs3HJIYW6gpGaPl7uK5mvrM9gzI4ZbaQ+lrFRg4jfMW3dreVjIF9XTHZCRhS
         eoWNihvuCSPdnB5jjYBF33RMn9bRSJP2h33fwjpBAVeu8Gc7g2uwitlfdNA2xLikcPwZ
         jr+NZ8rtAdXkM5C3uc0B/YIJJVvLG/W/Z24oyj6F9cXr9+8lPiwykibFyZ+nelcE4t3C
         ht9BOHydTBhlyl9J1mnQ34EB9h4A0YnfydHB1vEToMQ0UFPz54fyP7UwUC8WIFW3MJ/Y
         VZOxl2yNp6w/y2Drw92BbfoJoklICtNv2Y+M+vSN1MI3xvem+d4yHdPZxtC/aG+dwVTo
         9HCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768927110; x=1769531910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WTGG2ytHaY23kSUxsu1UAySzMOYsXMBO8CWz9PWhsI=;
        b=37rFqslp26V5ypKp6lxyLMQWajX5j3WJToHs8Ka1TshCFokUgOgvc6T+G/Ag634Wc+
         mkcEO8YWNqeUn4S/gKXfEXexoJ0NWdqd0lUx1P6dRqiwkVSV1NrGRBNFP0PRp5ZPCmx7
         YuUM2QUqKy7RgZf88+sstUeaCiux82d6HNA/vb95h7cXOIlE3v+iHjbBuf8jHLDNntFk
         t949D1shNkVdj9JZsAvAbLwuXmBO99ViMgEn96OiPdRso4a9yGGlKyrqwK2APtsCOirh
         uXjVwHinR9DtRV+89xrUzfQCk6S9Nq6MYg69Os47p+DS/4cexBYhxfUUoVgFU9u7izp/
         FLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768927110; x=1769531910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1WTGG2ytHaY23kSUxsu1UAySzMOYsXMBO8CWz9PWhsI=;
        b=JV/qFib5NH8yBvkY20Q4mr2In7rNT+fJd8PoQAtMdfRL6KqOviU+TS9R/utEro7IX0
         tQ8D1nOuDpv1cNzRPL11EBtq5a/K0EDkS40bUtX5CWt/Nb1uECe64VAbMNVIer3xxP6q
         4ERqMzk+A86z9LhyXW/V20oR/BPKiTkR60B9W5bBgq7lnfcg/i8LZLP3gHv4ORtI1Bz1
         d2XgcbJCkwzhGTzbrXgZBi6UUkcRqu5c5xTf7r+b+b4CqetPSa/nJHqujVExD75wR/7Z
         2eLpmu/P+8ZthmhwYygytsWdxvcAoUk014+uPQGVkRE94XIjc39uvgqWTWZNLQ9RB1V+
         JHkA==
X-Forwarded-Encrypted: i=1; AJvYcCVjNuwlj913lFN5W4o8Fco5hh142O9GhT6tJDIk/SurAcI2IgsI1xMGiX5yw3IlTuUPDoQ/Fn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIzVINrAUhOdkcxysCAGuuaoAEJxkqnXnH4U6JC5Mq/fuvFtuH
	SE7+sHdmtfg9KYiXGtj2CWNnRnNUUyROvX39Xnb48Q2jFmld1JuDecOkooyOLqyuKcXw38yrvPs
	DYoYnWNyB/qpFsb+p8pkTstGeOadXiyB6tYG4SbXp
X-Gm-Gg: AZuq6aJlu0LPGN8mO2Op8vS7z+KxsjZDZ6Sg6RXZT8hTEfEs+Z6OZnOQxoN3Xoi1Y6E
	IgI4f92MAJZz2inkm23BuucFJUz/TxuL302wxfHJ236Zx+Ewg9oLElRIQRte1i0OMvcQWP7iEZF
	ZltfwdViskJlb9WkMMrURmRhXrw7LIpDqnYIPY3sgL8/o1PLg6RNh5EWbm0erGE13Xshv7/3h5k
	3fTfocnNosmI9uXgH0JbrKMTcJEwHjeQdtJsc/DD4dA0VYaK+HtdirBqUpi8kuSWa7Hhr3+
X-Received: by 2002:a05:690c:6e88:b0:787:a126:5619 with SMTP id
 00721157ae682-793b321c097mr147961457b3.11.1768927109995; Tue, 20 Jan 2026
 08:38:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118175215.2871535-1-edumazet@google.com> <20260120073057.5ef3a5e1@kernel.org>
 <CANn89iL-w7ES=OsNQhLTZjxVdfOJxU2s7wRXJF6HkKSAZM2FBg@mail.gmail.com>
 <CANn89iJUh-3xDWkXhNatmBj2tWd1dLHXLbE6YT9EA2Lmb_yCLQ@mail.gmail.com> <20260120082942.3c62738b@kernel.org>
In-Reply-To: <20260120082942.3c62738b@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 17:38:18 +0100
X-Gm-Features: AZwV_QhLxX9RoidDYE7G7QuKfaTGa4FmCz-uSD2gHY76CilqyWGZAQAuif9xsck
Message-ID: <CANn89iKEJrHZ2cHzkqKXz0ibCusUUcxATJz7H_WH=HptfVQ=6A@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 0/3] gro: inline tcp6_gro_{receive,complete}
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251557-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 88F0549BF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 5:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 20 Jan 2026 16:44:52 +0100 Eric Dumazet wrote:
> > On Tue, Jan 20, 2026 at 4:41=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > > > Still not good?
> > > >
> > > > net/ipv6/udp_offload.c:136:17: error: static declaration of =E2=80=
=98udp6_gro_receive=E2=80=99 follows non-static declaration
> > > >   136 | struct sk_buff *udp6_gro_receive(struct list_head *head, st=
ruct sk_buff *skb)
> > > >       |                 ^~~~~~~~~~~~~~~~
> > > > In file included from net/ipv6/udp_offload.c:16:
> > > > ./include/net/gro.h:408:17: note: previous declaration of =E2=80=98=
udp6_gro_receive=E2=80=99 with type =E2=80=98struct sk_buff *(struct list_h=
ead *, struct sk_buff *)=E2=80=99
> > > >   408 | struct sk_buff *udp6_gro_receive(struct list_head *, struct=
 sk_buff *);
> > > >       |                 ^~~~~~~~~~~~~~~~
> > > > net/ipv6/udp_offload.c:168:29: error: static declaration of =E2=80=
=98udp6_gro_complete=E2=80=99 follows non-static declaration
> > > >   168 | INDIRECT_CALLABLE_SCOPE int udp6_gro_complete(struct sk_buf=
f *skb, int nhoff)
> > > >       |                             ^~~~~~~~~~~~~~~~~
> > > > ./include/net/gro.h:409:5: note: previous declaration of =E2=80=98u=
dp6_gro_complete=E2=80=99 with type =E2=80=98int(struct sk_buff *, int)=E2=
=80=99
> > > >   409 | int udp6_gro_complete(struct sk_buff *, int);
> > > >       |     ^~~~~~~~~~~~~~~~~
> > >
> > > Oh well, I thought I tested this stuff.
> >
> > Interesting... clang (our default compiler for kernel) does not complai=
n at all.
>
> Well, at least I _think_ it's this series, haven't tested.
> It breaks in the kselftests, no allmodconfig, here's the full config:
>
> https://netdev-ctrl.bots.linux.dev/logs/vmksft/packetdrill-dbg/results/48=
2021/config
>
> Also possible that it's a silent conflict with another pending series.

To clarify : clang does not see an error, gcc does.

I removed the INDIRECT_CALLABLE_SCOPE from both functions for v3.

Thanks.

