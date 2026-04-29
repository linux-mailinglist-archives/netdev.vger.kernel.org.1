Return-Path: <netdev+bounces-282152-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDl4B4BO8WlrfwEAu9opvQ
	(envelope-from <netdev+bounces-282152-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:19:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FA248DBB2
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 838B43020A75
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 00:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042098F7D;
	Wed, 29 Apr 2026 00:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QyMCMHCB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824BE40DFB6
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 00:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777421947; cv=pass; b=siaHbv4g4/nKoSTBHqv7UfKqQGLYG0tbmxY6eIY+gBKti/+4kwGJIKIjf19ERP1mf6X8Z+h6t48d1nkWbwp9WoCpR2H2MVV34XTv5SfiJuetVi04sAkerAP4CosaNK4gvD2n1vyFJOLWH+xvybipEDNkDU457Ofxh+1iBLJDkvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777421947; c=relaxed/simple;
	bh=XkKZ/mj1q7M/FfHOOe3zkERonyM+OzTdga0/2XDfTDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ghJMASiYYoGeMxP2wbgWLPB2aPHYSoa6Dz2McLBPADd3fvqJdTgJjnpvcAhwXd6z9mZGszSsiqHqXwsJ5HT35/3fsumsaAaIqoJ1YC5KWRft/KYxASTHI8UkpX1QRCWVVQ6eGJR294ANSwTzyTBTkhj8nnyqPaq+aDW4I49d7Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QyMCMHCB; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50fb4a7d704so69627241cf.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 17:19:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777421945; cv=none;
        d=google.com; s=arc-20240605;
        b=PocgQmoNhAWgL9Pk8ztHOfSo9APD2ZNapVz69JVhfwvK/rf2HPlY8iEPw/oiAF9+wM
         hfm+kng+Fm8oR0hiMPhX7RGkJgpp3w1E6NLdYbvNSbHyi9n4sGjxR09zXGYzFJunxWs0
         T1R3ft+Kmup/Sybx4Tg5Sm6gfTO9QvxQ2i8BfKl2TGYgYHmXWJTaP9fCOk+2VLokVcwr
         py8iCBbdt5tCfraeS6lw7j5rDe+Gmm/8tVfa9KWAS4ZR3mClx9p2WeE2EqTRkAlNHEjF
         7uJ7sYMGhGei5cZZM2r06OEJO0smm/1DLnC5GyGKYdzlw2E7kJDF+o1/DlkPHYCoZ3th
         IkoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XkKZ/mj1q7M/FfHOOe3zkERonyM+OzTdga0/2XDfTDQ=;
        fh=xSZtAxWLI3UrLNGAPx+48TwwOK8qn1XlkvC0q4LUiw4=;
        b=MQd7DAAhKOCdLs97eTBLy+IjXK/+F2sx/S/NFEFqZkhxSchs3qDS96qfCBcY8zWuC2
         JX9dlhKVA+Ps0S1O9zmI8ttdh3sH3kW2bb/3IOCLp8f47rF6pXb8bIa/B2djv8y+5z/v
         7WL7GYP/yoi7S/3p/vye/4oS1m+uFuqG/xSE9gsPJpizPAFFAixqCSt1gKmBmTKTwqzZ
         4sqJBG6c6SxuKhwzZqNfHt0aKtxQxQzL9ZyJ9jgtDydQrbFyrFJ/tito6RQICOHXMX0f
         xCTrQ36IuEg9u2Z+q7wonFd/PhaJ/OTGLmlE/Pp1QCFGahRnm074VQfbW14eo+PWdFds
         fbow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777421945; x=1778026745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkKZ/mj1q7M/FfHOOe3zkERonyM+OzTdga0/2XDfTDQ=;
        b=QyMCMHCBpOYwvihAOwbelbwAm+fZUNjI4MqEUjVcDct9+udJP4Lgv3DvkLv1f6WQsN
         yhifkBnqWzKGaLuMsZdmGoDg+8CI97eZLmTlC/xyWYbetMzGlADcL7lsSyeK3zbHQAnC
         vm7dqW7SlgIBoRd7/o9Ktft6ypGHJh0TmWi1LBeTEW/Pgn4SzpywfDwtrT5Zem4E+hzB
         IWd0h2wZnjgXry5sBgqBtmRRNOARxJ/hzEkT0TJ7hswwXPM1uZJccA3km4/sNhk7wbid
         nUzCN9JMRmGaMocV1mw6mAZ/7OWh/OK9u+VYokvclulqJEvmyBoK1KUMYGQ8jNUEdMax
         jhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777421945; x=1778026745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XkKZ/mj1q7M/FfHOOe3zkERonyM+OzTdga0/2XDfTDQ=;
        b=BiksArkUngIl0wIlkKBDAT2+l7GpMJWK3iSsTHyUzDjJGNz8TbV5r4DZ5aSneRZsFt
         nKbJxHI7dhFR3TeScuujZVKNcGmgLFb8eqSP6d/66JS0L3ZMr/QxIh7vYXwvP7d9/BNn
         umApj5MXEmjbADoxRIrlZvfSUaDwzqBQCJRSjJeYP1MDpNhsPcilud5rvDbCqLnlJguZ
         h9cDKPSOL8fjSFC2s6un/bY8FFw35j6XDNQC2CCPkdsCNWNFNFL7OkI2gcbNVkkNi5B2
         1VwmuqYS/ZixzFtYw/b8PtrRlFhKsGkMBfWz1rsD8HLdSMWGEnToWYfB+2vkll5kQl+T
         Vneg==
X-Forwarded-Encrypted: i=1; AFNElJ+fUPvFJ5Fyvnq2FmHQciS0XrSWYWrECU6cf15/iVbp7i9ztYZ+KBuKSQlULpI5d6e1i61E92s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS4r2tBlwk7f6YQ5tnotwR2X7/WNF1wxiHfBxvZN5qiMnkrWdi
	nixKIDmfuKrISmyxJLkmqSJ8cu+j//1IAWcScFWAtbU5iUjJHDtsCz1Z8E156Sln5a0UCpbrxiX
	w6elqBZSyEwbF1aBtwfS3biNoV1mxvedF/EJGXTGc
X-Gm-Gg: AeBDietMDKNCfVhJ1i+I0ZFB1GE1JE6ImcId0O3za9c0DhhHffy2fTtUNTJYd9YAE3T
	3X3lmWv6YpQ6yxn3f6WcLdNLtWBR2M04thbQZn2GkxZQRbbiFn5lg9IiDkvAcxwcf6AX99j/F7Y
	rCOdSL2ugLyeqHctSqhH/20EO5ySJsHc4M3uKyCxL6l2igESP2RAfJKf++rryvuwCbVs2iIsZOY
	y8q3FJh8GzpudaTkOFEVLWjRBd1cGFrfqm64W1ghTXSuQiOr/bwgjREEjUZR5YpmdnIpOw7uaHo
	1hsk8fElAdLfgHLWo2hUOdZlHwYsaMXqRJ/GpFyoitHgcdE5seZhKDfPgT018Lkneb1f2Mq+f4X
	WeZ+g7egM8w==
X-Received: by 2002:a05:622a:580a:b0:50d:9b07:9c2b with SMTP id
 d75a77b69052e-5100e1eee59mr69688891cf.56.1777421944944; Tue, 28 Apr 2026
 17:19:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428160445.1336649-2-horms@kernel.org> <20260429001407.3358732-1-kuniyu@google.com>
In-Reply-To: <20260429001407.3358732-1-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Apr 2026 17:18:52 -0700
X-Gm-Features: AVHnY4KKlkWec-HQGbs5cX-YKQvE3XbPshpjsA3kmqjAsw5YiRo6hWvPRLv_BxU
Message-ID: <CANn89i+hGOytai+vBqxLGWi2CyZiz+cQf+24E+6eWVz2qOZfWQ@mail.gmail.com>
Subject: Re: [PATCH net] bareudp: fix NULL pointer dereference in bareudp_fill_metadata_dst()
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: horms@kernel.org, andrew+netdev@lunn.ch, bestswngs@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, martin.varghese@nokia.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, willemb@google.com, xmei5@asu.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 60FA248DBB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282152-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,davemloft.net,nokia.com,vger.kernel.org,redhat.com,google.com,asu.edu];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]

On Tue, Apr 28, 2026 at 5:14=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> From: Simon Horman <horms@kernel.org>
> Date: Tue, 28 Apr 2026 17:04:46 +0100
> > From: 'Simon Horman' <horms@kernel.org>
> >
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > Full review at: https://sashiko.dev
> > ---
> > bareudp: fix NULL pointer dereference in bareudp_fill_metadata_dst()
> >
> > This commit fixes a NULL pointer dereference in bareudp_fill_metadata_d=
st()
> > by adding a check for the socket in the IPv6 path. If the device is dow=
n
> > and the socket is NULL, it now returns -ESHUTDOWN.
> >
> > > Add a NULL check returning -ESHUTDOWN, consistent with the xmit paths
> > > in the same driver.
> >
> > Does the IPv4 path also need to be updated to remain consistent?
>
> No, because udp_tunnel_dst_lookup() does not take struct
> sock while udp_tunnel6_dst_lookup() does.
>
> And all the other fast paths (bareudp_xmit_skb() and
> bareudp6_xmit_skb()) have NULL checks properly.
>
>
> >
> > While the IPv4 path lookup doesn't use the socket pointer directly, if =
the
> > socket is NULL (meaning the device is down), shouldn't the IPv4 path al=
so
> > return -ESHUTDOWN instead of successfully performing a route lookup?
> >
> > > diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
> > > index 0df3208783ad..da5866ba0699 100644
> > > --- a/drivers/net/bareudp.c
> > > +++ b/drivers/net/bareudp.c
> > > @@ -529,6 +529,9 @@ static int bareudp_fill_metadata_dst(struct net_d=
evice *dev,
> >
> > Is it possible for an IPv6 tunnel key to be incorrectly processed as IP=
v4
> > earlier in this function?
>
> I think this is orthogonal to this patch and can be a follow-up.
>
> I have a series to remove all synchronize_rcu() from all UDP tunnel
> users and udp_tunnel_sock_release(), but it conflict with this patch,
> so I hope this land net-next this Thursday :)

Same here hope for me!

Reviewed-by: Eric Dumazet <edumazet@google.com>

