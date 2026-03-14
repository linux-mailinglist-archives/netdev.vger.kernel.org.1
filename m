Return-Path: <netdev+bounces-267871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLUHO4HjtWny6QAAu9opvQ
	(envelope-from <netdev+bounces-267871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 23:38:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 053D228F5AB
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 23:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2F9F930215DD
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 22:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29454345CCE;
	Sat, 14 Mar 2026 22:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GHTB6Bfy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3599288C39
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 22:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773527753; cv=pass; b=Q8dMUHtsS3grRiqxm4TehKRqd3NQ+u+OwCrkiqhmw2MgdGWQMFIzfDtyY24U0iJtHbupIlrSuN4nygCXNaYiL7AokoICl69m5yl/oh/3PmfflE86413JN4bvS4owTSY2BVzTeKDP8X1S7OgvKccNI/aqh/lGX6MLzSVz2PiTKrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773527753; c=relaxed/simple;
	bh=Za8UO+IC0do/au7jrArhBVr80dZ/Yly/j1QmwutH7Ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QTczB5HEBBH4Q0IQjRpt5xy3dMmI7gwyY6ZcZneahkyo+f7bM8qCnQi78+o3xHOli5I3RwD/n4AxX9vPjzl/rbYlJgrVLVdBY3jLzKRJLYoBcVsRbggdQTeuYyyuuIpj7TcPSCRIi97WpQ6GZ10WG0oAc+mjrieRYn7eO0YgiD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GHTB6Bfy; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-89a1347051aso47428926d6.2
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 15:35:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773527751; cv=none;
        d=google.com; s=arc-20240605;
        b=LswD/uVfOROi1PYh1af0f61rWi8JTHL7RFnAA0DiGrYhbcVQKVByn4wyX8JZyHIqZx
         DoMZJvfAyAFfINS100N0YkkOxlZdq9W3hsztZ+b0bxJc/cKevW6pOOGqB9R/AK4cPpcL
         ALCRoTm4WvmDUoKTaL70eNACuOdqjC8ex0oixAu0tcwV1YnfDX48NBXThVrzic6Hxp/u
         gYlP9DyxUnU/n+m0VpH1+eeeLBxY277twOTeVpm7bu2W5W3dIDglWLibEstcnW1tE1fd
         G8LQjQr0ofV7u9CHLM1bsx/TzJpmTK6bhMQLFNF3ihCc1/l7djVr0W9WJ2dnODChE6qO
         HfiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yXqYhBic5nT2eU25zDmpGTspWo4/dlIk2E5aJ+aumKo=;
        fh=B8u2z6J/pSJ+O6LOIvZpyg+VqB3EDY++fbXHwBA16Ks=;
        b=egNKZ0kw8Fw62KASmHuvvExFcF+ouMxyHrzfz5I1CVIoiU2QPy4Qd35cb5+yNu98Lc
         +ZZw6Hlqtvoh1vv2htoiVACsoFUYW9bDBQ5m1a0xiCmfDW9EumUH+FKjSUnuwtzuhTEL
         CiaIgElRLKe/FaO3s6cLtS1kRe80Ur7YfWLk3YXlnXTrUy5ujZxbGP47mIEHbFJP1cHK
         xWNqo0NZkqQp1XzsmamPHlGvGzBqdmA0yg/qPcsgexcQbE3KHLawaE0T5uBnARQwZ896
         FyMPjK+rmfZNCz0wb4rAr5FYtlWh+iQof3xs+OnrCihfT6ymjVnCLZzRMvFsZFQlqkg1
         IrTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773527751; x=1774132551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXqYhBic5nT2eU25zDmpGTspWo4/dlIk2E5aJ+aumKo=;
        b=GHTB6BfyacEg3YImejZosyH+u2yUjHNjsKz4IcbtFN0zlme4+WI+aeqws8TdcdwhAX
         pjCLMsh7aJxXieYJyMs3rSzDmpUONyhw8sfpGFOp8UOw31i6+/zdRJypEB6ETU4fHzkx
         MqYjv/zhtcNFMqAoFfpl00qHVaYKztgmepWGJS5HNtFf7r3C1gV5nqCty10+og8BCLxB
         PxQc4hviHBPSUFROS3r43QvTXuP9+wUwLJw7d/XngzmPkM5DXyp2aLs7vdG0N0Onl6VN
         frx65MpTTtz3Z/imopakdDZjajDr0ccQaUh8AJ6xGJ4LVVmxVHZ3dPtjrVqhDJ4cxilk
         LdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773527751; x=1774132551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yXqYhBic5nT2eU25zDmpGTspWo4/dlIk2E5aJ+aumKo=;
        b=rvr7Ouxbnu6Xxymx7WngtcpyjNLi4JLkxTmnXJUpNzh5yOixivE/fvq/HHuxad5AL1
         xZ5Dz1yE0EG3mFuErHpttSb7c6RLny05SBHOlJT37BKoDRPGiCp8ePsDw8jXUqNEGGKh
         uyIAVVw5poXkhnxwWG/jDQ7GowjtPKkDtdjXTwvVu32L+x8BVj2KiDFzy53VEJlkkG/A
         yQYF8cWAFgiZi/c9ljVDtCgRHhtPa/2n3BuNvFJz9lP25ahZTFzTKuE0cBTXOgWf2z+w
         TILlRC6eQAPfoxqG2kZmwWQlInaJYiAKPnSK99X0BAPkM+pvmLFKNZQwxHdt0ee18f0M
         SbSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz5kVhz0RyAEY0LQ8OJic3i0kLgkVuJ7gms0HVO49/CZ9hxGnQ3+lY/x9Ixs2KkY+0nNFvwy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFh4judISl8yYI8DMRCNXkn0G7kvJWDvVROm5qPzvz9gGksDQH
	re1KdiE8fR9mAqPy+jtiLztWwxWySMSjly2TnREFX4wHufq5V8yKCv2bpqNMOniAWX2FnWujJrv
	XSxLRcpvh5YRYl9xH5nTBB3W5ukliD1BVpHfgZx+y
X-Gm-Gg: ATEYQzxubbRKGNQ1/mjd3tXbtWB/1/66w3OsbbrUi/chLp51by/BprKoNxhwfJ2xJaT
	X6qGGiR9BLEMlnLzKlFEdQne2BF2ZsnvarGLwvAT3ABGGXj4nOk0NSCKJ+VE2Cmwv63KrKa4/gH
	L7msXLB7RupVJMI/dKsiCYoavCV6GOMGKpbdsGKBEcwd6NP/Pvrh4J0MnTD84xPQQtkW3gTTwaY
	4QHjaTnmdMeyGjk+eTvAGSduuMNwfwDPEUWIxZ29ruPyqENG3yeA52ookJHlaE8z55ossuC/JkF
	ZkLCCUGp
X-Received: by 2002:a05:622a:1455:b0:509:1c90:e192 with SMTP id
 d75a77b69052e-50957e277efmr107911551cf.66.1773527750237; Sat, 14 Mar 2026
 15:35:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260314180802.50222-1-edumazet@google.com> <20260314145202.778a8535@kernel.org>
 <CANn89iJ7JUgU64dmEYGvD5sWqpf-ssymNQ=2dZKOY2zPjtq0Aw@mail.gmail.com>
In-Reply-To: <CANn89iJ7JUgU64dmEYGvD5sWqpf-ssymNQ=2dZKOY2zPjtq0Aw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 14 Mar 2026 23:35:39 +0100
X-Gm-Features: AaiRm50t7jQAESZW_yC73uwcEcsMPQpuzGh3yrd0dFhCtJpbGGXbsJR9EdTHV68
Message-ID: <CANn89iJb0aF_4z5+AoL-zgbsr76W8QqPc1=tfW8Td8=6h890Uw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] tcp: add cwnd_event_tx_start to tcp_congestion_ops
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267871-lists,netdev=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[mail.gmail.com:server fail,sin.lore.kernel.org:server fail];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 053D228F5AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 11:27=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Sat, Mar 14, 2026 at 10:52=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> >
> > On Sat, 14 Mar 2026 18:08:02 +0000 Eric Dumazet wrote:
> > > (tcp_congestion_ops)->cwnd_event() is called very often, with
> > > @event oscillating between CA_EVENT_TX_START and other values.
> > >
> > > This is not branch prediction friendly.
> > >
> > > Provide a new cwnd_event_tx_start pointer dedicated for CA_EVENT_TX_S=
TART.
> > >
> > > Both BBR and CUBIC benefit from this change, since they only care
> > > about CA_EVENT_TX_START.
> >
> > BPF still not building :(
> >
> >   progs/tcp_ca_kfunc.c:121:33: error: use of undeclared identifier 'cwn=
d_event_tx_start'
> >     121 |         .cwnd_event_tx_start =3D (void *)cwnd_event_tx_start,
> >         |                                        ^~~~~~~~~~~~~~~~~~~
> >
> >
> > https://github.com/kernel-patches/bpf/actions/runs/23096281431/job/6708=
9276918
>
>
> make clean
> vng -bv CC=3Dclang >RES
> make headers ; make -j100 -C tools/testing/selftests/net ; make -j100
> -C tools/testing/selftests/bpf
>  make -j100 -C tools/testing/selftests/bpf
> make: Entering directory

It seems my config missed

CONFIG_NET_SCH_BPF=3Dy

