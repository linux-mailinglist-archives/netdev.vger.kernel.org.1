Return-Path: <netdev+bounces-279917-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yK9ZBr+C5mkIxgEAu9opvQ
	(envelope-from <netdev+bounces-279917-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:47:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B58C74336E5
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84C2A3024479
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CB03CA4B4;
	Mon, 20 Apr 2026 19:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoRkQ2h3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535513B0AFB
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 19:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776714292; cv=pass; b=l7EzELqcohlzXmUsaf6AVwFCu8wsKhtfinv47doqY7fzyuvX1IED9g1vyYCzCcorSwoccb9c2XjCVg5oFQnoxbng/CLiQkSKgtkma5xkcHqpyUWPwR7C+fZI3VYI+6iBTWQrVisnYxGkG7QPzY4XW8vDfDP2bNmz5RfErZ5LdVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776714292; c=relaxed/simple;
	bh=6jXgnYqFlngMwDcsFq8mpBHFUc04URMA1SiiHOhe8Ms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mbTpRhriiZJqPHLJRXLSsOre2QD5NvIWApVvNmWNx6a/+BysFAO6j2/Jm5ZV3ikYoeV3JjoCWobnHaGW6cl7hDDy1+syO2gvGiRLnEHEyXfA99fSkOpEERjhqTJNCNDafIUurUotJicTGdttFVHQwTYekG4fPuHT4nFaQjICXAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BoRkQ2h3; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-41c4d660b19so848936fac.1
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 12:44:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776714290; cv=none;
        d=google.com; s=arc-20240605;
        b=azITwnnf9AZW5LO5dsMhCHuOPxMKe09Oy0cWl2/uX6SD1or8Os2RrsaZqU2c/ukPON
         uBfVZADONItjuMn1WY5Zdw2uCMPSP8yKPlp2ZNtBfTcswXzkW9aVyP9xHaMmTSU+hXeD
         ZSs0kdvdgeDhzv+SVB+yMZAEyG2Bss7IINkn2xJKPlcQOOQ5ygrJARghfSi1YXV1/4tz
         QZ4V4hCkW769y+oY43NbBsMIq7AsxIMpLl8VxwajGvlWQuz0WF3v6dwriz35eeNZyNv/
         Ho4EV562eJJm1ZE6VMzK1cg1MwTEUr4T8YYx6papNVtobGza9QTI4cGsXmcs9FZKVAUg
         j5IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NrFBEd5Hxd3znL27N+M0coP9GIoEE8kuB1MrCyY7TmE=;
        fh=QUSpEdLzMWpZmI988R8OjNYHLRAdEvCFgIOiUoTibh4=;
        b=F0vJfogWsuXLxdGWZ6jIDl0Zq6THUQQU1Nk84vBqIZEOmLMIU1idgUw4/2liVUqexk
         UkjgwexsjRMjiYn848FWnbsgU5CoA63yvNWbDie0bpGMf6DJYvnjX9L+tErTOBKf6YjK
         Ld7pDALklFNAsQBelafwPCAAd0kZpwZFRHJAOSGoZG8ryPF8eNb8BgggwDd0khkTIc3q
         xsm7hmvozOuPk2rswa9UEPa9G/4bStwZo3IV/IL5SUe92st/2UjZg2vHWLmGep2yrU5l
         6vGJz/TvtNnmWRYRNYQE8FV+qroUjvarO0eFonC3g0lTy5WG285cB16CFsWH+IPwYRPZ
         OK4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776714290; x=1777319090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrFBEd5Hxd3znL27N+M0coP9GIoEE8kuB1MrCyY7TmE=;
        b=BoRkQ2h3gvCy4JMT7w2epL+KNzj39HXWZkSPdbMtBftzaK7JHvShcLbsGGPZ2z2rH+
         EyYujfCcqogPr85eahtttxAGdLvtk1ALq8l+cbj2QBvmKZznErAheVg9pCT6FBZLGxMn
         jKtnDlrYi+vz+rCQSaAV8Bko+cdjv4BExikePFTtk8BQNJKP4RTZFj35R/7R9DvaJ1cb
         PGdu8riFVbsBCJGXnhdyvRW1UJXN3ZfMRloPYc+hiDbO5NAAEBdtjsG5SGSJvfLzQ32x
         m/jG0K1P7QCKBfBfKpZdVEwdwzw2Lzl4BZ7HEk++r4kKe/dxX78rVEkqu3TvFhD8BfDi
         f49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776714290; x=1777319090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NrFBEd5Hxd3znL27N+M0coP9GIoEE8kuB1MrCyY7TmE=;
        b=JSgEDJDIUZcMQ5ABQdchZ+ot1T4F9jwvWLaFID2mSEoarXpzsU9St2+UGAXwM62q6/
         jDDnN39rSUKYuiazk/9mKkYVN7RGW+2gOT4DPxFkqdOF+ClO5vvS+E1M93tOKGKXHJ63
         DffMreVsdf3nPzDPIdE0mgxwjhsJaTEXdX4oZ3wVxr0AAMZGhTAK8PUFbuWYLtAPvRlu
         Zu4vfxi961X10/8/6GXAwYdjXQqGPcu4pdQbYy9AEQWavoPdgb6M4JZP+X5kD6bPHjoi
         5bXa5xn+DyHnOJUk+bJM9Ef/CkWK9F9qldcQiFy/mpoEo0kprdG6B5xZ1wdiTxsbApQg
         LIDg==
X-Forwarded-Encrypted: i=1; AFNElJ+xPsOZtQqozREh+JAQLXGmvVKgQaqywF5wZRnx+8GXebVY6q/whU5yEA5wLFlK6LsoecQrV7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ykf7kijPFwvCc0IqcScNY+iDVzY0UC6BYB4ctHszVtNY/Z9z
	h/9j8H4wOlgAAJ/DqoFw/4KxWezbvBZ0h7KFo9UZxLmehUZF9Pe3LGxeCaT6FhbvyJepNxgC595
	1qdy3Xv+FMgEVoOawZccJeQVEqkLb8us=
X-Gm-Gg: AeBDieskjE/OhGLWny6KBbnim71NlvBg2XyV2dMOZwxCF/A3p/FEmPFyDmNRAUQgjuT
	ZvTz4QhUrlUinA9BnRKfKEBXOEyr/gA6T+QlbvZPjGxaNmFhZKDRHTSKyq0NX+OsGMmYdtVx9Pk
	m4hQlsQE8lgWsFaToemDllZBtNjXCPJ0GG64er9g8IkDzIx6EUidzd6ObjqglWa92mjxxMw0O7g
	iNjONziJX6rT1pdFgK2j0EL+YPZwfubzVEi3918iCX0p1P6LiTB5OA2038f51x93LB2u5Jwk33N
	VTE7IyptfUm21BbgT0EICx+OA4nwThz/2kTYQYHtLuxrkHtC
X-Received: by 2002:a05:6820:82a:b0:67b:f1c8:ede1 with SMTP id
 006d021491bc7-69462f44064mr9004785eaf.53.1776714290182; Mon, 20 Apr 2026
 12:44:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417055408.4667-1-devnexen@gmail.com> <b44de581-9f41-4804-afb1-72c491d9443a@gmail.com>
In-Reply-To: <b44de581-9f41-4804-afb1-72c491d9443a@gmail.com>
From: David CARLIER <devnexen@gmail.com>
Date: Mon, 20 Apr 2026 20:44:39 +0100
X-Gm-Features: AQROBzBSluoIh10jRt0_98McgNJVoNK2fLZ7HLdTtSL5hz3I43x5DeSAEDkEuRw
Message-ID: <CA+XhMqyN_fFptjA=8YJtXzyStQZ68xJiNSG464o4R-dQFLHt7w@mail.gmail.com>
Subject: Re: [PATCH] gtp: disable BH before calling udp_tunnel_xmit_skb()
To: Justin Iurman <justin.iurman@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Harald Welte <laforge@gnumonks.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Weiming Shi <bestswngs@gmail.com>, 
	osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279917-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[netfilter.org,gnumonks.org,lunn.ch,google.com,kernel.org,redhat.com,gmail.com,lists.osmocom.org,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B58C74336E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Julian,

On Mon, 20 Apr 2026 at 20:02, Justin Iurman <justin.iurman@gmail.com> wrote=
:
>
> On 4/17/26 07:54, David Carlier wrote:
> > gtp_genl_send_echo_req() runs as a generic netlink doit handler in
> > process context with BH not disabled. It calls udp_tunnel_xmit_skb(),
> > which eventually invokes iptunnel_xmit() =E2=80=94 that uses __this_cpu=
_inc/dec
> > on softnet_data.xmit.recursion to track the tunnel xmit recursion level=
.
> >
> > Without local_bh_disable(), the task may migrate between
> > dev_xmit_recursion_inc() and dev_xmit_recursion_dec(), breaking the
> > per-CPU counter pairing. The result is stale or negative recursion
> > levels that can later produce false-positive
> > SKB_DROP_REASON_RECURSION_LIMIT drops on either CPU.
> >
> > The other udp_tunnel_xmit_skb() call sites in gtp.c are unaffected:
> > the data path runs under ndo_start_xmit and the echo response handlers
> > run from the UDP encap rx softirq, both with BH already disabled.
> >
> > Fix it by disabling BH around the udp_tunnel_xmit_skb() call, mirroring
> > commit 2cd7e6971fc2 ("sctp: disable BH before calling
> > udp_tunnel_xmit_skb()").
>
> Why not fix iptunnel_xmit() directly, rather than fixing all possible
> callers? Basically, jut like we did for lwtunnel_{output|xmit}(). The
> advantage would be that we no longer have to worry about BHs in the
> callers, and BHs would only be disabled when necessary.

Good point =E2=80=94 your lwtunnel fix (c03a49f3093a) is a close parallel, =
and
  a central fix would avoid chasing callers one by one (sctp was patched
  last week, gtp is this one, and tipc/wireguard/ovpn genl paths look
  similar).

  Happy to respin as v2 with local_bh_disable/enable moved into
  iptunnel_xmit() (and ip6tunnel_xmit() for symmetry), and drop the
  gtp-local hunk. That would also supersede Xin Long's recent sctp
commit
  (2cd7e6971fc2), so I'll make sure to Cc him.

  One thing I'd like your take on before I send: iptunnel_xmit() feels
  like the natural home since it owns the recursion counter, but would
  you rather see it in udp_tunnel_xmit_skb()? I don't want to pick the
  wrong spot if you already have a preference.

Cheers !

