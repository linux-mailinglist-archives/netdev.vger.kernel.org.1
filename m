Return-Path: <netdev+bounces-52994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638A98010BD
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9FE281B5E
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 17:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127E14D5B4;
	Fri,  1 Dec 2023 17:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="azipypqH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF96A103
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 09:10:02 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a0029289b1bso319907266b.1
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 09:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1701450601; x=1702055401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3zW7mG2APHlMn0V6o6nSB6zPP6gthz2hZJEIkh2JQ8=;
        b=azipypqHJwP9+l/NGQNNE7ZatJ5nFj/fVvQ/qWZLdy9MGUbQSMsQNca1T7/OngU48X
         VUgwUvESxcM18afEapKC/WKFV+c/AvO9U9oJDrP3wmOdk8zzDRedDUwJ8QZgfQX2h6Zj
         JTYastoeQlNtzOLBp39dBcRMTn/JocNAtC0OfcUimm635afDfpNQ96yXfNHZhSwXGcpH
         W6PosswVLcbfroHE4DGNTYWUKG10r1NfafpgTsLn8C1K2YyQrEiuWsDpUcuVjKcl33BJ
         tviuBUbQ0ETmu8D0KqVm8Zk2r2W1VXgYvuAxRlhogstF35GM+wiUyHjQ5WmWp0AKswTE
         rlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701450601; x=1702055401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3zW7mG2APHlMn0V6o6nSB6zPP6gthz2hZJEIkh2JQ8=;
        b=Z69fsadjU4B5gMRU47NBlHHngjJ6dmVd2rTOE+70Vt+2e9D5OYat7iwhcKUkxQi9Gm
         bBbGM2NpMLFq5+Iv0O+Au1YvIIQCqR8Mh8F+FeFYvM9jK3r/LCNeWCajUeYVZx6kO3L9
         zey5ZkgcKyLlrCzdsDkE2e1jnWuqnc/euanckoK0TYxoG3es4cMSaumous48fLgiWeZn
         KZvioWryDmq/T86fq9XtCRVrQE4qcWQ+uveoZyH3NhDwOsrhee/12b4mWEzTNEf9Ciwe
         SB1LWdD5OijSnmzve75Kc9aBWpupEfnSDs8LLvuyPVvjykkOneXG5+dcTyVBn3OJTS5d
         ezyw==
X-Gm-Message-State: AOJu0YwNZUnoPETD23m7vK6QYUhMDuxIX/TgFEr3zTD3dcO6mrKA6xL2
	5W5fUFLCkyb+9ttkBWpQGfAltxWzn0USIhV9JDEQDA==
X-Google-Smtp-Source: AGHT+IH4ncADHFyIn/OqBzHVQ/DOI9V6HAKg1NgLlTJq0oNS8mR9wtqEIUQxSmogb93qB7eVnNTo5G+gMKvTILVe9PI=
X-Received: by 2002:a17:906:3b17:b0:9e0:dcf:17d8 with SMTP id
 g23-20020a1709063b1700b009e00dcf17d8mr917922ejf.71.1701450601142; Fri, 01 Dec
 2023 09:10:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <92a355bd-7105-4a17-9543-ba2d8ae36a37@kernel.org>
 <21d05784-3cd7-4050-b66f-bad3eab73f4e@kernel.org> <7f48dc04-080d-f7e1-5e01-598a1ace2d37@iogearbox.net>
 <87fs0qj61x.fsf@toke.dk> <0b0c6538-92a5-3041-bc48-d7286f1b873b@gmail.com>
 <87plzsi5wj.fsf@toke.dk> <1ff5c528-79a8-fbb7-8083-668ca5086ecf@iogearbox.net>
 <871qc72vmh.fsf@toke.dk> <8677db3e-5662-7ebe-5af0-e5a3ca60587f@iogearbox.net>
In-Reply-To: <8677db3e-5662-7ebe-5af0-e5a3ca60587f@iogearbox.net>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 1 Dec 2023 11:09:50 -0600
Message-ID: <CAO3-PbptY8PvyVnAfM=n=T8ihivso-jD1iwyWO=8WVWyLFe81A@mail.gmail.com>
Subject: Re: Does skb_metadata_differs really need to stop GRO aggregation?
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Edward Cree <ecree.xilinx@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, kernel-team <kernel-team@cloudflare.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 10:32=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
>
> On 11/30/23 2:55 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > Daniel Borkmann <daniel@iogearbox.net> writes
> >> On 11/29/23 10:52 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >>> Edward Cree <ecree.xilinx@gmail.com> writes:
> >>>> On 28/11/2023 14:39, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >>>>> I'm not quite sure what should be the semantics of that, though. I.=
e.,
> >>>>> if you are trying to aggregate two packets that have the flag set, =
which
> >>>>> packet do you take the value from? What if only one packet has the =
flag
> >>
> >> It would probably make sense if both packets have it set.
> >
> > Right, so "aggregate only if both packets have the flag set, keeping th=
e
> > metadata area from the first packet", then?
>
> Yes, sgtm.
>

There is one flaw for TCP in current implementation (before adding the
flag), which we experienced earlier in production: when metadata
differs on TCP packets, it not only disables GRO, but also reorder all
PSH packets. This happens because when metadata differs, the new
packet will be linked as a different node on the GRO merge list, since
NAPI_GRO_CB->same_flow is set to 0 for all previous packets. However,
packets with flags like PSH will be immediately flushed to the upper
stack, while its predecessor packets might still be waiting on the
merge list. I think it might make sense to first delay metadata
comparison before skb_gro_receive, then add the flag to determine if
the difference really matters.

Yan

