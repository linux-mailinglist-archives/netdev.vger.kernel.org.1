Return-Path: <netdev+bounces-307543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MMqZJDp2Vmp56AAAu9opvQ
	(envelope-from <netdev+bounces-307543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:47:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 355D6757996
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:47:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=NLC58upT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307543-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307543-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACEFB314E0C6
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 17:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C8C4156D5;
	Tue, 14 Jul 2026 17:44:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05583909B9
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 17:44:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051052; cv=pass; b=qIrOvcbq4dgQ5I9TTqdhhyFVlVFY9RhPsKvjLqpQF+t7m5xxM2+zn3u++D4DOhx53YPZdBcEkuV0b2XUN+mxfcywcQkL/W4aE5AyDjjrRwRSCDPHdbT8gtw/Wvaky95jM7Oq4IwRzWYG7eeU85HxaR6NgO7beLGXqYp/4igJd38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051052; c=relaxed/simple;
	bh=JDuTfhJTWstpJvfRy/NTAtn6+ConTe3zcMRhSX3H1kY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CaOBT4LJJ8xJphLAL7aksIHZIDsCXdK1dRYTqBPA5YlRLRWICs7jI+Ze/VjKAOtUlNFPORBVAxWgXJMuQSSkWyUfnm5smVvDmEX7NaT/64MJ9TFdAlyfrjipx2T2EkCovQiKAlMX7QxIAi2cNDGU7ffL9+ecAiwGPLt75IdUj5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLC58upT; arc=pass smtp.client-ip=209.85.208.52
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-697cee2eb6dso1391912a12.0
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 10:44:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784051039; cv=none;
        d=google.com; s=arc-20260327;
        b=dNCbsiWsFi7YayONo0ArPAi/dTdnMkHMmMm2+PscWV5mZ/pXEJFapK6CFX9KoV98cu
         fxWavnQCLwURt1oaTNBoqmjlMLMqH1Y9fp9RcM8JeYXpgPsi7FCWkpkxa6DKnKui+P7W
         oRvZyA2njPIMxlqgCJCOQQQEcCad5F2L8lPJLJ6SfYcP2EqwBCm61WfYEGWfCMdL30u9
         I60yAjNIcqI980/RyFwFt4ZsRIM2cerKq5B8fwZaJpi9OUT/jE5XEnCX0rbtqE5fcMyx
         vw3LwqbL1viQw1w03imqjsDeVhLOxcgvvmB9fA7ndS/d/EKIZ4hxegpvJIXL1etlSXFn
         WGhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zmM3GtgNw27l1Tq0fmnNqzL+GRDJtL7rqIl7qgYTkHE=;
        fh=7vMLJMeHk2Ud5AWOyNHhspgPwF8221eOByoqAyUFh8A=;
        b=ilopfU7ze7bo6KDVaQvdxzEWCzXIRl2vPYpvH1mj9C1OkdiFmXuiY6GpCgWRT7RkWF
         PEXhL1zbaKxKJaDUOb3iK+/OU3s/MlQSMkIiYF01zZsy37aZtU55YpVqea7AcshymBVt
         AVGMu9Y2snCqvuXGJ9LfxG1Vx4tUomD07gWqtVYzdhIMjE0PPZDw/0XL3aCPLQkRB0qa
         ziO55nso5K8txKpjbK2G/dLLqNDsbwhol0gNYZlbzZXypMWd583Qd/tbMax7iVl1GYUE
         CP4rNlFHHi/UGglWCHUN3akaDlqkBiLgCKFc0zZ+wuQ/6LdCG67HCi3wiGJSdAph3H/e
         kP2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784051039; x=1784655839; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zmM3GtgNw27l1Tq0fmnNqzL+GRDJtL7rqIl7qgYTkHE=;
        b=NLC58upTQMuiESgjhiWEY3Az5lgSX08qYzabWHB7awqhuSW04/dGmIW8HdWJVEKcOb
         CnAUAP5JD6wG7m96S/nOAv43tK7vD4dfe3jFv6tw/l8argjFWI3bNsPSpblkKtC2riKc
         Vl4m9EUgk70RTKgFYbCBhAGUrD+UA4W1CNXtj1+jVmMkk+SyNGDCnTCRIzm1FhH97eyZ
         UUrpfpEPleRCdgRMZBYMsThGn3cbNz7OOK5+xP/E3e/PJWGFa9UF3CpgCWm6G3i7nSTS
         LbiY0c57Moqa4M7pAZJEBzoADcv3bywvm3l9ivgwa93XroGEIds9EKzUafm9Vfwp+6w/
         3i2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784051039; x=1784655839;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zmM3GtgNw27l1Tq0fmnNqzL+GRDJtL7rqIl7qgYTkHE=;
        b=sqUuinOCe0ooYfi/ArTO4peG/2/YEgbz6lw9ommgGjtvnCZ629ZxNhMVE8L4Z57CXk
         2IWJqKJa5nhGq+ZtP+ADc9kSnJ6EB9jdR3anzSISfZcbnbk3IUz8xL/8Rzdn1Z8Z1Rff
         i480r+uLUujY6mUvrdYvlnVmxgC4DlfT8VRlWSNEjaydmiResDPw0iVSYLICvZCvqZm1
         v4xPmKxFwTnepj7nw7hDeuFALOMYLDtA+OkijAHf2GXmX4G39PtC2AxCCXriDha5p5iu
         2sMf4lQvL5fsLH/dzDBNTuQWaFVeoORJuveCnyjbjQNFYyGdMmdkFiGN23FSUsK2l63p
         4GiA==
X-Forwarded-Encrypted: i=1; AHgh+RqVnqeMPzOGojMAs/DAxX662hJkT7XkRS7Y6er8RnbCbVbyoXcRf9Vh/+13VVzSfoVQDMi5N2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLyKp3+uv7qdAwZNMNGraKTLkCvNjhHuLbf6T8OnbH1yQNPoba
	nT0zS+S6g9jLHdk9yZeQpNRXCeFUhWYc751hNaXhj8OkdPXZL0mD3ZgWh63QaqyLbegxr0HatQb
	7HSPvv+dJMeICE3ISor+wRGqG6/EommE=
X-Gm-Gg: AfdE7cl95Ohg93r+tuDgnDPk+ZDygZFrvjAyufa6tRT+O4eu7AiQaQCnZrNcV+I1tub
	skIOqhNkGaW41wQJX1rhZBEm2WR24sUJAhXcrQk+XS1WGwz+1MDTAQfYnXn/7BYsbfjwsJRdTbP
	6NCD+KDh2CB0EKXdODlcu0EY3vQfpUjMp3zZ8Wf9m9aV9g5JlHor7QlpWYbrKB2E9RnUvDtMKER
	NemBye5RmNPc/ymfOmAG/epRiOIZj2Whz3BBiHn+E8M3yJby6Qu0J4wxhwUVjjzKRec9JfbHNGU
	dnK6HVnlM8qTHVXkm2cWEZSHhDxf
X-Received: by 2002:a17:907:6e86:b0:c0e:4017:6471 with SMTP id
 a640c23a62f3a-c161e86871cmr681203966b.16.1784051038882; Tue, 14 Jul 2026
 10:43:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706163024.1205930-2-bestswngs@gmail.com> <20260713134610.1779498-1-horms@kernel.org>
In-Reply-To: <20260713134610.1779498-1-horms@kernel.org>
From: Weiming Shi <bestswngs@gmail.com>
Date: Wed, 15 Jul 2026 01:43:21 +0800
X-Gm-Features: AUfX_myVDAgOYXdE7b544NcnLD48aV5KTXGXCZVfOr8LYmN7iu9JiFYjOoQPhlg
Message-ID: <CANgPUi1G441VV3G-gHy0Ng8Q9A43rTXLAUnTU7OyRgCZJSicpA@mail.gmail.com>
Subject: Re: [PATCH net v2] tipc: fix NULL deref in tipc_named_node_up() on
 empty publication list
To: Simon Horman <horms@kernel.org>
Cc: jmaloy@redhat.com, netdev@vger.kernel.org, 
	tipc-discussion@lists.sourceforge.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	hoang.h.le@dektech.com.au, xmei5@asu.edu, linux-kernel@vger.kernel.org, 
	tung.quang.nguyen@est.tech
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:jmaloy@redhat.com,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:hoang.h.le@dektech.com.au,m:xmei5@asu.edu,m:linux-kernel@vger.kernel.org,m:tung.quang.nguyen@est.tech,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307543-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 355D6757996

Simon Horman <horms@kernel.org> =E4=BA=8E2026=E5=B9=B47=E6=9C=8813=E6=97=A5=
=E5=91=A8=E4=B8=80 21:46=E5=86=99=E9=81=93=EF=BC=9A
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> tipc: fix NULL deref in tipc_named_node_up() on empty publication list
>
> This commit fixes a NULL pointer dereference in tipc_named_node_up() that
> occurs when the cluster_scope publication list is empty. The fix introduc=
es
> an early return to avoid calling named_distribute() with an empty list.
>
> > diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
> > index ba4f4906e13b7..60ccaa862162c 100644
> > --- a/net/tipc/name_distr.c
> > +++ b/net/tipc/name_distr.c
> > @@ -218,6 +218,10 @@ void tipc_named_node_up(struct net *net, u32 dnode=
, u16 capabilities)
> >       spin_unlock_bh(&tn->nametbl_lock);
> >
> >       read_lock_bh(&nt->cluster_scope_lock);
> > +     if (list_empty(&nt->cluster_scope)) {
> > +             read_unlock_bh(&nt->cluster_scope_lock);
> > +             return;
> > +     }
>
> [Severity: Critical]
> Does this early return prevent the transmission of the last_bulk
> synchronization message to the peer node?
>
> In tipc_named_dequeue(), the peer node sets *open =3D true only when rece=
iving
> a message where msg_is_last_bulk(hdr) is true:
>
> net/tipc/name_distr.c:tipc_named_dequeue() {
>         ...
>         if (*open && (*rcv_nxt =3D=3D seqno)) {
>                 (*rcv_nxt)++;
>                 __skb_unlink(skb, namedq);
>                 ...
>                 return skb;
>         }
>         ...
> }
>
> If *open is false, all subsequent non-bulk name publications will fail th=
is
> sequence check and remain in the namedq indefinitely.
>
> Without sending the last_bulk message, could this cause a permanent stall
> of name table updates and an unbounded memory leak of socket buffers on t=
he
> peer node?
>
> >       named_distribute(net, &head, dnode, &nt->cluster_scope, seqno);
>
> [Severity: High]
> This isn't a bug introduced by this patch, but looking at named_distribut=
e()
> called here, what happens if buffer allocation fails during the loop?
>
> Inside named_distribute():
>
> net/tipc/name_distr.c:named_distribute() {
>         ...
>         if (!skb) {
>                 skb =3D named_prepare_buf(net, PUBLICATION, msg_rem, dnod=
e);
>                 if (!skb) {
>                         pr_warn("Bulk publication failure\n");
>                         return;
>                 }
>         ...
> }
>
> If the function returns early due to allocation failure, the messages
> already added to the queue are transmitted by tipc_node_xmit(), but none
> of them will have the last_bulk flag set since that happens at the very e=
nd
> of the function.
>
> Could this also prevent the receiving node from transitioning its named_o=
pen
> state to true, leading to the exact same permanent stall and memory leak =
of
> subsequent normal name publications?
>
> >       tipc_node_xmit(net, &head, dnode, 0);
> >       read_unlock_bh(&nt->cluster_scope_lock);
> --
> pw-bot: changes-requested


Hi ,
Thank you for the review and feedback. v3 sent.

