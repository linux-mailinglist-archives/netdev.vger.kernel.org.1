Return-Path: <netdev+bounces-253374-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ya0qMKIpd2mwcwEAu9opvQ
	(envelope-from <netdev+bounces-253374-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 09:45:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B41785980
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 09:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C557B30036E1
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 08:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010033033E0;
	Mon, 26 Jan 2026 08:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2OuX6z5F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D70283C82
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769417119; cv=pass; b=JLixUqr+Iemyt1T1IEtLG8bEGT/DP0bZ8KpoKFGxQ17qXgFp+oS1a8488qrzwn2XC0/yHWRYozt4r2lzXh4Fn4GhU0nhboyylpjnGVwsgCz+wzNjKdeZQ2EBcGRtFI0Odzj49KU4E4jhtftm5R+sgoCa6bECxNkkf63e0Gt03ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769417119; c=relaxed/simple;
	bh=0nd8O42Nu4jiGXUt41S68Pskc2rrdvFEev6YaFN5ONU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dxXClU693F7mGpbuQjv+uZQxi8cg59bEPjsjUOnRKaLSxHVE59V+92HRNGKeiBkU+69ixJGq20hZsXMoInt/TV0qtJgyRi1xjz7u51c8hBHORivGFr8wFiyjTMyI7w4uBX1lnbc/mX78k5R7z31IDZr8WcQxX8HbTwYFrnBO3NY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2OuX6z5F; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5014e8a42aeso62620311cf.2
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 00:45:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769417117; cv=none;
        d=google.com; s=arc-20240605;
        b=aRtHf4s+cjCxhG7almXFHEkSYyzDOw/TNVp7qMjdmce95R9GlYT2znQ6MptYL5C8qq
         Q5HOtToThwLrz4UZPWrunnyKWqRkuBrNMCNTGXVR1xBi8ma/7ga2Ai93xi/2AmCbPAp2
         /hnek9bzZ8hD2eSGS5A8AmXPvMQbf5VzLSbRV6VubVLp4L5swEc32WhT9UTm9E66QT0L
         rtwzHijdTwNT6y1VArRCThtIuo347PNvzqB2DhC8Q+3No+ECy7E9I18IwxHyVbvdjBON
         0fhF5S7BdEtdTkRbGeDcTTlRGmiA/d3NPza5eDAUBoYSvM8vrEbPTSybHWwh0YLjOwQT
         kDFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pz9PLn3EM8HCuggmgbD6Xd3xGkDuk2JMgakavAN+iZg=;
        fh=nKQ5FAc8KcLf0c7QIoUuZCPg6pQ0c+FuT84SbHZvxLg=;
        b=L36HRJceTeDIxtVsgnr7GRenBjhJ9UcI/uXJrxk6ilLxFzgE/3bbEp4qKrM1fbCa1s
         8kGJumN/mk0ju0lhFSrlyKMqftgnDdEB4oSQf4hEU7sHlB1nXakuoQOtUP3/vEKMa9Bt
         Ky2epBfkpL6QdMbjoVSK+2EdlstzHoFDpfpslKOxXbrGoMo4zB6KbEDS4AOCvBSkE64k
         8jbOT+jerwrfaCQ2ftpjepdwR+7SBoF6aVf3FZMaKRYKMYh/Kh2uKMGppLNuoLQu61Ob
         tiHMfFDiek/+bpFQx98ajtTBlcrED/plvqoVO33nlG0C/C0S4lNbfoyjZi+QbXTKtL+E
         k5kA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769417117; x=1770021917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pz9PLn3EM8HCuggmgbD6Xd3xGkDuk2JMgakavAN+iZg=;
        b=2OuX6z5F9KN+uKXWFINySHb636fQQdKVD+mxuSI++P+/I3f71GRkgJuVnuyS2NzMYB
         03+E+yzc/c54PidIGW7Q3UhR02CE9pOdP6x/mlGCCIbbfj3zxBDey7zAN4hCq9r86wM/
         FC5WaPA5PzmuW+AHWGEuMQJ96UI0iSNHHhYee5X/0HYoZILCDvm8kQiLDQCcKYf2hVgW
         O5S9FPQqFNys7RB4+NfYMQ11tf7u16+B1/piSfgzwccMAAeI61Hc7+jrOwEh1UhxZ27v
         oFyPy91KQTALC3dlmHyPyswqI+q02u85OqGhelA1M69Zt/oboxeBKnPr4vV3YA0EwP6/
         bi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769417117; x=1770021917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pz9PLn3EM8HCuggmgbD6Xd3xGkDuk2JMgakavAN+iZg=;
        b=IrdTSf17h6/qNlD9i6ET6di4bEvuLF5mD+0IwDE4zdo4KOe06q9gXEBUuJkBUJ/TXk
         p6Qjfies2ZuC1g9yRXMj9N75j1dxnC7fCiuyozTOlTPZyeVote6D2CHEN4II1b6mHqDo
         HpUmApZZ0tvvmib7sEdNsuSCk1Rli9GN5h2rJqbGuDrN6t66dbVGGx0JGjppjGqYICSU
         ulJgl9mnUXqMzNdLElnORzCn6tEnLRYEgGQ0OwmtQ/1RbMqkhDq2u7lV5A1/2Q/HK4Lt
         2Jl3CsLf3v1PWByesICAbPX5kmlYPpaXhZsb5s82EGYKQW2OnHlrczY8eVK6QeTE/MdV
         GERg==
X-Forwarded-Encrypted: i=1; AJvYcCWu9djD1dyVsulaBQ2xFe4qaA0kxUtMWWHps1yGrmhT63gOuVDHiUadJdKSvyfhpu1C2Fw5GB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKrQDaFeNkgQVod2dHOmeHn43DeWtSRLWazVW5vEz+YLsChL26
	4Ve3Z/E9FjMRGp5jwsSs7Q+imGMZS6efeCXsIzaOC+Pi5sb7m4WtwpykCdsen+7R4gTLtSyCt1s
	dKO0A1OIC5RgZAP1eMckGNbJkpNm0PALRGrkqvSyl
X-Gm-Gg: AZuq6aLJbkuMOuRGOWsXFmUvGzN5H+4+1Cg4mKr5DBymmqUwjDsYjwxO+Qn2lSPmiL9
	p7qSz1RVb7AHagekSBPiHvg243wcKNhxhe7QWV3qDk5weTjY07qN7BJO5hwOXXDVw3votx6w5qZ
	kyDSt39KZkJ1wxURHc74hUDQkLuBw086xB7XEap1n/HxISJugnpoy1qwkKBn7sasY/F17iiRSim
	RhW4+ZOdu5XtBZK6id5mI/JzA4TxXlV51yYioA7G/M+tz3cC+0XyDyKonqn/mDgj/kykhPG
X-Received: by 2002:ac8:5d8a:0:b0:501:492f:bddb with SMTP id
 d75a77b69052e-50314bd0469mr39565201cf.28.1769417117031; Mon, 26 Jan 2026
 00:45:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123111605.4089200-1-edumazet@google.com> <CADVnQyktV_z9=SoT7yhkT6mBQKRjaJgpwLhR2SdWGQS3iKD3Tw@mail.gmail.com>
 <ebb3a731-a3ec-444e-8efe-aa13cb76adad@redhat.com>
In-Reply-To: <ebb3a731-a3ec-444e-8efe-aa13cb76adad@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 Jan 2026 09:45:06 +0100
X-Gm-Features: AZwV_Qhn33D2HYPmhBUdL31qtNhOBEwyouCbyvmnw3vXQ5JmAfpUKZRpKkgSXec
Message-ID: <CANn89iL=a922QTQUwr5EK6XeL+gQu-zeqca1PYhs-NBu3aeyzg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: move sk_forced_mem_schedule() to tcp.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-253374-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1B41785980
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 9:18=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Hi Eric,
>
> On Fri, Jan 23, 2026 at 6:16=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> > TCP fast path can (auto)inline this helper, instead
>  of (auto)inling it from tcp_send_fin().
> >
> >> No change of overall code size, but tcp_sendmsg() is faster.
> >
> > $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> > add/remove: 0/0 grow/shrink: 1/1 up/down: 141/-140 (1)
> > Function                                     old     new   delta
> > tcp_stream_alloc_skb                         216     357    +141
> > tcp_send_fin                                 688     548    -140
> > Total: Before=3D22236729, After=3D22236730, chg +0.00%
> >
> > BTW, we might change tcp_send_fin() to use tcp_stream_alloc_skb().
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> I've a question out of sheer curiosity: are you using some specific tool
> to look for inline opportunity, or "just" careful code and/or objdump
> analysis?

I am studying performance profiles on a stress test using Google
production kernels,
on platforms that are a big chunk of the fleet.
These kernels are very close to upstream (at least for core and TCP
networking stacks), and use clang and FDO.

I am currently focusing on some functions that even FDO does not
inline, for some reasons.

Thanks !

